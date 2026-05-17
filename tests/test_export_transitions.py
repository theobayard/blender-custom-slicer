from pathlib import Path

from blender_addon import export, ir
from blender_addon.export import ExportLayerOptions, ExportSettings
from blender_addon.template_parse import ParsedTemplate, parse_bambu_template

import pytest

TEMPLATE = """; H
; CP TOOLCHANGE START
; SWAP_0_TO_1
; CP TOOLCHANGE END
; mid
; CP TOOLCHANGE START
; SWAP_1_TO_0
; CP TOOLCHANGE END
; CHANGE_LAYER
; layer num/total_layer_count: 1/2
; Z_HEIGHT: 0.4
; WIPE_TOWER_START
; PURGE_040
; WIPE_TOWER_END
; CHANGE_LAYER
; layer num/total_layer_count: 2/2
; Z_HEIGHT: 0.6
; WIPE_TOWER_START
; PURGE_060
; WIPE_TOWER_END
; F
"""


def _seg(x0, y0, x1, y1, z, fr=3000.0):
    return ir.Segment(
        p0=(x0, y0, z),
        p1=(x1, y1, z),
        e_delta=0.1,
        feedrate=fr,
    )


def test_layer_zero_purge_uses_relative_e_and_layer_z():
    parsed = parse_bambu_template(TEMPLATE)
    layers = (ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),)
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        parsed,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )
    wipe = g.index("; WIPE_TOWER_START")
    prep = g[:wipe]
    assert "M83 ; relative E for purge tower" in prep
    assert "G1 Z0.20000 F30000" in prep
    assert prep.rindex("M82") < prep.index("M83 ; relative E for purge tower")


def test_filament_transition_inserts_swap_and_z():
    parsed = parse_bambu_template(TEMPLATE)
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(1, 0, 1, 1, 0.4),), filament_index=1),
    )
    ir_in = ir.PrintIR(layers=layers)
    g = export.export_print_ir_to_gcode_string(
        ir_in,
        parsed,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )
    assert "; H" in g
    assert g.index("M82 ; absolute E for composed motion") < g.index("; CHANGE_LAYER")
    assert g.index("; CHANGE_LAYER") < g.index("M73 L1")
    assert "G92 E0" in g
    assert "SWAP_0_TO_1" in g
    assert "SWAP_1_TO_0" not in g
    assert "; PURGE_040" in g
    assert "G1 Z0.40000" in g
    assert "M73 L1" in g
    assert "M991 S0 P0 ;notify layer change" in g
    assert "M73 L2" in g
    assert "M991 S0 P1 ;notify layer change" in g


def test_export_is_deterministic():
    parsed = parse_bambu_template(TEMPLATE)
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
    )
    ir_in = ir.PrintIR(layers=layers)
    a = export.export_print_ir_to_gcode_string(
        ir_in,
        parsed,
        0.45,
        0.2,
        0.2,
        1.75,
        3000.0,
    )
    b = export.export_print_ir_to_gcode_string(
        ir_in,
        parsed,
        0.45,
        0.2,
        0.2,
        1.75,
        3000.0,
    )
    assert a == b


X1_TEMPLATE = """; H
; EXECUTABLE_BLOCK_START
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; WIPE_TOWER_START
W02
; WIPE_TOWER_END
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; WIPE_TOWER_START
W04
; WIPE_TOWER_END
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; WIPE_TOWER_START
W06
; WIPE_TOWER_END
; CHANGE_LAYER
; Z_HEIGHT: 8.4
;=X1
G1 Z11.4 F1200
G1 X10 Y10
G1 Z11.4 F3000
; filament start gcode

; OBJECT_ID: 7
G1 X20 Y20
; CHANGE_LAYER
; Z_HEIGHT: 11
;=X1
G1 Z14 F1200
G1 X30 Y30
G1 Z14 F3000
; filament start gcode

; OBJECT_ID: 8
G1 X40 Y40
; MACHINE_END_GCODE_START
M400
; EXECUTABLE_BLOCK_END
"""


def test_x1_swap_z_rebased_to_layer_z_preserves_park_hop():
    parsed = parse_bambu_template(X1_TEMPLATE)
    assert parsed.swap_0_to_1_source_z == 8.4
    assert parsed.swap_1_to_0_source_z == 11.0

    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(1, 0, 1, 1, 0.4),), filament_index=1),
        ir.Layer(z=0.6, perimeter=(_seg(1, 1, 0, 1, 0.6),), filament_index=0),
    )
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        parsed,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )

    assert "Z11.4" not in g
    assert "Z14" not in g
    assert "Z-7.800" not in g

    assert g.count("G1 Z-7.800 F1200") == 0
    assert g.count("G1 Z-7.800 F3000") == 0
    assert g.count("G1 Z3.400 F1200") == 1
    assert g.count("G1 Z3.400 F3000") == 1
    assert g.count("G1 Z3.600 F1200") == 1
    assert g.count("G1 Z3.600 F3000") == 1


