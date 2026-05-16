; HEADER_BLOCK_START
; BambuStudio 02.05.00.66
; model printing time: 14m 46s; total estimated time: 23m 5s
; total layer number: 72
; total filament length [mm] : 1276.94,390.43
; total filament volume [cm^3] : 3071.40,939.10
; total filament weight [g] : 3.81,1.16
; filament_density: 1.24,1.24
; filament_diameter: 1.75,1.75
; max_z_height: 20.08
; filament: 1,2
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0,0
; additional_cooling_fan_speed = 70,70
; apply_scarf_seam_on_circles = 1
; apply_top_surface_compensation = 0
; auxiliary_fan = 1
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_color_penetration_layers = 3
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0,0
; change_filament_gcode = ;=X1 20251031=\nM620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{else}\nM620.11 S0\n{endif}\nM400\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F{flush_volumetric_speeds[previous_extruder]/2.4053*60} T{flush_temperatures[previous_extruder]}\nT[next_extruder]\nM620.1 E F{flush_volumetric_speeds[next_extruder]/2.4053*60} T{flush_temperatures[next_extruder]}\n\n{if next_extruder < 255}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\nG92 E0\n{if flush_length_1 > 1}\nM83\n; FLUSH_START\n; always use highest temperature to flush\nM400\n{if filament_type[next_extruder] == "PETG"}\nM109 S260\n{elsif filament_type[next_extruder] == "PVA"}\nM109 S210\n{else}\nM109 S{flush_temperatures[next_extruder]}\n{endif}\n{if flush_length_1 > 23.7}\nG1 E23.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\n{else}\nG1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X105 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\n\nG1 X70 F10000\nG1 X80 F15000\nG1 X60\nG1 X80\nG1 X60\nG1 X80 ; shake to put down garbage\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200,200
; close_fan_the_first_x_layers = 1,1
; complete_print_exhaust_fan_speed = 70,70
; cool_plate_temp = 35,35
; cool_plate_temp_initial_layer = 35,35
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10,10
; cooling_slowdown_logic = uniform_cooling,uniform_cooling
; counter_coef_1 = 0,0
; counter_coef_2 = 0.008,0.008
; counter_coef_3 = -0.041,-0.041
; counter_limit_max = 0.033,0.033
; counter_limit_min = -0.035,-0.035
; curr_bed_type = Textured PEI Plate
; default_acceleration = 10000
; default_filament_colour = ;
; default_filament_profile = "Bambu PLA Basic @BBL X1C"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50,50
; different_settings_to_system = enable_prime_tower;;;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70,70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_overhang_bridge_fan = 1,1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0,0
; enable_prime_tower = 0
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 0,0
; eng_plate_temp_initial_layer = 0,0
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 1#0|4#0;1#0|4#0
; extruder_clearance_dist_to_rod = 33
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 34
; extruder_clearance_max_radius = 68
; extruder_colour = #018001
; extruder_max_nozzle_count = 1
; extruder_nozzle_stats = Standard#1
; extruder_offset = 0x2
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard,Direct Drive High Flow"
; fan_cooling_layer_time = 100,100
; fan_direction = left
; fan_max_speed = 100,100
; fan_min_speed = 100,100
; filament_adaptive_volumetric_speed = 0,0
; filament_adhesiveness_category = 100,100
; filament_bridge_speed = 25,25
; filament_change_length = 10,10
; filament_change_length_nc = 10,10
; filament_colour = #161616;#FFFFFF
; filament_colour_type = 0;0
; filament_cooling_before_tower = 0,0
; filament_cost = 20,20
; filament_density = 1.24,1.24
; filament_dev_ams_drying_ams_limitations = 1;0;1;0
; filament_dev_ams_drying_heat_distortion_temperature = 45,45
; filament_dev_ams_drying_temperature = 45,45,45,45,45,45,45,45
; filament_dev_ams_drying_time = 12,12,12,12,12,12,12,12
; filament_dev_chamber_drying_bed_temperature = 70,70
; filament_dev_chamber_drying_time = 12,12
; filament_dev_drying_cooling_temperature = 45,45
; filament_dev_drying_softening_temperature = 50,50
; filament_diameter = 1.75,1.75
; filament_enable_overhang_speed = 1,1
; filament_end_gcode = "; filament end gcode \n\n";"; filament end gcode \n\n"
; filament_extruder_variant = "Direct Drive Standard";"Direct Drive Standard"
; filament_flow_ratio = 0.98,0.98
; filament_flush_temp = 0,0
; filament_flush_volumetric_speed = 0,0
; filament_ids = GFL99;GFL99
; filament_is_support = 0,0
; filament_map = 1,1
; filament_map_2 = 0,0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 12,12
; filament_minimal_purge_on_wipe_tower = 15,15
; filament_multi_colour = #161616;#FFFFFF
; filament_notes = 
; filament_nozzle_map = 0,0
; filament_overhang_1_4_speed = 0,0
; filament_overhang_2_4_speed = 50,50
; filament_overhang_3_4_speed = 30,30
; filament_overhang_4_4_speed = 10,10
; filament_overhang_totally_speed = 10,10
; filament_pre_cooling_temperature = 0,0
; filament_pre_cooling_temperature_nc = 0,0
; filament_prime_volume = 45,45
; filament_prime_volume_nc = 60,60
; filament_printable = 3,3
; filament_ramming_travel_time = 0,0
; filament_ramming_travel_time_nc = 0,0
; filament_ramming_volumetric_speed = -1,-1
; filament_ramming_volumetric_speed_nc = -1,-1
; filament_retract_length_nc = 14,14
; filament_scarf_gap = 15%,15%
; filament_scarf_height = 10%,10%
; filament_scarf_length = 10,10
; filament_scarf_seam_type = none,none
; filament_self_index = 1,2
; filament_settings_id = "Generic PLA";"Generic PLA"
; filament_shrink = 100%,100%
; filament_soluble = 0,0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10,10
; filament_tower_interface_pre_extrusion_length = 0,0
; filament_tower_interface_print_temp = -1,-1
; filament_tower_interface_purge_volume = 20,20
; filament_tower_ironing_area = 4,4
; filament_type = PLA;PLA
; filament_velocity_adaptation_factor = 1,1
; filament_vendor = Generic;Generic
; filament_volume_map = 0,0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0,0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_volumes_matrix = 0,632,180,0
; flush_volumes_vector = 140,140,140,140
; full_fan_speed_layer = 0,0
; fuzzy_skin = none
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 200
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 0
; group_algo_with_time = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; hole_coef_1 = 0,0
; hole_coef_2 = -0.008,-0.008
; hole_coef_3 = 0.23415,0.23415
; hole_limit_max = 0.22,0.22
; hole_limit_min = 0.088,0.088
; host_type = octoprint
; hot_plate_temp = 55,55
; hot_plate_temp_initial_layer = 55,55
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10,10
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 200
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 200
; ironing_direction = 45
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.28
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0,0
; machine_end_gcode = ;===== date: 20240528 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos\nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of "timelapse_record_flag"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A0 B20 L100 C37 D20 M40 E42 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C46 D10 M80 E46 F10 N80\nM1006 A44 B20 L100 C39 D20 M60 E48 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C48 D10 M60 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10  N100\nM1006 A49 B20 L100 C44 D20 M100 E41 F20 N100\nM1006 A0 B20 L100 C0 D20 M60 E0 F20 N100\nM1006 A0 B20 L100 C37 D20 M30 E37 F20 N60\nM1006 W\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\nM960 S5 P0 ; turn off logo lamp\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,500
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,500
; machine_max_speed_y = 500,500
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0
; machine_min_travel_rate = 0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = ;===== machine: X1-0.4 ====================\n;===== date: 20251031 ==================\n;===== start printer sound ================\nM17\nM400 S1\nM1006 S1\nM1006 A0 B10 L100 C37 D10 M60 E37 F10 N60\nM1006 A0 B10 L100 C41 D10 M60 E41 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A46 B10 L100 C43 D10 M70 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A43 B10 L100 C0 D10 M60 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A41 B10 L100 C0 D10 M100 E41 F10 N100\nM1006 A44 B10 L100 C0 D10 M100 E44 F10 N100\nM1006 A49 B10 L100 C0 D10 M100 E49 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A48 B10 L100 C44 D10 M60 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A44 B10 L100 C0 D10 M90 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A46 B10 L100 C43 D10 M60 E39 F10 N100\nM1006 W\n;===== turn on the HB fan =================\nM104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle\n;===== reset machine status =================\nM290 X40 Y40 Z2.6666666\nG91\nM17 Z0.4 ; lower the z-motor current\nG380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed\nG380 S2 Z-25 F300 ;\nG1 Z5 F300;\nG90\nM17 X1.2 Y1.2 Z0.75 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 5\nM221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\nG29.1 Z{+0.0} ; clear z-trim value first\nM204 S10000 ; init ACC set to 10m/s^2\n\n;===== heatbed preheat ====================\nM1002 gcode_claim_action:54\nM140 S[bed_temperature_initial_layer_single] ;set bed temp\nM190 S[bed_temperature_initial_layer_single] ;wait for bed temp\n\n{if scan_first_layer}\n;=========register first layer scan=====\nM977 S1 P60\n{endif}\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_no_support_extruder]=="PLA"}\n    {if (bed_temperature[initial_no_support_extruder] >45)||(bed_temperature_initial_layer[initial_no_support_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n    M142 P1 R35 S40\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n;===== prepare print temperature and material ==========\nM104 S[nozzle_temperature_initial_layer] ;set extruder temp\nG91\nG0 Z10 F1200\nG90\nG28 X\nM975 S1 ; turn on\nG1 X60 F12000\nG1 Y245\nG1 Y265 F3000\nM620 M\nM620 S[initial_no_support_extruder]A   ; switch material if AMS exist\n    M109 S[nozzle_temperature_initial_layer]\n    G1 X120 F12000\n\n    G1 X20 Y50 F12000\n    G1 Y-3\n    T[initial_no_support_extruder]\n    G1 X54 F12000\n    G1 Y265\n    M400\nM621 S[initial_no_support_extruder]A\nM620.1 E F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60} T{flush_temperatures[initial_no_support_extruder]}\n\nM412 S1 ; ===turn on filament runout detection===\n\nM109 S250 ;set nozzle to common flush temp\nM106 P1 S0\nG92 E0\nG1 E50 F200\nM400\nM104 S[nozzle_temperature_initial_layer]\nG92 E0\nG1 E50 F200\nM400\nM106 P1 S255\nG92 E0\nG1 E5 F300\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20} ; drop nozzle temp, make filament shink a bit\nG92 E0\nG1 E-0.5 F300\n\nG1 X70 F9000\nG1 X76 F15000\nG1 X65 F15000\nG1 X76 F15000\nG1 X65 F15000; shake to put down garbage\nG1 X80 F6000\nG1 X95 F15000\nG1 X80 F15000\nG1 X165 F15000; wipe and shake\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\nM106 S255\nG1 X65 Y230 F18000\nG1 Y264 F6000\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20}\nG1 X100 F18000 ; first wipe mouth\n\nG0 X135 Y253 F20000  ; move to exposed steel surface edge\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nG0 Z5 F20000\n\nG1 X60 Y265\nG92 E0\nG1 E-0.5 F300 ; retrack more\nG1 X100 F5000; second wipe mouth\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X90 F5000\nG0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle\nM104 S140 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM221 S; push soft endstop status\nM221 Z0 ;turn off Z axis endstop\nG0 Z0.5 F20000\nG0 X125 Y259.5 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 X128\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\n\nM109 S140 ; wait nozzle temp down to heatbed acceptable\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\n\nM221 R; pop softend status\nG1 Z10 F1200\nM400\nG1 Z10\nG1 F30000\nG1 X128 Y128\nG29.2 S1 ; turn on ABL\n;G28 ; home again after hard wipe mouth\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n;===== check scanner clarity ===========================\nG1 X128 Y128 F24000\nG28 Z P0\nM972 S5 P0\nG1 X230 Y15 F24000\n;===== check scanner clarity end =======================\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\nM622 J1\n\n    M1002 gcode_claim_action : 1\n    G29 A X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\n\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_no_support_extruder]=="PLA"}\n    {if (bed_temperature[initial_no_support_extruder] >45)||(bed_temperature_initial_layer[initial_no_support_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n    M142 P1 R35 S40\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\nM104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]} ; set extrude temp earlier, to reduce wait time\n\n;===== mech mode fast check============================\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q1 A7 B30 C80  H15 K0\nM974 Q1 S2 P0\n\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q0 A7 B30 C90 Q0 H15 K0\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X230 Y15\nG28 X ; re-home XY\n;===== mech mode fast check============================\n\n{if scan_first_layer}\n;start heatbed  scan====================================\nM976 S2 P1\nG90\nG1 X128 Y128 F20000\nM976 S3 P2  ;register void printing detection\n{endif}\n\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\nG1 X18.0 Y1.0 Z0.8 F18000;Move to start position\nM109 S{nozzle_temperature[initial_no_support_extruder]}\nG1 Z0.2\nG0 E2 F300\nG0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\nG0 X239.5\nG0 E0.2\nG0 Y1.5 E0.700\nG0 X231 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type=="Textured PEI Plate"}\nG29.1 Z{-0.04} ; for Textured PEI Plate\n{endif}\n\n;===== draw extrinsic para cali paint =================\nM1002 judge_flag extrude_cali_flag\nM622 J1\n\n    M1002 gcode_claim_action : 8\n\n    T1000\n\n    G0 F1200.0 X231 Y12   Z0.2 E0.577\n    G0 F1200.0 X226 Y12   Z0.2 E0.275\n    G0 F1200.0 X226 Y1.5  Z0.2 E0.577\n    G0 F1200.0 X220 Y1.5  Z0.2 E0.330\n    G0 F1200.0 X220 Y8    Z0.2 E0.358\n    G0 F1200.0 X210 Y8    Z0.2 E0.549\n    G0 F1200.0 X210 Y1.5  Z0.2 E0.357\n\n    G0 X48.0 E11.9 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X48.0 Y12 E0.772 F1200.0\n    G0 X45.0 E0.22 F1200.0\n    G0 X35.0 Y6.0 E0.86 F1200.0\n\n    ;=========== extruder cali extrusion ==================\n    T1000\n    M83\n    {if default_acceleration > 0}\n        {if outer_wall_acceleration > 0}\n            M204 S[outer_wall_acceleration]\n        {else}\n            M204 S[default_acceleration]\n        {endif}\n    {endif}\n    G0 X35.000 Y6.000 Z0.300 F30000 E0\n    G1 F1500.000 E0.800\n    M106 S0 ; turn off fan\n    G0 X185.000 E9.35441 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G0 X187 Z0\n    G1 F1500.000 E-0.800\n    G0 Z1\n    G0 X180 Z0.3 F18000\n\n    M900 L1000.0 M1.0\n    M900 K0.040\n    G0 X45.000 F30000\n    G0 Y8.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n    M400\n\n    G0 X45.000 F30000\n    M900 K0.020\n    G0 X45.000 F30000\n    G0 Y10.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n    M400\n\n    G0 X45.000 F30000\n    M900 K0.000\n    G0 X45.000 F30000\n    G0 Y12.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n\n    G0 X45.000 F30000 ; move to start point\n\nM623 ; end of "draw extrinsic para cali paint"\n\n\nM1002 judge_flag extrude_cali_flag\nM622 J0\n    G0 X231 Y1.5 F30000\n    G0 X18 E14.3 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM623\n\nM104 S140\n\n\n;=========== laser and rgb calibration ===========\nM400\nM18 E\nM500 R\n\nM973 S3 P14\n\nG1 X120 Y1.0 Z0.3 F18000.0;Move to first extrude line pos\nT1100\nG1 X235.0 Y1.0 Z0.3 F18000.0;Move to first extrude line pos\nM400 P100\nM960 S1 P1\nM400 P100\nM973 S6 P0; use auto exposure for horizontal laser by xcam\nM960 S0 P0\n\nG1 X240.0 Y6.0 Z0.3 F18000.0;Move to vertical extrude line pos\nM960 S2 P1\nM400 P100\nM973 S6 P1; use auto exposure for vertical laser by xcam\nM960 S0 P0\n\n;=========== handeye calibration ======================\nM1002 judge_flag extrude_cali_flag\nM622 J1\n\n    M973 S3 P1 ; camera start stream\n    M400 P500\n    M973 S1\n    G0 F6000 X228.500 Y4.750 Z0.000\n    M960 S0 P1\n    M973 S1\n    M400 P800\n    M971 S6 P0\n    M973 S2 P0\n    M400 P500\n    G0 Z0.000 F12000\n    M960 S0 P0\n    M960 S1 P1\n    G0 X215.00 Y4.750\n    M400 P200\n    M971 S5 P1\n    M973 S2 P1\n    M400 P500\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y6.75\n    M400 P200\n    M971 S5 P3\n    G0 Z0.500 F12000\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y6.75\n    M400 P200\n    M971 S5 P4\n    M973 S2 P0\n    M400 P500\n    M960 S0 P0\n    M960 S1 P1\n    G0 X215.00 Y4.750\n    M400 P500\n    M971 S5 P2\n    M963 S1\n    M400 P1500\n    M964\n    T1100\n    G1 Z3 F3000\n\n    M400\n    M500 ; save cali data\n\n    M104 S{nozzle_temperature[initial_no_support_extruder]} ; rise nozzle temp now ,to reduce temp waiting time.\n\n    T1100\n    M400 P400\n    M960 S0 P0\n    G0 F30000.000 Y10.000 X65.000 Z0.000\n    M400 P400\n    M960 S1 P1\n    M400 P50\n\n    M969 S1 N3 A2000\n    G0 F360.000 X181.000 Z0.000\n    M980.3 A70.000 B{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*60/4} C5.000 D{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*60} E5.000 F175.000 H1.000 I0.000 J0.020 K0.040\n    M400 P100\n    G0 F20000\n    G0 Z1 ; rise nozzle up\n    T1000 ; change to nozzle space\n    G0 X45.000 Y4.000 F30000 ; move to test line pos\n    M969 S0 ; turn off scanning\n    M960 S0 P0\n\n\n    G1 Z2 F20000\n    T1000\n    G0 X45.000 Y4.000 F30000 E0\n    M109 S{nozzle_temperature[initial_no_support_extruder]}\n    G0 Z0.3\n    G1 F1500.000 E3.600\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n\n    ; see if extrude cali success, if not ,use default value\n    M1002 judge_last_extrude_cali_success\n    M622 J0\n        M400\n        M900 K0.02 M{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*0.02}\n    M623\n\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X185.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X190.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X195.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X200.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X205.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X210.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X215.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X220.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X225.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    M973 S4\n\nM623\n\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM973 S4 ; turn off scanner\nM400 ; wait all motion done before implement the emprical L parameters\n;M900 L500.0 ; Empirical parameters\nM109 S[nozzle_temperature_initial_layer]\nM960 S1 P0 ; turn off laser\nM960 S2 P0 ; turn off laser\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\nG90\nM83\nT1000\n;===== purge line to wipe the nozzle ============================\nG1 E{-retraction_length[initial_no_support_extruder]} F1800\nG1 X18.0 Y2.5 Z0.8 F18000.0;Move to start position\nG1 E{retraction_length[initial_no_support_extruder]} F1800\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]}\nG1 Z0.2\nG0 X239 E15 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\nG0 Y12 E0.7 F{outer_wall_volumetric_speed/(0.3*0.5)/4* 60}\n
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 28
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; no_slow_down_for_cooling_on_outwalls = 0,0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.2
; nozzle_temperature = 220,220
; nozzle_temperature_initial_layer = 220,220
; nozzle_temperature_range_high = 240,240
; nozzle_temperature_range_low = 190,190
; nozzle_type = hardened_steel
; nozzle_volume = 107
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100,100
; overhang_fan_threshold = 50%,50%
; overhang_threshold_participating_cooling = 95%,95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0,0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0,0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02,0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 0
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab P1S 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_sequence = by layer
; print_settings_id = 0.28mm Extra Draft @BBL X1C
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab X1 Carbon
; printer_notes = 
; printer_settings_id = Bambu Lab X1 Carbon 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1,1
; reduce_infill_retraction = 1
; required_nozzle_HRC = 3,3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0,0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 1
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1,1
; slow_down_layer_time = 8,8
; slow_down_min_speed = 20,20
; slowdown_end_acc = 100000
; slowdown_end_height = 400
; slowdown_end_speed = 1000
; slowdown_start_acc = 100000
; slowdown_start_height = 0
; slowdown_start_speed = 1000
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 150
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 200
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 45,45
; supertack_plate_temp_initial_layer = 45,45
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 40
; support_top_z_distance = 0.2
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 45,45
; template_custom_gcode = 
; textured_plate_temp = 55,55
; textured_plate_temp_initial_layer = 55,55
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;========Date 20250206========\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\nM1004 S5 P1  ; external shutter\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C10 O0\nG92 E0\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n; SKIPPABLE_END\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 4
; top_one_wall_type = all top
; top_shell_layers = 4
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.45
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab P1S 0.4 nozzle";"Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle";"Bambu Lab H2S 0.4 nozzle";"Bambu Lab P2S 0.4 nozzle";"Bambu Lab H2C 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; volumetric_speed_coefficients = "0 0 0 0 0 0";"0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 2
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 216.437
; wipe_tower_y = 197.131
; wrapping_detection_gcode = 
; wrapping_detection_layers = 20
; wrapping_exclude_area = 
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R23
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: X1-0.4 ====================
;===== date: 20251031 ==================
;===== start printer sound ================
M17
M400 S1
M1006 S1
M1006 A0 B10 L100 C37 D10 M60 E37 F10 N60
M1006 A0 B10 L100 C41 D10 M60 E41 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A46 B10 L100 C43 D10 M70 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A43 B10 L100 C0 D10 M60 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A41 B10 L100 C0 D10 M100 E41 F10 N100
M1006 A44 B10 L100 C0 D10 M100 E44 F10 N100
M1006 A49 B10 L100 C0 D10 M100 E49 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A48 B10 L100 C44 D10 M60 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A44 B10 L100 C0 D10 M90 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A46 B10 L100 C43 D10 M60 E39 F10 N100
M1006 W
;===== turn on the HB fan =================
M104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle
;===== reset machine status =================
M290 X40 Y40 Z2.6666666
G91
M17 Z0.4 ; lower the z-motor current
G380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed
G380 S2 Z-25 F300 ;
G1 Z5 F300;
G90
M17 X1.2 Y1.2 Z0.75 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 5
M221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem
G29.1 Z0 ; clear z-trim value first
M204 S10000 ; init ACC set to 10m/s^2

