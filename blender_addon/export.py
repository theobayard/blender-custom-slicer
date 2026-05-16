from __future__ import annotations

import re
from dataclasses import dataclass

from . import ir
from .template_parse import ParsedTemplate

_MOTION_CMD_RE = re.compile(r"^\s*G[0-3]\b", re.IGNORECASE)
_Z_TOKEN_RE = re.compile(r"(?<![A-Za-z])Z(-?\d+(?:\.\d+)?)")

WIPE_TOWER_Z_EPS = 1e-4


class MissingPurgeTowerError(ValueError):
    pass


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
    center_on_bed_at_export: bool = False
    bed_width_mm: float = 256.0
    bed_depth_mm: float = 256.0


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


def _append_bambu_layer_progress(
    parts: list[str], layer_idx: int, emit_m991: bool
) -> None:
    parts.append(f"M73 L{layer_idx + 1}\n")
    if emit_m991:
        parts.append(f"M991 S0 P{layer_idx} ;notify layer change\n")


def _purge_tower_slice_z_fallback(
    parsed: ParsedTemplate,
    layer_z: float,
    slice_thickness_mm: float,
) -> tuple[str, float] | None:
    zb = parsed.purge_towers_by_layer_z_fallback
    if not zb:
        return None
    max_radius = max(WIPE_TOWER_Z_EPS, 0.51 * slice_thickness_mm)
    best: tuple[str, float, float] | None = None
    for k, txt in zb.items():
        diff = abs(k - layer_z)
        if diff > max_radius:
            continue
        if best is None or diff < best[2] or (diff == best[2] and k < best[1]):
            best = (txt, k, diff)
    if best is None:
        return None
    return best[0], best[1]


def _maintenance_purge_tower_for_layer(
    parsed: ParsedTemplate, layer_1based: int
) -> tuple[str, float] | None:
    m = parsed.purge_towers_by_layer_1based
    if not m:
        return None
    hit = m.get(layer_1based)
    if hit is not None and "; CP EMPTY GRID" in hit[0]:
        return hit
    for delta in range(1, len(m) + 1):
        for key in (layer_1based - delta, layer_1based + delta):
            if key < 1 or key not in m:
                continue
            candidate = m[key]
            if "; CP EMPTY GRID" in candidate[0]:
                return candidate
    if hit is not None:
        return hit
    return None


def _purge_tower_for_export_layer(
    parsed: ParsedTemplate,
    layer_idx_0based: int,
    layer_z: float,
    slice_thickness_mm: float,
    *,
    prev_filament: int = 0,
    new_filament: int = 0,
    filament_changed: bool = False,
) -> tuple[str, float] | None:
    if filament_changed:
        if prev_filament == 0 and new_filament == 1:
            post = parsed.purge_tower_post_swap_0_to_1
            if post is not None:
                return post
        elif prev_filament == 1 and new_filament == 0:
            post = parsed.purge_tower_post_swap_1_to_0
            if post is not None:
                return post
    hit = _maintenance_purge_tower_for_layer(parsed, layer_idx_0based + 1)
    if hit is not None:
        return hit
    return _purge_tower_slice_z_fallback(
        parsed, layer_z, slice_thickness_mm
    )


def _template_covers_all_print_layers(parsed: ParsedTemplate, num_print_layers: int) -> bool:
    m = parsed.purge_towers_by_layer_1based
    if not m or num_print_layers < 1:
        return False
    return all(i in m for i in range(1, num_print_layers + 1))


