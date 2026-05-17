from __future__ import annotations

from .. import ir


def ir_xy_min_max(print_ir: ir.PrintIR) -> tuple[float, float, float, float]:
    minx = miny = float("inf")
    maxx = maxy = float("-inf")
    for layer in print_ir.layers:
        for seg in layer.perimeter:
            for x, y in ((seg.p0[0], seg.p0[1]), (seg.p1[0], seg.p1[1])):
                minx = min(minx, x)
                maxx = max(maxx, x)
                miny = min(miny, y)
                maxy = max(maxy, y)
    return minx, maxx, miny, maxy


def xy_center_on_bed_offset(
    print_ir: ir.PrintIR, bed_w: float, bed_d: float
) -> tuple[float, float]:
    minx, maxx, miny, maxy = ir_xy_min_max(print_ir)
    cx = (minx + maxx) * 0.5
    cy = (miny + maxy) * 0.5
    return bed_w * 0.5 - cx, bed_d * 0.5 - cy


def e_per_mm(line_width: float, layer_h: float, filament_diameter: float) -> float:
    r = filament_diameter * 0.5
    filament_area = 3.141592653589793 * r * r
    vol_per_mm = line_width * layer_h
    return vol_per_mm / filament_area if filament_area > 0 else 0.0


def append_layer_entry_moves(
    parts: list[str],
    layer_idx: int,
    p0: tuple[float, float, float],
    layer_z: float,
    fr: float,
    object_id: str | None,
    xy_offset: tuple[float, float],
) -> None:
    x0 = p0[0] + xy_offset[0]
    y0 = p0[1] + xy_offset[1]
    if object_id is not None:
        parts.append(f"; OBJECT_ID: {object_id}\n")
    if layer_idx == 0:
        parts.append(f"G1 X{x0:.5f} Y{y0:.5f} Z{layer_z:.5f} F{fr:.1f}\n")
    else:
        parts.append(f"G1 X{x0:.5f} Y{y0:.5f} F30000\n")
        parts.append(f"G1 Z{layer_z:.5f} F1200\n")
    parts.append("; FEATURE: Outer wall\n")


def append_perimeter(
    parts: list[str],
    layer: ir.Layer,
    e_scale: float,
    fr: float,
    xy_offset: tuple[float, float],
    e_accum: float,
) -> float:
    for seg in layer.perimeter:
        x1, y1, _ = seg.p1
        x1 += xy_offset[0]
        y1 += xy_offset[1]
        length = (
            (seg.p1[0] - seg.p0[0]) ** 2
            + (seg.p1[1] - seg.p0[1]) ** 2
            + (seg.p1[2] - seg.p0[2]) ** 2
        ) ** 0.5
        e_seg = seg.e_delta if seg.e_delta > 0 else e_scale * length
        e_accum += e_seg
        parts.append(f"G1 X{x1:.5f} Y{y1:.5f} E{e_accum:.5f} F{fr:.1f}\n")
    return e_accum
