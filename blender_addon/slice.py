from __future__ import annotations

import math
from typing import Callable, Optional

import bpy
from mathutils import Vector

from . import ir

_last_ir: Optional[ir.PrintIR] = None


def get_last_ir() -> Optional[ir.PrintIR]:
    return _last_ir


def clear_last_ir() -> None:
    global _last_ir
    _last_ir = None


def _filament_fn(mode: str) -> Callable[[int], int]:
    if mode == "ALTERNATE_01":

        def fn(i: int) -> int:
            return i % 2

        return fn

    def fn0(_: int) -> int:
        return 0

    return fn0


def _dedupe_points(
    pts: list[tuple[float, float]], tol: float = 1e-5
) -> list[tuple[float, float]]:
    out: list[tuple[float, float]] = []
    for x, y in pts:
        if any(abs(x - ox) < tol and abs(y - oy) < tol for ox, oy in out):
            continue
        out.append((x, y))
    return out


def _edge_plane_xy(
    p0: Vector, p1: Vector, z: float, tol: float
) -> Optional[tuple[float, float]]:
    z0, z1 = p0.z, p1.z
    if abs(z0 - z) < tol and abs(z1 - z) < tol:
        return None
    if z0 < z - tol and z1 < z - tol:
        return None
    if z0 > z + tol and z1 > z + tol:
        return None
    if abs(z1 - z0) < tol:
        return None
    t = (z - z0) / (z1 - z0)
    if t < -1e-6 or t > 1 + 1e-6:
        return None
    x = p0.x + t * (p1.x - p0.x)
    y = p0.y + t * (p1.y - p0.y)
    return (x, y)


def _triangle_segments_at_z(
    va: Vector, vb: Vector, vc: Vector, z: float, tol: float
) -> Optional[tuple[tuple[float, float], tuple[float, float]]]:
    hits: list[tuple[float, float]] = []
    for p, q in ((va, vb), (vb, vc), (vc, va)):
        h = _edge_plane_xy(p, q, z, tol)
        if h is not None:
            hits.append(h)
    hits = _dedupe_points(hits, tol=tol * 10)
    if len(hits) < 2:
        return None
    if len(hits) == 2:
        return (hits[0], hits[1])
    return None


def _segment_length(a: tuple[float, float], b: tuple[float, float]) -> float:
    return math.hypot(b[0] - a[0], b[1] - a[1])


def _pk(p: tuple[float, float]) -> tuple[float, float]:
    return (round(p[0], 5), round(p[1], 5))


def _fan_triangles(poly: tuple[int, ...]) -> list[tuple[int, int, int]]:
    if len(poly) < 3:
        return []
    i0 = poly[0]
    return [(i0, poly[k], poly[k + 1]) for k in range(1, len(poly) - 1)]


def _collect_slice_segments(
    verts: list[Vector], polys: list[tuple[int, ...]], z: float, tol: float
) -> list[tuple[tuple[float, float], tuple[float, float]]]:
    segs: list[tuple[tuple[float, float], tuple[float, float]]] = []
    seen: set[frozenset[tuple[float, float]]] = set()
    for poly in polys:
        for ia, ib, ic in _fan_triangles(poly):
            tri = _triangle_segments_at_z(verts[ia], verts[ib], verts[ic], z, tol)
            if not tri:
                continue
            a, b = tri
            ka, kb = _pk(a), _pk(b)
            key = frozenset((ka, kb))
            if key in seen:
                continue
            seen.add(key)
            segs.append((a, b))
    return segs


def _walk_cycle(adj: dict[tuple[float, float], list[tuple[float, float]]]) -> list[tuple[float, float]]:
    for k in adj:
        adj[k] = sorted(set(adj[k]))
    start = min(adj.keys())
    loop = [start]
    prev: Optional[tuple[float, float]] = None
    curr = start
    for _ in range(len(adj) * 8 + 40):
        neighs = [n for n in adj[curr] if prev is None or n != prev]
        if not neighs:
            return []
        nxt = min(neighs)
        if nxt == start and len(loop) > 2:
            return loop
        prev, curr = curr, nxt
        loop.append(curr)
    return []


def _remove_cycle_edges(
    adj: dict[tuple[float, float], set[tuple[float, float]]],
    loop: list[tuple[float, float]],
) -> None:
    n = len(loop)
    for i in range(n):
        a, b = loop[i], loop[(i + 1) % n]
        if b in adj.get(a, set()):
            adj[a].discard(b)
        if a in adj.get(b, set()):
            adj[b].discard(a)
        if not adj.get(a):
            adj.pop(a, None)
        if not adj.get(b):
            adj.pop(b, None)


