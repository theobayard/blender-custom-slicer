from blender_addon import brim, export, ir
from blender_addon.export.motion import ir_xy_min_max


def _square_loop(size: float = 10.0) -> list[tuple[float, float]]:
    s = size
    return [(0.0, 0.0), (s, 0.0), (s, s), (0.0, s)]


def test_first_brim_loop_respects_object_gap_from_outer_surface():
    gap = 0.1
    lw = 0.45
    loops = brim.build_brim_loops(_square_loop(10.0), 5.0, gap, lw)
    min_y = min(p[1] for p in loops[0])
    assert abs(min_y + gap + lw) < 0.02
    outer_surface_y = -lw * 0.5
    inner_brim_edge_y = min_y + lw * 0.5
    assert abs(inner_brim_edge_y - (outer_surface_y - gap)) < 0.02


def test_build_brim_loops_count_and_gap():
    width = 5.0
    gap = 0.1
    lw = 0.45
    loops = brim.build_brim_loops(_square_loop(), width, gap, lw)
    expected = len(brim._brim_offset_distances(width, gap, lw))
    assert len(loops) == expected
    assert expected >= 1

    inner = loops[0]
    min_x = min(p[0] for p in inner)
    min_y = min(p[1] for p in inner)
    expect = gap + lw
    assert min_x <= -expect + 0.05
    assert min_y <= -expect + 0.05


def test_export_brim_before_outer_wall():
    brim_loop = (
        ir.Segment(p0=(20.0, 0.0, 0.2), p1=(21.0, 0.0, 0.2), e_delta=0.0, feedrate=1800.0),
        ir.Segment(p0=(21.0, 0.0, 0.2), p1=(21.0, 1.0, 0.2), e_delta=0.0, feedrate=1800.0),
    )
    wall = (
        ir.Segment(p0=(0.0, 0.0, 0.2), p1=(1.0, 0.0, 0.2), e_delta=0.0, feedrate=1800.0),
        ir.Segment(p0=(1.0, 0.0, 0.2), p1=(1.0, 1.0, 0.2), e_delta=0.0, feedrate=1800.0),
    )
    layers = (
        ir.Layer(
            z=0.2,
            perimeter=wall,
            filament_index=0,
            brim_loops=(brim_loop,),
        ),
    )
    g = export.emit_motion_from_ir(
        ir.PrintIR(layers=layers),
        line_width=0.45,
        first_layer_height=0.2,
        layer_height=0.2,
        filament_diameter=1.75,
        default_feedrate=1800.0,
    )
    assert "; FEATURE: Brim\n" in g
    assert g.index("; FEATURE: Brim\n") < g.index("; FEATURE: Outer wall\n")
    assert "X20.00000 Y0.00000" in g


def test_ir_xy_min_max_includes_brim():
    brim_loop = (
        ir.Segment(p0=(50.0, 0.0, 0.2), p1=(55.0, 0.0, 0.2), e_delta=0.0, feedrate=1800.0),
    )
    wall = (
        ir.Segment(p0=(0.0, 0.0, 0.2), p1=(10.0, 0.0, 0.2), e_delta=0.0, feedrate=1800.0),
    )
    with_brim = ir.PrintIR(
        layers=(
            ir.Layer(
                z=0.2,
                perimeter=wall,
                filament_index=0,
                brim_loops=(brim_loop,),
            ),
        )
    )
    without_brim = ir.PrintIR(
        layers=(ir.Layer(z=0.2, perimeter=wall, filament_index=0),)
    )
    minx_b, maxx_b, _, _ = ir_xy_min_max(with_brim)
    minx_w, maxx_w, _, _ = ir_xy_min_max(without_brim)
    assert maxx_b >= 55.0
    assert maxx_w < 55.0


def test_validate_brim_only_on_layer_zero():
    brim_loop = (
        ir.Segment(p0=(1.0, 0.0, 0.2), p1=(2.0, 0.0, 0.2), e_delta=0.0, feedrate=1800.0),
    )
    wall = (
        ir.Segment(p0=(0.0, 0.0, 0.2), p1=(1.0, 0.0, 0.2), e_delta=0.0, feedrate=1800.0),
    )
    bad = ir.PrintIR(
        layers=(
            ir.Layer(z=0.2, perimeter=wall, filament_index=0),
            ir.Layer(
                z=0.4,
                perimeter=wall,
                filament_index=0,
                brim_loops=(brim_loop,),
            ),
        )
    )
    try:
        ir.validate_print_ir(bad)
        assert False, "expected IRValidationError"
    except ir.IRValidationError:
        pass
