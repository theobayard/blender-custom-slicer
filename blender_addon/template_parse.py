from __future__ import annotations

from dataclasses import dataclass

START = "; CP TOOLCHANGE START"
END = "; CP TOOLCHANGE END"
CUSTOM_START = "; ---CUSTOM_MOTION_START---"
EXECUTABLE_START = "; EXECUTABLE_BLOCK_START"
WIPE_TOWER_START = "; WIPE_TOWER_START"
CHANGE_LAYER_START = "; CHANGE_LAYER"
MACHINE_END_START = "; MACHINE_END_GCODE_START"
EXECUTABLE_END = "; EXECUTABLE_BLOCK_END"
X1_SWAP_START_PREFIX = ";=X1"
FILAMENT_START = "; filament start gcode"
Z_HEIGHT_PREFIX = "; Z_HEIGHT:"


@dataclass(frozen=True)
class ParsedTemplate:
    header: str
    swap_0_to_1: str
    swap_1_to_0: str
    footer: str
    swap_0_to_1_source_z: float | None = None
    swap_1_to_0_source_z: float | None = None


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
        block_ranges.append((i, j, None))
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

    return ParsedTemplate(
        header=header,
        swap_0_to_1=swap_0_to_1,
        swap_1_to_0=swap_1_to_0,
        footer=footer,
        swap_0_to_1_source_z=first_src_z,
        swap_1_to_0_source_z=second_src_z,
    )
