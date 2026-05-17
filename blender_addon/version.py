from __future__ import annotations

import ast
from pathlib import Path


def read_bl_info_version() -> tuple[int, int, int]:
    init_path = Path(__file__).resolve().parent / "__init__.py"
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
    if not isinstance(bl_info_node, ast.Dict):
        raise RuntimeError("bl_info must be a dict literal in __init__.py")
    keys: list[str] = []
    for k in bl_info_node.keys:
        if isinstance(k, ast.Constant) and isinstance(k.value, str):
            keys.append(k.value)
        elif isinstance(k, ast.Str):
            keys.append(k.s)
    vi = keys.index("version")
    vnode = bl_info_node.values[vi]
    if not isinstance(vnode, ast.Tuple):
        raise RuntimeError("bl_info['version'] must be a tuple literal in __init__.py")
    tup: list[int] = []
    for el in vnode.elts:
        if isinstance(el, ast.Constant) and isinstance(el.value, int):
            tup.append(el.value)
        elif isinstance(el, ast.Num):
            tup.append(int(el.n))
    return tuple(tup)


ADDON_VERSION = read_bl_info_version()
ADDON_VERSION_STRING = "%d.%d.%d" % ADDON_VERSION
