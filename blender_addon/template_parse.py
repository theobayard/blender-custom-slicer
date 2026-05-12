from __future__ import annotations

from dataclasses import dataclass

START = "; CP TOOLCHANGE START"
END = "; CP TOOLCHANGE END"
CUSTOM_START = "; ---CUSTOM_MOTION_START---"
EXECUTABLE_START = "; EXECUTABLE_BLOCK_START"
WIPE_TOWER_START = "; WIPE_TOWER_START"
MACHINE_END_START = "; MACHINE_END_GCODE_START"
EXECUTABLE_END = "; EXECUTABLE_BLOCK_END"


@dataclass(frozen=True)
class ParsedTemplate:
    header: str
    swap_0_to_1: str
    swap_1_to_0: str
    footer: str


class TemplateParseError(ValueError):
    pass


def _indices_of_cp_toolchange_start(lines: list[str]) -> list[int]:
    return [i for i, ln in enumerate(lines) if ln.strip() == START]


def _auto_header_end_before_first_wipe_tower(
    lines: list[str], first_cp_idx: int
) -> int | None:
    exec_idx = None
    for i, ln in enumerate(lines):
        if ln.strip() == EXECUTABLE_START:
            exec_idx = i
            break
    if exec_idx is None:
        return None
    for i in range(exec_idx + 1, first_cp_idx):
        if lines[i].strip() == WIPE_TOWER_START:
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

    start_indices = _indices_of_cp_toolchange_start(lines)
    if len(start_indices) < 2:
        raise TemplateParseError(
            "need at least two '; CP TOOLCHANGE START' blocks (capture A,B,A style export)"
        )
    first_cp_idx = start_indices[0]

    custom_idx = None
    for i, ln in enumerate(lines):
        if ln.strip() == CUSTOM_START.strip():
            custom_idx = i
            break

    if custom_idx is not None:
        header_lines = lines[:custom_idx]
    elif header_trim == "legacy":
        header_lines = lines[:first_cp_idx]
    else:
        auto_end = _auto_header_end_before_first_wipe_tower(lines, first_cp_idx)
        if auto_end is not None:
            header_lines = lines[:auto_end]
        else:
            header_lines = lines[:first_cp_idx]

    block_ranges: list[tuple[int, int]] = []
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
        block_ranges.append((i, j))
        i = j + 1

    if len(block_ranges) < 2:
        raise TemplateParseError(
            "need two toolchange blocks; slice a model with two filament changes in Bambu Studio"
        )

    first_s, first_e = block_ranges[0]
    second_s, second_e = block_ranges[1]
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
    )
