from __future__ import annotations

import re
from pathlib import Path

import pytest

from blender_addon import export, ir
from blender_addon.export import ExportLayerOptions
from blender_addon.template_parse import parse_bambu_template

ASSET = (
    Path(__file__).resolve().parents[1]
    / "blender_addon"
    / "assets"
    / "2_color_change_cube.ipynb.gcode"
)


@pytest.fixture(scope="module")
def cube_parsed():
    if not ASSET.is_file():
        pytest.skip(f"missing template asset: {ASSET}")
    text = ASSET.read_text(encoding="utf-8", errors="replace")
    return parse_bambu_template(text)


def _square_perimeter(z: float) -> tuple[ir.Segment, ...]:
    e = 0.05
    fr = 3000.0
    pts = [(0.0, 0.0), (10.0, 0.0), (10.0, 10.0), (0.0, 10.0)]
    segs: list[ir.Segment] = []
    for i in range(4):
        x0, y0 = pts[i]
        x1, y1 = pts[(i + 1) % 4]
        segs.append(
            ir.Segment(
                p0=(x0, y0, z),
                p1=(x1, y1, z),
                e_delta=e,
                feedrate=fr,
            )
        )
    return tuple(segs)


def _example_print_ir() -> ir.PrintIR:
    layers = (
        ir.Layer(z=0.2, perimeter=_square_perimeter(0.2), filament_index=0),
        ir.Layer(z=0.4, perimeter=_square_perimeter(0.4), filament_index=0),
        ir.Layer(z=0.6, perimeter=_square_perimeter(0.6), filament_index=1),
        ir.Layer(z=0.8, perimeter=_square_perimeter(0.8), filament_index=1),
        ir.Layer(z=1.0, perimeter=_square_perimeter(1.0), filament_index=0),
    )
    return ir.PrintIR(layers=layers)


def _count_transitions_01_10(layers: tuple[ir.Layer, ...]) -> tuple[int, int]:
    t01 = t10 = 0
    prev = layers[0].filament_index
    for ly in layers[1:]:
        fi = ly.filament_index
        if fi != prev:
            if prev == 0 and fi == 1:
                t01 += 1
            elif prev == 1 and fi == 0:
                t10 += 1
            else:
                raise AssertionError(f"unexpected transition {prev} -> {fi}")
        prev = fi
    return t01, t10


def _expected_motion_line_count(
    num_layers: int,
    segs_per_layer: int,
    *,
    emit_bambu_markers: bool = True,
    layer_fan: bool = False,
    object_id: bool = False,
) -> int:
    preamble = 6 if emit_bambu_markers else 1
    fan_lines = (num_layers - 1) if layer_fan else 0
    layer_0_entry = 1
    layer_n_entry = (num_layers - 1) * 2
    feature_lines = num_layers
    object_id_lines = num_layers if object_id else 0
    return (
        num_layers * preamble
        + num_layers * segs_per_layer
        + layer_0_entry
        + layer_n_entry
        + feature_lines
        + object_id_lines
        + fan_lines
    )


def _expected_total_lines(
    parsed,
    num_layers: int,
    segs_per_layer: int,
    t01: int,
    t10: int,
    *,
    emit_bambu_markers: bool = True,
    layer_fan: bool = False,
) -> int:
    h = len(parsed.header.splitlines())
    f = len(parsed.footer.splitlines())
    composer_prefix = 2
    s01 = len(parsed.swap_0_to_1.splitlines())
    s10 = len(parsed.swap_1_to_0.splitlines())
    motion = _expected_motion_line_count(
        num_layers,
        segs_per_layer,
        emit_bambu_markers=emit_bambu_markers,
        layer_fan=layer_fan,
        object_id=parsed.object_id is not None,
    )
    swap_lines = t01 * s01 + t10 * s10
    e_mode_restore_lines = (t01 + t10) * 2
    return h + f + composer_prefix + motion + swap_lines + e_mode_restore_lines


def test_real_cube_template_parse_structure(cube_parsed):
    p = cube_parsed
    assert len(p.header.splitlines()) < 5000
    assert "; CP TOOLCHANGE START" not in p.header
    assert p.swap_0_to_1.count("; CP TOOLCHANGE START") == 1
    assert p.swap_1_to_0.count("; CP TOOLCHANGE START") == 1
    assert p.footer.count("; CP TOOLCHANGE START") == 0


def test_emit_motion_instruction_counts_from_ir():
    print_ir = _example_print_ir()
    L = len(print_ir.layers)
    S = len(print_ir.layers[0].perimeter)
    motion = export.emit_motion_from_ir(
        print_ir,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )
    assert motion.count("; CHANGE_LAYER") == L
    assert "; LAYER_CHANGE" not in motion
    assert "; layer num/total_layer_count: 1/5" in motion
    assert len(re.findall(r"^M73 L\d+$", motion, flags=re.M)) == L
    assert (
        len(re.findall(r"^M991 S0 P\d+ ;notify layer change$", motion, flags=re.M))
        == L
    )
    assert motion.count("; FEATURE: Outer wall") == L
    assert "; OBJECT_ID:" not in motion
    assert len(re.findall(r"^G1 .* E[0-9.]", motion, flags=re.M)) == L * S
    no_e_g1_lines = [
        ln for ln in motion.splitlines() if ln.startswith("G1 ") and " E" not in ln
    ]
    assert len(no_e_g1_lines) == 1 + 2 * (L - 1)


def test_export_with_real_template_line_budget_and_swaps(cube_parsed):
    p = cube_parsed
    print_ir = _example_print_ir()
    layers = print_ir.layers
    L = len(layers)
    S = len(layers[0].perimeter)
    t01, t10 = _count_transitions_01_10(layers)
    assert (t01, t10) == (1, 1)

    out = export.export_print_ir_to_gcode_string(
        print_ir,
        p,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )
    lines = out.splitlines()

    assert len(lines) == _expected_total_lines(p, L, S, t01, t10)
    assert "; layer num/total_layer_count: 1/5" in out
    assert "; layer num/total_layer_count: 5/5" in out
    assert "; LAYER_CHANGE" not in out
    composed_start = out.index("M82 ; absolute E for composed motion\n")
    composed_end = out.index(p.footer)
    composed = out[composed_start:composed_end]
    assert len(re.findall(r"^M73 L\d+$", composed, flags=re.M)) == L
    assert (
        len(re.findall(r"^M991 S0 P\d+ ;notify layer change$", composed, flags=re.M))
        == L
    )
    assert composed.count("; FEATURE: Outer wall") == L
    assert p.object_id is not None
    assert composed.count(f"; OBJECT_ID: {p.object_id}") == L
    assert out.count(p.swap_0_to_1) == t01
    assert out.count(p.swap_1_to_0) == t10

    assert out.count("G1 Z0.60000 F1200") == 1
    assert out.count("G1 Z1.00000 F1200") == 1
    assert "; Z_HEIGHT: 0.20000" in out

    m73_footer = len(re.findall(r"^M73 P\d+ R0$", p.footer, flags=re.M))
    assert m73_footer == 1
    assert len(re.findall(r"^M73 P\d+ R0$", out, flags=re.M)) == m73_footer
