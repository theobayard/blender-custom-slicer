# blender-custom-slicer

## Purpose

Blender add-on: vase-oriented mesh → per-layer single perimeter → plain `.gcode` for Bambu X1C + AMS (SD card), using one Bambu Studio–exported template for header/footer and toolchange macros.

## Assumptions

- Mesh is vase-compatible (single outer wall per layer; no infill/shells in this tool).
- Layer 0 uses `filament_index == 0` (matches template preamble loading slot 0).
- Template was sliced in Bambu Studio for X1C + AMS with two filaments (A=slot 0, B=slot 1) and at least two toolchanges (e.g. A→B→A) so both `; CP TOOLCHANGE START` … `; CP TOOLCHANGE END` blocks exist; first block treated as 0→1, second as 1→0.
- Model XY fits the bed assumed by the template (plan referenced 200×200; adjust template if your object is larger).

## Template capture (one-time)

### Goal

One `.gcode` file from **Bambu Studio** for **X1C + AMS** that contains:

- A normal **start / first-filament** preamble (slot **0** loaded first — matches add-on rule: layer 0 uses filament **0**).
- **Two** Bambu toolchange macro blocks: `; CP TOOLCHANGE START` … `; CP TOOLCHANGE END`, in this order:
  1. First block = **filament 0 → 1**
  2. Second block = **filament 1 → 0**  
  (Capture with an **A → B → A** pattern so both directions appear once.)

### Bambu Studio walkthrough (typical flow)

1. **Printer and AMS**  
   - Select **X1 Carbon** (or your exact X1C profile) with **AMS** enabled.  
   - Add **two** filaments in Studio and assign them to **the first two AMS slots** (Studio usually labels them **1** and **2**). The add-on treats the **first** loaded slot as filament **0** and the **second** as filament **1** — keep that order when you paint A→B→A (first color = slot 1, second = slot 2, third = slot 1 again).

2. **Placeholder part**  
   - Add a simple solid (e.g. **cube**), modest size (e.g. **40–80 mm** tall is enough).  
   - Enough **layer count** so you can place **at least two** filament changes at different heights (taller cube = easier).

3. **Force A → B → A (two swaps)**  
   Use whichever Studio feature you have (names vary by version):

   - **Paint / segmentation:** Paint a **bottom** band as filament **A**, a **middle** band as **B**, **top** band as **A** again so the slice order along Z is **A → B → A**.  
   - **Multiple bodies:** Split height into three stacked cubes; assign bottom and top to **A**, middle to **B**, **merge** or keep as one plate object per Studio rules.  
   - **Height-based change:** If your build has “change filament at height/layer”, schedule **one** change **A→B** and a **second** change **B→A** before the print ends.

   You only need the **exported G-code** to contain **two** `; CP TOOLCHANGE START` blocks in the right **0→1 then 1→0** order; you do **not** need to print this cube for capture.

4. **Process**  
   - Use your real **nozzle**, **bed**, and **filament** types (template stays tied to those choices).  
   - **Slice** and confirm the preview shows **two** color transitions.

5. **Export**  
   - **Export** / **Export plate sliced file** → choose **`.gcode`** (plain G-code for SD), **not** only a `.3mf` if you need a single file path for the add-on.  
   - Save somewhere stable, e.g. `~/3dp/templates/x1c_ams_two_swap_template.gcode`.

6. **Verify before Blender**  
   Open the file in a text editor and search for **`; CP TOOLCHANGE START`**: you need **≥ 2** matches, with **`; CP TOOLCHANGE END`** closing each block.  
   Optional: search **`; CP TOOLCHANGE START`** and confirm the **first** block is the **first** time the job leaves filament 0 for 1 (first AMS change in the file). If your slice order were wrong (e.g. B first), **re-assign** paints so the **first** change is **0→1**.

7. **Optional marker (finer control than auto trim)**  
   Insert a line exactly:

   `; ---CUSTOM_MOTION_START---`

   **immediately before** the first line of motion you want replaced. **Header** is then everything **before** that line (this overrides auto wipe-tower trim).

