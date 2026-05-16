import bpy
from bpy.props import BoolProperty, EnumProperty, FloatProperty, StringProperty
from bpy.types import Operator, Panel, Scene
from bpy_extras.io_utils import ExportHelper

from . import export, preview, slice
from .template_parse import TemplateParseError, parse_bambu_template
from .version import ADDON_VERSION_STRING


class SLICER_OT_generate_path(Operator):
    bl_idname = "slicer.generate_path"
    bl_label = "Generate path"
    bl_options = {"REGISTER", "UNDO"}

    def execute(self, context):
        obj = context.active_object
        if not obj or obj.type != "MESH":
            self.report({"ERROR"}, "Select a mesh object")
            return {"CANCELLED"}
        s = context.scene
        try:
            bu_to_mm = slice.scene_bu_to_mm(s)
            print_ir = slice.mesh_to_print_ir(
                obj,
                context.evaluated_depsgraph_get(),
                s,
                s.slicer_layer_height,
                s.slicer_first_layer_height,
                s.slicer_feedrate,
                filament_mode=s.slicer_filament_mode,
            )
            preview.build_preview(context, print_ir, 1.0 / bu_to_mm)
        except Exception as e:
            self.report({"ERROR"}, str(e))
            return {"CANCELLED"}
        self.report({"INFO"}, f"Path: {len(print_ir.layers)} layers")
        return {"FINISHED"}


class SLICER_OT_export_gcode(Operator, ExportHelper):
    bl_idname = "slicer.export_gcode"
    bl_label = "Export G-code"
    bl_options = {"REGISTER"}
    filename_ext = ".gcode"
    filter_glob: StringProperty(default="*.gcode", options={"HIDDEN"}, maxlen=255)

    def execute(self, context):
        print_ir = slice.get_last_ir()
        if not print_ir:
            self.report({"ERROR"}, "Generate path first")
            return {"CANCELLED"}
        path = bpy.path.abspath(context.scene.slicer_template_path)
        if not path:
            self.report({"ERROR"}, "Set template path")
            return {"CANCELLED"}
        try:
            with open(path, "r", encoding="utf-8", errors="replace") as f:
                text = f.read()
            parsed = parse_bambu_template(text)
        except OSError as e:
            self.report({"ERROR"}, f"Template read failed: {e}")
            return {"CANCELLED"}
        except TemplateParseError as e:
            self.report({"ERROR"}, str(e))
            return {"CANCELLED"}
        s = context.scene
        try:
            body = export.export_print_ir_to_gcode_string(
                print_ir,
                parsed,
                s.slicer_line_width,
                s.slicer_first_layer_height,
                s.slicer_layer_height,
                s.slicer_filament_diameter,
                s.slicer_feedrate,
                settings=export.ExportSettings(
                    center_on_bed_at_export=s.slicer_export_center_on_bed,
                    bed_width_mm=s.slicer_bed_width_mm,
                    bed_depth_mm=s.slicer_bed_depth_mm,
                ),
            )
        except Exception as e:
            self.report({"ERROR"}, str(e))
            return {"CANCELLED"}
        out = bpy.path.abspath(self.filepath)
        try:
            with open(out, "w", encoding="utf-8", newline="\n") as f:
                f.write(body)
        except OSError as e:
            self.report({"ERROR"}, f"Write failed: {e}")
            return {"CANCELLED"}
        self.report({"INFO"}, f"Wrote {out}")
        return {"FINISHED"}


class SLICER_OT_clear_preview(Operator):
    bl_idname = "slicer.clear_preview"
    bl_label = "Clear preview"

    def execute(self, context):
        preview.clear_preview()
        slice.clear_last_ir()
        return {"FINISHED"}


