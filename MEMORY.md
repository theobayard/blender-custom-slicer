# blender-custom-slicer

## Purpose

Blender add-on: vase-oriented mesh → per-layer single perimeter → plain `.gcode` for Bambu X1C + AMS (SD card), using one Bambu Studio–exported template for header/footer and toolchange macros.

**User-facing overview (Mermaid diagrams, install, module map):** [README.md](README.md).

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

**Dev-only placeholder (do not print):** [blender_addon/assets/minimal_bambu_template_placeholder.gcode](blender_addon/assets/minimal_bambu_template_placeholder.gcode) — parses and composes for UI/export testing in Blender; it is **not** a real Bambu preamble or AMS macro set. Standalone wipes must include **`; layer num/total_layer_count:`** alongside **`; Z_HEIGHT:`** (indexed mode); stubs at layers **1** and **2** at **0.4 / 0.6 mm** so **Alternate 0/1** smoke tests avoid `MissingPurgeTowerError`.

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
- **Scene units → G-code mm:** world positions are `(BU × scene.unit_settings.scale_length) × slicer_mm_per_scene_meter`. **scale_length** turns BU into scene meters; **mm per scene meter** (panel default **10**) maps those meters to printer mm — **10** means one scene-meter prints as **10 mm** (same numerals as if that distance were **centimeters** on the bed). Use **1000** for true scale (1 scene m → 1000 mm). Composed motion is prefixed with **`M82`** and **`G92 E0`** after the template header because Bambu’s start block uses **`M83`** (relative E) while the exporter emits **absolute cumulative E**. **Export-time XY centering (default on):** the Slicer panel’s **Center on bed at export** shifts composed **`G1 X/Y`** so the IR’s **axis-aligned XY bounding box** is centered on the printable rectangle (**Bed X/Y**, default **256×256** mm for X1/X1C). This applies only to exported G-code; **Generate path** / preview use **unmodified** IR. Turn off **Center on bed at export** to keep IR coordinates at the printer’s front-left origin (previous behavior).
- **Standalone purge towers (multi-material):** Towers are `; WIPE_TOWER_START`…`; WIPE_TOWER_END` spans **outside** the first two toolchange blocks. Each stored chunk **includes** the contiguous Bambu **prime-tower prelude** immediately above `; WIPE_TOWER_START`: `; LAYER_HEIGHT:`, `; FEATURE: Prime tower` (only that feature line, not e.g. Outer wall), and `; LINE_WIDTH:` — Studio treats these as part of the tower block, not optional comments. **Preferred:** indexed mode — use the nearest preceding `; layer num/total_layer_count: k/N` where **`N` equals `; total layer number:` from the header** when that header field exists (skips Bambu **prime-tower** markers like `k/17`). Search is limited to **600 lines** above each wipe so a lone early `1/100` does not bind every later wipe. **`; Z_HEIGHT:`** still supplies rebase Z. **Export** tries the layer map first, then **Z slab fallback** when the layer key is missing (partial index + `purge_towers_by_layer_z_fallback`). `template_executable_layer_total` follows indexed `k…` coverage vs header `N`. **Legacy:** no header / no matching `k/N` in window → Z-only map. **`MissingPurgeTowerError`:** on any **filament change** if no purge resolves (index + Z). If the template’s **`purge_towers_by_layer_1based`** contains **every** layer key `1…L` for `L =` this print’s layer count, **every** layer must resolve a purge (same lookup order); otherwise Studio-style previews miss tower motion on non-switch layers. Indexed lookup is **not** limited by `template_executable_layer_total` (that field can understate; layer keys still apply).
- **CP / X1 swap Z-rebase:** `_cp_toolchange_ranges` sets `swap_*_source_z` from the nearest preceding `; Z_HEIGHT:` (same as `;=X1` path). `_swap_macro` rebases all `G0`–`G3` `Z` tokens in the macro to the export layer’s `layer.z`, so standalone purge towers (no `Z` in the chunk) extrude at print height instead of the template’s color-change Z. **`MissingPurgeTowerError` / indexed purge map unchanged.**
- **Purge tower variants:** Template **maintenance** towers contain `; CP EMPTY GRID` (per-layer prime). **Post-toolchange** towers omit that block (slim arc wipe after `; CP TOOLCHANGE END`, or immediately before the next CP). Parser fills `purge_tower_post_swap_0_to_1` / `purge_tower_post_swap_1_to_0` by scanning near the first/second CP block (ahead of CP end, else behind CP start). **Export:** filament-change layers use post-swap chunks; other layers use maintenance chunks from `purge_towers_by_layer_1based` (nearest keyed maintenance if that index is a post-swap-only layer). **Layer 0 / no swap:** emit `M83` + `G1 Z<layer.z>` before the rebased tower so relative-E Studio chunks match template semantics under composed `M82`.
- **Post-swap motion invariant:** after each `_swap_macro` + optional purge block, `export_print_ir_to_gcode_string` emits `G1 X Y F30000` (XY travel) **then** `G1 Z{layer.z} F1200`, **then** the perimeter. The rebased macro typically ends at **`layer_z`** (park/return Z shifted with the macro), not `layer_z + 3`. Without the XY travel + Z drop, the first extrude can drag from the wipe corner. **`_expected_total_lines`** counts swap/purge lines from the template macros (line count unchanged by rebase).
- **Known follow-ups (not fixed with CP rebase):** (1) **Layer 0, no filament change:** purge runs after `M82`/`G92 E0` while the header may leave the nozzle at the template’s first-layer Z; tower chunks use relative E from Studio (`M83` context) — may need `M83` + `G1 Z{layer.z}` before the first standalone wipe when no swap ran. (2) **Post-wipe XY at print Z:** if the macro ends at `layer_z`, the following `G1 X Y F30000` can scrape across the bed until `G1 Z{layer.z}` — consider ending swaps at clearance or lifting before XY travel.
- **Bambu Studio G-code preview:** composed motion emits **`M73 L<n>`** and **`M991 S0 P<n-1>`** (same pattern as Studio’s `layer_change_gcode`), not `M73 P… R0` percent lines and not Prusa-style **`; LAYER_CHANGE`** — Studio’s layer slider / Z grouping for AMS jobs keys off the native markers.
- **Color-change layer order (must match native Bambu):** for every layer, markers (`; CHANGE_LAYER`/`; Z_HEIGHT:`/`; LAYER_HEIGHT:`/`; layer num/...`/`M73 L`/`M991`) come first. If **`filament_index` changed**, **`_swap_macro`** runs **next**. If the template maps a standalone tower for **`layer index`**, that segment runs **next** (rebased from template Z). **`M82` + `G92 E0`** run whenever a swap **or** purge block ran—then **`; OBJECT_ID: <id>`** (if captured), **`G1 X Y F30000`** travel at clearance, **`G1 Z<layer.z> F1200`**, **`; FEATURE: Outer wall`**, then **XY-only** extrudes. Putting markers after the swap, or leaving the printer in `M83` after the macro, makes Bambu Studio’s preview collapse all layers to first-layer Z and over-extrude. `e_accum` resets to 0 after each swap or purge block. Layer 0 keeps its combined `G1 X Y Z F` initial approach.
- **`; OBJECT_ID:` is required for preview Z binning:** when `exclude_object = 1` (Bambu default), Studio’s preview groups extrudes by object span. Without `; OBJECT_ID:` wrappers our extrudes stay outside any object span and the preview renders all layers stacked at first-layer Z even though `G1 Z<layer.z>` is correct. `ParsedTemplate.object_id` captures the first `; OBJECT_ID: <id>` value from the template and the exporter emits one `; OBJECT_ID: <id>` plus a single `; FEATURE: Outer wall` per layer. If the template has no `; OBJECT_ID:`, both are skipped (minimal placeholder template path).
- Install: **Edit → Preferences → Add-ons → Install…** select the `blender_addon` folder (or zip the folder).
- **Local export output:** save Blender **Export G-code** and other scratch prints under **`local_gcode/`** at the repo root. That directory is **gitignored**; keep tracked templates/samples in [blender_addon/assets/](blender_addon/assets/) only.
- Tests: `pytest` from repo root (no Blender required for parser/export tests).
- Keep `git status` clean proactively: remove scratch artifacts and revert unrelated accidental edits before handing work back.
- **Add-on version:** bump `ADDON_VERSION` in [blender_addon/version.py](blender_addon/version.py) **and** the **`"version": (x, y, z)`** tuple inside [blender_addon/__init__.py](blender_addon/__init__.py) `bl_info` — they must stay identical. Blender only accepts **literal** values in `bl_info` (it parses with `ast.literal_eval`); a variable like `"version": ADDON_VERSION` breaks discovery and the add-on **vanishes** from Preferences. In the **3D Viewport**, press **N** → sidebar **Slicer** tab → the panel title is **`Slicer (vX.Y.Z)`** after reload.
- **Reload in Blender after `blender_addon/` edits:** with Blender running and Cursor’s **user-blender** MCP connected, run **`execute_blender_code`** every time add-on Python changes, e.g. `import bpy` then `bpy.ops.preferences.addon_disable(module="blender_addon")` and `bpy.ops.preferences.addon_enable(module="blender_addon")`. The coding agent should do this MCP reload after each such edit (not needed for docs-only changes).
- **Hard reload (pick up changed `.py` on disk):** disable/enable alone can leave old code in `sys.modules`. Paste in Blender’s **Scripting** console (or MCP `execute_blender_code`): disable → delete `blender_addon` entries from `sys.modules` → `importlib.invalidate_caches()` → enable. Do **not** call `blender_addon.unregister()` before `addon_disable` (Blender will unregister again and can error). Optional last resort: `bpy.ops.script.reload()` reloads **all** scripts/add-ons and may disrupt other add-ons or this MCP session. **VS Code / Cursor:** run task **“Blender: hard reload add-on (MCP socket)”** (`.vscode/tasks.json`) — it runs [scripts/blender_addon_hard_reload_socket.py](scripts/blender_addon_hard_reload_socket.py), which speaks the same JSON-over-TCP protocol as `blender-mcp`’s `execute_blender_code` (default `localhost:9876`; override with `BLENDER_MCP_HOST` / `BLENDER_MCP_PORT` if the add-on uses non-defaults).