8. **Auto header trim (default, no marker)**  
   If there is no custom marker, the parser ends **header** at the first `; WIPE_TOWER_START` that appears after `; EXECUTABLE_BLOCK_START` and before the first `; CP TOOLCHANGE START`. That removes the template’s wipe tower and first‑filament object toolpath from the header so the composed file is machine preamble + your IR motion (instead of embedding the whole first‑color cube). If that pattern is missing (e.g. wipe tower disabled), the parser falls back to **legacy**: header = everything before the first toolchange. For full control, use the custom marker above or pass `header_trim="legacy"` from code.

9. **Footer trim (always)**  
   After the second `; CP TOOLCHANGE END`, Bambu files usually continue with the **third‑filament object toolpath** before machine shutdown. That chunk is **discarded**. **Footer** is only lines from **`; MACHINE_END_GCODE_START`** through **`; EXECUTABLE_BLOCK_END`** (inclusive). If `; MACHINE_END_GCODE_START` is missing, the raw tail is kept (placeholder templates).

10. **Blender**  
   In the **Slicer** panel, set **Template path** to this `.gcode`. Use **Generate path** on your real mesh, then **Export G-code**.

### When to re-capture

- You change **printer model**, **AMS layout**, or **start G-code** significantly.  
- You need a **larger bed / object** than the template’s implicit limits.  
- Bambu **changes macro markers** in a firmware/Studio update (then we’d adjust the parser — today it expects `; CP TOOLCHANGE START` / `END`).

**Dev-only placeholder (do not print):** [blender_addon/assets/minimal_bambu_template_placeholder.gcode](blender_addon/assets/minimal_bambu_template_placeholder.gcode) — parses and composes for UI/export testing in Blender; it is **not** a real Bambu preamble or AMS macro set.

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

