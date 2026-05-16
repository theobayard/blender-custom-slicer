from __future__ import annotations

import re
from dataclasses import dataclass

from . import ir
from .template_parse import ParsedTemplate

_MOTION_CMD_RE = re.compile(r"^\s*G[0-3]\b", re.IGNORECASE)
_Z_TOKEN_RE = re.compile(r"(?<![A-Za-z])Z(-?\d+(?:\.\d+)?)")


def _rebase_swap_z(macro: str, source_z: float, target_z: float) -> str:
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


@dataclass(frozen=True)
class ExportSettings:
    feedrate_first_layer_scale: float = 0.5


@dataclass(frozen=True)
class ExportLayerOptions:
    emit_bambu_markers: bool = True
    layer_fan_enable: bool = False
    layer_fan_percent: int = 100
    layer_fan_use_p1: bool = True


def _fan_pwm_from_percent(percent: int) -> int:
    return max(0, min(255, int(round(percent * 255 / 100))))


def _layer_fan_gcode(percent: int, use_p1: bool) -> str:
    pwm = _fan_pwm_from_percent(percent)
    if use_p1:
        return f"M106 P1 S{pwm}\n"
    return f"M106 S{pwm}\n"


def _append_bambu_layer_markers(
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


def _swap_macro(
    parsed: ParsedTemplate, prev_f: int, new_f: int, target_z: float
) -> str:
    if prev_f == new_f:
        return ""
    if prev_f == 0 and new_f == 1:
        macro = parsed.swap_0_to_1
        source_z = parsed.swap_0_to_1_source_z
    elif prev_f == 1 and new_f == 0:
        macro = parsed.swap_1_to_0
        source_z = parsed.swap_1_to_0_source_z
    else:
        raise ValueError(
            f"unsupported filament transition {prev_f} -> {new_f} (MVP supports 0 and 1 only)"
        )
    if source_z is None:
        return macro
    return _rebase_swap_z(macro, source_z, target_z)


def _e_per_mm(line_width: float, layer_h: float, filament_diameter: float) -> float:
    r = filament_diameter * 0.5
    filament_area = 3.141592653589793 * r * r
    vol_per_mm = line_width * layer_h
    return vol_per_mm / filament_area if filament_area > 0 else 0.0


def export_print_ir_to_gcode_string(
    print_ir: ir.PrintIR,
    parsed: ParsedTemplate,
    line_width: float,
    first_layer_height: float,
    layer_height: float,
    filament_diameter: float,
    default_feedrate: float,
    settings: ExportSettings | None = None,
    layer_options: ExportLayerOptions | None = None,
) -> str:
    settings = settings or ExportSettings()
    layer_opts = layer_options or ExportLayerOptions()
    ir.validate_print_ir(print_ir)

    parts: list[str] = [
        parsed.header,
        "M82 ; absolute E for composed motion\nG92 E0\n",
    ]
    prev_f = 0
    e_accum = 0.0
    first_move = True
    total_layers = len(print_ir.layers)

    for layer_idx, layer in enumerate(print_ir.layers):
        fi = layer.filament_index
        if fi != prev_f:
            parts.append(_swap_macro(parsed, prev_f, fi, layer.z))
            p0 = layer.perimeter[0].p0
            parts.append(f"G1 X{p0[0]:.5f} Y{p0[1]:.5f} F30000\n")
            parts.append(f"G1 Z{layer.z:.5f} F1200\n")
            prev_f = fi
            first_move = False

        lh = first_layer_height if layer_idx == 0 else layer_height
        e_scale = _e_per_mm(line_width, lh, filament_diameter)
        fr = default_feedrate * (
            settings.feedrate_first_layer_scale if layer_idx == 0 else 1.0
        )

        if layer_opts.emit_bambu_markers:
            _append_bambu_layer_markers(
                parts, layer.z, lh, layer_idx + 1, total_layers
            )
        parts.append("; LAYER_CHANGE\n")
        pct = int(round(100.0 * (layer_idx + 1) / max(total_layers, 1)))
        parts.append(f"M73 P{pct} R0\n")

        for seg in layer.perimeter:
            x0, y0, z0 = seg.p0
            x1, y1, z1 = seg.p1
            length = (
                (x1 - x0) ** 2 + (y1 - y0) ** 2 + (z1 - z0) ** 2
            ) ** 0.5
            e_seg = seg.e_delta if seg.e_delta > 0 else e_scale * length
            if first_move:
                parts.append(f"G1 X{x0:.5f} Y{y0:.5f} Z{z0:.5f} F{fr:.1f}\n")
                first_move = False
            e_accum += e_seg
            parts.append(
                f"G1 X{x1:.5f} Y{y1:.5f} Z{z1:.5f} E{e_accum:.5f} F{fr:.1f}\n"
            )

        if layer_opts.layer_fan_enable and layer_idx < total_layers - 1:
            parts.append(
                _layer_fan_gcode(layer_opts.layer_fan_percent, layer_opts.layer_fan_use_p1)
            )

    parts.append(parsed.footer)
    return "".join(parts)


def emit_motion_from_ir(
    print_ir: ir.PrintIR,
    line_width: float,
    first_layer_height: float,
    layer_height: float,
    filament_diameter: float,
    default_feedrate: float,
    settings: ExportSettings | None = None,
    layer_options: ExportLayerOptions | None = None,
) -> str:
    settings = settings or ExportSettings()
    layer_opts = layer_options or ExportLayerOptions()
    ir.validate_print_ir(print_ir)
    parts: list[str] = []
    e_accum = 0.0
    first_move = True
    total_layers = len(print_ir.layers)
    for layer_idx, layer in enumerate(print_ir.layers):
        lh = first_layer_height if layer_idx == 0 else layer_height
        e_scale = _e_per_mm(line_width, lh, filament_diameter)
        fr = default_feedrate * (
            settings.feedrate_first_layer_scale if layer_idx == 0 else 1.0
        )
        if layer_opts.emit_bambu_markers:
            _append_bambu_layer_markers(
                parts, layer.z, lh, layer_idx + 1, total_layers
            )
        parts.append("; LAYER_CHANGE\n")
        pct = int(round(100.0 * (layer_idx + 1) / max(total_layers, 1)))
        parts.append(f"M73 P{pct} R0\n")
        for seg in layer.perimeter:
            x0, y0, z0 = seg.p0
            x1, y1, z1 = seg.p1
            length = (
                (x1 - x0) ** 2 + (y1 - y0) ** 2 + (z1 - z0) ** 2
            ) ** 0.5
            e_seg = seg.e_delta if seg.e_delta > 0 else e_scale * length
            if first_move:
                parts.append(f"G1 X{x0:.5f} Y{y0:.5f} Z{z0:.5f} F{fr:.1f}\n")
                first_move = False
            e_accum += e_seg
            parts.append(
                f"G1 X{x1:.5f} Y{y1:.5f} Z{z1:.5f} E{e_accum:.5f} F{fr:.1f}\n"
            )
        if layer_opts.layer_fan_enable and layer_idx < total_layers - 1:
            parts.append(
                _layer_fan_gcode(layer_opts.layer_fan_percent, layer_opts.layer_fan_use_p1)
            )
    return "".join(parts)
