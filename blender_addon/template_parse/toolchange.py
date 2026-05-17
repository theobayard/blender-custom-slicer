from __future__ import annotations

from .markers import (
    CHANGE_LAYER_START,
    CUSTOM_START,
    END,
    EXECUTABLE_END,
    EXECUTABLE_START,
    FILAMENT_START,
    MACHINE_END_START,
    START,
    WIPE_TOWER_START,
    X1_SWAP_START_PREFIX,
    Z_HEIGHT_PREFIX,
)
from .types import TemplateParseError


def source_layer_z_above(lines: list[str], start_idx: int) -> float | None:
    for i in range(start_idx - 1, -1, -1):
        stripped = lines[i].strip()
        if stripped.startswith(Z_HEIGHT_PREFIX):
            try:
                return float(stripped[len(Z_HEIGHT_PREFIX) :].strip())
            except ValueError:
                return None
    return None


def cp_toolchange_ranges(
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
            raise TemplateParseError(
                "unclosed '; CP TOOLCHANGE START' block (missing END)"
            )
        source_z = source_layer_z_above(lines, i)
        block_ranges.append((i, j, source_z))
        i = j + 1
    return block_ranges


def x1_toolchange_ranges(
    lines: list[str],
) -> list[tuple[int, int, float | None]]:
    starts = [
        i for i, ln in enumerate(lines) if ln.strip().startswith(X1_SWAP_START_PREFIX)
    ]
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
        source_z = source_layer_z_above(lines, start_idx)
        block_ranges.append((start_idx, end_idx, source_z))
    return block_ranges


def require_two_toolchanges(
    lines: list[str],
) -> list[tuple[int, int, float | None]]:
    block_ranges = cp_toolchange_ranges(lines)
    if len(block_ranges) < 2:
        block_ranges = x1_toolchange_ranges(lines)
    if len(block_ranges) < 2:
        raise TemplateParseError(
            "need two toolchange blocks; provide either '; CP TOOLCHANGE START/END' "
            "blocks or Bambu ';=X1' swaps"
        )
    return block_ranges


def auto_header_end_before_first_wipe_tower(
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


def auto_header_end_before_first_layer_change(
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


def extract_header_lines(
    lines: list[str],
    block_ranges: list[tuple[int, int, float | None]],
    *,
    header_trim: str,
) -> list[str]:
    first_swap_idx = block_ranges[0][0]
    custom_idx = None
    for i, ln in enumerate(lines):
        if ln.strip() == CUSTOM_START.strip():
            custom_idx = i
            break

    if custom_idx is not None:
        return lines[:custom_idx]
    if header_trim == "legacy":
        return lines[:first_swap_idx]
    auto_end = auto_header_end_before_first_wipe_tower(lines, first_swap_idx)
    if auto_end is None:
        auto_end = auto_header_end_before_first_layer_change(lines, first_swap_idx)
    if auto_end is not None:
        return lines[:auto_end]
    return lines[:first_swap_idx]


def trim_footer_to_machine_shutdown(footer_lines: list[str]) -> list[str]:
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


def strip_trailing_blank(lines: list[str]) -> list[str]:
    out = list(lines)
    while out and out[-1].strip() == "":
        out.pop()
    return out


def first_object_id(lines: list[str]) -> str | None:
    from .markers import OBJECT_ID_PREFIX

    for ln in lines:
        s = ln.strip()
        if s.startswith(OBJECT_ID_PREFIX):
            value = s[len(OBJECT_ID_PREFIX) :].strip()
            if value:
                return value
    return None
