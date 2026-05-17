from __future__ import annotations

from .. import ir
from ..template_parse.types import GcodeChunk, ParsedTemplate
from .gcode_edit import (
    append_bambu_layer_markers,
    append_bambu_layer_progress,
    layer_fan_gcode,
    rebase_swap_z,
)
from .motion import (
    append_brim_loops,
    append_layer_entry_moves,
    append_perimeter,
    e_per_mm,
    xy_center_on_bed_offset,
)
from .purge_resolve import missing_purge_tower_message, resolve_purge_for_layer, swap_macro_text
from .types import ExportLayerOptions, ExportSettings, MissingPurgeTowerError


def _xy_offset_for_export(print_ir: ir.PrintIR, settings: ExportSettings) -> tuple[float, float]:
    if (
        settings.center_on_bed_at_export
        and settings.bed_width_mm > 0
        and settings.bed_depth_mm > 0
    ):
        return xy_center_on_bed_offset(
            print_ir, settings.bed_width_mm, settings.bed_depth_mm
        )
    return (0.0, 0.0)


def _append_purge_block(
    parts: list[str],
    wipe: GcodeChunk,
    layer_z: float,
    filament_changed: bool,
) -> None:
    if not filament_changed:
        parts.append("M83 ; relative E for purge tower\n")
        parts.append(f"G1 Z{layer_z:.5f} F30000\n")
    parts.append(rebase_swap_z(wipe.text, wipe.source_z, layer_z))


def _reset_absolute_e(parts: list[str]) -> float:
    parts.append("M82 ; restore absolute E after swap macro or purge tower\n")
    parts.append("G92 E0\n")
    return 0.0


def _emit_layers(
    print_ir: ir.PrintIR,
    line_width: float,
    first_layer_height: float,
    layer_height: float,
    filament_diameter: float,
    default_feedrate: float,
    settings: ExportSettings,
    layer_opts: ExportLayerOptions,
    *,
    parsed: ParsedTemplate | None = None,
    header_footer: tuple[str, str] | None = None,
) -> str:
    parts: list[str] = []
    if header_footer is not None:
        parts.append(header_footer[0])
        parts.append("M82 ; absolute E for composed motion\nG92 E0\n")

    prev_f = 0
    e_accum = 0.0
    total_layers = len(print_ir.layers)
    xy_offset = _xy_offset_for_export(print_ir, settings)
    require_purge_each_layer = (
        parsed.purge_index.requires_purge_every_layer(total_layers)
        if parsed is not None
        else False
    )
    object_id = parsed.object_id if parsed is not None else None

    for layer_idx, layer in enumerate(print_ir.layers):
        lh = first_layer_height if layer_idx == 0 else layer_height
        e_scale = e_per_mm(line_width, lh, filament_diameter)
        fr = default_feedrate * (
            settings.feedrate_first_layer_scale if layer_idx == 0 else 1.0
        )

        if layer_opts.emit_bambu_markers:
            append_bambu_layer_markers(
                parts, layer.z, lh, layer_idx + 1, total_layers
            )
        append_bambu_layer_progress(
            parts, layer_idx, emit_m991=layer_opts.emit_bambu_markers
        )

        fi = layer.filament_index
        prev_fil_before = prev_f
        filament_changed = fi != prev_fil_before
        wipe = None

        if parsed is not None:
            if filament_changed:
                parts.append(swap_macro_text(parsed, prev_fil_before, fi, layer.z))
                prev_f = fi
            wipe = resolve_purge_for_layer(
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
                        missing_purge_tower_message(
                            layer_idx + 1,
                            layer.z,
                            prev_fil_before,
                            fi,
                            for_transition=filament_changed,
                        )
                    )
            else:
                _append_purge_block(parts, wipe, layer.z, filament_changed)

            if filament_changed or wipe is not None:
                e_accum = _reset_absolute_e(parts)

        if layer_idx == 0 and layer.brim_loops:
            e_accum = append_brim_loops(
                parts, layer.brim_loops, e_scale, fr, xy_offset, e_accum
            )

        append_layer_entry_moves(
            parts,
            layer_idx,
            layer.perimeter[0].p0,
            layer.z,
            fr,
            object_id,
            xy_offset,
        )
        e_accum = append_perimeter(parts, layer, e_scale, fr, xy_offset, e_accum)

        if layer_opts.layer_fan_enable and layer_idx < total_layers - 1:
            parts.append(
                layer_fan_gcode(
                    layer_opts.layer_fan_percent, layer_opts.layer_fan_use_p1
                )
            )

    if header_footer is not None:
        parts.append(header_footer[1])
    return "".join(parts)


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
    return _emit_layers(
        print_ir,
        line_width,
        first_layer_height,
        layer_height,
        filament_diameter,
        default_feedrate,
        settings,
        layer_opts,
        parsed=parsed,
        header_footer=(parsed.header, parsed.footer),
    )


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
    return _emit_layers(
        print_ir,
        line_width,
        first_layer_height,
        layer_height,
        filament_diameter,
        default_feedrate,
        settings,
        layer_opts,
        parsed=None,
        header_footer=None,
    )