;===== heatbed preheat ====================
M1002 gcode_claim_action:54
M140 S55 ;set bed temp
M190 S55 ;wait for bed temp


;=========register first layer scan=====
M977 S1 P60


;=============turn on fans to prevent PLA jamming=================

    
    M106 P3 S180
    ;Prevent PLA from jamming
    M142 P1 R35 S40

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S220 ;set extruder temp
G91
G0 Z10 F1200
G90
G28 X
M975 S1 ; turn on
G1 X60 F12000
G1 Y245
G1 Y265 F3000
M620 M
M620 S0A   ; switch material if AMS exist
    M109 S220
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
    G1 Y265
    M400
M621 S0A
M620.1 E F299.339 T240

M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
M73 P6 R21
G1 E50 F200
M400
M104 S220
G92 E0
M73 P25 R17
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P26 R16
G1 E-0.5 F300

M73 P27 R16
G1 X70 F9000
G1 X76 F15000
G1 X65 F15000
G1 X76 F15000
G1 X65 F15000; shake to put down garbage
G1 X80 F6000
G1 X95 F15000
G1 X80 F15000
G1 X165 F15000; wipe and shake
M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1
M106 S255
G1 X65 Y230 F18000
G1 Y264 F6000
M109 S200
G1 X100 F18000 ; first wipe mouth

G0 X135 Y253 F20000  ; move to exposed steel surface edge
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
G0 Z5 F20000

G1 X60 Y265
G92 E0
G1 E-0.5 F300 ; retrack more
G1 X100 F5000; second wipe mouth
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
M73 P28 R16
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X90 F5000
G0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle
M104 S140 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)

M221 S; push soft endstop status
M221 Z0 ;turn off Z axis endstop
G0 Z0.5 F20000
G0 X125 Y259.5 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 X128
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300

M109 S140 ; wait nozzle temp down to heatbed acceptable
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000

M221 R; pop softend status
G1 Z10 F1200
M400
G1 Z10
G1 F30000
G1 X128 Y128
G29.2 S1 ; turn on ABL
;G28 ; home again after hard wipe mouth
M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================

;===== check scanner clarity ===========================
G1 X128 Y128 F24000
G28 Z P0
M972 S5 P0
G1 X230 Y15 F24000
;===== check scanner clarity end =======================

;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X93.4454 Y124.653 I20 J20
    M400
    M500 ; save cali data

M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623
;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression

;=============turn on fans to prevent PLA jamming=================

    
    M106 P3 S180
    ;Prevent PLA from jamming
    M142 P1 R35 S40

M106 P2 S100 ; turn on big fan ,to cool down toolhead

M104 S220 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q0 A7 B30 C90 Q0 H15 K0
M974 Q0 S2 P0

M975 S1
G1 F30000
G1 X230 Y15
G28 X ; re-home XY
;===== mech mode fast check============================


;start heatbed  scan====================================
M976 S2 P1
G90
G1 X128 Y128 F20000
M976 S3 P2  ;register void printing detection


