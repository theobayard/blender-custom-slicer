from __future__ import annotations

from collections import defaultdict

from .markers import (
    LAYER_MARKER_MAX_LOOKBACK,
    OBJECT_FEATURE_MARKERS,
    POST_TOOLCHANGE_MAX_CHUNK_LINES,
    POST_TOOLCHANGE_SCAN_LINES,
    WIPE_TOWER_END,
    WIPE_TOWER_PRELUDE_PREFIXES,
    WIPE_TOWER_START,
    Z_HEIGHT_PREFIX,
    _HEADER_TOTAL_LAYER_RE,
    _LAYER_NUM_TOTAL_RE,
)
from .toolchange import source_layer_z_above
from .types import GcodeChunk, PurgeIndex, TemplateParseError


def header_total_layer_count(lines: list[str], scan_limit: int = 4000) -> int | None:
    n = min(len(lines), scan_limit)
    for i in range(n):
        m = _HEADER_TOTAL_LAYER_RE.match(lines[i])
        if m:
            return int(m.group(1))
    return None


def source_layer_num_and_total_above(
    lines: list[str],
    start_idx: int,
    layer_total_filter: int | None,
) -> tuple[int | None, int | None]:
    lo = 0
    if layer_total_filter is not None:
        lo = max(0, start_idx - LAYER_MARKER_MAX_LOOKBACK)
    for i in range(start_idx - 1, lo - 1, -1):
        m = _LAYER_NUM_TOTAL_RE.match(lines[i])
        if not m:
            continue
        k = int(m.group(1))
        n = int(m.group(2))
        if layer_total_filter is not None and n != layer_total_filter:
            continue
        return k, n
    return None, None


def is_prime_tower_feature_comment(stripped: str) -> bool:
    return stripped.lower().startswith("; feature: prime tower")


def is_maintenance_purge_tower_chunk(chunk: str) -> bool:
    return "; CP EMPTY GRID" in chunk


def is_valid_post_toolchange_purge_chunk(chunk: str) -> bool:
    if is_maintenance_purge_tower_chunk(chunk):
        return False
    if len(chunk.splitlines()) > POST_TOOLCHANGE_MAX_CHUNK_LINES:
        return False
    return not any(marker in chunk for marker in OBJECT_FEATURE_MARKERS)


def wipe_tower_chunk_start_line(lines: list[str], wipe_start_idx: int) -> int:
    lo = wipe_start_idx
    k = wipe_start_idx - 1
    while k >= 0:
        st = lines[k].strip()
        if st.startswith(WIPE_TOWER_PRELUDE_PREFIXES) or is_prime_tower_feature_comment(
            st
        ):
            lo = k
            k -= 1
            continue
        break
    return lo


def wipe_inside_toolchange(
    t_lo: int, t_hi: int, cp0: tuple[int, int], cp1: tuple[int, int]
) -> bool:
    c0_lo, c0_hi = cp0
    c1_lo, c1_hi = cp1

    def inside(lo: int, hi: int) -> bool:
        return t_lo >= lo and t_hi <= hi

    return inside(c0_lo, c0_hi) or inside(c1_lo, c1_hi)


def standalone_wipe_chunk_at(
    lines: list[str], wipe_start_idx: int
) -> GcodeChunk:
    j = wipe_start_idx + 1
    while j < len(lines) and lines[j].strip() != WIPE_TOWER_END:
        j += 1
    if j >= len(lines):
        raise TemplateParseError(
            "unclosed '; WIPE_TOWER_START' block (missing '; WIPE_TOWER_END')"
        )
    chunk_lo = wipe_tower_chunk_start_line(lines, wipe_start_idx)
    chunk = "\n".join(lines[chunk_lo : j + 1]) + "\n"
    z_raw = source_layer_z_above(lines, wipe_start_idx)
    if z_raw is None:
        raise TemplateParseError(
            f"'; WIPE_TOWER_START' at line {wipe_start_idx + 1} has no preceding "
            f"'{Z_HEIGHT_PREFIX.strip()}'"
        )
    return GcodeChunk(chunk, float(z_raw))