def _segments_to_adj(
    segments: list[tuple[tuple[float, float], tuple[float, float]]],
) -> dict[tuple[float, float], set[tuple[float, float]]]:
    adj: dict[tuple[float, float], set[tuple[float, float]]] = {}
    for a, b in segments:
        ka, kb = _pk(a), _pk(b)
        adj.setdefault(ka, set()).add(kb)
        adj.setdefault(kb, set()).add(ka)
    return adj


def _longest_cycle_from_segments(
    segments: list[tuple[tuple[float, float], tuple[float, float]]],
) -> list[tuple[float, float]]:
    adj_list = _segments_to_adj(segments)
    adj_mut: dict[tuple[float, float], set[tuple[float, float]]] = {
        k: set(v) for k, v in adj_list.items()
    }
    best: list[tuple[float, float]] = []
    best_len = -1.0
    while adj_mut:
        adj_walk = {k: sorted(v) for k, v in adj_mut.items()}
        cyc = _walk_cycle(adj_walk)
        if len(cyc) < 3:
            break
        perim = sum(
            _segment_length(cyc[i], cyc[(i + 1) % len(cyc)]) for i in range(len(cyc))
        )
        if perim > best_len:
            best_len = perim
            best = list(cyc)
        _remove_cycle_edges(adj_mut, cyc)
    if len(best) < 3:
        raise ValueError("no closed contour found at layer height")
    return best


def _contour_at_z(
    verts: list[Vector], polys: list[tuple[int, ...]], z: float, tol: float
) -> list[tuple[float, float]]:
    segs = _collect_slice_segments(verts, polys, z, tol)
    if not segs:
        raise ValueError(f"no intersection at z={z}")
    return _longest_cycle_from_segments(segs)


def _mesh_world_geometry(obj: bpy.types.Object, depsgraph: bpy.types.Depsgraph):
    eval_obj = obj.evaluated_get(depsgraph)
    mesh = eval_obj.to_mesh()
    try:
        mw = eval_obj.matrix_world
        verts = [mw @ mesh.vertices[i].co for i in range(len(mesh.vertices))]
        polys: list[tuple[int, ...]] = []
        for p in mesh.polygons:
            polys.append(tuple(p.vertices))
        return verts, polys
    finally:
        eval_obj.to_mesh_clear()


def _layer_plane_heights(
    z_min: float, z_max: float, first_layer_height: float, layer_height: float, tol: float
) -> list[float]:
    if z_max - z_min < tol:
        return [z_min]
    heights: list[float] = []
    z = z_min + first_layer_height
    while z <= z_max - tol:
        heights.append(z)
        z = z + layer_height
    if not heights:
        heights = [z_min + (z_max - z_min) * 0.5]
    return heights


def mesh_to_print_ir(
    obj: bpy.types.Object,
    depsgraph: bpy.types.Depsgraph,
    layer_height: float,
    first_layer_height: float,
    feedrate: float,
    filament_mode: str = "SAME_0",
    z_tol: float = 1e-5,
) -> ir.PrintIR:
    if obj.type != "MESH":
        raise TypeError("active object must be a mesh")
    if layer_height <= 0 or first_layer_height <= 0:
        raise ValueError("layer heights must be positive")

    verts, polys = _mesh_world_geometry(obj, depsgraph)
    zs = [v.z for v in verts]
    z_min, z_max = min(zs), max(zs)
    layers_z = _layer_plane_heights(z_min, z_max, first_layer_height, layer_height, z_tol)

    ff = _filament_fn(filament_mode)
    out_layers: list[ir.Layer] = []

    for idx, lz in enumerate(layers_z):
        loop2d = _contour_at_z(verts, polys, lz, z_tol)
        segs: list[ir.Segment] = []
        n = len(loop2d)
        for i in range(n):
            x0, y0 = loop2d[i]
            x1, y1 = loop2d[(i + 1) % n]
            segs.append(
                ir.Segment(
                    p0=(x0, y0, lz),
                    p1=(x1, y1, lz),
                    e_delta=0.0,
                    feedrate=feedrate,
                )
            )
        out_layers.append(
            ir.Layer(
                z=lz,
                perimeter=tuple(segs),
                filament_index=ff(idx),
            )
        )

    print_ir = ir.PrintIR(layers=tuple(out_layers), machine_profile_id="x1c_ams")
    ir.validate_print_ir(print_ir)
    global _last_ir
    _last_ir = print_ir
    return print_ir
