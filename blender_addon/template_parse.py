from __future__ import annotations

import re
from collections import defaultdict
from dataclasses import dataclass, field

START = "; CP TOOLCHANGE START"
END = "; CP TOOLCHANGE END"
CUSTOM_START = "; ---CUSTOM_MOTION_START---"
EXECUTABLE_START = "; EXECUTABLE_BLOCK_START"
WIPE_TOWER_START = "; WIPE_TOWER_START"
WIPE_TOWER_END = "; WIPE_TOWER_END"
CHANGE_LAYER_START = "; CHANGE_LAYER"
MACHINE_END_START = "; MACHINE_END_GCODE_START"
EXECUTABLE_END = "; EXECUTABLE_BLOCK_END"
X1_SWAP_START_PREFIX = ";=X1"
FILAMENT_START = "; filament start gcode"
Z_HEIGHT_PREFIX = "; Z_HEIGHT:"

_LAYER_NUM_TOTAL_RE = re.compile(
    r"^\s*;\s*layer\s+num/total_layer_count:\s*(\d+)\s*/\s*(\d+)\s*$",
    re.IGNORECASE,
)
_HEADER_TOTAL_LAYER_RE = re.compile(
    r"^\s*;\s*total\s+layer\s+number:\s*(\d+)\s*$",
    re.IGNORECASE,
)


_POST_TOOLCHANGE_SCAN_LINES = 500
_POST_TOOLCHANGE_MAX_CHUNK_LINES = 120

_OBJECT_FEATURE_MARKERS = (
    "; OBJECT_ID:",
    "; FEATURE: Inner wall",
    "; FEATURE: Outer wall",
    "; FEATURE: Sparse infill",
)


@dataclass(frozen=True)
class ParsedTemplate:
    header: str
    swap_0_to_1: str
    swap_1_to_0: str
    footer: str
    swap_0_to_1_source_z: float | None = None
    swap_1_to_0_source_z: float | None = None
    object_id: str | None = None
    purge_towers_by_layer_1based: dict[int, tuple[str, float]] = field(default_factory=dict)
    purge_towers_by_layer_z_fallback: dict[float, str] = field(default_factory=dict)
    template_executable_layer_total: int | None = None
    purge_tower_post_swap_0_to_1: tuple[str, float] | None = None
    purge_tower_post_swap_1_to_0: tuple[str, float] | None = None


class TemplateParseError(ValueError):
    pass


def _cp_toolchange_ranges(
    lines: list[str],
) -> list[tuple[int, int, float | None]]:
    block_ranges: list[tuple[int, int, float | None]] = []
    i = 0
    while i < len(lines):
        if lines[i].strip() != START:
            i += 1
            continue
        j = i + 1
        while j < len(lines) and lines[j].strip() != END:
            j += 1
        if j >= len(lines):
            raise TemplateParseError("unclosed '; CP TOOLCHANGE START' block (missing END)")
        source_z = _source_layer_z_above(lines, i)
        block_ranges.append((i, j, source_z))
        i = j + 1
    return block_ranges


def _source_layer_z_above(lines: list[str], start_idx: int) -> float | None:
    for i in range(start_idx - 1, -1, -1):
        stripped = lines[i].strip()
        if stripped.startswith(Z_HEIGHT_PREFIX):
            try:
                return float(stripped[len(Z_HEIGHT_PREFIX):].strip())
            except ValueError:
                return None
    return None


def _header_total_layer_count(lines: list[str], scan_limit: int = 4000) -> int | None:
    n = min(len(lines), scan_limit)
    for i in range(n):
        m = _HEADER_TOTAL_LAYER_RE.match(lines[i])
        if m:
            return int(m.group(1))
    return None


_LAYER_MARKER_MAX_LOOKBACK = 600


def _source_layer_num_and_total_above(
    lines: list[str],
    start_idx: int,
    layer_total_filter: int | None,
) -> tuple[int | None, int | None]:
    lo = 0
    if layer_total_filter is not None:
        lo = max(0, start_idx - _LAYER_MARKER_MAX_LOOKBACK)
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