def post_toolchange_tower_near_cp(
    lines: list[str],
    cp_start: int,
    cp_end: int,
    cp_ranges: list[tuple[int, int, float | None]],
    cp_index: int,
) -> GcodeChunk | None:
    next_cp_start = None
    if cp_index + 1 < len(cp_ranges):
        next_cp_start = cp_ranges[cp_index + 1][0]

    ahead_hi = min(len(lines), cp_end + 1 + POST_TOOLCHANGE_SCAN_LINES)
    if next_cp_start is not None:
        ahead_hi = min(ahead_hi, next_cp_start)

    for i in range(cp_end + 1, ahead_hi):
        if lines[i].strip() != WIPE_TOWER_START:
            continue
        chunk = standalone_wipe_chunk_at(lines, i)
        if is_valid_post_toolchange_purge_chunk(chunk.text):
            return chunk

    back_lo = max(0, cp_start - POST_TOOLCHANGE_SCAN_LINES)
    for i in range(cp_start - 1, back_lo - 1, -1):
        if lines[i].strip() != WIPE_TOWER_START:
            continue
        chunk = standalone_wipe_chunk_at(lines, i)
        if is_valid_post_toolchange_purge_chunk(chunk.text):
            return chunk

    return None


def build_purge_index(
    lines: list[str],
    cp0: tuple[int, int],
    cp1: tuple[int, int],
    layer_total_filter: int | None,
) -> PurgeIndex:
    c0_lo, c0_hi = cp0
    c1_lo, c1_hi = cp1

    by_ln: defaultdict[int, list[GcodeChunk]] = defaultdict(list)
    zb: defaultdict[float, list[str]] = defaultdict(list)
    tagged_any = False
    canon_total: int | None = None

    i = 0
    while i < len(lines):
        if lines[i].strip() != WIPE_TOWER_START:
            i += 1
            continue
        start_idx = i
        j = i + 1
        while j < len(lines) and lines[j].strip() != WIPE_TOWER_END:
            j += 1
        if j >= len(lines):
            raise TemplateParseError(
                "unclosed '; WIPE_TOWER_START' block (missing '; WIPE_TOWER_END')"
            )
        end_idx = j
        if wipe_inside_toolchange(start_idx, end_idx, (c0_lo, c0_hi), (c1_lo, c1_hi)):
            i = end_idx + 1
            continue

        chunk = standalone_wipe_chunk_at(lines, start_idx)
        layer_no, tot_n = source_layer_num_and_total_above(
            lines, start_idx, layer_total_filter
        )
        if layer_no is None:
            zb[round(chunk.source_z, 5)].append(chunk.text)
        else:
            tagged_any = True
            if tot_n is not None:
                if canon_total is None:
                    canon_total = tot_n
                elif canon_total != tot_n:
                    raise TemplateParseError(
                        f"contradicting template layer totals in purge segments: "
                        f"{canon_total} vs {tot_n}"
                    )
            by_ln[layer_no].append(chunk)
        i = end_idx + 1

    maintenance: dict[int, GcodeChunk] = {}
    other: dict[int, GcodeChunk] = {}
    exec_total: int | None = None

    if tagged_any:
        by_layer_flat: dict[int, GcodeChunk] = {}
        for lyr in sorted(by_ln):
            lst = by_ln[lyr]
            joined_text = "".join(c.text for c in lst)
            by_layer_flat[lyr] = GcodeChunk(joined_text, lst[0].source_z)
        ks = sorted(by_layer_flat.keys())
        if ks[0] != 1:
            raise TemplateParseError(
                "standalone purge towers: layer indices must start at 1"
            )
        if ks != list(range(1, ks[-1] + 1)):
            raise TemplateParseError(
                "standalone purge towers: contiguous layers 1…N required; "
                f"gap or duplicate ordering near layer {ks[-1]}"
            )
        kmax = ks[-1]
        exec_total = kmax
        if canon_total is not None:
            if canon_total < kmax:
                raise TemplateParseError(
                    "standalone purge towers: template total_layer_count "
                    f"{canon_total} contradicts purge blocks up to layer {kmax}"
                )
            if canon_total == kmax:
                exec_total = canon_total
        for lyr, chunk in by_layer_flat.items():
            if is_maintenance_purge_tower_chunk(chunk.text):
                maintenance[lyr] = chunk
            else:
                other[lyr] = chunk

    zb_out = {zk: "".join(parts) for zk, parts in zb.items()}
    return PurgeIndex(
        maintenance_by_layer=maintenance,
        other_by_layer=other,
        z_fallback=zb_out,
        template_executable_layer_total=exec_total,
    )
