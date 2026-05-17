# blender-custom-slicer

Blender add-on that turns a **vase-style mesh** into a **single-perimeter, layer-by-layer toolpath**, then **composes** a Bambu **X1 Carbon + AMS**–compatible `.gcode` file for **SD-card printing**. Custom motion comes from Blender; machine preamble, AMS toolchange macros, purge towers, and shutdown come from a **one-time Bambu Studio template** you capture and reuse.

Operational details, template capture, and dev notes: **[MEMORY.md](MEMORY.md)**.

---

## High-level overview

```mermaid
flowchart TB
    subgraph inputs["Inputs"]
        MESH["Blender mesh<br/>(vase-compatible)"]
        TPL["Bambu Studio template<br/>.gcode (X1C + AMS)"]
        PANEL["Slicer panel settings<br/>layer height, filament mode, …"]
    end

    subgraph blender["Blender add-on"]
        SLICE["slice.py<br/>mesh → PrintIR"]
        PREV["preview.py<br/>3D path overlay"]
        PARSE["template_parse.py<br/>header / swaps / towers / footer"]
        EXP["export.py<br/>IR + template → motion"]
        OPS["operators.py<br/>UI + file I/O"]
    end

    subgraph core["Pure Python (testable without Blender)"]
        IR["ir.py<br/>PrintIR, Layer, Segment"]
        PARSE
        EXP
    end

    subgraph output["Output"]
        GCODE["Plain .gcode<br/>SD card → X1C"]
    end

    MESH --> SLICE
    PANEL --> SLICE
    SLICE --> IR
    IR --> PREV
    IR --> EXP
    TPL --> PARSE
    PARSE --> EXP
    OPS --> SLICE
    OPS --> EXP
    EXP --> GCODE
```

**Idea in one sentence:** slice geometry in Blender into a stable intermediate representation (IR), then **splice** your per-layer extrusion into a **known-good** Bambu file instead of reimplementing AMS, purge towers, and machine start/end G-code.

---

## End-to-end workflow

```mermaid
sequenceDiagram
    actor User
    participant BS as Bambu Studio
    participant BL as Blender (add-on)
    participant FS as Filesystem
    participant X1 as X1C (SD card)

    Note over User,BS: One-time (or when printer/firmware changes)
    User->>BS: Slice A→B→A cube, export .gcode
    BS->>FS: x1c_ams_template.gcode

    Note over User,X1: Every print
    User->>BL: Install add-on, set Template path
    User->>BL: Select mesh, tune Slicer settings
    User->>BL: Generate path
    BL->>BL: mesh_to_print_ir + preview curves
    User->>BL: Export G-code
    BL->>FS: Read template, parse, compose
    BL->>FS: my_part.gcode
    User->>X1: Copy to SD, print
```

---

## Module architecture

```mermaid
flowchart LR
    subgraph bpy_required["Requires Blender (bpy)"]
        direction TB
        INIT["__init__.py<br/>bl_info, register"]
        OPS["operators.py"]
        SLICE["slice.py"]
        PREV["preview.py"]
    end

    subgraph pure["Pure Python"]
        direction TB
        IR["ir.py"]
        TP["template_parse.py"]
        EXP["export.py"]
    end

    INIT --> OPS
    OPS --> SLICE
    OPS --> PREV
    OPS --> EXP
    OPS --> TP
    SLICE --> IR
    SLICE --> PREV
    EXP --> IR
    EXP --> TP

    subgraph tests["tests/"]
        T1["test_template_parse.py"]
        T2["test_export_*.py"]
    end

    TP --> T1
    EXP --> T2
```

| Module | Role |
|--------|------|
| [`blender_addon/ir.py`](blender_addon/ir.py) | Canonical **PrintIR**: layers of perimeter **segments** (XYZ, extrusion, feedrate) + per-layer **filament_index**. |
| [`blender_addon/slice.py`](blender_addon/slice.py) | Mesh ↔ horizontal planes → 2D contours → closed loops → **PrintIR**; stores last IR in memory. |
| [`blender_addon/preview.py`](blender_addon/preview.py) | Builds temporary curve objects in the viewport for visual verification. |
| [`blender_addon/template_parse.py`](blender_addon/template_parse.py) | Splits a Bambu export into **header**, **0→1 / 1→0 swap macros**, **purge tower** chunks (by layer index and/or Z), **footer**. |
| [`blender_addon/export.py`](blender_addon/export.py) | Walks **PrintIR** layers and emits Bambu-style markers, swaps, towers, and **G1** extrusion; prepends header and appends footer. |
| [`blender_addon/operators.py`](blender_addon/operators.py) | **Slicer** sidebar panel, **Generate path**, **Export G-code**, scene properties. |
| [`blender_addon/version.py`](blender_addon/version.py) | `ADDON_VERSION` — bump with `bl_info["version"]` in [`__init__.py`](blender_addon/__init__.py). |

