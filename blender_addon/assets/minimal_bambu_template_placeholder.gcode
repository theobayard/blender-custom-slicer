; =============================================================================
; PLACEHOLDER ONLY — NOT A REAL BAMBU X1C+AMS TEMPLATE
; =============================================================================
; This file exists so the add-on can parse and compose G-code in Blender
; without Bambu Studio. It is NOT safe or correct for printing on an X1C.
; For SD-card printing, export a real .gcode from Bambu Studio (X1C + AMS,
; two toolchanges A→B→A) and set Template path to that file. See MEMORY.md.
; =============================================================================

G21 ; millimeters
G90 ; absolute XYZ
M82 ; absolute extruder

; ---CUSTOM_MOTION_START---
; (Parser ignores lines from here until toolchange blocks are collected.)

; CP TOOLCHANGE START
; PLACEHOLDER 0→1 — replace with real macro from Bambu Studio export
M117 FC_PLACEHOLDER_SWAP_0_TO_1
; CP TOOLCHANGE END

; discarded placeholder motion between swaps (not used by parser)

; CP TOOLCHANGE START
; PLACEHOLDER 1→0 — replace with real macro from Bambu Studio export
M117 FC_PLACEHOLDER_SWAP_1_TO_0
; CP TOOLCHANGE END

; =============================================================================
; FOOTER PLACEHOLDER — real template ends with machine-specific shutdown
; =============================================================================
M117 FC_PLACEHOLDER_FOOTER
M400 ; finish moves
