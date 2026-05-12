# blender-custom-slicer

Blender add-on that builds a single-perimeter layer path and composes SD-card `.gcode` with a captured Bambu X1C + AMS template.

See [MEMORY.md](MEMORY.md) for assumptions and template capture.

## Install

Zip the `blender_addon` directory or use **Install** and pick that folder in Blender **Edit → Preferences → Add-ons**.

## Usage

1. Set **Template path** to your exported X1C+AMS `.gcode` (or, for testing only, [blender_addon/assets/minimal_bambu_template_placeholder.gcode](blender_addon/assets/minimal_bambu_template_placeholder.gcode) — **not for real prints**).
2. Select a mesh object.
3. **Generate path** then **Export G-code**.

## Layout

- [blender_addon/version.py](blender_addon/version.py) — `ADDON_VERSION` / `ADDON_VERSION_STRING` (bump when you change the add-on; shown in the Slicer panel and in `bl_info`).
- [blender_addon/operators.py](blender_addon/operators.py) — panels and operators.
- `ir`, `export`, `template_parse` — pure Python; `slice`, `preview` — require Blender.

## Tests

```bash
pip install pytest
pytest
```

