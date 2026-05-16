bl_info = {
    "name": "Custom Slicer (X1C path)",
    "author": "blender-custom-slicer",
    "version": (0, 1, 10),
    "blender": (3, 6, 0),
    "location": "View3D > Sidebar > Slicer",
    "description": "Single-perimeter slice preview and Bambu template G-code export",
    "category": "Object",
}


def register():
    from . import operators

    operators.register()


def unregister():
    from . import operators

    operators.unregister()