def _x1_toolchange_ranges(
    lines: list[str],
) -> list[tuple[int, int, float | None]]:
    starts = [i for i, ln in enumerate(lines) if ln.strip().startswith(X1_SWAP_START_PREFIX)]
    block_ranges: list[tuple[int, int, float | None]] = []
    for start_idx in starts:
        filament_start_idx = None
        for i in range(start_idx + 1, len(lines)):
            if lines[i].strip() == FILAMENT_START:
                filament_start_idx = i
                break
        if filament_start_idx is None:
            continue

        resume_idx = None
        for i in range(filament_start_idx + 1, len(lines)):
            stripped = lines[i].strip()
            if (
                stripped.startswith("; OBJECT_ID:")
                or stripped == "; CHANGE_LAYER"
                or stripped.startswith("; FEATURE:")
            ):
                resume_idx = i
                break

        end_idx = filament_start_idx if resume_idx is None else resume_idx - 1
        source_z = _source_layer_z_above(lines, start_idx)
        block_ranges.append((start_idx, end_idx, source_z))
    return block_ranges


def _auto_header_end_before_first_wipe_tower(
    lines: list[str], first_swap_idx: int
) -> int | None:
    exec_idx = None
    for i, ln in enumerate(lines):
        if ln.strip() == EXECUTABLE_START:
            exec_idx = i
            break
    if exec_idx is None:
        return None
    for i in range(exec_idx + 1, first_swap_idx):
        if lines[i].strip() == WIPE_TOWER_START:
            return i
    return None


def _auto_header_end_before_first_layer_change(
    lines: list[str], first_swap_idx: int
) -> int | None:
    exec_idx = None
    for i, ln in enumerate(lines):
        if ln.strip() == EXECUTABLE_START:
            exec_idx = i
            break
    if exec_idx is None:
        return None
    for i in range(exec_idx + 1, first_swap_idx):
        if lines[i].strip() == CHANGE_LAYER_START:
            return i
    return None


def _trim_footer_to_machine_shutdown(footer_lines: list[str]) -> list[str]:
    try:
        mi = next(
            i for i, ln in enumerate(footer_lines) if ln.strip() == MACHINE_END_START
        )
    except StopIteration:
        return footer_lines
    try:
        ei = next(
            i
            for i, ln in enumerate(footer_lines[mi:], start=mi)
            if ln.strip() == EXECUTABLE_END
        )
    except StopIteration:
        return footer_lines[mi:]
    return footer_lines[mi : ei + 1]


def _strip_trailing_blank(lines: list[str]) -> list[str]:
    while lines and lines[-1].strip() == "":
        lines.pop()
    return lines


_WIPE_TOWER_PRELUDE_PREFIXES = (
    "; LAYER_HEIGHT:",
    "; LINE_WIDTH:",
)


def _is_prime_tower_feature_comment(stripped: str) -> bool:
    return stripped.lower().startswith("; feature: prime tower")


def _is_maintenance_purge_tower_chunk(chunk: str) -> bool:
    return "; CP EMPTY GRID" in chunk


def _is_valid_post_toolchange_purge_chunk(chunk: str) -> bool:
    if _is_maintenance_purge_tower_chunk(chunk):
        return False
    if len(chunk.splitlines()) > _POST_TOOLCHANGE_MAX_CHUNK_LINES:
        return False
    return not any(marker in chunk for marker in _OBJECT_FEATURE_MARKERS)


