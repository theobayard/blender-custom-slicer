from __future__ import annotations

import re

_MOTION_CMD_RE = re.compile(r"^\s*G[0-3]\b", re.IGNORECASE)
_Z_TOKEN_RE = re.compile(r"(?<![A-Za-z])Z(-?\d+(?:\.\d+)?)")


def rebase_swap_z(macro: str, source_z: float, target_z: float) -> str:
    delta = target_z - source_z
    if delta == 0.0:
        return macro
    out_lines: list[str] = []
    for line in macro.splitlines():
        if _MOTION_CMD_RE.match(line):

            def _shift(match: re.Match[str]) -> str:
                return f"Z{float(match.group(1)) + delta:.3f}"

            line = _Z_TOKEN_RE.sub(_shift, line)
        out_lines.append(line)
    return "\n".join(out_lines) + ("\n" if macro.endswith("\n") else "")


def fan_pwm_from_percent(percent: int) -> int:
    return max(0, min(255, int(round(percent * 255 / 100))))


def layer_fan_gcode(percent: int, use_p1: bool) -> str:
    pwm = fan_pwm_from_percent(percent)
    if use_p1:
        return f"M106 P1 S{pwm}\n"
    return f"M106 S{pwm}\n"


def append_bambu_layer_markers(
    parts: list[str],
    layer_z: float,
    layer_h: float,
    layer_num_1based: int,
    total_layers: int,
) -> None:
    parts.append("; CHANGE_LAYER\n")
    parts.append(f"; Z_HEIGHT: {layer_z:.5f}\n")
    parts.append(f"; LAYER_HEIGHT: {layer_h:.5f}\n")
    parts.append(
        f"; layer num/total_layer_count: {layer_num_1based}/{total_layers}\n"
    )


def append_bambu_layer_progress(
    parts: list[str], layer_idx: int, emit_m991: bool
) -> None:
    parts.append(f"M73 L{layer_idx + 1}\n")
    if emit_m991:
        parts.append(f"M991 S0 P{layer_idx} ;notify layer change\n")
