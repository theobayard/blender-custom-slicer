from __future__ import annotations

from ..template_parse.types import GcodeChunk, ParsedTemplate, PurgeIndex
from .gcode_edit import rebase_swap_z

WIPE_TOWER_Z_EPS = 1e-4


def missing_purge_tower_message(
    layer_num_1based: int,
    z: float,
    prev_f: int,
    new_f: int,
    *,
    for_transition: bool,
) -> str:
    tail = (
        f"filament transition at layer {layer_num_1based} (Z={z:.5f} mm, {prev_f}→{new_f}). "
        if for_transition
        else f"layer {layer_num_1based} (Z={z:.5f} mm); this template supplies a purge map for every layer of this print. "
    )
    return (
        "No standalone purge tower in template for "
        + tail
        + "Use a template whose standalone '; WIPE_TOWER_*' blocks carry "
        "'; layer num/total_layer_count: <k>/<N>' matching this layer index, "
        "or (legacy) a '; Z_HEIGHT:' fallback map outside the first two "
        "'; CP TOOLCHANGE' blocks."
    )


def swap_macro_text(parsed: ParsedTemplate, prev_f: int, new_f: int, target_z: float) -> str:
    if prev_f == new_f:
        return ""
    if prev_f == 0 and new_f == 1:
        macro = parsed.swap_0_to_1
    elif prev_f == 1 and new_f == 0:
        macro = parsed.swap_1_to_0
    else:
        raise ValueError(
            f"unsupported filament transition {prev_f} -> {new_f} (MVP supports 0 and 1 only)"
        )
    if macro.source_z is None:
        return macro.text
    return rebase_swap_z(macro.text, macro.source_z, target_z)


def _maintenance_for_layer(
    index: PurgeIndex, layer_1based: int
) -> GcodeChunk | None:
    m = index.maintenance_by_layer
    if not m:
        return None
    hit = m.get(layer_1based)
    if hit is not None:
        return hit
    for delta in range(1, len(m) + 1):
        for key in (layer_1based - delta, layer_1based + delta):
            if key < 1 or key not in m:
                continue
            return m[key]
    return None


def _other_for_layer(index: PurgeIndex, layer_1based: int) -> GcodeChunk | None:
    o = index.other_by_layer
    if not o:
        return None
    hit = o.get(layer_1based)
    if hit is not None:
        return hit
    for delta in range(1, len(o) + 1):
        for key in (layer_1based - delta, layer_1based + delta):
            if key < 1 or key not in o:
                continue
            return o[key]
    return None


def _z_fallback_chunk(
    index: PurgeIndex,
    layer_z: float,
    slice_thickness_mm: float,
) -> GcodeChunk | None:
    zb = index.z_fallback
    if not zb:
        return None
    max_radius = max(WIPE_TOWER_Z_EPS, 0.51 * slice_thickness_mm)
    best: tuple[str, float, float] | None = None
    for k, txt in zb.items():
        diff = abs(k - layer_z)
        if diff > max_radius:
            continue
        if best is None or diff < best[2] or (diff == best[2] and k < best[1]):
            best = (txt, k, diff)
    if best is None:
        return None
    return GcodeChunk(best[0], best[1])


def resolve_purge_for_layer(
    parsed: ParsedTemplate,
    layer_idx_0based: int,
    layer_z: float,
    slice_thickness_mm: float,
    *,
    prev_filament: int = 0,
    new_filament: int = 0,
    filament_changed: bool = False,
) -> GcodeChunk | None:
    index = parsed.purge_index
    if filament_changed:
        if prev_filament == 0 and new_filament == 1:
            if index.post_swap_0_to_1 is not None:
                return index.post_swap_0_to_1
        elif prev_filament == 1 and new_filament == 0:
            if index.post_swap_1_to_0 is not None:
                return index.post_swap_1_to_0
    hit = _maintenance_for_layer(index, layer_idx_0based + 1)
    if hit is not None:
        return hit
    hit = _other_for_layer(index, layer_idx_0based + 1)
    if hit is not None:
        return hit
    return _z_fallback_chunk(index, layer_z, slice_thickness_mm)