def _standalone_wipe_chunk_at(
    lines: list[str], wipe_start_idx: int
) -> tuple[str, float]:
    j = wipe_start_idx + 1
    while j < len(lines) and lines[j].strip() != WIPE_TOWER_END:
        j += 1
    if j >= len(lines):
        raise TemplateParseError(
            "unclosed '; WIPE_TOWER_START' block (missing '; WIPE_TOWER_END')"
        )
    chunk_lo = _wipe_tower_chunk_start_line(lines, wipe_start_idx)
    chunk = "\n".join(lines[chunk_lo : j + 1]) + "\n"
    z_raw = _source_layer_z_above(lines, wipe_start_idx)
    if z_raw is None:
        raise TemplateParseError(
            f"'; WIPE_TOWER_START' at line {wipe_start_idx + 1} has no preceding "
            f"'{Z_HEIGHT_PREFIX.strip()}'"
        )
    return chunk, float(z_raw)


def _post_toolchange_tower_near_cp(
    lines: list[str],
    cp_start: int,
    cp_end: int,
    cp_ranges: list[tuple[int, int, float | None]],
    cp_index: int,
) -> tuple[str, float] | None:
    next_cp_start = None
    if cp_index + 1 < len(cp_ranges):
        next_cp_start = cp_ranges[cp_index + 1][0]

    ahead_hi = min(len(lines), cp_end + 1 + _POST_TOOLCHANGE_SCAN_LINES)
    if next_cp_start is not None:
        ahead_hi = min(ahead_hi, next_cp_start)

    for i in range(cp_end + 1, ahead_hi):
        if lines[i].strip() != WIPE_TOWER_START:
            continue
        chunk, z_raw = _standalone_wipe_chunk_at(lines, i)
        if _is_valid_post_toolchange_purge_chunk(chunk):
            return chunk, z_raw

    back_lo = max(0, cp_start - _POST_TOOLCHANGE_SCAN_LINES)
    for i in range(cp_start - 1, back_lo - 1, -1):
        if lines[i].strip() != WIPE_TOWER_START:
            continue
        chunk, z_raw = _standalone_wipe_chunk_at(lines, i)
        if _is_valid_post_toolchange_purge_chunk(chunk):
            return chunk, z_raw

    return None


def _wipe_tower_chunk_start_line(lines: list[str], wipe_start_idx: int) -> int:
    lo = wipe_start_idx
    k = wipe_start_idx - 1
    while k >= 0:
        st = lines[k].strip()
        if st.startswith(_WIPE_TOWER_PRELUDE_PREFIXES) or _is_prime_tower_feature_comment(
            st
        ):
            lo = k
            k -= 1
            continue
        break
    return lo


def _extract_standalone_purge_towers(
    lines: list[str],
    cp0: tuple[int, int],
    cp1: tuple[int, int],
    layer_total_filter: int | None,
) -> tuple[
    dict[int, tuple[str, float]],
    dict[float, str],
    int | None,
]:
    c0_lo, c0_hi = cp0
    c1_lo, c1_hi = cp1

    def tower_inside_cp(t_lo: int, t_hi: int) -> bool:
        def inside(lo: int, hi: int) -> bool:
            return t_lo >= lo and t_hi <= hi

        return inside(c0_lo, c0_hi) or inside(c1_lo, c1_hi)

    by_ln: defaultdict[int, list[tuple[str, float]]] = defaultdict(list)
    zb: defaultdict[float, list[str]] = defaultdict(list)
    tagged_any = False
    loose_any = False
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
        if tower_inside_cp(start_idx, end_idx):
            i = end_idx + 1
            continue

        chunk_lo = _wipe_tower_chunk_start_line(lines, start_idx)
        chunk = "\n".join(lines[chunk_lo : end_idx + 1]) + "\n"
        z_raw = _source_layer_z_above(lines, start_idx)
        if z_raw is None:
            raise TemplateParseError(
                f"'; WIPE_TOWER_START' at line {start_idx + 1} has no preceding "
                f"'{Z_HEIGHT_PREFIX.strip()}'"
            )
        layer_no, tot_n = _source_layer_num_and_total_above(
            lines, start_idx, layer_total_filter
        )
        if layer_no is None:
            loose_any = True
            zb[round(z_raw, 5)].append(chunk)
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
            by_ln[layer_no].append((chunk, float(z_raw)))
        i = end_idx + 1

    if tagged_any:
        by_layer_flat: dict[int, tuple[str, float]] = {}
        for lyr in sorted(by_ln):
            lst = by_ln[lyr]
            joined = "".join(t[0] for t in lst)
            by_layer_flat[lyr] = (joined, lst[0][1])
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
        zb_out = {zk: "".join(parts) for zk, parts in zb.items()}
        return by_layer_flat, zb_out, exec_total

    return {}, {zk: "".join(parts) for zk, parts in zb.items()}, None


