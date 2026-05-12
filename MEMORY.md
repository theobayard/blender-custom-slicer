# blender-custom-slicer

## Purpose

Blender add-on: vase-oriented mesh → per-layer single perimeter → plain `.gcode` for Bambu X1C + AMS (SD card), using one Bambu Studio–exported template for header/footer and toolchange macros.

## Assumptions

- Mesh is vase-compatible (single outer wall per layer; no infill/shells in this tool).
- Layer 0 uses `filament_index == 0` (matches template preamble loading slot 0).
- Template was sliced in Bambu Studio for X1C + AMS with two filaments (A=slot 0, B=slot 1) and at least two toolchanges (e.g. A→B→A) so both `; CP TOOLCHANGE START` … `; CP TOOLCHANGE END` blocks exist; first block treated as 0→1, second as 1→0.
- Model XY fits the bed assumed by the template (plan referenced 200×200; adjust template if your object is larger).

## Template capture (one-time)

1. X1C + AMS, two materials in slots 0 and 1.
2. Placeholder model (e.g. cube) with height sufficient for several layers.
3. Force at least two filament changes so exported `.gcode` contains two CP toolchange blocks (order: first change 0→1, second 1→0).
4. Export `.gcode`, point add-on **Template path** at that file.

Optional: add a line `; ---CUSTOM_MOTION_START---` immediately before the first segment of motion you want replaced; if present, **header** ends before that line (everything after the marker is ignored until toolchange parsing). If absent, **header** is all lines before the first `; CP TOOLCHANGE START`.

## Limits / non-goals (MVP)

- No cloud `.gcode.3mf` packaging.
- No Orca/Bambu CLI handoff for custom paths.
- N-gons are fan-triangulated from vertex 0 for slicing; non-convex polygons can produce wrong contours (prefer triangulated / convex meshes for critical prints).
- Hardware validation is manual on printer (see checklist below).

## Manual hardware checklist

1. **Single-filament cylinder:** Filament mode *Single (slot 0)*, one AMS slot loaded, verify path and print.
2. **Two-color cylinder:** *Alternate 0/1*, two materials in AMS slots 0 and 1, verify one swap and second layer color.
3. **Full vase:** Same as production settings, confirm no layer skips and acceptable seam.

## Dev

- Install: **Edit → Preferences → Add-ons → Install…** select the `blender_addon` folder (or zip the folder).
- Tests: `pytest` from repo root (no Blender required for parser/export tests).