class SLICER_PT_panel(Panel):
    bl_label = f"Slicer (v{ADDON_VERSION_STRING})"
    bl_idname = "SLICER_PT_panel"
    bl_space_type = "VIEW_3D"
    bl_region_type = "UI"
    bl_category = "Slicer"

    def draw(self, context):
        layout = self.layout
        s = context.scene
        layout.prop(s, "slicer_template_path", text="Template")
        layout.prop(s, "slicer_layer_height")
        layout.prop(s, "slicer_first_layer_height")
        layout.prop(s, "slicer_line_width")
        layout.prop(s, "slicer_filament_diameter")
        layout.prop(s, "slicer_feedrate")
        layout.prop(s, "slicer_mm_per_scene_meter")
        layout.prop(s, "slicer_export_center_on_bed")
        split = layout.split()
        split.enabled = s.slicer_export_center_on_bed
        split.prop(s, "slicer_bed_width_mm", text="Bed X (mm)")
        split.prop(s, "slicer_bed_depth_mm", text="Bed Y (mm)")
        layout.prop(s, "slicer_filament_mode")
        layout.operator("slicer.generate_path")
        layout.operator("slicer.export_gcode")
        layout.operator("slicer.clear_preview")


_cls = (
    SLICER_OT_generate_path,
    SLICER_OT_export_gcode,
    SLICER_OT_clear_preview,
    SLICER_PT_panel,
)


def register():
    for c in _cls:
        bpy.utils.register_class(c)
    Scene.slicer_template_path = StringProperty(
        name="Template path",
        description="Bambu Studio exported .gcode for X1C+AMS with two toolchanges",
        default="",
        subtype="FILE_PATH",
    )
    Scene.slicer_layer_height = FloatProperty(
        name="Layer height", default=0.2, min=0.01, max=1.0
    )
    Scene.slicer_first_layer_height = FloatProperty(
        name="First layer height", default=0.2, min=0.01, max=1.0
    )
    Scene.slicer_line_width = FloatProperty(
        name="Line width", default=0.45, min=0.05, max=2.0
    )
    Scene.slicer_filament_diameter = FloatProperty(
        name="Filament diameter", default=1.75, min=0.5, max=3.0
    )
    Scene.slicer_feedrate = FloatProperty(
        name="Feedrate", default=1800.0, min=60.0, max=30000.0
    )
    Scene.slicer_mm_per_scene_meter = FloatProperty(
        name="mm per scene meter",
        description=(
            "World length: first convert Blender units to meters (× scene unit scale), "
            "then × this → G-code mm. 10 ≈ same number as meters but printed as centimeters; "
            "1000 = full metric (1 scene m → 1000 mm on bed)"
        ),
        default=10.0,
        min=0.001,
        max=1_000_000.0,
    )
    Scene.slicer_export_center_on_bed = BoolProperty(
        name="Center on bed at export",
        description=(
            "Shift exported XY only so the path bbox is centered on the printable area "
            "(preview stays aligned with the model)"
        ),
        default=True,
    )
    Scene.slicer_bed_width_mm = FloatProperty(
        name="Bed width",
        description="Printable X size in mm for centering (X1/X1C default 256)",
        default=256.0,
        min=1.0,
        max=1000.0,
    )
    Scene.slicer_bed_depth_mm = FloatProperty(
        name="Bed depth",
        description="Printable Y size in mm for centering (X1/X1C default 256)",
        default=256.0,
        min=1.0,
        max=1000.0,
    )
    Scene.slicer_filament_mode = EnumProperty(
        name="Filament mode",
        items=(
            ("SAME_0", "Single (slot 0)", "All layers filament 0"),
            ("ALTERNATE_01", "Alternate 0/1", "Alternate layers for two-color tests"),
        ),
        default="SAME_0",
    )


def unregister():
    for c in reversed(_cls):
        try:
            bpy.utils.unregister_class(c)
        except RuntimeError:
            pass
    for attr in (
        "slicer_template_path",
        "slicer_layer_height",
        "slicer_first_layer_height",
        "slicer_line_width",
        "slicer_filament_diameter",
        "slicer_feedrate",
        "slicer_mm_per_scene_meter",
        "slicer_export_center_on_bed",
        "slicer_bed_width_mm",
        "slicer_bed_depth_mm",
        "slicer_filament_mode",
    ):
        try:
            delattr(Scene, attr)
        except Exception:
            pass
