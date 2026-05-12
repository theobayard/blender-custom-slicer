from pathlib import Path

import pytest

from blender_addon.template_parse import parse_bambu_template

CUBE = (
    Path(__file__).resolve().parents[1]
    / "blender_addon"
    / "assets"
    / "2_color_change_cube.ipynb.gcode"
)


@pytest.mark.skipif(not CUBE.is_file(), reason="cube asset missing")
def test_cube_template_footer_must_not_embed_third_color_object_toolpath():
    text = CUBE.read_text(encoding="utf-8", errors="replace")
    p = parse_bambu_template(text)
    assert p.footer.count("G1 X4.396") == 0, (
        "footer still contains template object moves after 2nd toolchange; "
        "Bambu Studio will preview the phantom cube body"
    )
    assert len(p.footer.splitlines()) < 500
