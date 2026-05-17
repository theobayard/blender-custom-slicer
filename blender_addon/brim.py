from __future__ import annotations

import math

from . import ir


def loop2d_from_layer(layer: ir.Layer) -> list[tuple[float, float]]:
    if not layer.perimeter:
        return []
    return [(seg.p0[0], seg.p0[1]) for seg in layer.perimeter]


def _signed_area(loop: list[tuple[float, float]]) -> float:
    n = len(loop)
    if n < 3:
        return 0.0
    a = 0.0
    for i in range(n):
        x0, y0 = loop[i]
        x1, y1 = loop[(i + 1) % n]
        a += x0 * y1 - x1 * y0
    return a * 0.5


def _ensure_ccw(loop: list[tuple[float, float]]) -> list[tuple[float, float]]:
    if _signed_area(loop) < 0:
        return list(reversed(loop))
    return list(loop)


def _normalize(vx: float, vy: float) -> tuple[float, float]:
    ln = math.hypot(vx, vy)
    if ln < 1e-12:
        return (0.0, 0.0)
    return (vx / ln, vy / ln)


def _outward_normal(vx: float, vy: float) -> tuple[float, float]:
    return (vy, -vx)


def offset_polygon_outward(
    loop: list[tuple[float, float]], distance: float
) -> list[tuple[float, float]]:
    if distance <= 0 or len(loop) < 3:
        return list(loop)
    pts = _ensure_ccw(loop)
    n = len(pts)
    out: list[tuple[float, float]] = []
    for i in range(n):
        px, py = pts[(i - 1) % n]
        cx, cy = pts[i]
        nx, ny = pts[(i + 1) % n]
        e1x, e1y = _normalize(cx - px, cy - py)
        e2x, e2y = _normalize(nx - cx, ny - cy)
        n1x, n1y = _outward_normal(e1x, e1y)
        n2x, n2y = _outward_normal(e2x, e2y)
        mx, my = n1x + n2x, n1y + n2y
        mlen = math.hypot(mx, my)
        if mlen < 1e-12:
            ox, oy = n1x, n1y
        else:
            mx /= mlen
            my /= mlen
            dot = mx * n1x + my * n1y
            if abs(dot) < 1e-9:
                ox, oy = n1x, n1y
            else:
                scale = distance / dot
                scale = min(scale, distance * 8.0)
                ox, oy = mx * scale, my * scale
        out.append((cx + ox, cy + oy))
    return out


def _brim_offset_distances(
    width_mm: float, gap_mm: float, line_width_mm: float
) -> list[float]:
    if line_width_mm <= 0 or width_mm <= 0:
        return []
    max_center = gap_mm + width_mm
    dists: list[float] = []
    i = 0
    while True:
        d = gap_mm + line_width_mm * (i + 1)
        if d > max_center + 1e-9:
            break
        dists.append(d)
        i += 1
    if not dists:
        dists.append(gap_mm + line_width_mm)
    return dists


def build_brim_loops(
    loop2d: list[tuple[float, float]],
    width_mm: float,
    gap_mm: float,
    line_width_mm: float,
) -> list[list[tuple[float, float]]]:
    if len(loop2d) < 3:
        return []
    base = _ensure_ccw(loop2d)
    loops: list[list[tuple[float, float]]] = []
    for dist in _brim_offset_distances(width_mm, gap_mm, line_width_mm):
        offset = offset_polygon_outward(base, dist)
        if len(offset) >= 3:
            loops.append(offset)
    return loops


def brim_loops_to_segments(
    loops: list[list[tuple[float, float]]],
    z: float,
    feedrate: float,
) -> tuple[tuple[ir.Segment, ...], ...]:
    out: list[tuple[ir.Segment, ...]] = []
    for loop in loops:
        if len(loop) < 3:
            continue
        segs: list[ir.Segment] = []
        n = len(loop)
        for i in range(n):
            x0, y0 = loop[i]
            x1, y1 = loop[(i + 1) % n]
            segs.append(
                ir.Segment(
                    p0=(x0, y0, z),
                    p1=(x1, y1, z),
                    e_delta=0.0,
                    feedrate=feedrate,
                )
            )
        if segs:
            out.append(tuple(segs))
    return tuple(out)