;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S220
M73 P29 R16
G1 Z0.2
G0 E2 F300
G0 X240 E15 F4800
G0 Y11 E0.700 F1200
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X231 E0.700 F4800
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Textured PEI Plate

G29.1 Z-0.04 ; for Textured PEI Plate


;===== draw extrinsic para cali paint =================
M1002 judge_flag extrude_cali_flag
M622 J1

    M1002 gcode_claim_action : 8

    T1000

    G0 F1200.0 X231 Y12   Z0.2 E0.577
    G0 F1200.0 X226 Y12   Z0.2 E0.275
    G0 F1200.0 X226 Y1.5  Z0.2 E0.577
    G0 F1200.0 X220 Y1.5  Z0.2 E0.330
    G0 F1200.0 X220 Y8    Z0.2 E0.358
    G0 F1200.0 X210 Y8    Z0.2 E0.549
    G0 F1200.0 X210 Y1.5  Z0.2 E0.357

    G0 X48.0 E11.9 F4800
    G0 X48.0 Y12 E0.772 F1200.0
    G0 X45.0 E0.22 F1200.0
    G0 X35.0 Y6.0 E0.86 F1200.0

    ;=========== extruder cali extrusion ==================
    T1000
    M83
    
        
            M204 S5000
        
    
    G0 X35.000 Y6.000 Z0.300 F30000 E0
    G1 F1500.000 E0.800
    M106 S0 ; turn off fan
    G0 X185.000 E9.35441 F4800
    G0 X187 Z0
    G1 F1500.000 E-0.800
    G0 Z1
    G0 X180 Z0.3 F18000

    M900 L1000.0 M1.0
    M900 K0.040
    G0 X45.000 F30000
    G0 Y8.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F1200
    G1 X70.000 E0.31181 F1200
    G1 X75.000 E0.31181 F4800
    G1 X80.000 E0.31181 F1200
    G1 X85.000 E0.31181 F4800
    G1 X90.000 E0.31181 F1200
    G1 X95.000 E0.31181 F4800
    G1 X100.000 E0.31181 F1200
    G1 X105.000 E0.31181 F4800
    G1 X110.000 E0.31181 F1200
    G1 X115.000 E0.31181 F4800
    G1 X120.000 E0.31181 F1200
    G1 X125.000 E0.31181 F4800
    G1 X130.000 E0.31181 F1200
    G1 X135.000 E0.31181 F4800
M73 P30 R16
    G1 X140.000 E0.31181 F1200
    G1 X145.000 E0.31181 F4800
    G1 X150.000 E0.31181 F1200
    G1 X155.000 E0.31181 F4800
    G1 X160.000 E0.31181 F1200
    G1 X165.000 E0.31181 F4800
    G1 X170.000 E0.31181 F1200
    G1 X175.000 E0.31181 F4800
    G1 X180.000 E0.31181 F4800
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3
    M400

    G0 X45.000 F30000
    M900 K0.020
    G0 X45.000 F30000
    G0 Y10.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F1200
    G1 X70.000 E0.31181 F1200
    G1 X75.000 E0.31181 F4800
    G1 X80.000 E0.31181 F1200
    G1 X85.000 E0.31181 F4800
    G1 X90.000 E0.31181 F1200
    G1 X95.000 E0.31181 F4800
M73 P30 R15
    G1 X100.000 E0.31181 F1200
    G1 X105.000 E0.31181 F4800
    G1 X110.000 E0.31181 F1200
    G1 X115.000 E0.31181 F4800
    G1 X120.000 E0.31181 F1200
    G1 X125.000 E0.31181 F4800
M73 P31 R15
    G1 X130.000 E0.31181 F1200
    G1 X135.000 E0.31181 F4800
    G1 X140.000 E0.31181 F1200
    G1 X145.000 E0.31181 F4800
    G1 X150.000 E0.31181 F1200
    G1 X155.000 E0.31181 F4800
    G1 X160.000 E0.31181 F1200
    G1 X165.000 E0.31181 F4800
    G1 X170.000 E0.31181 F1200
    G1 X175.000 E0.31181 F4800
    G1 X180.000 E0.31181 F4800
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3
    M400

    G0 X45.000 F30000
    M900 K0.000
    G0 X45.000 F30000
    G0 Y12.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F1200
    G1 X70.000 E0.31181 F1200
    G1 X75.000 E0.31181 F4800
    G1 X80.000 E0.31181 F1200
    G1 X85.000 E0.31181 F4800
    G1 X90.000 E0.31181 F1200
    G1 X95.000 E0.31181 F4800
    G1 X100.000 E0.31181 F1200
    G1 X105.000 E0.31181 F4800
    G1 X110.000 E0.31181 F1200
    G1 X115.000 E0.31181 F4800
    G1 X120.000 E0.31181 F1200
    G1 X125.000 E0.31181 F4800
    G1 X130.000 E0.31181 F1200
    G1 X135.000 E0.31181 F4800
    G1 X140.000 E0.31181 F1200
    G1 X145.000 E0.31181 F4800
    G1 X150.000 E0.31181 F1200
    G1 X155.000 E0.31181 F4800
M73 P32 R15
    G1 X160.000 E0.31181 F1200
    G1 X165.000 E0.31181 F4800
    G1 X170.000 E0.31181 F1200
    G1 X175.000 E0.31181 F4800
    G1 X180.000 E0.31181 F4800
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3

    G0 X45.000 F30000 ; move to start point

M623 ; end of "draw extrinsic para cali paint"


M1002 judge_flag extrude_cali_flag
M622 J0
    G0 X231 Y1.5 F30000
    G0 X18 E14.3 F4800
M623

M104 S140


;=========== laser and rgb calibration ===========
M400
M18 E
M500 R

M973 S3 P14

G1 X120 Y1.0 Z0.3 F18000.0;Move to first extrude line pos
T1100
G1 X235.0 Y1.0 Z0.3 F18000.0;Move to first extrude line pos
M400 P100
M960 S1 P1
M400 P100
M973 S6 P0; use auto exposure for horizontal laser by xcam
M960 S0 P0

G1 X240.0 Y6.0 Z0.3 F18000.0;Move to vertical extrude line pos
M960 S2 P1
M400 P100
M973 S6 P1; use auto exposure for vertical laser by xcam
M960 S0 P0

;=========== handeye calibration ======================
M1002 judge_flag extrude_cali_flag
M622 J1

    M973 S3 P1 ; camera start stream
    M400 P500
    M973 S1
    G0 F6000 X228.500 Y4.750 Z0.000
    M960 S0 P1
    M973 S1
    M400 P800
    M971 S6 P0
    M973 S2 P0
    M400 P500
    G0 Z0.000 F12000
    M960 S0 P0
    M960 S1 P1
    G0 X215.00 Y4.750
    M400 P200
    M971 S5 P1
    M973 S2 P1
    M400 P500
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y6.75
    M400 P200
    M971 S5 P3
    G0 Z0.500 F12000
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y6.75
    M400 P200
    M971 S5 P4
    M973 S2 P0
    M400 P500
    M960 S0 P0
    M960 S1 P1
    G0 X215.00 Y4.750
    M400 P500
    M971 S5 P2
    M963 S1
    M400 P1500
    M964
    T1100
    G1 Z3 F3000

    M400
    M500 ; save cali data

    M104 S220 ; rise nozzle temp now ,to reduce temp waiting time.

    T1100
    M400 P400
    M960 S0 P0
    G0 F30000.000 Y10.000 X65.000 Z0.000
    M400 P400
    M960 S1 P1
    M400 P50

    M969 S1 N3 A2000
    G0 F360.000 X181.000 Z0.000
    M980.3 A70.000 B74.8733 C5.000 D299.493 E5.000 F175.000 H1.000 I0.000 J0.020 K0.040
    M400 P100
    G0 F20000
    G0 Z1 ; rise nozzle up
    T1000 ; change to nozzle space
    G0 X45.000 Y4.000 F30000 ; move to test line pos
    M969 S0 ; turn off scanning
    M960 S0 P0


    G1 Z2 F20000
    T1000
    G0 X45.000 Y4.000 F30000 E0
    M109 S220
    G0 Z0.3
    G1 F1500.000 E3.600
    G1 X65.000 E1.24726 F1200
    G1 X70.000 E0.31181 F1200
    G1 X75.000 E0.31181 F4800
    G1 X80.000 E0.31181 F1200
    G1 X85.000 E0.31181 F4800
    G1 X90.000 E0.31181 F1200
    G1 X95.000 E0.31181 F4800
    G1 X100.000 E0.31181 F1200
    G1 X105.000 E0.31181 F4800
    G1 X110.000 E0.31181 F1200
    G1 X115.000 E0.31181 F4800
    G1 X120.000 E0.31181 F1200
    G1 X125.000 E0.31181 F4800
    G1 X130.000 E0.31181 F1200
    G1 X135.000 E0.31181 F4800

    ; see if extrude cali success, if not ,use default value
    M1002 judge_last_extrude_cali_success
    M622 J0
        M400
        M900 K0.02 M0.099831
    M623

    G1 X140.000 E0.31181 F1200
    G1 X145.000 E0.31181 F4800
    G1 X150.000 E0.31181 F1200
    G1 X155.000 E0.31181 F4800
    G1 X160.000 E0.31181 F1200
    G1 X165.000 E0.31181 F4800
    G1 X170.000 E0.31181 F1200
    G1 X175.000 E0.31181 F4800
    G1 X180.000 E0.31181 F1200
    G1 X185.000 E0.31181 F4800
    G1 X190.000 E0.31181 F1200
    G1 X195.000 E0.31181 F4800
    G1 X200.000 E0.31181 F1200
    G1 X205.000 E0.31181 F4800
    G1 X210.000 E0.31181 F1200
    G1 X215.000 E0.31181 F4800
    G1 X220.000 E0.31181 F1200
    G1 X225.000 E0.31181 F4800
    M973 S4

M623

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M973 S4 ; turn off scanner
M400 ; wait all motion done before implement the emprical L parameters
;M900 L500.0 ; Empirical parameters
M109 S220
M960 S1 P0 ; turn off laser
M960 S2 P0 ; turn off laser
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
M83
T1000
;===== purge line to wipe the nozzle ============================
G1 E-0.8 F1800
G1 X18.0 Y2.5 Z0.8 F18000.0;Move to start position
G1 E0.8 F1800
M109 S220
G1 Z0.2
G0 X239 E15 F4800
G0 Y12 E0.7 F1200
; MACHINE_START_GCODE_END
; filament start gcode
M106 P3 S150


