import ast
from pathlib import Path

from blender_addon.version import ADDON_VERSION, read_bl_info_version


def test_bl_info_version_literal_matches_version_module():
    init_path = (
        Path(__file__).resolve().parents[1] / "blender_addon" / "__init__.py"
    )
    tree = ast.parse(init_path.read_text(encoding="utf-8"))
    bl_info_node = None
    for node in tree.body:
        if isinstance(node, ast.Assign):
            for t in node.targets:
                if isinstance(t, ast.Name) and t.id == "bl_info":
                    bl_info_node = node.value
                    break
        if bl_info_node is not None:
            break
    assert isinstance(bl_info_node, ast.Dict), "bl_info must be a dict literal for Blender"
    assert read_bl_info_version() == ADDON_VERSION