def test_cube_cp_swap_z_rebased_so_wipe_tower_uses_layer_z():
    root = Path(__file__).resolve().parents[1]
    pth = root / "blender_addon" / "assets" / "2_color_change_cube.gcode"
    if not pth.is_file():
        pytest.skip("cube asset not present")
    parsed = parse_bambu_template(pth.read_text(encoding="utf-8", errors="replace"))
    assert parsed.swap_0_to_1_source_z == pytest.approx(5.8)
    assert parsed.swap_1_to_0_source_z == pytest.approx(19.24)

    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.56, perimeter=(_seg(1, 0, 1, 1, 0.56),), filament_index=1),
        ir.Layer(z=0.84, perimeter=(_seg(1, 1, 0, 1, 0.84),), filament_index=0),
    )
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        parsed,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.28,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )

    assert "Z5.8" not in g
    assert "Z19.24" not in g
    assert "Z8.8" not in g
    assert "Z22.24" not in g
    assert g.count("G1 Z3.560 F1200") == 1
    assert g.count("G1 Z3.560 F3000") == 1
    assert g.count("G1 Z3.840 F1200") == 1
    assert g.count("G1 Z3.840 F3000") == 1
    assert g.count("G1 Z0.560") >= 1
    assert g.count("G1 Z0.840") >= 1

    swap_start = g.index("; CP TOOLCHANGE START")
    first_swap_end = g.index("; CP TOOLCHANGE END")
    assert "G1 Z0.560" in g[swap_start:first_swap_end]
    wipe_start = g.index("; WIPE_TOWER_START", first_swap_end + 1)
    wipe_end = g.index("; WIPE_TOWER_END", wipe_start)
    post_swap_tower = g[wipe_start:wipe_end]
    assert "CP EMPTY GRID" not in post_swap_tower
    assert "G1  X232.402 Y232.474" in post_swap_tower


def test_x1_swap_no_source_z_falls_back_to_raw_macro():
    text = """; EXECUTABLE_BLOCK_START
; CHANGE_LAYER
;=X1
G1 Z11.4 F1200
; filament start gcode

; OBJECT_ID: 7
G1 X10 Y10
;=X1
G1 Z14 F1200
; filament start gcode

; OBJECT_ID: 8
G1 X20 Y20
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; WIPE_TOWER_START
PW
; WIPE_TOWER_END
; MACHINE_END_GCODE_START
M400
; EXECUTABLE_BLOCK_END
"""
    parsed = parse_bambu_template(text)
    assert parsed.swap_0_to_1_source_z is None

    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(1, 0, 1, 1, 0.4),), filament_index=1),
    )
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        parsed,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )
    assert "G1 Z11.4 F1200" in g


def test_post_swap_emits_e_mode_restore_xy_travel_z_drop_then_xy_only_extrude():
    parsed = parse_bambu_template(TEMPLATE)
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(7, 11, 8, 12, 0.4),), filament_index=1),
    )
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        parsed,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )
    swap_end = g.index("SWAP_0_TO_1")
    tail = g[swap_end:]
    e_mode_line = "M82 ; restore absolute E after swap macro or purge tower\n"
    e_zero_line = "G92 E0\n"
    purge_chunk = "; PURGE_060"
    travel_line = "G1 X7.00000 Y11.00000 F30000\n"
    z_drop_line = "G1 Z0.40000 F1200\n"
    feature_line = "; FEATURE: Outer wall\n"
    purge_idx = tail.index(purge_chunk)
    e_mode_idx = tail.index(e_mode_line)
    e_zero_idx = tail.index(e_zero_line)
    travel_idx = tail.index(travel_line)
    z_idx = tail.index(z_drop_line)
    feature_idx = tail.index(feature_line)
    extrude_idx = tail.index("G1 X8.00000 Y12.00000 E")
    assert purge_idx < e_mode_idx < e_zero_idx < travel_idx < z_idx < feature_idx < extrude_idx
    assert "G1 X7.00000 Y11.00000 Z0.40000 F" not in tail
    assert "G1 X8.00000 Y12.00000 Z0.40000 E" not in tail
    assert "; OBJECT_ID:" not in g


def test_change_layer_marker_precedes_swap_macro():
    parsed = parse_bambu_template(TEMPLATE)
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(7, 11, 8, 12, 0.4),), filament_index=1),
    )
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        parsed,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )
    second_layer_marker = g.index("; Z_HEIGHT: 0.40000")
    swap_marker = g.index("SWAP_0_TO_1")
    m991_layer2 = g.index("M991 S0 P1 ;notify layer change")
    assert second_layer_marker < swap_marker
    assert m991_layer2 < swap_marker


