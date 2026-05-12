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
