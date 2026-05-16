from pathlib import Path

import pytest

from blender_addon.template_parse import TemplateParseError, parse_bambu_template


def test_cube_asset_auto_header_trim_line_count():
    root = Path(__file__).resolve().parents[1]
    pth = root / "blender_addon" / "assets" / "2_color_change_cube.ipynb.gcode"
    if not pth.is_file():
        pytest.skip("cube asset not present")
    text = pth.read_text(encoding="utf-8", errors="replace")
    p = parse_bambu_template(text)
    assert len(p.header.splitlines()) == 1221
    p_legacy = parse_bambu_template(text, header_trim="legacy")
    assert len(p_legacy.header.splitlines()) > 100000


def test_cube_asset_without_prime_tower_parses_x1_swaps():
    root = Path(__file__).resolve().parents[1]
    pth = root / "blender_addon" / "assets" / "2_color_change_cube.gcode"
    if not pth.is_file():
        pytest.skip("cube asset not present")
    text = pth.read_text(encoding="utf-8", errors="replace")
    p = parse_bambu_template(text)
    assert ";=X1" in p.swap_0_to_1
    assert ";=X1" in p.swap_1_to_0
    assert "M73 E1" in p.swap_0_to_1
    assert "M73 E0" in p.swap_1_to_0
    assert "; filament start gcode" in p.swap_0_to_1
    assert "; filament start gcode" in p.swap_1_to_0
    assert "; CHANGE_LAYER" not in p.header
    assert "; OBJECT_ID:" not in p.header
    assert p.swap_0_to_1_source_z == pytest.approx(8.6)
    assert p.swap_1_to_0_source_z == pytest.approx(11.12)
    assert "G1 Z11.6 F1200" in p.swap_0_to_1
    assert "G1 Z14.12 F1200" in p.swap_1_to_0


def test_placeholder_asset_parses():
    root = Path(__file__).resolve().parents[1]
    p = root / "blender_addon" / "assets" / "minimal_bambu_template_placeholder.gcode"
    text = p.read_text(encoding="utf-8")
    r = parse_bambu_template(text)
    assert "G21" in r.header
    assert "CP TOOLCHANGE START" in r.swap_0_to_1
    assert "CP TOOLCHANGE START" in r.swap_1_to_0
    assert "FOOTER" in r.footer or "footer" in r.footer.lower()


def test_parse_two_toolchanges():
    text = """; start
G21
; CP TOOLCHANGE START
MACRO_A
; CP TOOLCHANGE END
G1 X1
; CP TOOLCHANGE START
MACRO_B
; CP TOOLCHANGE END
; end
M2
"""
    p = parse_bambu_template(text)
    assert "; start" in p.header
    assert "MACRO_A" in p.swap_0_to_1
    assert "MACRO_B" in p.swap_1_to_0
    assert "M2" in p.footer


def test_parse_custom_motion_start_truncates_header():
    text = """; keep
; ---CUSTOM_MOTION_START---
ignored motion
; CP TOOLCHANGE START
A
; CP TOOLCHANGE END
; CP TOOLCHANGE START
B
; CP TOOLCHANGE END
tail
"""
    p = parse_bambu_template(text)
    assert "keep" in p.header
    assert "ignored" not in p.header
    assert "A" in p.swap_0_to_1


def test_parse_requires_two_blocks():
    text = """; CP TOOLCHANGE START
X
; CP TOOLCHANGE END
"""
    with pytest.raises(TemplateParseError):
        parse_bambu_template(text)


def test_parse_x1_swap_blocks_without_cp_markers():
    text = """; EXECUTABLE_BLOCK_START
; CHANGE_LAYER
;=X1 20251031=
M620 S1A
M73 E1
M621 S1A
; filament start gcode
M106 P3 S150

; OBJECT_ID: 7
G1 X10 Y10
;=X1 20251031=
M620 S0A
M73 E0
M621 S0A
; filament start gcode
M106 P3 S150

; OBJECT_ID: 8
G1 X20 Y20
; MACHINE_END_GCODE_START
M400
; EXECUTABLE_BLOCK_END
"""
    p = parse_bambu_template(text)
    assert "M73 E1" in p.swap_0_to_1
    assert "M73 E0" in p.swap_1_to_0
    assert "; CHANGE_LAYER" not in p.header
    assert p.swap_0_to_1_source_z is None
    assert p.swap_1_to_0_source_z is None


def test_parse_x1_swap_extracts_source_z_from_z_height_comment():
    text = """; EXECUTABLE_BLOCK_START
; CHANGE_LAYER
; Z_HEIGHT: 4.20
; LAYER_HEIGHT: 0.2
;=X1
G1 Z7.2 F1200
G1 X10 Y10
M620 S1A
G1 Z7.2 F3000
M621 S1A
; filament start gcode
M106 P3 S150

; OBJECT_ID: 7
G1 X10 Y10
; CHANGE_LAYER
; Z_HEIGHT: 8.40
; LAYER_HEIGHT: 0.2
;=X1
G1 Z11.4 F1200
M620 S0A
G1 Z11.4 F3000
M621 S0A
; filament start gcode
M106 P3 S150

; OBJECT_ID: 8
G1 X20 Y20
; MACHINE_END_GCODE_START
M400
; EXECUTABLE_BLOCK_END
"""
    p = parse_bambu_template(text)
    assert p.swap_0_to_1_source_z == pytest.approx(4.2)
    assert p.swap_1_to_0_source_z == pytest.approx(8.4)