;VT0
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/72
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
M204 S6000
G1 Z.4 F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.588 Y141.796
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X94.302 Y141.796 E.68108
G1 X94.302 Y123.51 E.68108
G1 X112.588 Y123.51 E.68108
G1 X112.588 Y141.736 E.67884
M204 S6000
G1 X113.045 Y142.253 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X93.845 Y142.253 E.71513
G1 X93.845 Y123.053 E.71513
G1 X113.045 Y123.053 E.71513
G1 X113.045 Y142.193 E.71289
; WIPE_START
G1 X111.045 Y142.199 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X111.221 Y134.569 Z.6 F30000
G1 X111.471 Y123.693 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50487
G1 F6300
M204 S500
G1 X112.2 Y124.422 E.03879
G1 X112.2 Y125.075 E.02459
G1 X111.024 Y123.899 E.06262
G1 X110.37 Y123.899 E.02459
G1 X112.2 Y125.728 E.0974
G1 X112.2 Y126.382 E.02459
G1 X109.717 Y123.899 E.13217
G1 X109.064 Y123.899 E.02459
G1 X112.2 Y127.035 E.16695
G1 X112.2 Y127.688 E.02459
G1 X108.41 Y123.899 E.20173
G1 X107.757 Y123.899 E.02459
G1 X112.2 Y128.341 E.23651
G1 X112.2 Y128.995 E.02459
M73 P33 R15
G1 X107.104 Y123.899 E.27129
G1 X106.45 Y123.899 E.02459
G1 X112.2 Y129.648 E.30607
G1 X112.2 Y130.301 E.02459
G1 X105.797 Y123.899 E.34084
G1 X105.144 Y123.899 E.02459
G1 X112.2 Y130.955 E.37562
G1 X112.2 Y131.608 E.02459
G1 X104.491 Y123.899 E.4104
G1 X103.837 Y123.899 E.02459
G1 X112.2 Y132.261 E.44518
G1 X112.2 Y132.915 E.02459
G1 X103.184 Y123.899 E.47996
G1 X102.531 Y123.899 E.02459
M73 P35 R14
G1 X112.2 Y133.568 E.51474
G1 X112.2 Y134.221 E.02459
G1 X101.877 Y123.899 E.54951
G1 X101.224 Y123.899 E.02459
G1 X112.2 Y134.874 E.58429
G1 X112.2 Y135.528 E.02459
G1 X100.571 Y123.899 E.61907
G1 X99.918 Y123.899 E.02459
G1 X112.2 Y136.181 E.65385
G1 X112.2 Y136.834 E.02459
G1 X99.264 Y123.899 E.68863
G1 X98.611 Y123.899 E.02459
G1 X112.2 Y137.488 E.72341
G1 X112.2 Y138.141 E.02459
G1 X97.958 Y123.899 E.75819
G1 X97.304 Y123.899 E.02459
G1 X112.2 Y138.794 E.79296
G1 X112.2 Y139.448 E.02459
G1 X96.651 Y123.899 E.82774
G1 X95.998 Y123.899 E.02459
G1 X112.2 Y140.101 E.86252
G1 X112.2 Y140.754 E.02459
G1 X95.344 Y123.899 E.8973
G1 X94.691 Y123.899 E.02459
G1 X112.2 Y141.407 E.93208
G1 X111.547 Y141.408 E.02458
G1 X94.691 Y124.552 E.89732
G1 X94.691 Y125.205 E.02459
G1 X110.893 Y141.408 E.86254
G1 X110.24 Y141.408 E.02459
G1 X94.691 Y125.858 E.82776
G1 X94.691 Y126.512 E.02459
G1 X109.587 Y141.408 E.79299
G1 X108.934 Y141.408 E.02459
G1 X94.691 Y127.165 E.75821
G1 X94.691 Y127.818 E.02459
G1 X108.28 Y141.408 E.72343
G1 X107.627 Y141.408 E.02459
G1 X94.691 Y128.472 E.68865
G1 X94.691 Y129.125 E.02459
G1 X106.974 Y141.408 E.65387
G1 X106.32 Y141.408 E.02459
G1 X94.691 Y129.778 E.61909
G1 X94.691 Y130.432 E.02459
G1 X105.667 Y141.408 E.58432
G1 X105.014 Y141.408 E.02459
M73 P36 R14
G1 X94.691 Y131.085 E.54954
G1 X94.691 Y131.738 E.02459
G1 X104.36 Y141.408 E.51476
G1 X103.707 Y141.408 E.02459
G1 X94.691 Y132.391 E.47998
G1 X94.691 Y133.045 E.02459
G1 X103.054 Y141.408 E.4452
G1 X102.401 Y141.408 E.02459
G1 X94.691 Y133.698 E.41042
G1 X94.691 Y134.351 E.02459
G1 X101.747 Y141.408 E.37565
G1 X101.094 Y141.408 E.02459
G1 X94.691 Y135.005 E.34087
G1 X94.691 Y135.658 E.02459
G1 X100.441 Y141.408 E.30609
G1 X99.787 Y141.408 E.02459
G1 X94.691 Y136.311 E.27131
G1 X94.691 Y136.964 E.02459
G1 X99.134 Y141.408 E.23653
G1 X98.481 Y141.408 E.02459
G1 X94.691 Y137.618 E.20175
G1 X94.691 Y138.271 E.02459
G1 X97.827 Y141.408 E.16697
G1 X97.174 Y141.408 E.02459
G1 X94.691 Y138.924 E.1322
G1 X94.691 Y139.578 E.02459
G1 X96.521 Y141.408 E.09742
G1 X95.868 Y141.408 E.02459
G1 X94.691 Y140.231 E.06264
G1 X94.691 Y140.884 E.02459
G1 X95.42 Y141.613 E.03881
; CHANGE_LAYER
; Z_HEIGHT: 0.48
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6300
G1 X94.691 Y140.884 E-.39179
G1 X94.691 Y140.231 E-.24825
G1 X94.914 Y140.454 E-.11996
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/72
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S255
M106 P2 S178
; open powerlost recovery
M1003 S1
M976 S1 P1 ; scan model before printing 2nd layer
M400 P100
G1 E.8
G1 E-.8
M204 S10000
G17
G3 Z.6 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.967 Y141.912 Z.88 F30000
G1 Z.48
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424499
G1 F7056.416
G1 X112.542 Y141.336 E.03382
G1 X112.542 Y140.821 E.02142
G1 X111.613 Y141.75 E.05459
G1 X111.098 Y141.75 E.02142
G1 X112.542 Y140.306 E.08489
G1 X112.542 Y139.79 E.02142
G1 X110.583 Y141.75 E.11519
G1 X110.067 Y141.75 E.02142
G1 X112.542 Y139.275 E.14549
G1 X112.542 Y138.76 E.02142
G1 X109.552 Y141.75 E.17579
G1 X109.036 Y141.75 E.02142
G1 X112.542 Y138.244 E.20609
G1 X112.542 Y137.729 E.02142
G1 X108.521 Y141.75 E.23639
G1 X108.006 Y141.75 E.02142
G1 X112.542 Y137.214 E.26669
G1 X112.542 Y136.698 E.02142
G1 X107.49 Y141.75 E.29698
G1 X106.975 Y141.75 E.02142
G1 X112.542 Y136.183 E.32728
G1 X112.542 Y135.668 E.02142
G1 X106.46 Y141.75 E.35758
M73 P37 R14
G1 X105.944 Y141.75 E.02142
G1 X112.542 Y135.152 E.38788
G1 X112.542 Y134.637 E.02142
G1 X105.429 Y141.75 E.41818
G1 X104.914 Y141.75 E.02142
G1 X112.542 Y134.121 E.44848
G1 X112.542 Y133.606 E.02142
G1 X104.398 Y141.75 E.47878
G1 X103.883 Y141.75 E.02142
G1 X112.542 Y133.091 E.50908
G1 X112.542 Y132.575 E.02142
G1 X103.368 Y141.75 E.53938
G1 X102.852 Y141.75 E.02142
G1 X112.542 Y132.06 E.56968
G1 X112.542 Y131.545 E.02142
G1 X102.337 Y141.75 E.59997
G1 X101.822 Y141.75 E.02142
G1 X112.542 Y131.029 E.63027
G1 X112.542 Y130.514 E.02142
G1 X101.306 Y141.75 E.66057
G1 X100.791 Y141.75 E.02142
G1 X112.542 Y129.999 E.69087
G1 X112.542 Y129.483 E.02142
G1 X100.275 Y141.75 E.72117
G1 X99.76 Y141.75 E.02142
G1 X112.542 Y128.968 E.75147
G1 X112.542 Y128.453 E.02142
G1 X99.245 Y141.75 E.78177
G1 X98.729 Y141.75 E.02142
G1 X112.542 Y127.937 E.81207
G1 X112.542 Y127.422 E.02142
G1 X98.214 Y141.75 E.84237
G1 X97.699 Y141.75 E.02142
G1 X112.542 Y126.907 E.87267
G1 X112.542 Y126.391 E.02142
G1 X97.183 Y141.75 E.90297
G1 X96.668 Y141.75 E.02142
G1 X112.542 Y125.876 E.93326
G1 X112.542 Y125.36 E.02142
G1 X96.153 Y141.75 E.96356
G1 X95.637 Y141.75 E.02142
G1 X112.542 Y124.845 E.99386
G1 X112.542 Y124.33 E.02142
G1 X95.122 Y141.75 E1.02416
G1 X94.607 Y141.75 E.02142
G1 X112.542 Y123.814 E1.05446
G1 X112.542 Y123.557 E.01071
G1 X112.284 Y123.557 E.01071
G1 X94.349 Y141.492 E1.05446
G1 X94.349 Y140.977 E.02142
G1 X111.769 Y123.557 E1.02416
G1 X111.253 Y123.557 E.02142
G1 X94.349 Y140.461 E.99386
G1 X94.349 Y139.946 E.02142
G1 X110.738 Y123.557 E.96356
G1 X110.223 Y123.557 E.02142
G1 X94.349 Y139.431 E.93326
G1 X94.349 Y138.915 E.02142
G1 X109.707 Y123.557 E.90296
G1 X109.192 Y123.557 E.02142
G1 X94.349 Y138.4 E.87266
G1 X94.349 Y137.884 E.02142
G1 X108.677 Y123.557 E.84236
G1 X108.161 Y123.557 E.02142
G1 X94.349 Y137.369 E.81206
G1 X94.349 Y136.854 E.02142
G1 X107.646 Y123.557 E.78176
G1 X107.131 Y123.557 E.02142
G1 X94.349 Y136.338 E.75147
G1 X94.349 Y135.823 E.02142
G1 X106.615 Y123.557 E.72117
G1 X106.1 Y123.557 E.02142
G1 X94.349 Y135.308 E.69087
G1 X94.349 Y134.792 E.02142
G1 X105.584 Y123.557 E.66057
G1 X105.069 Y123.557 E.02142
G1 X94.349 Y134.277 E.63027
G1 X94.349 Y133.762 E.02142
G1 X104.554 Y123.557 E.59997
G1 X104.038 Y123.557 E.02142
G1 X94.349 Y133.246 E.56967
G1 X94.349 Y132.731 E.02142
G1 X103.523 Y123.557 E.53937
G1 X103.008 Y123.557 E.02142
G1 X94.349 Y132.216 E.50907
G1 X94.349 Y131.7 E.02142
G1 X102.492 Y123.557 E.47877
G1 X101.977 Y123.557 E.02142
G1 X94.349 Y131.185 E.44848
G1 X94.349 Y130.67 E.02142
G1 X101.462 Y123.557 E.41818
G1 X100.946 Y123.557 E.02142
G1 X94.349 Y130.154 E.38788
G1 X94.349 Y129.639 E.02142
G1 X100.431 Y123.557 E.35758
G1 X99.916 Y123.557 E.02142
G1 X94.349 Y129.123 E.32728
G1 X94.349 Y128.608 E.02142
G1 X99.4 Y123.557 E.29698
G1 X98.885 Y123.557 E.02142
G1 X94.349 Y128.093 E.26668
G1 X94.349 Y127.577 E.02142
G1 X98.37 Y123.557 E.23638
G1 X97.854 Y123.557 E.02142
G1 X94.349 Y127.062 E.20608
G1 X94.349 Y126.547 E.02142
G1 X97.339 Y123.557 E.17578
G1 X96.823 Y123.557 E.02142
G1 X94.349 Y126.031 E.14549
G1 X94.349 Y125.516 E.02142
G1 X96.308 Y123.557 E.11519
G1 X95.793 Y123.557 E.02142
G1 X94.349 Y125.001 E.08489
G1 X94.349 Y124.485 E.02142
G1 X95.277 Y123.557 E.05459
G1 X94.762 Y123.557 E.02142
G1 X94.187 Y124.132 E.03381
; CHANGE_LAYER
; Z_HEIGHT: 0.76
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F7056.416
G1 X94.762 Y123.557 E-.30905
G1 X95.277 Y123.557 E-.19584
G1 X94.803 Y124.031 E-.25511
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/72
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
G17
G3 Z.88 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.847 Y134.781 Z1.16 F30000
G1 X112.704 Y124.132 Z1.16
G1 Z.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424499
G1 F7056.416
G1 X112.129 Y123.557 E.03382
G1 X111.613 Y123.557 E.02142
G1 X112.542 Y124.485 E.05459
G1 X112.542 Y125.001 E.02142
G1 X111.098 Y123.557 E.08489
G1 X110.583 Y123.557 E.02142
M73 P38 R14
G1 X112.542 Y125.516 E.11519
G1 X112.542 Y126.031 E.02142
G1 X110.067 Y123.557 E.14549
G1 X109.552 Y123.557 E.02142
G1 X112.542 Y126.547 E.17579
G1 X112.542 Y127.062 E.02142
G1 X109.036 Y123.557 E.20609
G1 X108.521 Y123.557 E.02142
G1 X112.542 Y127.577 E.23639
G1 X112.542 Y128.093 E.02142
G1 X108.006 Y123.557 E.26669
G1 X107.49 Y123.557 E.02142
G1 X112.542 Y128.608 E.29698
G1 X112.542 Y129.124 E.02142
G1 X106.975 Y123.557 E.32728
G1 X106.46 Y123.557 E.02142
G1 X112.542 Y129.639 E.35758
G1 X112.542 Y130.154 E.02142
G1 X105.944 Y123.557 E.38788
G1 X105.429 Y123.557 E.02142
G1 X112.542 Y130.67 E.41818
G1 X112.542 Y131.185 E.02142
G1 X104.914 Y123.557 E.44848
G1 X104.398 Y123.557 E.02142
G1 X112.542 Y131.7 E.47878
G1 X112.542 Y132.216 E.02142
G1 X103.883 Y123.557 E.50908
G1 X103.368 Y123.557 E.02142
G1 X112.542 Y132.731 E.53938
G1 X112.542 Y133.246 E.02142
G1 X102.852 Y123.557 E.56968
G1 X102.337 Y123.557 E.02142
G1 X112.542 Y133.762 E.59997
G1 X112.542 Y134.277 E.02142
G1 X101.822 Y123.557 E.63027
G1 X101.306 Y123.557 E.02142
G1 X112.542 Y134.792 E.66057
G1 X112.542 Y135.308 E.02142
G1 X100.791 Y123.557 E.69087
G1 X100.275 Y123.557 E.02142
G1 X112.542 Y135.823 E.72117
G1 X112.542 Y136.338 E.02142
G1 X99.76 Y123.557 E.75147
G1 X99.245 Y123.557 E.02142
G1 X112.542 Y136.854 E.78177
G1 X112.542 Y137.369 E.02142
G1 X98.729 Y123.557 E.81207
G1 X98.214 Y123.557 E.02142
G1 X112.542 Y137.885 E.84237
G1 X112.542 Y138.4 E.02142
G1 X97.699 Y123.557 E.87267
G1 X97.183 Y123.557 E.02142
G1 X112.542 Y138.915 E.90296
G1 X112.542 Y139.431 E.02142
G1 X96.668 Y123.557 E.93326
G1 X96.153 Y123.557 E.02142
G1 X112.542 Y139.946 E.96356
G1 X112.542 Y140.461 E.02142
G1 X95.637 Y123.557 E.99386
G1 X95.122 Y123.557 E.02142
G1 X112.542 Y140.977 E1.02416
G1 X112.542 Y141.492 E.02142
G1 X94.607 Y123.557 E1.05446
G1 X94.349 Y123.557 E.01071
G1 X94.349 Y123.814 E.01071
G1 X112.284 Y141.75 E1.05446
G1 X111.769 Y141.75 E.02142
G1 X94.349 Y124.33 E1.02416
G1 X94.349 Y124.845 E.02142
G1 X111.253 Y141.75 E.99386
G1 X110.738 Y141.75 E.02142
G1 X94.349 Y125.361 E.96356
G1 X94.349 Y125.876 E.02142
G1 X110.223 Y141.75 E.93326
G1 X109.707 Y141.75 E.02142
G1 X94.349 Y126.391 E.90296
G1 X94.349 Y126.907 E.02142
G1 X109.192 Y141.75 E.87266
G1 X108.677 Y141.75 E.02142
G1 X94.349 Y127.422 E.84236
G1 X94.349 Y127.937 E.02142
G1 X108.161 Y141.75 E.81206
G1 X107.646 Y141.75 E.02142
G1 X94.349 Y128.453 E.78176
G1 X94.349 Y128.968 E.02142
G1 X107.131 Y141.75 E.75147
G1 X106.615 Y141.75 E.02142
G1 X94.349 Y129.483 E.72117
G1 X94.349 Y129.999 E.02142
G1 X106.1 Y141.75 E.69087
G1 X105.584 Y141.75 E.02142
G1 X94.349 Y130.514 E.66057
G1 X94.349 Y131.029 E.02142
G1 X105.069 Y141.75 E.63027
G1 X104.554 Y141.75 E.02142
G1 X94.349 Y131.545 E.59997
G1 X94.349 Y132.06 E.02142
G1 X104.038 Y141.75 E.56967
G1 X103.523 Y141.75 E.02142
G1 X94.349 Y132.575 E.53937
G1 X94.349 Y133.091 E.02142
G1 X103.008 Y141.75 E.50907
G1 X102.492 Y141.75 E.02142
G1 X94.349 Y133.606 E.47877
G1 X94.349 Y134.122 E.02142
G1 X101.977 Y141.75 E.44848
G1 X101.462 Y141.75 E.02142
G1 X94.349 Y134.637 E.41818
G1 X94.349 Y135.152 E.02142
G1 X100.946 Y141.75 E.38788
G1 X100.431 Y141.75 E.02142
G1 X94.349 Y135.668 E.35758
G1 X94.349 Y136.183 E.02142
G1 X99.916 Y141.75 E.32728
G1 X99.4 Y141.75 E.02142
G1 X94.349 Y136.698 E.29698
G1 X94.349 Y137.214 E.02142
G1 X98.885 Y141.75 E.26668
G1 X98.37 Y141.75 E.02142
G1 X94.349 Y137.729 E.23638
G1 X94.349 Y138.244 E.02142
G1 X97.854 Y141.75 E.20608
G1 X97.339 Y141.75 E.02142
G1 X94.349 Y138.76 E.17578
G1 X94.349 Y139.275 E.02142
G1 X96.823 Y141.75 E.14548
G1 X96.308 Y141.75 E.02142
G1 X94.349 Y139.79 E.11519
G1 X94.349 Y140.306 E.02142
G1 X95.793 Y141.75 E.08489
G1 X95.277 Y141.75 E.02142
G1 X94.349 Y140.821 E.05459
G1 X94.349 Y141.337 E.02142
G1 X94.924 Y141.912 E.03381
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F7056.416
G1 X94.349 Y141.337 E-.30905
G1 X94.349 Y140.821 E-.19583
G1 X94.824 Y141.296 E-.25511
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/72
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
G17
G3 Z1.16 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2469
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2469
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z1.44 F30000
G1 Z1.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2469
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2469
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 1.32
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/72
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
G17
G3 Z1.44 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z1.32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
M73 P39 R14
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z1.72 F30000
G1 X112.527 Y128.59 Z1.72
G1 Z1.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/72
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
G17
G3 Z1.72 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
M73 P39 R13
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/72
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
G17
G3 Z2 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
M73 P40 R13
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z2.28 F30000
G1 X112.527 Y128.59 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 2.16
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/72
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
G17
G3 Z2.28 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z2.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z2.56 F30000
G1 Z2.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 2.44
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/72
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
G17
G3 Z2.56 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z2.44
G1 E.8 F1800
; FEATURE: Inner wall
M73 P41 R13
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z2.84 F30000
G1 X112.527 Y128.59 Z2.84
G1 Z2.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/72
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
G17
G3 Z2.84 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z3.12 F30000
G1 Z2.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
M73 P42 R13
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/72
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
G17
G3 Z3.12 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z3.4 F30000
G1 X112.527 Y128.59 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 3.28
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/72
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
G17
G3 Z3.4 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z3.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
M73 P43 R13
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z3.68 F30000
G1 Z3.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/72
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
G17
G3 Z3.68 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z3.96 F30000
G1 X112.527 Y128.59 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
M73 P43 R12
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 3.84
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/72
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
G17
G3 Z3.96 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z3.84
G1 E.8 F1800
; FEATURE: Inner wall
M73 P44 R12
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z4.24 F30000
G1 Z3.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 4.12
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/72
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
G17
G3 Z4.24 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z4.12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z4.52 F30000
G1 X112.527 Y128.59 Z4.52
G1 Z4.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
M73 P45 R12
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/72
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
G17
G3 Z4.52 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 4.68
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/72
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
G17
G3 Z4.8 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z4.68
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
M73 P46 R12
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z5.08 F30000
G1 X112.527 Y128.59 Z5.08
G1 Z4.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 4.96
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 18/72
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
G17
G3 Z5.08 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z4.96
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z5.36 F30000
G1 Z4.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 19/72
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
G17
G3 Z5.36 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z5.24
M73 P47 R12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z5.64 F30000
G1 X112.527 Y128.59 Z5.64
G1 Z5.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 5.52
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 20/72
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
G17
G3 Z5.64 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z5.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z5.92 F30000
G1 Z5.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
M73 P48 R12
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
M73 P48 R11
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 21/72
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
G17
G3 Z5.92 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z6.2 F30000
G1 X112.527 Y128.59 Z6.2
G1 Z5.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/72
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
G17
G3 Z6.2 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z6.08
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
M73 P49 R11
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z6.48 F30000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 6.36
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 23/72
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
G17
G3 Z6.48 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z6.36
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z6.76 F30000
G1 X112.527 Y128.59 Z6.76
G1 Z6.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 6.64
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 24/72
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
G17
G3 Z6.76 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z6.64
M73 P50 R11
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z7.04 F30000
G1 Z6.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 25/72
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
G17
G3 Z7.04 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z6.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z7.32 F30000
G1 X112.527 Y128.59 Z7.32
G1 Z6.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
M73 P51 R11
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 7.2
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 26/72
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
G17
G3 Z7.32 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z7.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z7.6 F30000
G1 Z7.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 7.48
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 27/72
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
G17
G3 Z7.6 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z7.48
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
M73 P52 R11
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z7.88 F30000
G1 X112.527 Y128.59 Z7.88
G1 Z7.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 7.76
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 28/72
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
G17
G3 Z7.88 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z7.76
M73 P52 R10
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z8.16 F30000
G1 Z7.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 8.04
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 29/72
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
G17
G3 Z8.16 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z8.04
M73 P53 R10
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z8.44 F30000
G1 X112.527 Y128.59 Z8.44
G1 Z8.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 8.32
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 30/72
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
G17
G3 Z8.44 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z8.32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z8.72 F30000
G1 Z8.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
M73 P54 R10
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 31/72
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
G17
G3 Z8.72 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