def _missing_purge_tower_message(
    layer_num_1based: int,
    z: float,
    prev_f: int,
    new_f: int,
    *,
    for_transition: bool,
) -> str:
    tail = (
        f"filament transition at layer {layer_num_1based} (Z={z:.5f} mm, {prev_f}→{new_f}). "
        if for_transition
        else f"layer {layer_num_1based} (Z={z:.5f} mm); this template supplies a purge map for every layer of this print. "
    )
    return (
        "No standalone purge tower in template for "
        + tail
        + "Use a template whose standalone '; WIPE_TOWER_*' blocks carry "
        "'; layer num/total_layer_count: <k>/<N>' matching this layer index, "
        "or (legacy) a '; Z_HEIGHT:' fallback map outside the first two "
        "'; CP TOOLCHANGE' blocks."
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


def _ir_xy_min_max(print_ir: ir.PrintIR) -> tuple[float, float, float, float]:
    minx = miny = float("inf")
    maxx = maxy = float("-inf")
    for layer in print_ir.layers:
        for seg in layer.perimeter:
            for x, y in ((seg.p0[0], seg.p0[1]), (seg.p1[0], seg.p1[1])):
                minx = min(minx, x)
                maxx = max(maxx, x)
                miny = min(miny, y)
                maxy = max(maxy, y)
    return minx, maxx, miny, maxy


def _xy_center_on_bed_offset(
    print_ir: ir.PrintIR, bed_w: float, bed_d: float
) -> tuple[float, float]:
    minx, maxx, miny, maxy = _ir_xy_min_max(print_ir)
    cx = (minx + maxx) * 0.5
    cy = (miny + maxy) * 0.5
    return bed_w * 0.5 - cx, bed_d * 0.5 - cy


def _e_per_mm(line_width: float, layer_h: float, filament_diameter: float) -> float:
    r = filament_diameter * 0.5
    filament_area = 3.141592653589793 * r * r
    vol_per_mm = line_width * layer_h
    return vol_per_mm / filament_area if filament_area > 0 else 0.0


def _append_layer_entry_moves(
    parts: list[str],
    layer_idx: int,
    p0: tuple[float, float, float],
    layer_z: float,
    fr: float,
    object_id: str | None,
    xy_offset: tuple[float, float],
) -> None:
    x0 = p0[0] + xy_offset[0]
    y0 = p0[1] + xy_offset[1]
    if object_id is not None:
        parts.append(f"; OBJECT_ID: {object_id}\n")
    if layer_idx == 0:
        parts.append(f"G1 X{x0:.5f} Y{y0:.5f} Z{layer_z:.5f} F{fr:.1f}\n")
    else:
        parts.append(f"G1 X{x0:.5f} Y{y0:.5f} F30000\n")
        parts.append(f"G1 Z{layer_z:.5f} F1200\n")
    parts.append("; FEATURE: Outer wall\n")


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
    if (
        settings.center_on_bed_at_export
        and settings.bed_width_mm > 0
        and settings.bed_depth_mm > 0
    ):
        xy_offset = _xy_center_on_bed_offset(
            print_ir, settings.bed_width_mm, settings.bed_depth_mm
        )
    else:
        xy_offset = (0.0, 0.0)

    parts: list[str] = [
        parsed.header,
        "M82 ; absolute E for composed motion\nG92 E0\n",
    ]
    prev_f = 0
    e_accum = 0.0
    total_layers = len(print_ir.layers)
    require_purge_each_layer = _template_covers_all_print_layers(parsed, total_layers)

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
        _append_bambu_layer_progress(
            parts, layer_idx, emit_m991=layer_opts.emit_bambu_markers
        )

        fi = layer.filament_index
        prev_fil_before = prev_f
        filament_changed = fi != prev_fil_before
        if filament_changed:
            parts.append(_swap_macro(parsed, prev_fil_before, fi, layer.z))
            prev_f = fi

        wipe = _purge_tower_for_export_layer(
            parsed,
            layer_idx,
            layer.z,
            lh,
            prev_filament=prev_fil_before,
            new_filament=fi,
            filament_changed=filament_changed,
        )
        if wipe is None:
            if filament_changed or require_purge_each_layer:
                raise MissingPurgeTowerError(
                    _missing_purge_tower_message(
                        layer_idx + 1,
                        layer.z,
                        prev_fil_before,
                        fi,
                        for_transition=filament_changed,
                    )
                )
        else:
            wipe_text, wipe_src_z = wipe
            if not filament_changed:
                parts.append("M83 ; relative E for purge tower\n")
                parts.append(f"G1 Z{layer.z:.5f} F30000\n")
            parts.append(_rebase_swap_z(wipe_text, wipe_src_z, layer.z))

        if filament_changed or wipe is not None:
            parts.append("M82 ; restore absolute E after swap macro or purge tower\n")
            parts.append("G92 E0\n")
            e_accum = 0.0

        _append_layer_entry_moves(
            parts,
            layer_idx,
            layer.perimeter[0].p0,
            layer.z,
            fr,
            parsed.object_id,
            xy_offset,
        )

        for seg in layer.perimeter:
            x1, y1, _ = seg.p1
            x1 += xy_offset[0]
            y1 += xy_offset[1]
            length = (
                (seg.p1[0] - seg.p0[0]) ** 2
                + (seg.p1[1] - seg.p0[1]) ** 2
                + (seg.p1[2] - seg.p0[2]) ** 2
            ) ** 0.5
            e_seg = seg.e_delta if seg.e_delta > 0 else e_scale * length
            e_accum += e_seg
            parts.append(
                f"G1 X{x1:.5f} Y{y1:.5f} E{e_accum:.5f} F{fr:.1f}\n"
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
    if (
        settings.center_on_bed_at_export
        and settings.bed_width_mm > 0
        and settings.bed_depth_mm > 0
    ):
        xy_offset = _xy_center_on_bed_offset(
            print_ir, settings.bed_width_mm, settings.bed_depth_mm
        )
    else:
        xy_offset = (0.0, 0.0)
    parts: list[str] = []
    e_accum = 0.0
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
        _append_bambu_layer_progress(
            parts, layer_idx, emit_m991=layer_opts.emit_bambu_markers
        )
        _append_layer_entry_moves(
            parts, layer_idx, layer.perimeter[0].p0, layer.z, fr, None, xy_offset
        )
        for seg in layer.perimeter:
            x1, y1, _ = seg.p1
            x1 += xy_offset[0]
            y1 += xy_offset[1]
            length = (
                (seg.p1[0] - seg.p0[0]) ** 2
                + (seg.p1[1] - seg.p0[1]) ** 2
                + (seg.p1[2] - seg.p0[2]) ** 2
            ) ** 0.5
            e_seg = seg.e_delta if seg.e_delta > 0 else e_scale * length
            e_accum += e_seg
            parts.append(
                f"G1 X{x1:.5f} Y{y1:.5f} E{e_accum:.5f} F{fr:.1f}\n"
            )
        if layer_opts.layer_fan_enable and layer_idx < total_layers - 1:
            parts.append(
                _layer_fan_gcode(layer_opts.layer_fan_percent, layer_opts.layer_fan_use_p1)
            )
    return "".join(parts)
