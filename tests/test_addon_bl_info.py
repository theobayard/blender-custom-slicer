import ast
from pathlib import Path

from blender_addon import version


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
    keys = []
    for k in bl_info_node.keys:
        if isinstance(k, ast.Constant) and isinstance(k.value, str):
            keys.append(k.value)
        elif isinstance(k, ast.Str):
            keys.append(k.s)
    vi = keys.index("version")
    vnode = bl_info_node.values[vi]
    assert isinstance(vnode, ast.Tuple), "bl_info['version'] must be a tuple literal"
    tup = []
    for el in vnode.elts:
        if isinstance(el, ast.Constant) and isinstance(el.value, int):
            tup.append(el.value)
        elif isinstance(el, ast.Num):
            tup.append(int(el.n))
    tup = tuple(tup)
    assert tup == version.ADDON_VERSION
