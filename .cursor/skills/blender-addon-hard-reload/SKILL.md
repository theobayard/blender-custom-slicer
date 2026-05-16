     ---
name: blender-addon-hard-reload
description: Hard reload a Blender add-on after Python edits by disabling it, removing its modules from sys.modules, invalidating import caches, re-enabling it, and verifying the loaded version/path. Use when Blender appears to keep stale code after addon reload.
---
# Blender Add-on Hard Reload

Use this workflow after editing `blender_addon/*.py` when normal disable/enable does not pick up changes.

## Required sequence

1. Disable the add-on with `bpy.ops.preferences.addon_disable(module="blender_addon")`.
2. Remove `blender_addon` and `blender_addon.*` entries from `sys.modules`.
3. Run `importlib.invalidate_caches()`.
4. Re-enable with `bpy.ops.preferences.addon_enable(module="blender_addon")`.
5. Verify:
   - add-on is enabled
   - loaded `bl_info["version"]`
   - loaded module path

## MCP execution pattern

- Use `user-blender` MCP tool `execute_blender_code`.
- Return a JSON-serializable `result` dict with:
  - `was_enabled`
  - `is_enabled_now`
  - `loaded_version`
  - `loaded_path`

## Canonical snippet

```python
import sys
import importlib
import bpy
import addon_utils

module_name = "blender_addon"

def is_enabled(name):
    return any(a.module == name for a in bpy.context.preferences.addons)

was_enabled = is_enabled(module_name)
if was_enabled:
    bpy.ops.preferences.addon_disable(module=module_name)

for key in list(sys.modules.keys()):
    if key == module_name or key.startswith(module_name + "."):
        del sys.modules[key]

importlib.invalidate_caches()
bpy.ops.preferences.addon_enable(module=module_name)

loaded_version = None
loaded_path = None
for mod in addon_utils.modules():
    if mod.__name__ == module_name:
        loaded_version = mod.bl_info.get("version")
        loaded_path = getattr(mod, "__file__", None)
        break

result = {
    "was_enabled": was_enabled,
    "is_enabled_now": is_enabled(module_name),
    "loaded_version": loaded_version,
    "loaded_path": loaded_path,
}
```
