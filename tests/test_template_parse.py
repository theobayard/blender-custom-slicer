import pytest

from blender_addon.template_parse import TemplateParseError, parse_bambu_template


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
