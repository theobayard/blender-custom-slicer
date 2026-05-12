# blender-custom-slicer

Blender add-on that builds a single-perimeter layer path and composes SD-card `.gcode` with a captured Bambu X1C + AMS template.

See [MEMORY.md](MEMORY.md) for assumptions and template capture.

## Install

Zip the `blender_addon` directory or use **Install** and pick that folder in Blender **Edit → Preferences → Add-ons**.

## Usage

1. Set **Template path** to your exported X1C+AMS `.gcode`.
2. Select a mesh object.
3. **Generate path** then **Export G-code**.

## Layout

- [blender_addon/__init__.py](blender_addon/__init__.py) — `bl_info`, `register` / `unregister` only (no `bpy` at import time so tests can import core modules).
- [blender_addon/operators.py](blender_addon/operators.py) — panels and operators.
- `ir`, `export`, `template_parse` — pure Python; `slice`, `preview` — require Blender.

## Tests

```bash
pip install pytest
pytest
```

