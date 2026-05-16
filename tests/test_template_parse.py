from pathlib import Path

import pytest

from blender_addon.template_parse import TemplateParseError, parse_bambu_template


def test_prime_tower_k_over_small_total_ignored_when_header_declares_print_layers():
    text = """; HEADER_BLOCK_START
; total layer number: 100
; HEADER_BLOCK_END
; CP TOOLCHANGE START
A
; CP TOOLCHANGE END
; CP TOOLCHANGE START
B
; CP TOOLCHANGE END
; CHANGE_LAYER
; Z_HEIGHT: 0.28
; layer num/total_layer_count: 1/17
; WIPE_TOWER_START
PRIME
; WIPE_TOWER_END
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; layer num/total_layer_count: 1/100
; WIPE_TOWER_START
OK1
; WIPE_TOWER_END
"""
    p = parse_bambu_template(text)
    assert "OK1" in p.purge_towers_by_layer_1based[1][0]
    assert "PRIME" not in p.purge_towers_by_layer_1based[1][0]


def test_wipe_does_not_bind_stale_k100_marker_beyond_lookback():
    filler = "\n".join([f"G1 X{i} Y{i}" for i in range(650)])
    text = f"""; HEADER_BLOCK_START
; total layer number: 100
; HEADER_BLOCK_END
; CP TOOLCHANGE START
A
; CP TOOLCHANGE END
; CP TOOLCHANGE START
B
; CP TOOLCHANGE END
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; layer num/total_layer_count: 1/100
; WIPE_TOWER_START
T1
; WIPE_TOWER_END
{filler}
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; layer num/total_layer_count: 2/17
; WIPE_TOWER_START
T2
; WIPE_TOWER_END
"""
    p = parse_bambu_template(text)
    assert 1 in p.purge_towers_by_layer_1based
    assert 2 not in p.purge_towers_by_layer_1based
    zb = p.purge_towers_by_layer_z_fallback
    assert len(zb) == 1 and any("T2" in v for v in zb.values())


def test_standalone_wipe_chunk_includes_bambu_prime_tower_prelude_comments():
    text = """; HEADER_BLOCK_START
; total layer number: 2
; HEADER_BLOCK_END
; CP TOOLCHANGE START
A
; CP TOOLCHANGE END
; CP TOOLCHANGE START
B
; CP TOOLCHANGE END
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; layer num/total_layer_count: 1/2
; LAYER_HEIGHT: 0.200000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
BODY
; WIPE_TOWER_END
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; layer num/total_layer_count: 2/2
; LAYER_HEIGHT: 0.200000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
BODY2
; WIPE_TOWER_END
"""
    p = parse_bambu_template(text)
    c1 = p.purge_towers_by_layer_1based[1][0]
    assert c1.startswith("; LAYER_HEIGHT: 0.200000\n")
    assert "; FEATURE: Prime tower\n" in c1
    assert "; LINE_WIDTH: 0.500000\n" in c1
    assert "; WIPE_TOWER_START\nBODY\n; WIPE_TOWER_END\n" in c1


def test_executable_cube_asset_purge_map_one_blob_per_layer():
    root = Path(__file__).resolve().parents[1]
    pth = root / "blender_addon" / "assets" / "2_color_change_cube.gcode"
    if not pth.is_file():
        pytest.skip("cube asset not present")
    p = parse_bambu_template(pth.read_text(encoding="utf-8", errors="replace"))
    m = p.purge_towers_by_layer_1based
    n = len(m)
    assert n >= 1
    assert sorted(m) == list(range(1, n + 1))
    blobs = {m[k][0] for k in m}
    assert len(blobs) == n
    assert m[1][0].startswith("; LAYER_HEIGHT:")


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


def test_cube_asset_parses_with_cp_swaps_and_layer_indexed_purge_towers():
    root = Path(__file__).resolve().parents[1]
    pth = root / "blender_addon" / "assets" / "2_color_change_cube.gcode"
    if not pth.is_file():
        pytest.skip("cube asset not present")
    text = pth.read_text(encoding="utf-8", errors="replace")
    p = parse_bambu_template(text)
    assert "; CP TOOLCHANGE START" in p.swap_0_to_1
    assert "; CP TOOLCHANGE END" in p.swap_0_to_1
    assert "; CP TOOLCHANGE START" in p.swap_1_to_0
    assert ";=X1" in p.swap_0_to_1
    assert "M73 E" in p.swap_0_to_1
    assert "M73" in p.swap_1_to_0
    assert "; filament start gcode" in p.swap_0_to_1
    assert "; filament start gcode" in p.swap_1_to_0
    assert "; OBJECT_ID:" not in p.header
    assert p.swap_0_to_1_source_z == pytest.approx(5.8)
    assert p.swap_1_to_0_source_z == pytest.approx(19.24)
    assert p.object_id is not None and p.object_id.isdigit()
    m = p.purge_towers_by_layer_1based
    n = len(m)
    assert n >= 1
    t58 = m[min(58, n)][0]
    assert t58.startswith("; LAYER_HEIGHT:")
    assert "; WIPE_TOWER_START" in t58
    assert "CP TOOLCHANGE START" not in t58
    assert p.purge_tower_post_swap_0_to_1 is not None
    assert p.purge_tower_post_swap_1_to_0 is not None
    post01, z01 = p.purge_tower_post_swap_0_to_1
    post10, z10 = p.purge_tower_post_swap_1_to_0
    assert z01 == pytest.approx(5.8)
    assert z10 == pytest.approx(19.24)
    assert "CP EMPTY GRID" not in post01
    assert "CP EMPTY GRID" not in post10
    assert "G1  X232.402 Y232.474" in post01
    assert m[22][0].count("CP EMPTY GRID") >= 1


def test_object_id_parsed_from_first_executable_block_marker():
    text = """; start
; OBJECT_ID: 42
; CP TOOLCHANGE START
A
; CP TOOLCHANGE END
G1 X1
; CP TOOLCHANGE START
B
; CP TOOLCHANGE END
"""
    r = parse_bambu_template(text)
    assert r.object_id == "42"


def test_object_id_absent_is_none():
    text = """; start
; CP TOOLCHANGE START
A
; CP TOOLCHANGE END
G1 X1
; CP TOOLCHANGE START
B
; CP TOOLCHANGE END
"""
    r = parse_bambu_template(text)
    assert r.object_id is None


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
