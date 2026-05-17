from blender_addon.export.gcode_edit import rebase_swap_z


def test_rebase_swap_z_shifts_motion_z_tokens():
    macro = "G1 X1 Y1 Z5.0 F3000\nM117 comment\nG0 Z6.0\n"
    out = rebase_swap_z(macro, 5.0, 7.0)
    assert "G1 X1 Y1 Z7.000 F3000" in out
    assert "G0 Z8.000" in out
    assert "M117 comment" in out


def test_rebase_swap_z_noop_when_delta_zero():
    macro = "G1 Z3.0\n"
    assert rebase_swap_z(macro, 3.0, 3.0) == macro


def test_rebase_swap_z_preserves_trailing_newline():
    macro = "G1 Z1.0\n"
    assert rebase_swap_z(macro, 1.0, 2.0).endswith("\n")
