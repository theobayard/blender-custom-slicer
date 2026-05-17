from __future__ import annotations

from .purge_towers import build_purge_index, header_total_layer_count, post_toolchange_tower_near_cp
from .toolchange import (
    extract_header_lines,
    first_object_id,
    require_two_toolchanges,
    strip_trailing_blank,
    trim_footer_to_machine_shutdown,
)
from .types import ParsedTemplate, PurgeIndex, SwapMacro


def normalize_lines(text: str) -> list[str]:
    return [ln.rstrip("\r") for ln in text.splitlines()]


def parse_bambu_template(text: str, *, header_trim: str = "auto") -> ParsedTemplate:
    lines = normalize_lines(text)
    block_ranges = require_two_toolchanges(lines)

    header_lines = extract_header_lines(lines, block_ranges, header_trim=header_trim)
    first_s, first_e, first_src_z = block_ranges[0]
    second_s, second_e, second_src_z = block_ranges[1]

    footer_lines = trim_footer_to_machine_shutdown(lines[second_e + 1 :])

    header = "\n".join(strip_trailing_blank(list(header_lines))) + "\n"
    swap_0_to_1 = SwapMacro(
        "\n".join(lines[first_s : first_e + 1]) + "\n", first_src_z
    )
    swap_1_to_0 = SwapMacro(
        "\n".join(lines[second_s : second_e + 1]) + "\n", second_src_z
    )
    footer = "\n".join(footer_lines)
    if footer and not footer.endswith("\n"):
        footer += "\n"

    hdr_layer_total = header_total_layer_count(lines)
    purge_index = build_purge_index(
        lines, (first_s, first_e), (second_s, second_e), hdr_layer_total
    )
    post_01 = post_toolchange_tower_near_cp(
        lines, first_s, first_e, block_ranges, 0
    )
    post_10 = post_toolchange_tower_near_cp(
        lines, second_s, second_e, block_ranges, 1
    )
    purge_index = PurgeIndex(
        maintenance_by_layer=purge_index.maintenance_by_layer,
        other_by_layer=purge_index.other_by_layer,
        z_fallback=purge_index.z_fallback,
        post_swap_0_to_1=post_01,
        post_swap_1_to_0=post_10,
        template_executable_layer_total=purge_index.template_executable_layer_total,
    )

    return ParsedTemplate(
        header=header,
        swap_0_to_1=swap_0_to_1,
        swap_1_to_0=swap_1_to_0,
        footer=footer,
        purge_index=purge_index,
        object_id=first_object_id(lines),
    )