---

## Intermediate representation (PrintIR)

```mermaid
classDiagram
    class PrintIR {
        +layers: Layer[]
        +machine_profile_id: str
    }
    class Layer {
        +z: float
        +perimeter: Segment[]
        +filament_index: int
    }
    class Segment {
        +p0: Vec3
        +p1: Vec3
        +e_delta: float
        +feedrate: float
        +surface_hit: SurfaceSample?
    }

    PrintIR "1" --> "*" Layer
    Layer "1" --> "*" Segment
```

- **Layer 0** must use `filament_index == 0` (matches template loading slot 0).
- One **closed perimeter** per layer (vase mode: no infill, no inner walls).
- Coordinates are in **printer mm** after `scene_bu_to_mm` (Blender units × scene scale × “mm per scene meter”).

---

## Slicing pipeline (mesh → IR)

```mermaid
flowchart TD
    A["Active mesh object"] --> B["Evaluated depsgraph<br/>world-space geometry"]
    B --> C["Layer Z heights<br/>first_layer_height + layer_height × n"]
    C --> D["For each Z: triangle ∩ plane"]
    D --> E["2D segments → adjacency graph"]
    E --> F["Longest closed cycle<br/>(single outer contour)"]
    F --> G["Order segments + extrusion<br/>from line width / filament dia"]
    G --> H["Assign filament_index<br/>SAME_0 or ALTERNATE_01"]
    H --> I["PrintIR + validate"]
    I --> J["Cache _last_ir<br/>build_preview curves"]
```

**Mesh expectations:** vase-compatible outer wall; prefer triangulated or convex faces (n-gons are fan-triangulated from vertex 0 — non-convex polygons can give wrong contours).

---

## G-code composition (template + IR)

A Bambu Studio export is treated as a **macro library** plus machine bookends. The exporter **does not** embed the template’s original object toolpath.

```mermaid
flowchart TB
    subgraph parsed["ParsedTemplate (from template_parse)"]
        H["header<br/>machine + AMS preamble"]
        S01["swap_0_to_1<br/>; CP TOOLCHANGE START … END"]
        S10["swap_1_to_0<br/>second CP block"]
        PT["purge_towers_by_layer_*<br/>maintenance + post-swap towers"]
        F["footer<br/>; MACHINE_END_GCODE_START …"]
    end

    subgraph composed["Composed .gcode"]
        OUT_H["header"]
        OUT_M["M82 + G92 E0<br/>(absolute E for our motion)"]
        OUT_L["For each IR layer:<br/>markers → swap? → tower? → perimeter"]
        OUT_F["footer"]
    end

  H --> OUT_H
  OUT_H --> OUT_M
  OUT_M --> OUT_L
  S01 -.-> OUT_L
  S10 -.-> OUT_L
  PT -.-> OUT_L
  OUT_L --> OUT_F
  F --> OUT_F
```

**Header trim (default):** everything before the first `; WIPE_TOWER_START` after `; EXECUTABLE_BLOCK_START` (drops the template cube’s wipe tower and first-color motion). Optional marker `; ---CUSTOM_MOTION_START---` overrides this. See [MEMORY.md](MEMORY.md).

**Footer trim:** only from `; MACHINE_END_GCODE_START` through `; EXECUTABLE_BLOCK_END` — third-filament object motion after the last toolchange is discarded.

---

## Per-layer export order

Order matches native Bambu Studio so **Bambu’s G-code preview** layers Z correctly (especially with AMS).

```mermaid
flowchart TD
    START(["Next layer from PrintIR"]) --> MARK["Bambu layer markers<br/>CHANGE_LAYER, Z_HEIGHT, layer num, M73 L, M991"]
    MARK --> CHG{filament_index<br/>changed?}
    CHG -->|yes| SWAP["Insert rebased CP toolchange macro<br/>0→1 or 1→0"]
    CHG -->|no| TWR
    SWAP --> TWR{purge tower for<br/>this layer?}
    TWR -->|yes| PURGE["Rebased WIPE_TOWER chunk<br/>M83 on non-swap layers"]
    TWR -->|no| NEED{swap or template<br/>requires tower?}
    NEED -->|missing| ERR["MissingPurgeTowerError"]
    NEED -->|ok| EABS
    PURGE --> EABS["M82 + G92 E0<br/>reset E accumulator"]
    TWR -->|no tower| EABS
    EABS --> APP["OBJECT_ID + FEATURE<br/>travel XY, G1 Z, G1 XYE perimeter"]
    APP --> NEXT{more layers?}
    NEXT -->|yes| START
    NEXT -->|no| FOOT["Append template footer"]
```