def parse_bambu_template(text: str, *, header_trim: str = "auto") -> ParsedTemplate:
    raw_lines = text.splitlines()
    lines = [ln.rstrip("\r") for ln in raw_lines]

    block_ranges = _cp_toolchange_ranges(lines)
    if len(block_ranges) < 2:
        block_ranges = _x1_toolchange_ranges(lines)
    if len(block_ranges) < 2:
        raise TemplateParseError(
            "need two toolchange blocks; provide either '; CP TOOLCHANGE START/END' blocks or Bambu ';=X1' swaps"
        )
    first_swap_idx = block_ranges[0][0]

    custom_idx = None
    for i, ln in enumerate(lines):
        if ln.strip() == CUSTOM_START.strip():
            custom_idx = i
            break

    if custom_idx is not None:
        header_lines = lines[:custom_idx]
    elif header_trim == "legacy":
        header_lines = lines[:first_swap_idx]
    else:
        auto_end = _auto_header_end_before_first_wipe_tower(lines, first_swap_idx)
        if auto_end is None:
            auto_end = _auto_header_end_before_first_layer_change(lines, first_swap_idx)
        if auto_end is not None:
            header_lines = lines[:auto_end]
        else:
            header_lines = lines[:first_swap_idx]

    first_s, first_e, first_src_z = block_ranges[0]
    second_s, second_e, second_src_z = block_ranges[1]
    swap_01_lines = lines[first_s : first_e + 1]
    swap_10_lines = lines[second_s : second_e + 1]

    footer_lines = _trim_footer_to_machine_shutdown(lines[second_e + 1 :])

    header = "\n".join(_strip_trailing_blank(list(header_lines))) + "\n"
    swap_0_to_1 = "\n".join(swap_01_lines) + "\n"
    swap_1_to_0 = "\n".join(swap_10_lines) + "\n"
    footer = "\n".join(footer_lines)
    if footer and not footer.endswith("\n"):
        footer += "\n"

    object_id = _first_object_id(lines)

    hdr_layer_total = _header_total_layer_count(lines)
    by_ln, zb, exec_total = _extract_standalone_purge_towers(
        lines, (first_s, first_e), (second_s, second_e), hdr_layer_total
    )
    post_01 = _post_toolchange_tower_near_cp(
        lines, first_s, first_e, block_ranges, 0
    )
    post_10 = _post_toolchange_tower_near_cp(
        lines, second_s, second_e, block_ranges, 1
    )

    return ParsedTemplate(
        header=header,
        swap_0_to_1=swap_0_to_1,
        swap_1_to_0=swap_1_to_0,
        footer=footer,
        swap_0_to_1_source_z=first_src_z,
        swap_1_to_0_source_z=second_src_z,
        object_id=object_id,
        purge_towers_by_layer_1based=by_ln,
        purge_towers_by_layer_z_fallback=zb,
        template_executable_layer_total=exec_total,
        purge_tower_post_swap_0_to_1=post_01,
        purge_tower_post_swap_1_to_0=post_10,
    )


_OBJECT_ID_PREFIX = "; OBJECT_ID:"


def _first_object_id(lines: list[str]) -> str | None:
    for ln in lines:
        s = ln.strip()
        if s.startswith(_OBJECT_ID_PREFIX):
            value = s[len(_OBJECT_ID_PREFIX):].strip()
            if value:
                return value
    return None
