from __future__ import annotations

from dataclasses import dataclass


class MissingPurgeTowerError(ValueError):
    pass


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
