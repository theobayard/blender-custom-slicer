import pytest

from blender_addon import export, ir
from blender_addon.export.purge_resolve import resolve_purge_for_layer
from blender_addon.template_parse.types import GcodeChunk, ParsedTemplate, PurgeIndex


def _minimal_parsed(**kwargs) -> ParsedTemplate:
    base = dict(
        header=";\n",
        swap_0_to_1="; CP TOOLCHANGE START\nS\n; CP TOOLCHANGE END\n",
        swap_1_to_0="; CP TOOLCHANGE START\nT\n; CP TOOLCHANGE END\n",
        footer=";\n",
        purge_towers_by_layer_1based={},
        purge_towers_by_layer_z_fallback={},
    )
    base.update(kwargs)
    return ParsedTemplate.from_test_slices(**base)


def test_resolve_prefers_post_swap_on_filament_change():
    post = GcodeChunk("; WIPE_TOWER_START\nPOST\n; WIPE_TOWER_END\n", 5.0)
    p = _minimal_parsed(
        purge_tower_post_swap_0_to_1=post.as_tuple(),
        purge_towers_by_layer_1based={2: ("; CP EMPTY GRID\nMAINT\n", 0.4)},
    )
    got = resolve_purge_for_layer(
        p, 1, 0.4, 0.2, prev_filament=0, new_filament=1, filament_changed=True
    )
    assert got is not None
    assert "POST" in got.text


def test_resolve_maintenance_by_layer():
    maint = GcodeChunk("; CP EMPTY GRID\nM\n", 0.4)
    p = ParsedTemplate(
        header=";\n",
        swap_0_to_1=_minimal_parsed().swap_0_to_1,
        swap_1_to_0=_minimal_parsed().swap_1_to_0,
        footer=";\n",
        purge_index=PurgeIndex(maintenance_by_layer={2: maint}),
    )
    got = resolve_purge_for_layer(
        p, 1, 0.4, 0.2, prev_filament=0, new_filament=0, filament_changed=False
    )
    assert got is maint


def test_resolve_nearest_maintenance_when_layer_is_post_swap_only():
    maint = GcodeChunk("; CP EMPTY GRID\nNEAR\n", 0.6)
    post_only = GcodeChunk("; WIPE\n", 0.4)
    p = ParsedTemplate(
        header=";\n",
        swap_0_to_1=_minimal_parsed().swap_0_to_1,
        swap_1_to_0=_minimal_parsed().swap_1_to_0,
        footer=";\n",
        purge_index=PurgeIndex(
            maintenance_by_layer={3: maint},
            other_by_layer={2: post_only},
        ),
    )
    got = resolve_purge_for_layer(
        p, 1, 0.4, 0.2, prev_filament=0, new_filament=0, filament_changed=False
    )
    assert got is maint


def test_resolve_other_by_layer_when_no_maintenance():
    stub = GcodeChunk("; WIPE_TOWER_START\nSTUB\n; WIPE_TOWER_END\n", 0.4)
    p = ParsedTemplate(
        header=";\n",
        swap_0_to_1=_minimal_parsed().swap_0_to_1,
        swap_1_to_0=_minimal_parsed().swap_1_to_0,
        footer=";\n",
        purge_index=PurgeIndex(other_by_layer={2: stub}),
    )
    got = resolve_purge_for_layer(
        p, 1, 0.4, 0.2, prev_filament=0, new_filament=0, filament_changed=False
    )
    assert got is stub


def test_resolve_z_fallback_when_no_layer_key():
    p = _minimal_parsed(
        purge_towers_by_layer_z_fallback={0.2: "; WIPE_TOWER_START\nZFB\n; WIPE_TOWER_END\n"}
    )
    got = resolve_purge_for_layer(
        p, 0, 0.21, 0.2, prev_filament=0, new_filament=0, filament_changed=False
    )
    assert got is not None
    assert "ZFB" in got.text
    assert got.source_z == pytest.approx(0.2)


def _seg(x0, y0, x1, y1, z):
    return ir.Segment(
        p0=(x0, y0, z),
        p1=(x1, y1, z),
        e_delta=0.1,
        feedrate=3000.0,
    )


def test_export_z_fallback_rebased_in_output():
    p = _minimal_parsed(
        purge_towers_by_layer_z_fallback={0.2: "G1 Z0.2 F3000\n; WIPE\n"}
    )
    layers = (ir.Layer(z=0.21, perimeter=(_seg(0, 0, 1, 0, 0.21),), filament_index=0),)
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        p,
        0.45,
        0.2,
        0.2,
        1.75,
        3000.0,
    )
    assert "G1 Z0.210" in g or "G1 Z0.21" in g


def test_full_layer_map_requires_purge_on_non_switch_layer():
    p = _minimal_parsed(
        purge_towers_by_layer_1based={
            1: ("; WIPE_TOWER_START\nL1\n; WIPE_TOWER_END\n", 0.2),
            2: ("; WIPE_TOWER_START\nL2\n; WIPE_TOWER_END\n", 0.4),
            3: ("; WIPE_TOWER_START\nL3\n; WIPE_TOWER_END\n", 0.6),
        },
    )
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(1, 0, 1, 1, 0.4),), filament_index=0),
        ir.Layer(z=0.6, perimeter=(_seg(1, 1, 0, 1, 0.6),), filament_index=0),
    )
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        p,
        0.45,
        0.2,
        0.2,
        1.75,
        3000.0,
    )
    assert "L2" in g
