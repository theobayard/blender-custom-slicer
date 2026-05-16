from blender_addon import export, ir
from blender_addon.export import ExportLayerOptions
from blender_addon.template_parse import parse_bambu_template

TEMPLATE = """; H
; CP TOOLCHANGE START
; SWAP_0_TO_1
; CP TOOLCHANGE END
; mid
; CP TOOLCHANGE START
; SWAP_1_TO_0
; CP TOOLCHANGE END
; F
"""


def _seg(x0, y0, x1, y1, z, fr=3000.0):
    return ir.Segment(
        p0=(x0, y0, z),
        p1=(x1, y1, z),
        e_delta=0.1,
        feedrate=fr,
    )


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
    assert g.index("; CHANGE_LAYER") < g.index("; LAYER_CHANGE")
    assert "G92 E0" in g
    assert "SWAP_0_TO_1" in g
    assert "SWAP_1_TO_0" not in g
    assert "G1 Z0.40000" in g
    assert "; LAYER_CHANGE" in g


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