**XY centering (export only):** optional shift so the IR bounding box is centered on the bed (default 256×256 mm); preview stays aligned with the model.

---

## Template capture (summary)

You need **one** Bambu Studio `.gcode` with **two** `; CP TOOLCHANGE START` … `; CP TOOLCHANGE END` blocks in order **0→1** then **1→0** (e.g. paint a cube **A → B → A**).

```mermaid
flowchart LR
    subgraph studio["Bambu Studio"]
        P1["X1C + AMS, 2 filaments"]
        P2["Tall cube, A/B/A bands"]
        P3["Slice + export .gcode"]
    end

    subgraph verify["Verify in editor"]
        V1["≥ 2 × CP TOOLCHANGE"]
        V2["Optional: CUSTOM_MOTION_START marker"]
    end

    subgraph blender["Blender Slicer panel"]
        B1["Template path → file"]
        B2["Generate path on real mesh"]
        B3["Export G-code"]
    end

    P1 --> P2 --> P3 --> V1 --> V2 --> B1 --> B2 --> B3
```

Full walkthrough: **[MEMORY.md § Template capture](MEMORY.md#template-capture-one-time)**.

**Dev-only placeholder** (parse/compose tests, **not for printing**): [`blender_addon/assets/minimal_bambu_template_placeholder.gcode`](blender_addon/assets/minimal_bambu_template_placeholder.gcode).

---

## Install and usage

### Install

1. Zip the [`blender_addon`](blender_addon) folder **or** use **Edit → Preferences → Add-ons → Install…** and select that folder.
2. Enable **Custom Slicer (X1C path)**.
3. In the 3D Viewport, press **N** → sidebar tab **Slicer**.

### Typical print workflow

1. **Template path** — your captured X1C+AMS `.gcode` (see above).
2. **Select** a mesh object.
3. Tune **layer height**, **line width**, **mm per scene meter** (default `10` maps scene meters to “centimeter-scale” bed numbers; use `1000` for true metric).
4. **Generate path** — builds IR and viewport preview.
5. **Export G-code** — writes composed file (default **center on bed** at export).

Exports for local iteration: save under [`local_gcode/`](local_gcode/) (gitignored).

### Filament modes

| Mode | Behavior |
|------|----------|
| **Single (slot 0)** | All layers `filament_index = 0`. |
| **Alternate 0/1** | Even layers 0, odd layers 1 — for two-color smoke tests with AMS slots 0 and 1 loaded. |

---

## Development

```mermaid
flowchart LR
    EDIT["Edit blender_addon/*.py"] --> RELOAD["Hard reload add-on<br/>MCP or VS Code task"]
    RELOAD --> TEST_BL["Generate path / export in Blender"]
    EDIT --> PYTEST["pytest from repo root"]
    PYTEST --> CI["Parser + export tests<br/>no Blender required"]
```

```bash
pip install pytest
pytest
```

- **Hard reload:** VS Code/Cursor task **“Blender: hard reload add-on (MCP socket)”** → [`scripts/blender_addon_hard_reload_socket.py`](scripts/blender_addon_hard_reload_socket.py).
- **G-code references:** [`docs/gcode-reference/`](docs/gcode-reference/).
- **Architecture notes:** [`PLAN.md`](PLAN.md).

Bump version in both [`blender_addon/version.py`](blender_addon/version.py) and the literal `bl_info["version"]` tuple in [`blender_addon/__init__.py`](blender_addon/__init__.py).

---

## Repository layout

```
blender_addon/          # Installable add-on package
  ir.py                 # PrintIR schema
  slice.py              # Mesh slicing (bpy)
  preview.py            # Viewport curves (bpy)
  template_parse.py     # Bambu template splitter
  export.py             # IR → composed G-code
  operators.py          # UI + operators
  assets/               # Sample templates / reference G-code (tracked)
docs/gcode-reference/   # Vendored Bambu G-code notes
local_gcode/            # Local exports (gitignored)
scripts/                # Dev utilities (hard reload, analysis)
tests/                  # pytest (no Blender)
MEMORY.md               # Assumptions, capture guide, dev invariants
PLAN.md                 # Original architecture / roadmap
```

---

## Limits (MVP)

- **Vase / single-wall** only — no infill, supports, or multiple walls per layer.
- **Plain `.gcode`** for SD card — no `.gcode.3mf` cloud packaging.
- **Two-filament AMS** template with both swap directions captured; N-filament generalization not implemented.
- **Hardware validation** is manual on the printer ([checklist in MEMORY.md](MEMORY.md#manual-hardware-checklist)).

---

## License

See repository defaults; no separate license file called out in-tree.
