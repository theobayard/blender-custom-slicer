import bpy
from mathutils import Vector

from . import ir

PREVIEW_OBJ_NAME = "SlicerPathPreview"
PREVIEW_DATA_NAME = "SlicerPathPreviewData"


def clear_preview() -> None:
    obj = bpy.data.objects.get(PREVIEW_OBJ_NAME)
    if obj:
        curve = obj.data
        bpy.data.objects.remove(obj, do_unlink=True)
        if curve and curve.users == 0:
            bpy.data.curves.remove(curve, do_unlink=True)


def build_preview(
    context: bpy.types.Context, print_ir: ir.PrintIR, mm_to_bu: float
) -> bpy.types.Object:
    clear_preview()
    curve = bpy.data.curves.new(PREVIEW_DATA_NAME, type="CURVE")
    curve.dimensions = "3D"
    obj = bpy.data.objects.new(PREVIEW_OBJ_NAME, curve)
    col = context.collection
    if col is None:
        col = context.scene.collection
    col.objects.link(obj)

    def _add_loop_spline(segments: tuple) -> None:
        spline = curve.splines.new("POLY")
        n = len(segments)
        if n == 0:
            curve.splines.remove(spline)
            return
        pts = [Vector(segments[i].p0) for i in range(n)]
        spline.points.add(n - 1)
        for i, co in enumerate(pts):
            spline.points[i].co = (
                co.x * mm_to_bu,
                co.y * mm_to_bu,
                co.z * mm_to_bu,
                1.0,
            )
        spline.use_cyclic_u = True

    for layer in print_ir.layers:
        for brim_loop in layer.brim_loops:
            _add_loop_spline(brim_loop)
        _add_loop_spline(layer.perimeter)

    return obj
