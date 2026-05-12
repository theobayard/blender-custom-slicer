from __future__ import annotations

from dataclasses import dataclass
from typing import Optional

Vec3 = tuple[float, float, float]


@dataclass(frozen=True)
class SurfaceSample:
    triangle_index: int
    u: float
    v: float


@dataclass(frozen=True)
class Segment:
    p0: Vec3
    p1: Vec3
    e_delta: float
    feedrate: float
    surface_hit: Optional[SurfaceSample] = None


@dataclass(frozen=True)
class Layer:
    z: float
    perimeter: tuple[Segment, ...]
    filament_index: int


@dataclass(frozen=True)
class PrintIR:
    layers: tuple[Layer, ...]
    machine_profile_id: str = "x1c_ams"


class IRValidationError(ValueError):
    pass


def validate_print_ir(ir: PrintIR) -> None:
    if not ir.layers:
        raise IRValidationError("PrintIR has no layers")
    if ir.layers[0].filament_index != 0:
        raise IRValidationError("layer 0 must have filament_index == 0")
    for i, layer in enumerate(ir.layers):
        if not layer.perimeter:
            raise IRValidationError(f"layer {i} has empty perimeter")
        for seg in layer.perimeter:
            if seg.feedrate <= 0:
                raise IRValidationError(f"layer {i} has non-positive feedrate")
            if seg.e_delta < 0:
                raise IRValidationError(f"layer {i} has negative e_delta")
