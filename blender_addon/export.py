from __future__ import annotations

from dataclasses import dataclass

from . import ir
from .template_parse import ParsedTemplate


@dataclass(frozen=True)
class ExportSettings:
    feedrate_first_layer_scale: float = 0.5


def _swap_macro(parsed: ParsedTemplate, prev_f: int, new_f: int) -> str:
    if prev_f == new_f:
        return ""
    if prev_f == 0 and new_f == 1:
        return parsed.swap_0_to_1
    if prev_f == 1 and new_f == 0:
        return parsed.swap_1_to_0
    raise ValueError(
        f"unsupported filament transition {prev_f} -> {new_f} (MVP supports 0 and 1 only)"
    )


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
) -> str:
    settings = settings or ExportSettings()
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
            parts.append(_swap_macro(parsed, prev_f, fi))
            parts.append(f"G1 Z{layer.z:.5f} F{max(600.0, 1200.0):.0f}\n")
            prev_f = fi

        lh = first_layer_height if layer_idx == 0 else layer_height
        e_scale = _e_per_mm(line_width, lh, filament_diameter)
        fr = default_feedrate * (
            settings.feedrate_first_layer_scale if layer_idx == 0 else 1.0
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
) -> str:
    settings = settings or ExportSettings()
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
    return "".join(parts)