def test_export_centers_composed_xy_on_bed():
    parsed = parse_bambu_template(TEMPLATE)
    layers = (
        ir.Layer(
            z=0.2,
            perimeter=(_seg(0.0, 0.0, 10.0, 0.0, 0.2),),
            filament_index=0,
        ),
    )
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        parsed,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
        settings=ExportSettings(
            center_on_bed_at_export=True,
            bed_width_mm=256.0,
            bed_depth_mm=256.0,
        ),
    )
    assert "G1 X123.00000 Y128.00000 Z0.20000 F" in g
    assert "G1 X133.00000 Y128.00000 E" in g


def test_layer_fan_m106_s_when_use_p1_off_minimal_template():
    parsed = parse_bambu_template(TEMPLATE)
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(0, 0, 1, 0, 0.4),), filament_index=0),
    )
    ir_in = ir.PrintIR(layers=layers)
    opts = ExportLayerOptions(
        emit_bambu_markers=False,
        layer_fan_enable=True,
        layer_fan_percent=100,
        layer_fan_use_p1=False,
    )
    g = export.export_print_ir_to_gcode_string(
        ir_in,
        parsed,
        0.45,
        0.2,
        0.2,
        1.75,
        3000.0,
        layer_options=opts,
    )
    assert g.count("M106 S255\n") == 1
    assert "M106 P1" not in g


def test_export_uses_layer_map_even_when_template_executable_total_understates():
    p = ParsedTemplate.from_test_slices(
        header="\n",
        swap_0_to_1="; CP TOOLCHANGE START\nS\n; CP TOOLCHANGE END\n",
        swap_1_to_0="; CP TOOLCHANGE START\nT\n; CP TOOLCHANGE END\n",
        footer="\n",
        purge_towers_by_layer_1based={
            1: ("; WIPE_TOWER_START\nL1\n; WIPE_TOWER_END\n", 0.2),
            2: ("; WIPE_TOWER_START\nL2\n; WIPE_TOWER_END\n", 0.4),
        },
        purge_towers_by_layer_z_fallback={},
        template_executable_layer_total=1,
    )
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(1, 0, 1, 1, 0.4),), filament_index=1),
    )
    g = export.export_print_ir_to_gcode_string(
        ir.PrintIR(layers=layers),
        p,
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=3000.0,
    )
    assert "L1" in g and "L2" in g


def test_unsupported_filament_transition_raises():
    parsed = parse_bambu_template(TEMPLATE)
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(1, 0, 1, 1, 0.4),), filament_index=2),
    )
    with pytest.raises(ValueError, match="unsupported filament transition"):
        export.export_print_ir_to_gcode_string(
            ir.PrintIR(layers=layers),
            parsed,
            0.45,
            0.2,
            0.2,
            1.75,
            3000.0,
        )


def test_motion_only_perimeter_matches_template_export_without_purge_map():
    parsed = ParsedTemplate.from_test_slices(
        header=";\n",
        swap_0_to_1="; CP TOOLCHANGE START\nS\n; CP TOOLCHANGE END\n",
        swap_1_to_0="; CP TOOLCHANGE START\nT\n; CP TOOLCHANGE END\n",
        footer=";\n",
    )
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(1, 0, 1, 1, 0.4),), filament_index=0),
    )
    print_ir = ir.PrintIR(layers=layers)
    motion = export.emit_motion_from_ir(
        print_ir, 0.45, 0.2, 0.2, 1.75, 3000.0
    )
    full = export.export_print_ir_to_gcode_string(
        print_ir, parsed, 0.45, 0.2, 0.2, 1.75, 3000.0
    )
    motion_g1 = [
        ln for ln in motion.splitlines() if ln.startswith("G1 X") and " E" in ln
    ]
    full_g1 = [
        ln for ln in full.splitlines() if ln.startswith("G1 X") and " E" in ln
    ]
    assert motion_g1 == full_g1


def test_missing_purge_tower_raises_with_clear_message():
    bare = """; H
; CP TOOLCHANGE START
S01
; CP TOOLCHANGE END
; CP TOOLCHANGE START
S10
; CP TOOLCHANGE END
"""
    parsed = parse_bambu_template(bare)
    layers = (
        ir.Layer(z=0.2, perimeter=(_seg(0, 0, 1, 0, 0.2),), filament_index=0),
        ir.Layer(z=0.4, perimeter=(_seg(1, 0, 1, 1, 0.4),), filament_index=1),
    )
    with pytest.raises(export.MissingPurgeTowerError) as exc_info:
        export.export_print_ir_to_gcode_string(
            ir.PrintIR(layers=layers),
            parsed,
            0.45,
            0.2,
            0.2,
            1.75,
            3000.0,
        )
    msg = str(exc_info.value)
    assert "layer 2" in msg
    assert "0.40000" in msg or "0.4" in msg
    assert "0→1" in msg