- **Bambu / G-code reference (local, for development):** [docs/gcode-reference/](docs/gcode-reference/) — not official Bambu specs; vendored notes for this repo.
  - [docs/gcode-reference/openbambuapi-gcode.md](docs/gcode-reference/openbambuapi-gcode.md) — from [OpenBambuAPI `gcode.md`](https://github.com/Doridian/OpenBambuAPI/blob/main/gcode.md): header block guards, AMS load/unload macro examples, and reverse‑engineered Bambu extensions (e.g. `M620`/`M621`, `M1002`, `G380`, non‑Marlin `G29` usage).
  - [docs/gcode-reference/community-gcode-docs.md](docs/gcode-reference/community-gcode-docs.md) — [rjduran/bambu-gcode-reference](https://github.com/rjduran/bambu-gcode-reference)–style table: header comment conventions, Marlin G/M codes Bambu Studio emits, and Bambu‑specific G/M sections (WIP community doc).
  - For **Bambu Studio placeholders** in custom G-code (`{layer_z}`, `{if}…{endif}`, etc.), the authoritative source remains the wiki: https://wiki.bambulab.com/en/software/bambu-studio/placeholder-list (not mirrored here unless added later).
- **Scene units → G-code mm:** world positions are `(BU × scene.unit_settings.scale_length) × slicer_mm_per_scene_meter`. **scale_length** turns BU into scene meters; **mm per scene meter** (panel default **10**) maps those meters to printer mm — **10** means one scene-meter prints as **10 mm** (same numerals as if that distance were **centimeters** on the bed). Use **1000** for true scale (1 scene m → 1000 mm). Composed motion is prefixed with **`M82`** and **`G92 E0`** after the template header because Bambu’s start block uses **`M83`** (relative E) while the exporter emits **absolute cumulative E**. The slicer does **not** auto-center on the bed: a Blender mesh at world `(0, 0, 0)` prints at the printer's `(0, 0)` corner — translate the mesh in Blender (or pick `mm_per_scene_meter` to land it where you want).
- **Post-swap motion invariant:** after each `_swap_macro` insertion, `export_print_ir_to_gcode_string` emits `G1 X{p0.x} Y{p0.y} F30000` (XY-only travel at clearance Z, since the rebased macro leaves the head at `layer_z + 3`) **then** `G1 Z{layer_z} F1200` (Z drop), **then** the perimeter loop extrudes from `p0`. Without this travel, the next `G1 X Y Z E F` extrudes from the wipe-park corner across the bed to the perimeter and silently eats the first edge `p0 → p1`. `_expected_total_lines` accounts for this as `post_swap_lines = (t01 + t10) * 2`.
- **Bambu Studio G-code preview:** composed motion emits **`M73 L<n>`** and **`M991 S0 P<n-1>`** (same pattern as Studio’s `layer_change_gcode`), not `M73 P… R0` percent lines and not Prusa-style **`; LAYER_CHANGE`** — Studio’s layer slider / Z grouping for AMS jobs keys off the native markers.
- **Color-change layer order (must match native Bambu):** for every layer, the exporter emits markers (`; CHANGE_LAYER`/`; Z_HEIGHT:`/`; LAYER_HEIGHT:`/`; layer num/...`/`M73 L`/`M991`) **before** the `_swap_macro` (when filament changes), then the macro, then **`M82` + `G92 E0`** to undo the macro’s internal `M83` (relative E) and zero state, then post-swap **`; OBJECT_ID: <id>`** wrapper, then `G1 X Y F30000` travel at clearance, then `G1 Z<layer.z> F1200` drop, then **`; FEATURE: Outer wall`**, then **XY-only** extrudes (no per-segment Z). Putting markers after the swap, or leaving the printer in `M83` after the macro, makes Bambu Studio’s preview collapse all layers to first-layer Z and over-extrude. `e_accum` resets to 0 after each swap because the macro itself runs `G92 E0`. Layer 0 keeps its combined `G1 X Y Z F` initial approach.
- **`; OBJECT_ID:` is required for preview Z binning:** when `exclude_object = 1` (Bambu default), Studio’s preview groups extrudes by object span. Without `; OBJECT_ID:` wrappers our extrudes stay outside any object span and the preview renders all layers stacked at first-layer Z even though `G1 Z<layer.z>` is correct. `ParsedTemplate.object_id` captures the first `; OBJECT_ID: <id>` value from the template and the exporter emits one `; OBJECT_ID: <id>` plus a single `; FEATURE: Outer wall` per layer. If the template has no `; OBJECT_ID:`, both are skipped (minimal placeholder template path).
- Install: **Edit → Preferences → Add-ons → Install…** select the `blender_addon` folder (or zip the folder).
- **Local export output:** save Blender **Export G-code** and other scratch prints under **`local_gcode/`** at the repo root. That directory is **gitignored**; keep tracked templates/samples in [blender_addon/assets/](blender_addon/assets/) only.
- Tests: `pytest` from repo root (no Blender required for parser/export tests).
- Keep `git status` clean proactively: remove scratch artifacts and revert unrelated accidental edits before handing work back.
- **Add-on version:** bump `ADDON_VERSION` in [blender_addon/version.py](blender_addon/version.py) **and** the **`"version": (x, y, z)`** tuple inside [blender_addon/__init__.py](blender_addon/__init__.py) `bl_info` — they must stay identical. Blender only accepts **literal** values in `bl_info` (it parses with `ast.literal_eval`); a variable like `"version": ADDON_VERSION` breaks discovery and the add-on **vanishes** from Preferences. In the **3D Viewport**, press **N** → sidebar **Slicer** tab → the panel title is **`Slicer (vX.Y.Z)`** after reload.
- **Reload in Blender after `blender_addon/` edits:** with Blender running and Cursor’s **user-blender** MCP connected, run **`execute_blender_code`** every time add-on Python changes, e.g. `import bpy` then `bpy.ops.preferences.addon_disable(module="blender_addon")` and `bpy.ops.preferences.addon_enable(module="blender_addon")`. The coding agent should do this MCP reload after each such edit (not needed for docs-only changes).
- **Hard reload (pick up changed `.py` on disk):** disable/enable alone can leave old code in `sys.modules`. Paste in Blender’s **Scripting** console (or MCP `execute_blender_code`): disable → delete `blender_addon` entries from `sys.modules` → `importlib.invalidate_caches()` → enable. Do **not** call `blender_addon.unregister()` before `addon_disable` (Blender will unregister again and can error). Optional last resort: `bpy.ops.script.reload()` reloads **all** scripts/add-ons and may disrupt other add-ons or this MCP session.
