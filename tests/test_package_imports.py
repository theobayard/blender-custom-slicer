from blender_addon import export
from blender_addon.export import purge_resolve as export_purge_resolve
from blender_addon.export.compose import export_print_ir_to_gcode_string
from blender_addon.export.gcode_edit import rebase_swap_z
from blender_addon.template_parse import (
    ParsedTemplate,
    PurgeIndex,
    parse_bambu_template,
)
from blender_addon.template_parse import purge_towers as tp_purge_towers


def test_facade_imports():
    assert callable(parse_bambu_template)
    assert callable(export_print_ir_to_gcode_string)
    assert callable(rebase_swap_z)
    assert callable(export.resolve_purge_for_layer)


def test_subpackage_imports():
    assert hasattr(tp_purge_towers, "build_purge_index")
    assert hasattr(export_purge_resolve, "resolve_purge_for_layer")
    assert ParsedTemplate is not None
    assert PurgeIndex is not None
