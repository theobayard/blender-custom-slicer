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

- Install: **Edit → Preferences → Add-ons → Install…** select the `blender_addon` folder (or zip the folder).
- Tests: `pytest` from repo root (no Blender required for parser/export tests).
- **Add-on version:** bump `ADDON_VERSION` in [blender_addon/version.py](blender_addon/version.py) **and** the **`"version": (x, y, z)`** tuple inside [blender_addon/__init__.py](blender_addon/__init__.py) `bl_info` — they must stay identical. Blender only accepts **literal** values in `bl_info` (it parses with `ast.literal_eval`); a variable like `"version": ADDON_VERSION` breaks discovery and the add-on **vanishes** from Preferences. In the **3D Viewport**, press **N** → sidebar **Slicer** tab → the panel title is **`Slicer (vX.Y.Z)`** after reload.
- **Reload in Blender after `blender_addon/` edits:** with Blender running and Cursor’s **user-blender** MCP connected, run **`execute_blender_code`** every time add-on Python changes, e.g. `import bpy` then `bpy.ops.preferences.addon_disable(module="blender_addon")` and `bpy.ops.preferences.addon_enable(module="blender_addon")`. The coding agent should do this MCP reload after each such edit (not needed for docs-only changes).