G1 E-1.2 F1800
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z11.6 F1200

G1 X70 F21000
G1 Y245
G1 Y265 F3000
M400
M106 P1 S0
M106 P2 S0

M104 S220


M620.11 S0

M400
G1 X90
G1 Y255 F4000
G1 X100 F5000
G1 X120 F15000
G1 X20 Y50 F21000
G1 Y-3

M620.1 E F299.339 T240
T1
M73 E1
M620.1 E F299.339 T240



M620.11 S0

G92 E0

M83
; FLUSH_START
; always use highest temperature to flush
M400

M109 S240


G1 E23.7 F299.339 ; do not need pulsatile flushing for start part
G1 E0.839775 F50
G1 E9.65742 F299.339
G1 E0.839775 F50
G1 E9.65742 F299.339
G1 E0.839775 F50
G1 E9.65742 F299.339
G1 E0.839775 F50
G1 E9.65742 F299.339

; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
G1 E11.824 F299.339
G1 E1.31378 F50
; FLUSH_END

; FLUSH_START
M400
M109 S220
G1 E2 F299.339 ;Compensate for filament spillage during waiting temperature
; FLUSH_END
M400
G92 E0
G1 E-2 F1800
M106 P1 S255
M400 S3

M73 P55 R10
G1 X70 F5000
G1 X90 F3000
G1 Y255 F4000
G1 X105 F5000
G1 Y265
G1 X70 F10000
G1 X100 F5000
G1 X70 F10000
G1 X100 F5000

G1 X70 F10000
G1 X80 F15000
G1 X60
G1 X80
G1 X60
G1 X80 ; shake to put down garbage
G1 X100 F5000
G1 X165 F15000; wipe and shake
G1 Y256 ; move Y to aside, prevent collision
M400
G1 Z11.6 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


; OBJECT_ID: 327
G1 X112.86 Y142.068 F30000
G1 Z8.6
G1 E2 F1800
; FEATURE: Inner wall
G1 F6594.904
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z9 F30000
G1 X112.527 Y128.59 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
M73 P59 R9
G1 X105.175 Y123.572 E.68006
M73 P60 R9
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
M73 P61 R8
G1 F6594.904
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 8.88
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
M73 P62 R8
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 32/72
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
G17
G3 Z9 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z8.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
M73 P63 R8
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
M73 P64 R8
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z9.28 F30000
G1 Z8.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
M73 P65 R8
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
M73 P65 R7
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
M73 P66 R7
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 9.16
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 33/72
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
G17
G3 Z9.28 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z9.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z9.56 F30000
G1 X112.527 Y128.59 Z9.56
G1 Z9.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 9.44
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 34/72
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
G17
G3 Z9.56 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z9.44
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z9.84 F30000
G1 Z9.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 9.72
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 35/72
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
G17
G3 Z9.84 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z9.72
G1 E.8 F1800
; FEATURE: Inner wall
M73 P67 R7
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z10.12 F30000
G1 X112.527 Y128.59 Z10.12
G1 Z9.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 10
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 36/72
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
G17
G3 Z10.12 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z10
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z10.4 F30000
G1 Z10
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
M73 P68 R7
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 10.28
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 37/72
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
G17
G3 Z10.4 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z10.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z10.68 F30000
G1 X112.527 Y128.59 Z10.68
G1 Z10.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 10.56
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 38/72
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
G17
G3 Z10.68 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z10.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
M73 P69 R7
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z10.96 F30000
G1 Z10.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 10.84
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 39/72
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
G17
G3 Z10.96 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z10.84
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z11.24 F30000
G1 X112.527 Y128.59 Z11.24
G1 Z10.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
M73 P69 R6
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 11.12
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 40/72
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
G17
G3 Z11.24 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

G1 E-1.2 F1800
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z14.12 F1200

G1 X70 F21000
M73 P70 R6
G1 Y245
G1 Y265 F3000
M400
M106 P1 S0
M106 P2 S0

M104 S220


M620.11 S0

M400
G1 X90
G1 Y255 F4000
G1 X100 F5000
G1 X120 F15000
G1 X20 Y50 F21000
G1 Y-3

; get travel path for change filament
M620.1 X54 Y0 F21000 P0
M620.1 X54 Y0 F21000 P1
M620.1 X54 Y245 F21000 P2

M620.1 E F299.339 T240
T0
M73 E0
M620.1 E F299.339 T240



M620.11 S0

