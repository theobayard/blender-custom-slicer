from __future__ import annotations

from dataclasses import dataclass

START = "; CP TOOLCHANGE START"
END = "; CP TOOLCHANGE END"
CUSTOM_START = "; ---CUSTOM_MOTION_START---"


@dataclass(frozen=True)
class ParsedTemplate:
    header: str
    swap_0_to_1: str
    swap_1_to_0: str
    footer: str


class TemplateParseError(ValueError):
    pass


def _strip_trailing_blank(lines: list[str]) -> list[str]:
    while lines and lines[-1].strip() == "":
        lines.pop()
    return lines


def parse_bambu_template(text: str) -> ParsedTemplate:
    raw_lines = text.splitlines()
    lines = [ln.rstrip("\r") for ln in raw_lines]

    custom_idx = None
    for i, ln in enumerate(lines):
        if ln.strip() == CUSTOM_START.strip():
            custom_idx = i
            break

    if custom_idx is not None:
        header_lines = lines[:custom_idx]
    else:
        start_indices: list[int] = []
        for i, ln in enumerate(lines):
            if ln.strip() == START:
                start_indices.append(i)
        if len(start_indices) < 2:
            raise TemplateParseError(
                "need at least two '; CP TOOLCHANGE START' blocks (capture A,B,A style export)"
            )
        header_lines = lines[: start_indices[0]]

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

    footer_lines = lines[second_e + 1 :]

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
