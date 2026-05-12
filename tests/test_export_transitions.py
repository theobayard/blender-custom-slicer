from blender_addon import export, ir
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
    assert g.index("M82 ; absolute E for composed motion") < g.index("; LAYER_CHANGE")
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