G92 E0

M83
; FLUSH_START
; always use highest temperature to flush
M400

M109 S240


G1 E23.7 F299.339 ; do not need pulsatile flushing for start part
G1 E1.02271 F50
G1 E11.7611 F299.339
G1 E1.02271 F50
G1 E11.7611 F299.339
G1 E1.02271 F50
G1 E11.7611 F299.339
G1 E1.02271 F50
G1 E11.7611 F299.339

; FLUSH_END
G1 E-2 F1800
G1 E2 F300







; FLUSH_START
M400
M109 S220
G1 E2 F299.339 ;Compensate for filament spillage during waiting temperature
; FLUSH_END
M400
G92 E0
G1 E-2 F1800
M106 P1 S255
M400 S3

G1 X70 F5000
G1 X90 F3000
G1 Y255 F4000
G1 X105 F5000
G1 Y265
G1 X70 F10000
G1 X100 F5000
G1 X70 F10000
G1 X100 F5000

G1 X70 F10000
G1 X80 F15000
G1 X60
G1 X80
G1 X60
G1 X80 ; shake to put down garbage
G1 X100 F5000
G1 X165 F15000; wipe and shake
G1 Y256 ; move Y to aside, prevent collision
M400
G1 Z14.12 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


; OBJECT_ID: 327
G1 X112.86 Y142.068 F30000
G1 Z11.12
G1 E2 F1800
; FEATURE: Inner wall
G1 F6594.904
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z11.52 F30000
G1 Z11.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F6594.904
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
M73 P71 R6
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 11.4
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 41/72
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
G17
G3 Z11.52 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z11.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
M73 P75 R5
G1 E-.04 F1800
G1 X111.947 Y134.79 Z11.8 F30000
M73 P76 R5
G1 X112.527 Y128.59 Z11.8
G1 Z11.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
M73 P77 R5
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 11.68
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 42/72
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
G17
G3 Z11.8 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z11.68
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z12.08 F30000
G1 Z11.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 11.96
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 43/72
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
G17
G3 Z12.08 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z11.96
M73 P78 R5
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z12.36 F30000
G1 X112.527 Y128.59 Z12.36
G1 Z11.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
M73 P78 R4
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 12.24
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 44/72
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
G17
G3 Z12.36 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z12.24
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z12.64 F30000
G1 Z12.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
M73 P79 R4
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 12.52
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 45/72
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
G17
G3 Z12.64 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z12.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z12.92 F30000
G1 X112.527 Y128.59 Z12.92
G1 Z12.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 12.8
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 46/72
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
G17
G3 Z12.92 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
M73 P80 R4
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z13.2 F30000
G1 Z12.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 13.08
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 47/72
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
G17
G3 Z13.2 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z13.08
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z13.48 F30000
G1 X112.527 Y128.59 Z13.48
G1 Z13.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 13.36
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 48/72
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
G17
G3 Z13.48 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z13.36
M73 P81 R4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z13.76 F30000
G1 Z13.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 13.64
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 49/72
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
G17
G3 Z13.76 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z13.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z14.04 F30000
G1 X112.527 Y128.59 Z14.04
G1 Z13.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
M73 P82 R4
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 13.92
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 50/72
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
G17
G3 Z14.04 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z13.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z14.32 F30000
G1 Z13.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
M73 P82 R3
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 14.2
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 51/72
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
G17
G3 Z14.32 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z14.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
M73 P83 R3
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z14.6 F30000
G1 X112.527 Y128.59 Z14.6
G1 Z14.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 14.48
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 52/72
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
G17
G3 Z14.6 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z14.48
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z14.88 F30000
G1 Z14.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 14.76
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 53/72
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
G17
G3 Z14.88 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z14.76
M73 P84 R3
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z15.16 F30000
G1 X112.527 Y128.59 Z15.16
G1 Z14.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 15.04
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 54/72
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
G17
G3 Z15.16 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z15.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z15.44 F30000
G1 Z15.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
M73 P85 R3
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 15.32
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 55/72
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
G17
G3 Z15.44 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z15.32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z15.72 F30000
G1 X112.527 Y128.59 Z15.72
G1 Z15.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 15.6
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 56/72
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
G17
G3 Z15.72 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z15.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P86 R3
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z16 F30000
G1 Z15.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 15.88
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 57/72
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
G17
G3 Z16 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z15.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z16.28 F30000
G1 X112.527 Y128.59 Z16.28
G1 Z15.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 16.16
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 58/72
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
G17
G3 Z16.28 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
M73 P87 R3
G1 Z16.16
G1 E.8 F1800
; FEATURE: Inner wall
M73 P87 R2
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z16.56 F30000
G1 Z16.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 16.44
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 59/72
; update layer progress
M73 L59
M991 S0 P58 ;notify layer change
G17
G3 Z16.56 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z16.44
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z16.84 F30000
G1 X112.527 Y128.59 Z16.84
G1 Z16.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
M73 P88 R2
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 16.72
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 60/72
; update layer progress
M73 L60
M991 S0 P59 ;notify layer change
G17
G3 Z16.84 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z16.72
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z17.12 F30000
G1 Z16.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 17
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 61/72
; update layer progress
M73 L61
M991 S0 P60 ;notify layer change
G17
G3 Z17.12 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P89 R2
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z17.4 F30000
G1 X112.527 Y128.59 Z17.4
G1 Z17
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 17.28
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 62/72
; update layer progress
M73 L62
M991 S0 P61 ;notify layer change
G17
G3 Z17.4 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z17.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z17.68 F30000
G1 Z17.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 17.56
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 63/72
; update layer progress
M73 L63
M991 S0 P62 ;notify layer change
G17
G3 Z17.68 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
M73 P90 R2
G1 Z17.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z17.96 F30000
G1 X112.527 Y128.59 Z17.96
G1 Z17.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 17.84
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 64/72
; update layer progress
M73 L64
M991 S0 P63 ;notify layer change
G17
G3 Z17.96 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z17.84
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z18.24 F30000
G1 Z17.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
M73 P91 R2
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 18.12
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 65/72
; update layer progress
M73 L65
M991 S0 P64 ;notify layer change
G17
G3 Z18.24 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z18.12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
M73 P91 R1
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z18.52 F30000
G1 X112.527 Y128.59 Z18.52
G1 Z18.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 18.4
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 66/72
; update layer progress
M73 L66
M991 S0 P65 ;notify layer change
G17
G3 Z18.52 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z18.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2461
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P92 R1
G1 F2461
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.509 Y141.735 Z18.8 F30000
G1 Z18.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2461
G1 X109.068 Y141.735 E.06938
G1 X112.527 Y138.276 E.21756
G1 X112.527 Y141.735 E.15384
G1 X94.364 Y123.572 E1.14257
G1 X94.364 Y127.03 E.15384
G1 X97.822 Y123.572 E.21756
G1 X99.382 Y123.572 E.06938
G1 X94.364 Y129.364 F30000
G1 F2461
G1 X94.364 Y130.924 E.06938
G1 X105.175 Y141.735 E.68006
G1 X101.716 Y141.735 E.15384
G1 X112.527 Y130.924 E.68006
G1 X112.527 Y134.382 E.15384
G1 X101.716 Y123.572 E.68006
G1 X105.175 Y123.572 E.15384
G1 X94.364 Y134.382 E.68006
G1 X94.364 Y138.276 E.17321
G1 X97.822 Y141.735 E.21756
G1 X94.364 Y141.735 E.15384
G1 X112.527 Y123.572 E1.14257
G1 X109.068 Y123.572 E.15384
G1 X112.527 Y127.03 E.21756
G1 X112.527 Y128.59 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 18.68
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X112.527 Y127.03 E-.59267
G1 X112.215 Y126.719 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 67/72
; update layer progress
M73 L67
M991 S0 P66 ;notify layer change
G17
G3 Z18.8 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z18.68
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2475
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2475
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.947 Y134.79 Z19.08 F30000
G1 X112.527 Y128.59 Z19.08
G1 Z18.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2475
G1 X112.527 Y127.03 E.06938
G1 X109.068 Y123.572 E.21756
G1 X112.527 Y123.572 E.15384
G1 X94.364 Y141.735 E1.14257
G1 X97.822 Y141.735 E.15384
G1 X94.364 Y138.276 E.21756
G1 X94.364 Y134.382 E.17321
G1 X105.175 Y123.572 E.68006
G1 X101.716 Y123.572 E.15384
G1 X112.527 Y134.382 E.68006
G1 X112.527 Y130.924 E.15384
G1 X101.716 Y141.735 E.68006
G1 X105.175 Y141.735 E.15384
G1 X94.364 Y130.924 E.68006
G1 X94.364 Y129.364 E.06938
G1 X99.382 Y123.572 F30000
G1 F2475
G1 X97.822 Y123.572 E.06938
G1 X94.364 Y127.03 E.21756
G1 X94.364 Y123.572 E.15384
G1 X112.527 Y141.735 E1.14257
G1 X112.527 Y138.276 E.15384
G1 X109.068 Y141.735 E.21756
G1 X107.509 Y141.735 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 18.96
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F6594.904
G1 X109.068 Y141.735 E-.59267
G1 X109.38 Y141.423 E-.16733
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 68/72
; update layer progress
M73 L68
M991 S0 P67 ;notify layer change
G17
G3 Z19.08 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
M73 P93 R1
G1 Z18.96
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2905
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2905
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
G1 F7144.614
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.869 Y141.375 Z19.36 F30000
G1 Z18.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2905
G1 X109.428 Y141.375 E.06938
G1 X112.167 Y138.636 E.17226
G1 X112.167 Y141.375 E.12181
G1 X94.724 Y123.932 E1.09728
G1 X94.724 Y126.67 E.12181
G1 X97.462 Y123.932 E.17226
G1 X99.022 Y123.932 E.06938
G1 X94.724 Y129.724 F30000
G1 F2905
G1 X94.724 Y131.284 E.06938
G1 X104.815 Y141.375 E.63477
G1 X102.076 Y141.375 E.12181
G1 X112.167 Y131.284 E.63477
G1 X112.167 Y134.022 E.12181
G1 X102.076 Y123.932 E.63477
G1 X104.815 Y123.932 E.12181
G1 X94.724 Y134.022 E.63477
G1 X94.724 Y138.636 E.20523
G1 X97.462 Y141.375 E.17226
G1 X94.724 Y141.375 E.12181
G1 X112.167 Y123.932 E1.09728
G1 X109.428 Y123.932 E.12181
G1 X112.167 Y126.67 E.17226
G1 X112.167 Y128.23 E.06938
G1 X112.488 Y123.611 F30000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.400195
G1 F2905
G1 X112.362 Y123.585 E.00499
G1 X94.529 Y123.585 E.69191
G1 X94.403 Y123.611 E.00499
G1 X94.377 Y123.737 E.00499
G1 X94.377 Y141.57 E.69191
G1 X94.403 Y141.695 E.00499
G1 X94.529 Y141.721 E.00499
G1 X112.362 Y141.721 E.69191
G1 X112.488 Y141.695 E.00499
G1 X112.514 Y141.57 E.00499
G1 X112.514 Y123.737 E.69191
G1 X112.5 Y123.67 E.00266
; CHANGE_LAYER
; Z_HEIGHT: 19.24
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F7560.659
G1 X112.514 Y123.737 E-.02603
G1 X112.514 Y125.668 E-.73397
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 69/72
; update layer progress
M73 L69
M991 S0 P68 ;notify layer change
G17
G3 Z19.36 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z19.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
M204 S10000
M73 P94 R1
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.785 Y141.907 Z19.64 F30000
G1 Z19.24
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40237
; LAYER_HEIGHT: 0.4
G1 F3000
G1 X112.497 Y141.195 E.05218
G1 X112.497 Y140.555 E.03314
G1 X111.347 Y141.705 E.08422
G1 X110.708 Y141.705 E.03314
G1 X112.497 Y139.915 E.13109
G1 X112.497 Y139.276 E.03314
G1 X110.068 Y141.705 E.17796
G1 X109.428 Y141.705 E.03314
G1 X112.497 Y138.636 E.22484
G1 X112.497 Y137.996 E.03314
G1 X108.788 Y141.705 E.27171
G1 X108.149 Y141.705 E.03314
G1 X112.497 Y137.356 E.31858
G1 X112.497 Y136.717 E.03314
G1 X107.509 Y141.705 E.36546
G1 X106.869 Y141.705 E.03314
G1 X112.497 Y136.077 E.41233
G1 X112.497 Y135.437 E.03314
G1 X106.229 Y141.705 E.4592
G1 X105.59 Y141.705 E.03314
G1 X112.497 Y134.797 E.50608
G1 X112.497 Y134.158 E.03314
G1 X104.95 Y141.705 E.55295
G1 X104.31 Y141.705 E.03314
G1 X112.497 Y133.518 E.59982
G1 X112.497 Y132.878 E.03314
G1 X103.67 Y141.705 E.6467
G1 X103.031 Y141.705 E.03314
G1 X112.497 Y132.238 E.69357
G1 X112.497 Y131.599 E.03314
G1 X102.391 Y141.705 E.74044
G1 X101.751 Y141.705 E.03314
G1 X112.497 Y130.959 E.78732
G1 X112.497 Y130.319 E.03314
G1 X101.111 Y141.705 E.83419
G1 X100.472 Y141.705 E.03314
G1 X112.497 Y129.679 E.88106
G1 X112.497 Y129.04 E.03314
G1 X99.832 Y141.705 E.92794
G1 X99.192 Y141.705 E.03314
G1 X112.497 Y128.4 E.97481
G1 X112.497 Y127.76 E.03314
G1 X98.552 Y141.705 E1.02168
G1 X97.913 Y141.705 E.03314
G1 X112.497 Y127.12 E1.06856
G1 X112.497 Y126.481 E.03314
G1 X97.273 Y141.705 E1.11543
G1 X96.633 Y141.705 E.03314
G1 X112.497 Y125.841 E1.1623
G1 X112.497 Y125.201 E.03314
G1 X95.993 Y141.705 E1.20917
G1 X95.354 Y141.705 E.03314
G1 X112.497 Y124.561 E1.25605
G1 X112.497 Y123.922 E.03314
G1 X94.714 Y141.705 E1.30292
G1 X94.394 Y141.705 E.01657
G1 X94.394 Y141.385 E.01657
G1 X112.177 Y123.602 E1.30292
G1 X111.537 Y123.602 E.03314
G1 X94.394 Y140.745 E1.25605
G1 X94.394 Y140.105 E.03314
G1 X110.897 Y123.602 E1.20918
G1 X110.258 Y123.602 E.03314
G1 X94.394 Y139.465 E1.1623
G1 X94.394 Y138.826 E.03314
G1 X109.618 Y123.602 E1.11543
G1 X108.978 Y123.602 E.03314
G1 X94.394 Y138.186 E1.06856
G1 X94.394 Y137.546 E.03314
G1 X108.338 Y123.602 E1.02168
G1 X107.699 Y123.602 E.03314
G1 X94.394 Y136.906 E.97481
G1 X94.394 Y136.267 E.03314
G1 X107.059 Y123.602 E.92794
G1 X106.419 Y123.602 E.03314
G1 X94.394 Y135.627 E.88106
G1 X94.394 Y134.987 E.03314
G1 X105.779 Y123.602 E.83419
G1 X105.14 Y123.602 E.03314
G1 X94.394 Y134.347 E.78732
G1 X94.394 Y133.708 E.03314
G1 X104.5 Y123.602 E.74044
G1 X103.86 Y123.602 E.03314
G1 X94.394 Y133.068 E.69357
G1 X94.394 Y132.428 E.03314
G1 X103.22 Y123.602 E.6467
G1 X102.581 Y123.602 E.03314
G1 X94.394 Y131.788 E.59982
G1 X94.394 Y131.149 E.03314
G1 X101.941 Y123.602 E.55295
G1 X101.301 Y123.602 E.03314
G1 X94.394 Y130.509 E.50608
G1 X94.394 Y129.869 E.03314
G1 X100.661 Y123.602 E.4592
G1 X100.022 Y123.602 E.03314
G1 X94.394 Y129.23 E.41233
G1 X94.394 Y128.59 E.03314
G1 X99.382 Y123.602 E.36546
G1 X98.742 Y123.602 E.03314
G1 X94.394 Y127.95 E.31858
G1 X94.394 Y127.31 E.03314
G1 X98.102 Y123.602 E.27171
G1 X97.463 Y123.602 E.03314
G1 X94.394 Y126.671 E.22484
G1 X94.394 Y126.031 E.03314
G1 X96.823 Y123.602 E.17796
G1 X96.183 Y123.602 E.03314
G1 X94.394 Y125.391 E.13109
G1 X94.394 Y124.751 E.03314
G1 X95.543 Y123.602 E.08422
G1 X94.904 Y123.602 E.03314
G1 X94.191 Y124.314 E.05218
; CHANGE_LAYER
; Z_HEIGHT: 19.52
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F3000
G1 X94.904 Y123.602 E-.38274
G1 X95.543 Y123.602 E-.24311
G1 X95.294 Y123.851 E-.13416
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 70/72
; update layer progress
M73 L70
M991 S0 P69 ;notify layer change
G17
G3 Z19.64 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
M73 P95 R1
G1 X112.86 Y142.068
G1 Z19.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.967 Y141.912 Z19.92 F30000
G1 Z19.52
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424499
G1 F7056.416
G1 X112.542 Y141.336 E.03382
G1 X112.542 Y140.821 E.02142
G1 X111.613 Y141.75 E.05459
G1 X111.098 Y141.75 E.02142
G1 X112.542 Y140.306 E.08489
G1 X112.542 Y139.79 E.02142
G1 X110.583 Y141.75 E.11519
G1 X110.067 Y141.75 E.02142
G1 X112.542 Y139.275 E.14549
G1 X112.542 Y138.76 E.02142
G1 X109.552 Y141.75 E.17579
G1 X109.036 Y141.75 E.02142
G1 X112.542 Y138.244 E.20609
G1 X112.542 Y137.729 E.02142
G1 X108.521 Y141.75 E.23639
G1 X108.006 Y141.75 E.02142
G1 X112.542 Y137.214 E.26669
G1 X112.542 Y136.698 E.02142
G1 X107.49 Y141.75 E.29698
G1 X106.975 Y141.75 E.02142
G1 X112.542 Y136.183 E.32728
G1 X112.542 Y135.668 E.02142
G1 X106.46 Y141.75 E.35758
G1 X105.944 Y141.75 E.02142
G1 X112.542 Y135.152 E.38788
G1 X112.542 Y134.637 E.02142
G1 X105.429 Y141.75 E.41818
G1 X104.914 Y141.75 E.02142
G1 X112.542 Y134.121 E.44848
M73 P95 R0
G1 X112.542 Y133.606 E.02142
G1 X104.398 Y141.75 E.47878
G1 X103.883 Y141.75 E.02142
G1 X112.542 Y133.091 E.50908
G1 X112.542 Y132.575 E.02142
G1 X103.368 Y141.75 E.53938
G1 X102.852 Y141.75 E.02142
G1 X112.542 Y132.06 E.56968
G1 X112.542 Y131.545 E.02142
G1 X102.337 Y141.75 E.59997
G1 X101.822 Y141.75 E.02142
G1 X112.542 Y131.029 E.63027
G1 X112.542 Y130.514 E.02142
G1 X101.306 Y141.75 E.66057
G1 X100.791 Y141.75 E.02142
G1 X112.542 Y129.999 E.69087
G1 X112.542 Y129.483 E.02142
G1 X100.275 Y141.75 E.72117
G1 X99.76 Y141.75 E.02142
G1 X112.542 Y128.968 E.75147
G1 X112.542 Y128.453 E.02142
G1 X99.245 Y141.75 E.78177
G1 X98.729 Y141.75 E.02142
G1 X112.542 Y127.937 E.81207
G1 X112.542 Y127.422 E.02142
G1 X98.214 Y141.75 E.84237
G1 X97.699 Y141.75 E.02142
G1 X112.542 Y126.907 E.87267
G1 X112.542 Y126.391 E.02142
G1 X97.183 Y141.75 E.90297
M73 P96 R0
G1 X96.668 Y141.75 E.02142
G1 X112.542 Y125.876 E.93326
G1 X112.542 Y125.36 E.02142
G1 X96.153 Y141.75 E.96356
G1 X95.637 Y141.75 E.02142
G1 X112.542 Y124.845 E.99386
G1 X112.542 Y124.33 E.02142
G1 X95.122 Y141.75 E1.02416
G1 X94.607 Y141.75 E.02142
G1 X112.542 Y123.814 E1.05446
G1 X112.542 Y123.557 E.01071
G1 X112.284 Y123.557 E.01071
G1 X94.349 Y141.492 E1.05446
G1 X94.349 Y140.977 E.02142
G1 X111.769 Y123.557 E1.02416
G1 X111.253 Y123.557 E.02142
G1 X94.349 Y140.461 E.99386
G1 X94.349 Y139.946 E.02142
G1 X110.738 Y123.557 E.96356
G1 X110.223 Y123.557 E.02142
G1 X94.349 Y139.431 E.93326
G1 X94.349 Y138.915 E.02142
G1 X109.707 Y123.557 E.90296
G1 X109.192 Y123.557 E.02142
G1 X94.349 Y138.4 E.87266
G1 X94.349 Y137.884 E.02142
G1 X108.677 Y123.557 E.84236
G1 X108.161 Y123.557 E.02142
G1 X94.349 Y137.369 E.81206
G1 X94.349 Y136.854 E.02142
G1 X107.646 Y123.557 E.78176
G1 X107.131 Y123.557 E.02142
G1 X94.349 Y136.338 E.75147
G1 X94.349 Y135.823 E.02142
G1 X106.615 Y123.557 E.72117
G1 X106.1 Y123.557 E.02142
G1 X94.349 Y135.308 E.69087
G1 X94.349 Y134.792 E.02142
G1 X105.584 Y123.557 E.66057
G1 X105.069 Y123.557 E.02142
G1 X94.349 Y134.277 E.63027
G1 X94.349 Y133.762 E.02142
G1 X104.554 Y123.557 E.59997
G1 X104.038 Y123.557 E.02142
G1 X94.349 Y133.246 E.56967
G1 X94.349 Y132.731 E.02142
G1 X103.523 Y123.557 E.53937
G1 X103.008 Y123.557 E.02142
G1 X94.349 Y132.216 E.50907
G1 X94.349 Y131.7 E.02142
G1 X102.492 Y123.557 E.47877
G1 X101.977 Y123.557 E.02142
G1 X94.349 Y131.185 E.44848
G1 X94.349 Y130.67 E.02142
G1 X101.462 Y123.557 E.41818
G1 X100.946 Y123.557 E.02142
G1 X94.349 Y130.154 E.38788
G1 X94.349 Y129.639 E.02142
G1 X100.431 Y123.557 E.35758
G1 X99.916 Y123.557 E.02142
G1 X94.349 Y129.123 E.32728
G1 X94.349 Y128.608 E.02142
G1 X99.4 Y123.557 E.29698
G1 X98.885 Y123.557 E.02142
G1 X94.349 Y128.093 E.26668
G1 X94.349 Y127.577 E.02142
G1 X98.37 Y123.557 E.23638
G1 X97.854 Y123.557 E.02142
G1 X94.349 Y127.062 E.20608
G1 X94.349 Y126.547 E.02142
G1 X97.339 Y123.557 E.17578
G1 X96.823 Y123.557 E.02142
G1 X94.349 Y126.031 E.14549
G1 X94.349 Y125.516 E.02142
G1 X96.308 Y123.557 E.11519
G1 X95.793 Y123.557 E.02142
G1 X94.349 Y125.001 E.08489
G1 X94.349 Y124.485 E.02142
G1 X95.277 Y123.557 E.05459
G1 X94.762 Y123.557 E.02142
G1 X94.187 Y124.132 E.03381
; CHANGE_LAYER
; Z_HEIGHT: 19.8
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F7056.416
G1 X94.762 Y123.557 E-.30905
G1 X95.277 Y123.557 E-.19584
G1 X94.803 Y124.031 E-.25511
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 71/72
; update layer progress
M73 L71
M991 S0 P70 ;notify layer change
G17
G3 Z19.92 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X112.86 Y142.068
G1 Z19.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X94.03 Y142.068 E.8376
G1 X94.03 Y123.238 E.8376
G1 X112.86 Y123.238 E.8376
G1 X112.86 Y142.008 E.83494
M204 S250
G1 X113.235 Y142.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
; WIPE_START
M204 S10000
G1 X111.235 Y142.389 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.847 Y134.781 Z20.2 F30000
G1 X112.704 Y124.132 Z20.2
G1 Z19.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424499
G1 F7056.416
G1 X112.129 Y123.557 E.03382
G1 X111.613 Y123.557 E.02142
G1 X112.542 Y124.485 E.05459
G1 X112.542 Y125.001 E.02142
G1 X111.098 Y123.557 E.08489
G1 X110.583 Y123.557 E.02142
G1 X112.542 Y125.516 E.11519
G1 X112.542 Y126.031 E.02142
G1 X110.067 Y123.557 E.14549
G1 X109.552 Y123.557 E.02142
G1 X112.542 Y126.547 E.17579
G1 X112.542 Y127.062 E.02142
G1 X109.036 Y123.557 E.20609
G1 X108.521 Y123.557 E.02142
G1 X112.542 Y127.577 E.23639
G1 X112.542 Y128.093 E.02142
G1 X108.006 Y123.557 E.26669
G1 X107.49 Y123.557 E.02142
G1 X112.542 Y128.608 E.29698
G1 X112.542 Y129.124 E.02142
G1 X106.975 Y123.557 E.32728
G1 X106.46 Y123.557 E.02142
G1 X112.542 Y129.639 E.35758
G1 X112.542 Y130.154 E.02142
G1 X105.944 Y123.557 E.38788
G1 X105.429 Y123.557 E.02142
G1 X112.542 Y130.67 E.41818
G1 X112.542 Y131.185 E.02142
G1 X104.914 Y123.557 E.44848
G1 X104.398 Y123.557 E.02142
G1 X112.542 Y131.7 E.47878
G1 X112.542 Y132.216 E.02142
G1 X103.883 Y123.557 E.50908
G1 X103.368 Y123.557 E.02142
G1 X112.542 Y132.731 E.53938
G1 X112.542 Y133.246 E.02142
G1 X102.852 Y123.557 E.56968
G1 X102.337 Y123.557 E.02142
G1 X112.542 Y133.762 E.59997
G1 X112.542 Y134.277 E.02142
G1 X101.822 Y123.557 E.63027
G1 X101.306 Y123.557 E.02142
G1 X112.542 Y134.792 E.66057
G1 X112.542 Y135.308 E.02142
G1 X100.791 Y123.557 E.69087
G1 X100.275 Y123.557 E.02142
G1 X112.542 Y135.823 E.72117
G1 X112.542 Y136.338 E.02142
G1 X99.76 Y123.557 E.75147
G1 X99.245 Y123.557 E.02142
G1 X112.542 Y136.854 E.78177
G1 X112.542 Y137.369 E.02142
G1 X98.729 Y123.557 E.81207
G1 X98.214 Y123.557 E.02142
G1 X112.542 Y137.885 E.84237
G1 X112.542 Y138.4 E.02142
G1 X97.699 Y123.557 E.87267
G1 X97.183 Y123.557 E.02142
G1 X112.542 Y138.915 E.90296
G1 X112.542 Y139.431 E.02142
G1 X96.668 Y123.557 E.93326
G1 X96.153 Y123.557 E.02142
G1 X112.542 Y139.946 E.96356
G1 X112.542 Y140.461 E.02142
G1 X95.637 Y123.557 E.99386
G1 X95.122 Y123.557 E.02142
G1 X112.542 Y140.977 E1.02416
G1 X112.542 Y141.492 E.02142
G1 X94.607 Y123.557 E1.05446
G1 X94.349 Y123.557 E.01071
G1 X94.349 Y123.814 E.01071
G1 X112.284 Y141.75 E1.05446
G1 X111.769 Y141.75 E.02142
G1 X94.349 Y124.33 E1.02416
G1 X94.349 Y124.845 E.02142
G1 X111.253 Y141.75 E.99386
G1 X110.738 Y141.75 E.02142
G1 X94.349 Y125.361 E.96356
G1 X94.349 Y125.876 E.02142
G1 X110.223 Y141.75 E.93326
G1 X109.707 Y141.75 E.02142
G1 X94.349 Y126.391 E.90296
G1 X94.349 Y126.907 E.02142
G1 X109.192 Y141.75 E.87266
G1 X108.677 Y141.75 E.02142
G1 X94.349 Y127.422 E.84236
G1 X94.349 Y127.937 E.02142
G1 X108.161 Y141.75 E.81206
G1 X107.646 Y141.75 E.02142
G1 X94.349 Y128.453 E.78176
G1 X94.349 Y128.968 E.02142
G1 X107.131 Y141.75 E.75147
G1 X106.615 Y141.75 E.02142
G1 X94.349 Y129.483 E.72117
G1 X94.349 Y129.999 E.02142
G1 X106.1 Y141.75 E.69087
G1 X105.584 Y141.75 E.02142
G1 X94.349 Y130.514 E.66057
G1 X94.349 Y131.029 E.02142
G1 X105.069 Y141.75 E.63027
G1 X104.554 Y141.75 E.02142
G1 X94.349 Y131.545 E.59997
G1 X94.349 Y132.06 E.02142
G1 X104.038 Y141.75 E.56967
G1 X103.523 Y141.75 E.02142
G1 X94.349 Y132.575 E.53937
G1 X94.349 Y133.091 E.02142
G1 X103.008 Y141.75 E.50907
M73 P97 R0
G1 X102.492 Y141.75 E.02142
G1 X94.349 Y133.606 E.47877
G1 X94.349 Y134.122 E.02142
G1 X101.977 Y141.75 E.44848
G1 X101.462 Y141.75 E.02142
G1 X94.349 Y134.637 E.41818
G1 X94.349 Y135.152 E.02142
G1 X100.946 Y141.75 E.38788
G1 X100.431 Y141.75 E.02142
G1 X94.349 Y135.668 E.35758
G1 X94.349 Y136.183 E.02142
G1 X99.916 Y141.75 E.32728
G1 X99.4 Y141.75 E.02142
G1 X94.349 Y136.698 E.29698
G1 X94.349 Y137.214 E.02142
G1 X98.885 Y141.75 E.26668
G1 X98.37 Y141.75 E.02142
G1 X94.349 Y137.729 E.23638
G1 X94.349 Y138.244 E.02142
G1 X97.854 Y141.75 E.20608
G1 X97.339 Y141.75 E.02142
G1 X94.349 Y138.76 E.17578
G1 X94.349 Y139.275 E.02142
G1 X96.823 Y141.75 E.14548
G1 X96.308 Y141.75 E.02142
G1 X94.349 Y139.79 E.11519
G1 X94.349 Y140.306 E.02142
G1 X95.793 Y141.75 E.08489
G1 X95.277 Y141.75 E.02142
G1 X94.349 Y140.821 E.05459
G1 X94.349 Y141.337 E.02142
G1 X94.924 Y141.912 E.03381
; CHANGE_LAYER
; Z_HEIGHT: 20.08
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F7056.416
G1 X94.349 Y141.337 E-.30905
G1 X94.349 Y140.821 E-.19583
G1 X94.824 Y141.296 E-.25511
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 72/72
; update layer progress
M73 L72
M991 S0 P71 ;notify layer change
G17
G3 Z20.2 I1.217 J0 P1  F30000
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 327
G1 X113.235 Y142.443
G1 Z20.08
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X93.655 Y142.443 E.80395
G1 X93.655 Y122.863 E.80395
G1 X113.235 Y122.863 E.80395
G1 X113.235 Y142.383 E.80148
M204 S10000
G1 X113.036 Y141.535 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.45
G1 F6594.904
M204 S2000
G1 X112.327 Y142.244 E.04459
G1 X111.776 Y142.244
G1 X113.036 Y140.984 E.07928
G1 X113.036 Y140.432
G1 X111.224 Y142.244 E.11396
G1 X110.673 Y142.244
G1 X113.036 Y139.881 E.14865
G1 X113.036 Y139.329
G1 X110.121 Y142.244 E.18334
G1 X109.57 Y142.244
G1 X113.036 Y138.778 E.21803
G1 X113.036 Y138.227
G1 X109.019 Y142.244 E.25271
G1 X108.467 Y142.244
G1 X113.036 Y137.675 E.2874
G1 X113.036 Y137.124
G1 X107.916 Y142.244 E.32209
G1 X107.364 Y142.244
G1 X113.036 Y136.572 E.35678
G1 X113.036 Y136.021
G1 X106.813 Y142.244 E.39147
G1 X106.262 Y142.244
G1 X113.036 Y135.469 E.42615
G1 X113.036 Y134.918
G1 X105.71 Y142.244 E.46084
G1 X105.159 Y142.244
G1 X113.036 Y134.367 E.49553
G1 X113.036 Y133.815
G1 X104.607 Y142.244 E.53022
G1 X104.056 Y142.244
G1 X113.036 Y133.264 E.56491
G1 X113.036 Y132.712
G1 X103.505 Y142.244 E.59959
G1 X102.953 Y142.244
G1 X113.036 Y132.161 E.63428
G1 X113.036 Y131.61
G1 X102.402 Y142.244 E.66897
G1 X101.85 Y142.244
G1 X113.036 Y131.058 E.70366
G1 X113.036 Y130.507
G1 X101.299 Y142.244 E.73835
G1 X100.747 Y142.244
G1 X113.036 Y129.955 E.77303
G1 X113.036 Y129.404
G1 X100.196 Y142.244 E.80772
G1 X99.645 Y142.244
G1 X113.036 Y128.852 E.84241
G1 X113.036 Y128.301
G1 X99.093 Y142.244 E.8771
G1 X98.542 Y142.244
G1 X113.036 Y127.75 E.91179
G1 X113.036 Y127.198
G1 X97.99 Y142.244 E.94647
G1 X97.439 Y142.244
G1 X113.036 Y126.647 E.98116
G1 X113.036 Y126.095
G1 X96.888 Y142.244 E1.01585
G1 X96.336 Y142.244
G1 X113.036 Y125.544 E1.05054
G1 X113.036 Y124.993
G1 X95.785 Y142.244 E1.08523
G1 X95.233 Y142.244
G1 X113.036 Y124.441 E1.11991
G1 X113.036 Y123.89
G1 X94.682 Y142.244 E1.1546
G1 X94.13 Y142.244
G1 X113.036 Y123.338 E1.18929
G1 X112.76 Y123.063
G1 X93.855 Y141.968 E1.18928
G1 X93.855 Y141.417
G1 X112.209 Y123.063 E1.15459
G1 X111.657 Y123.063
G1 X93.855 Y140.865 E1.11991
G1 X93.855 Y140.314
G1 X111.106 Y123.063 E1.08522
G1 X110.555 Y123.063
G1 X93.855 Y139.762 E1.05053
G1 X93.855 Y139.211
G1 X110.003 Y123.063 E1.01584
G1 X109.452 Y123.063
G1 X93.855 Y138.66 E.98115
G1 X93.855 Y138.108
G1 X108.9 Y123.063 E.94647
G1 X108.349 Y123.063
G1 X93.855 Y137.557 E.91178
G1 X93.855 Y137.005
G1 X107.797 Y123.063 E.87709
G1 X107.246 Y123.063
G1 X93.855 Y136.454 E.8424
G1 X93.855 Y135.902
G1 X106.695 Y123.063 E.80771
G1 X106.143 Y123.063
G1 X93.855 Y135.351 E.77303
G1 X93.855 Y134.8
G1 X105.592 Y123.063 E.73834
G1 X105.04 Y123.063
G1 X93.855 Y134.248 E.70365
G1 X93.855 Y133.697
G1 X104.489 Y123.063 E.66896
G1 X103.938 Y123.063
G1 X93.855 Y133.145 E.63427
G1 X93.855 Y132.594
G1 X103.386 Y123.063 E.59959
G1 X102.835 Y123.063
G1 X93.855 Y132.043 E.5649
G1 X93.855 Y131.491
G1 X102.283 Y123.063 E.53021
G1 X101.732 Y123.063
G1 X93.855 Y130.94 E.49552
G1 X93.855 Y130.388
G1 X101.18 Y123.063 E.46083
G1 X100.629 Y123.063
G1 X93.855 Y129.837 E.42615
G1 X93.855 Y129.285
M73 P98 R0
G1 X100.078 Y123.063 E.39146
G1 X99.526 Y123.063
G1 X93.855 Y128.734 E.35677
G1 X93.855 Y128.183
G1 X98.975 Y123.063 E.32208
G1 X98.423 Y123.063
G1 X93.855 Y127.631 E.28739
G1 X93.855 Y127.08
G1 X97.872 Y123.063 E.25271
G1 X97.321 Y123.063
G1 X93.855 Y126.528 E.21802
G1 X93.855 Y125.977
G1 X96.769 Y123.063 E.18333
G1 X96.218 Y123.063
G1 X93.855 Y125.426 E.14864
G1 X93.855 Y124.874
G1 X95.666 Y123.063 E.11395
G1 X95.115 Y123.063
G1 X93.855 Y124.323 E.07927
G1 X93.855 Y123.771
G1 X94.563 Y123.063 E.04458
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F6594.904
M204 S10000
G1 X93.855 Y123.771 E-.38083
G1 X93.855 Y124.323 E-.20954
G1 X94.17 Y124.007 E-.16963
; WIPE_END
G1 E-.04 F1800
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;===== date: 20240528 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z20.58 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos
G1 Y265 F3000

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z120.08 F600
    G1 Z118.08

M400 P100
M17 R ; restore z current

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0
;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A0 B20 L100 C37 D20 M40 E42 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C46 D10 M80 E46 F10 N80
M1006 A44 B20 L100 C39 D20 M60 E48 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C48 D10 M60 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10  N100
M1006 A49 B20 L100 C44 D20 M100 E41 F20 N100
M1006 A0 B20 L100 C0 D20 M60 E0 F20 N100
M1006 A0 B20 L100 C37 D20 M30 E37 F20 N60
M1006 W

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M960 S5 P0 ; turn off logo lamp
M73 P100 R0
; EXECUTABLE_BLOCK_END

