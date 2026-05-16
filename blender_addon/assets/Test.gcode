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
M82 ; absolute E for composed motion
G92 E0
; CHANGE_LAYER
; Z_HEIGHT: 0.28000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 1/17
; LAYER_CHANGE
M73 P6 R0
G1 X-10.00000 Y0.00000 Z0.28000 F900.0
G1 X-9.98924 Y0.10925 Z0.28000 E0.00575 F900.0
G1 X-9.80785 Y1.95090 Z0.28000 E0.10269 F900.0
G1 X-9.77599 Y2.05596 Z0.28000 E0.10844 F900.0
G1 X-9.23880 Y3.82683 Z0.28000 E0.20538 F900.0
G1 X-9.18705 Y3.92365 Z0.28000 E0.21113 F900.0
G1 X-8.31470 Y5.55570 Z0.28000 E0.30808 F900.0
G1 X-8.24505 Y5.64056 Z0.28000 E0.31383 F900.0
G1 X-7.07107 Y7.07107 Z0.28000 E0.41077 F900.0
G1 X-6.98621 Y7.14071 Z0.28000 E0.41652 F900.0
G1 X-5.55570 Y8.31470 Z0.28000 E0.51346 F900.0
G1 X-5.45889 Y8.36645 Z0.28000 E0.51921 F900.0
G1 X-3.82683 Y9.23880 Z0.28000 E0.61615 F900.0
G1 X-3.72178 Y9.27066 Z0.28000 E0.62190 F900.0
G1 X-1.95090 Y9.80785 Z0.28000 E0.71884 F900.0
G1 X-1.84165 Y9.81861 Z0.28000 E0.72459 F900.0
G1 X0.00000 Y10.00000 Z0.28000 E0.82154 F900.0
G1 X0.10925 Y9.98924 Z0.28000 E0.82729 F900.0
G1 X1.95090 Y9.80785 Z0.28000 E0.92423 F900.0
G1 X2.05596 Y9.77599 Z0.28000 E0.92998 F900.0
G1 X3.82683 Y9.23880 Z0.28000 E1.02692 F900.0
G1 X3.92365 Y9.18705 Z0.28000 E1.03267 F900.0
G1 X5.55570 Y8.31470 Z0.28000 E1.12961 F900.0
G1 X5.64056 Y8.24505 Z0.28000 E1.13536 F900.0
G1 X7.07107 Y7.07107 Z0.28000 E1.23230 F900.0
G1 X7.14071 Y6.98621 Z0.28000 E1.23805 F900.0
G1 X8.31470 Y5.55570 Z0.28000 E1.33500 F900.0
G1 X8.36645 Y5.45889 Z0.28000 E1.34075 F900.0
G1 X9.23880 Y3.82683 Z0.28000 E1.43769 F900.0
G1 X9.27066 Y3.72178 Z0.28000 E1.44344 F900.0
G1 X9.80785 Y1.95090 Z0.28000 E1.54038 F900.0
G1 X9.81861 Y1.84165 Z0.28000 E1.54613 F900.0
G1 X10.00000 Y0.00000 Z0.28000 E1.64307 F900.0
G1 X9.98924 Y-0.10925 Z0.28000 E1.64882 F900.0
G1 X9.80785 Y-1.95090 Z0.28000 E1.74576 F900.0
G1 X9.77599 Y-2.05596 Z0.28000 E1.75151 F900.0
G1 X9.23880 Y-3.82683 Z0.28000 E1.84846 F900.0
G1 X9.18705 Y-3.92365 Z0.28000 E1.85421 F900.0
G1 X8.31470 Y-5.55570 Z0.28000 E1.95115 F900.0
G1 X8.24505 Y-5.64056 Z0.28000 E1.95690 F900.0
G1 X7.07107 Y-7.07107 Z0.28000 E2.05384 F900.0
G1 X6.98621 Y-7.14071 Z0.28000 E2.05959 F900.0
G1 X5.55570 Y-8.31470 Z0.28000 E2.15653 F900.0
G1 X5.45889 Y-8.36645 Z0.28000 E2.16228 F900.0
G1 X3.82683 Y-9.23880 Z0.28000 E2.25922 F900.0
G1 X3.72178 Y-9.27066 Z0.28000 E2.26497 F900.0
G1 X1.95090 Y-9.80785 Z0.28000 E2.36192 F900.0
G1 X1.84165 Y-9.81861 Z0.28000 E2.36767 F900.0
G1 X0.00000 Y-10.00000 Z0.28000 E2.46461 F900.0
G1 X-0.10925 Y-9.98924 Z0.28000 E2.47036 F900.0
G1 X-1.95090 Y-9.80785 Z0.28000 E2.56730 F900.0
G1 X-2.05596 Y-9.77599 Z0.28000 E2.57305 F900.0
G1 X-3.82683 Y-9.23880 Z0.28000 E2.66999 F900.0
G1 X-3.92365 Y-9.18705 Z0.28000 E2.67574 F900.0
G1 X-5.55570 Y-8.31470 Z0.28000 E2.77268 F900.0
G1 X-5.64056 Y-8.24505 Z0.28000 E2.77843 F900.0
G1 X-7.07107 Y-7.07107 Z0.28000 E2.87538 F900.0
G1 X-7.14071 Y-6.98621 Z0.28000 E2.88113 F900.0
G1 X-8.31470 Y-5.55570 Z0.28000 E2.97807 F900.0
G1 X-8.36645 Y-5.45889 Z0.28000 E2.98382 F900.0
G1 X-9.23880 Y-3.82683 Z0.28000 E3.08076 F900.0
G1 X-9.27066 Y-3.72178 Z0.28000 E3.08651 F900.0
G1 X-9.80785 Y-1.95090 Z0.28000 E3.18345 F900.0
G1 X-9.81861 Y-1.84165 Z0.28000 E3.18920 F900.0
G1 X-10.00000 Y0.00000 Z0.28000 E3.28614 F900.0
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z3.560 F1200

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
G1 Z3.560 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z0.56000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 0.56000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 2/17
; LAYER_CHANGE
M73 P12 R0
G1 X-9.97848 Y0.21850 Z0.56000 E3.29765 F1800.0
G1 X-9.80785 Y1.95090 Z0.56000 E3.38884 F1800.0
G1 X-9.74412 Y2.16101 Z0.56000 E3.40034 F1800.0
G1 X-9.23880 Y3.82683 Z0.56000 E3.49153 F1800.0
G1 X-9.13530 Y4.02047 Z0.56000 E3.50303 F1800.0
G1 X-8.31470 Y5.55570 Z0.56000 E3.59422 F1800.0
G1 X-8.17541 Y5.72542 Z0.56000 E3.60572 F1800.0
G1 X-7.07107 Y7.07107 Z0.56000 E3.69691 F1800.0
G1 X-6.90135 Y7.21035 Z0.56000 E3.70841 F1800.0
G1 X-5.55570 Y8.31470 Z0.56000 E3.79960 F1800.0
G1 X-5.36207 Y8.41820 Z0.56000 E3.81111 F1800.0
G1 X-3.82683 Y9.23880 Z0.56000 E3.90230 F1800.0
G1 X-3.61673 Y9.30253 Z0.56000 E3.91380 F1800.0
G1 X-1.95090 Y9.80785 Z0.56000 E4.00499 F1800.0
G1 X-1.73240 Y9.82937 Z0.56000 E4.01649 F1800.0
G1 X0.00000 Y10.00000 Z0.56000 E4.10768 F1800.0
G1 X0.21850 Y9.97848 Z0.56000 E4.11918 F1800.0
G1 X1.95090 Y9.80785 Z0.56000 E4.21037 F1800.0
G1 X2.16101 Y9.74412 Z0.56000 E4.22187 F1800.0
G1 X3.82683 Y9.23880 Z0.56000 E4.31306 F1800.0
G1 X4.02047 Y9.13530 Z0.56000 E4.32457 F1800.0
G1 X5.55570 Y8.31470 Z0.56000 E4.41576 F1800.0
G1 X5.72542 Y8.17541 Z0.56000 E4.42726 F1800.0
G1 X7.07107 Y7.07107 Z0.56000 E4.51845 F1800.0
G1 X7.21035 Y6.90135 Z0.56000 E4.52995 F1800.0
G1 X8.31470 Y5.55570 Z0.56000 E4.62114 F1800.0
G1 X8.41820 Y5.36207 Z0.56000 E4.63264 F1800.0
G1 X9.23880 Y3.82683 Z0.56000 E4.72383 F1800.0
G1 X9.30253 Y3.61673 Z0.56000 E4.73533 F1800.0
G1 X9.80785 Y1.95090 Z0.56000 E4.82652 F1800.0
G1 X9.82937 Y1.73240 Z0.56000 E4.83803 F1800.0
G1 X10.00000 Y0.00000 Z0.56000 E4.92922 F1800.0
G1 X9.97848 Y-0.21850 Z0.56000 E4.94072 F1800.0
G1 X9.80785 Y-1.95090 Z0.56000 E5.03191 F1800.0
G1 X9.74412 Y-2.16101 Z0.56000 E5.04341 F1800.0
G1 X9.23880 Y-3.82683 Z0.56000 E5.13460 F1800.0
G1 X9.13530 Y-4.02047 Z0.56000 E5.14610 F1800.0
G1 X8.31470 Y-5.55570 Z0.56000 E5.23729 F1800.0
G1 X8.17541 Y-5.72542 Z0.56000 E5.24879 F1800.0
G1 X7.07107 Y-7.07107 Z0.56000 E5.33998 F1800.0
G1 X6.90135 Y-7.21035 Z0.56000 E5.35149 F1800.0
G1 X5.55570 Y-8.31470 Z0.56000 E5.44268 F1800.0
G1 X5.36207 Y-8.41820 Z0.56000 E5.45418 F1800.0
G1 X3.82683 Y-9.23880 Z0.56000 E5.54537 F1800.0
G1 X3.61673 Y-9.30253 Z0.56000 E5.55687 F1800.0
G1 X1.95090 Y-9.80785 Z0.56000 E5.64806 F1800.0
G1 X1.73240 Y-9.82937 Z0.56000 E5.65956 F1800.0
G1 X0.00000 Y-10.00000 Z0.56000 E5.75075 F1800.0
G1 X-0.21850 Y-9.97848 Z0.56000 E5.76225 F1800.0
G1 X-1.95090 Y-9.80785 Z0.56000 E5.85344 F1800.0
G1 X-2.16101 Y-9.74412 Z0.56000 E5.86495 F1800.0
G1 X-3.82683 Y-9.23880 Z0.56000 E5.95614 F1800.0
G1 X-4.02047 Y-9.13530 Z0.56000 E5.96764 F1800.0
G1 X-5.55570 Y-8.31470 Z0.56000 E6.05883 F1800.0
G1 X-5.72542 Y-8.17541 Z0.56000 E6.07033 F1800.0
G1 X-7.07107 Y-7.07107 Z0.56000 E6.16152 F1800.0
G1 X-7.21035 Y-6.90135 Z0.56000 E6.17302 F1800.0
G1 X-8.31470 Y-5.55570 Z0.56000 E6.26421 F1800.0
G1 X-8.41820 Y-5.36207 Z0.56000 E6.27571 F1800.0
G1 X-9.23880 Y-3.82683 Z0.56000 E6.36690 F1800.0
G1 X-9.30253 Y-3.61673 Z0.56000 E6.37841 F1800.0
G1 X-9.80785 Y-1.95090 Z0.56000 E6.46960 F1800.0
G1 X-9.82937 Y-1.73240 Z0.56000 E6.48110 F1800.0
G1 X-10.00000 Y0.00000 Z0.56000 E6.57229 F1800.0
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z3.840 F1200

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
G1 Z3.840 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z0.84000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 0.84000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 3/17
; LAYER_CHANGE
M73 P18 R0
G1 X-9.96772 Y0.32775 Z0.84000 E6.58954 F1800.0
G1 X-9.80785 Y1.95090 Z0.84000 E6.67498 F1800.0
G1 X-9.71225 Y2.26606 Z0.84000 E6.69223 F1800.0
G1 X-9.23880 Y3.82683 Z0.84000 E6.77767 F1800.0
G1 X-9.08355 Y4.11728 Z0.84000 E6.79492 F1800.0
G1 X-8.31470 Y5.55570 Z0.84000 E6.88036 F1800.0
G1 X-8.10577 Y5.81028 Z0.84000 E6.89762 F1800.0
G1 X-7.07107 Y7.07107 Z0.84000 E6.98306 F1800.0
G1 X-6.81649 Y7.28000 Z0.84000 E7.00031 F1800.0
G1 X-5.55570 Y8.31470 Z0.84000 E7.08575 F1800.0
G1 X-5.26525 Y8.46994 Z0.84000 E7.10300 F1800.0
G1 X-3.82683 Y9.23880 Z0.84000 E7.18844 F1800.0
G1 X-3.51168 Y9.33440 Z0.84000 E7.20569 F1800.0
G1 X-1.95090 Y9.80785 Z0.84000 E7.29113 F1800.0
G1 X-1.62315 Y9.84013 Z0.84000 E7.30838 F1800.0
G1 X0.00000 Y10.00000 Z0.84000 E7.39382 F1800.0
G1 X0.32775 Y9.96772 Z0.84000 E7.41108 F1800.0
G1 X1.95090 Y9.80785 Z0.84000 E7.49652 F1800.0
G1 X2.26606 Y9.71225 Z0.84000 E7.51377 F1800.0
G1 X3.82683 Y9.23880 Z0.84000 E7.59921 F1800.0
G1 X4.11728 Y9.08355 Z0.84000 E7.61646 F1800.0
G1 X5.55570 Y8.31470 Z0.84000 E7.70190 F1800.0
G1 X5.81028 Y8.10577 Z0.84000 E7.71915 F1800.0
G1 X7.07107 Y7.07107 Z0.84000 E7.80459 F1800.0
G1 X7.28000 Y6.81649 Z0.84000 E7.82184 F1800.0
G1 X8.31470 Y5.55570 Z0.84000 E7.90728 F1800.0
G1 X8.46994 Y5.26525 Z0.84000 E7.92454 F1800.0
G1 X9.23880 Y3.82683 Z0.84000 E8.00998 F1800.0
G1 X9.33440 Y3.51168 Z0.84000 E8.02723 F1800.0
G1 X9.80785 Y1.95090 Z0.84000 E8.11267 F1800.0
G1 X9.84013 Y1.62315 Z0.84000 E8.12992 F1800.0
G1 X10.00000 Y0.00000 Z0.84000 E8.21536 F1800.0
G1 X9.96772 Y-0.32775 Z0.84000 E8.23261 F1800.0
G1 X9.80785 Y-1.95090 Z0.84000 E8.31805 F1800.0
G1 X9.71225 Y-2.26606 Z0.84000 E8.33530 F1800.0
G1 X9.23880 Y-3.82683 Z0.84000 E8.42074 F1800.0
G1 X9.08355 Y-4.11728 Z0.84000 E8.43800 F1800.0
G1 X8.31470 Y-5.55570 Z0.84000 E8.52344 F1800.0
G1 X8.10577 Y-5.81028 Z0.84000 E8.54069 F1800.0
G1 X7.07107 Y-7.07107 Z0.84000 E8.62613 F1800.0
G1 X6.81649 Y-7.28000 Z0.84000 E8.64338 F1800.0
G1 X5.55570 Y-8.31470 Z0.84000 E8.72882 F1800.0
G1 X5.26525 Y-8.46994 Z0.84000 E8.74607 F1800.0
G1 X3.82683 Y-9.23880 Z0.84000 E8.83151 F1800.0
G1 X3.51168 Y-9.33440 Z0.84000 E8.84876 F1800.0
G1 X1.95090 Y-9.80785 Z0.84000 E8.93420 F1800.0
G1 X1.62315 Y-9.84013 Z0.84000 E8.95146 F1800.0
G1 X0.00000 Y-10.00000 Z0.84000 E9.03690 F1800.0
G1 X-0.32775 Y-9.96772 Z0.84000 E9.05415 F1800.0
G1 X-1.95090 Y-9.80785 Z0.84000 E9.13959 F1800.0
G1 X-2.26606 Y-9.71225 Z0.84000 E9.15684 F1800.0
G1 X-3.82683 Y-9.23880 Z0.84000 E9.24228 F1800.0
G1 X-4.11728 Y-9.08355 Z0.84000 E9.25953 F1800.0
G1 X-5.55570 Y-8.31470 Z0.84000 E9.34497 F1800.0
G1 X-5.81028 Y-8.10577 Z0.84000 E9.36222 F1800.0
G1 X-7.07107 Y-7.07107 Z0.84000 E9.44766 F1800.0
G1 X-7.28000 Y-6.81649 Z0.84000 E9.46492 F1800.0
G1 X-8.31470 Y-5.55570 Z0.84000 E9.55036 F1800.0
G1 X-8.46994 Y-5.26525 Z0.84000 E9.56761 F1800.0
G1 X-9.23880 Y-3.82683 Z0.84000 E9.65305 F1800.0
G1 X-9.33440 Y-3.51168 Z0.84000 E9.67030 F1800.0
G1 X-9.80785 Y-1.95090 Z0.84000 E9.75574 F1800.0
G1 X-9.84013 Y-1.62315 Z0.84000 E9.77299 F1800.0
G1 X-10.00000 Y0.00000 Z0.84000 E9.85843 F1800.0
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z4.120 F1200

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
G1 Z4.120 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z1.12000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 1.12000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 4/17
; LAYER_CHANGE
M73 P24 R0
G1 X-9.95696 Y0.43700 Z1.12000 E9.88143 F1800.0
G1 X-9.80785 Y1.95090 Z1.12000 E9.96112 F1800.0
G1 X-9.68038 Y2.37111 Z1.12000 E9.98413 F1800.0
G1 X-9.23880 Y3.82683 Z1.12000 E10.06382 F1800.0
G1 X-9.03180 Y4.21410 Z1.12000 E10.08682 F1800.0
G1 X-8.31470 Y5.55570 Z1.12000 E10.16651 F1800.0
G1 X-8.03612 Y5.89514 Z1.12000 E10.18951 F1800.0
G1 X-7.07107 Y7.07107 Z1.12000 E10.26920 F1800.0
G1 X-6.73163 Y7.34964 Z1.12000 E10.29220 F1800.0
G1 X-5.55570 Y8.31470 Z1.12000 E10.37189 F1800.0
G1 X-5.16844 Y8.52169 Z1.12000 E10.39489 F1800.0
G1 X-3.82683 Y9.23880 Z1.12000 E10.47458 F1800.0
G1 X-3.40663 Y9.36626 Z1.12000 E10.49759 F1800.0
G1 X-1.95090 Y9.80785 Z1.12000 E10.57728 F1800.0
G1 X-1.51390 Y9.85089 Z1.12000 E10.60028 F1800.0
G1 X0.00000 Y10.00000 Z1.12000 E10.67997 F1800.0
G1 X0.43700 Y9.95696 Z1.12000 E10.70297 F1800.0
G1 X1.95090 Y9.80785 Z1.12000 E10.78266 F1800.0
G1 X2.37111 Y9.68038 Z1.12000 E10.80566 F1800.0
G1 X3.82683 Y9.23880 Z1.12000 E10.88535 F1800.0
G1 X4.21410 Y9.03180 Z1.12000 E10.90835 F1800.0
G1 X5.55570 Y8.31470 Z1.12000 E10.98804 F1800.0
G1 X5.89514 Y8.03612 Z1.12000 E11.01105 F1800.0
G1 X7.07107 Y7.07107 Z1.12000 E11.09074 F1800.0
G1 X7.34964 Y6.73163 Z1.12000 E11.11374 F1800.0
G1 X8.31470 Y5.55570 Z1.12000 E11.19343 F1800.0
G1 X8.52169 Y5.16844 Z1.12000 E11.21643 F1800.0
G1 X9.23880 Y3.82683 Z1.12000 E11.29612 F1800.0
G1 X9.36626 Y3.40663 Z1.12000 E11.31912 F1800.0
G1 X9.80785 Y1.95090 Z1.12000 E11.39881 F1800.0
G1 X9.85089 Y1.51390 Z1.12000 E11.42181 F1800.0
G1 X10.00000 Y0.00000 Z1.12000 E11.50150 F1800.0
G1 X9.95696 Y-0.43700 Z1.12000 E11.52451 F1800.0
G1 X9.80785 Y-1.95090 Z1.12000 E11.60420 F1800.0
G1 X9.68038 Y-2.37111 Z1.12000 E11.62720 F1800.0
G1 X9.23880 Y-3.82683 Z1.12000 E11.70689 F1800.0
G1 X9.03180 Y-4.21410 Z1.12000 E11.72989 F1800.0
G1 X8.31470 Y-5.55570 Z1.12000 E11.80958 F1800.0
G1 X8.03612 Y-5.89514 Z1.12000 E11.83258 F1800.0
G1 X7.07107 Y-7.07107 Z1.12000 E11.91227 F1800.0
G1 X6.73163 Y-7.34964 Z1.12000 E11.93527 F1800.0
G1 X5.55570 Y-8.31470 Z1.12000 E12.01496 F1800.0
G1 X5.16844 Y-8.52169 Z1.12000 E12.03797 F1800.0
G1 X3.82683 Y-9.23880 Z1.12000 E12.11766 F1800.0
G1 X3.40663 Y-9.36626 Z1.12000 E12.14066 F1800.0
G1 X1.95090 Y-9.80785 Z1.12000 E12.22035 F1800.0
G1 X1.51390 Y-9.85089 Z1.12000 E12.24335 F1800.0
G1 X0.00000 Y-10.00000 Z1.12000 E12.32304 F1800.0
G1 X-0.43700 Y-9.95696 Z1.12000 E12.34604 F1800.0
G1 X-1.95090 Y-9.80785 Z1.12000 E12.42573 F1800.0
G1 X-2.37111 Y-9.68038 Z1.12000 E12.44873 F1800.0
G1 X-3.82683 Y-9.23880 Z1.12000 E12.52842 F1800.0
G1 X-4.21410 Y-9.03180 Z1.12000 E12.55143 F1800.0
G1 X-5.55570 Y-8.31470 Z1.12000 E12.63112 F1800.0
G1 X-5.89514 Y-8.03612 Z1.12000 E12.65412 F1800.0
G1 X-7.07107 Y-7.07107 Z1.12000 E12.73381 F1800.0
G1 X-7.34964 Y-6.73163 Z1.12000 E12.75681 F1800.0
G1 X-8.31470 Y-5.55570 Z1.12000 E12.83650 F1800.0
G1 X-8.52169 Y-5.16844 Z1.12000 E12.85950 F1800.0
G1 X-9.23880 Y-3.82683 Z1.12000 E12.93919 F1800.0
G1 X-9.36626 Y-3.40663 Z1.12000 E12.96219 F1800.0
G1 X-9.80785 Y-1.95090 Z1.12000 E13.04188 F1800.0
G1 X-9.85089 Y-1.51390 Z1.12000 E13.06489 F1800.0
G1 X-10.00000 Y0.00000 Z1.12000 E13.14458 F1800.0
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z4.400 F1200

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
G1 Z4.400 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z1.40000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 1.40000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 5/17
; LAYER_CHANGE
M73 P29 R0
G1 X-9.94620 Y0.54625 Z1.40000 E13.17333 F1800.0
G1 X-9.80785 Y1.95090 Z1.40000 E13.24727 F1800.0
G1 X-9.64852 Y2.47616 Z1.40000 E13.27602 F1800.0
G1 X-9.23880 Y3.82683 Z1.40000 E13.34996 F1800.0
G1 X-8.98005 Y4.31092 Z1.40000 E13.37871 F1800.0
G1 X-8.31470 Y5.55570 Z1.40000 E13.45265 F1800.0
G1 X-7.96648 Y5.98000 Z1.40000 E13.48141 F1800.0
G1 X-7.07107 Y7.07107 Z1.40000 E13.55534 F1800.0
G1 X-6.64677 Y7.41928 Z1.40000 E13.58410 F1800.0
G1 X-5.55570 Y8.31470 Z1.40000 E13.65804 F1800.0
G1 X-5.07162 Y8.57344 Z1.40000 E13.68679 F1800.0
G1 X-3.82683 Y9.23880 Z1.40000 E13.76073 F1800.0
G1 X-3.30157 Y9.39813 Z1.40000 E13.78948 F1800.0
G1 X-1.95090 Y9.80785 Z1.40000 E13.86342 F1800.0
G1 X-1.40465 Y9.86165 Z1.40000 E13.89217 F1800.0
G1 X0.00000 Y10.00000 Z1.40000 E13.96611 F1800.0
G1 X0.54625 Y9.94620 Z1.40000 E13.99487 F1800.0
G1 X1.95090 Y9.80785 Z1.40000 E14.06880 F1800.0
G1 X2.47616 Y9.64852 Z1.40000 E14.09756 F1800.0
G1 X3.82683 Y9.23880 Z1.40000 E14.17150 F1800.0
G1 X4.31092 Y8.98005 Z1.40000 E14.20025 F1800.0
G1 X5.55570 Y8.31470 Z1.40000 E14.27419 F1800.0
G1 X5.98000 Y7.96648 Z1.40000 E14.30294 F1800.0
G1 X7.07107 Y7.07107 Z1.40000 E14.37688 F1800.0
G1 X7.41928 Y6.64677 Z1.40000 E14.40563 F1800.0
G1 X8.31470 Y5.55570 Z1.40000 E14.47957 F1800.0
G1 X8.57344 Y5.07162 Z1.40000 E14.50833 F1800.0
G1 X9.23880 Y3.82683 Z1.40000 E14.58226 F1800.0
G1 X9.39813 Y3.30157 Z1.40000 E14.61102 F1800.0
G1 X9.80785 Y1.95090 Z1.40000 E14.68496 F1800.0
G1 X9.86165 Y1.40465 Z1.40000 E14.71371 F1800.0
G1 X10.00000 Y0.00000 Z1.40000 E14.78765 F1800.0
G1 X9.94620 Y-0.54625 Z1.40000 E14.81640 F1800.0
G1 X9.80785 Y-1.95090 Z1.40000 E14.89034 F1800.0
G1 X9.64852 Y-2.47616 Z1.40000 E14.91909 F1800.0
G1 X9.23880 Y-3.82683 Z1.40000 E14.99303 F1800.0
G1 X8.98005 Y-4.31092 Z1.40000 E15.02179 F1800.0
G1 X8.31470 Y-5.55570 Z1.40000 E15.09572 F1800.0
G1 X7.96648 Y-5.98000 Z1.40000 E15.12448 F1800.0
G1 X7.07107 Y-7.07107 Z1.40000 E15.19842 F1800.0
G1 X6.64677 Y-7.41928 Z1.40000 E15.22717 F1800.0
G1 X5.55570 Y-8.31470 Z1.40000 E15.30111 F1800.0
G1 X5.07162 Y-8.57344 Z1.40000 E15.32986 F1800.0
G1 X3.82683 Y-9.23880 Z1.40000 E15.40380 F1800.0
G1 X3.30157 Y-9.39813 Z1.40000 E15.43255 F1800.0
G1 X1.95090 Y-9.80785 Z1.40000 E15.50649 F1800.0
G1 X1.40465 Y-9.86165 Z1.40000 E15.53525 F1800.0
G1 X0.00000 Y-10.00000 Z1.40000 E15.60918 F1800.0
G1 X-0.54625 Y-9.94620 Z1.40000 E15.63794 F1800.0
G1 X-1.95090 Y-9.80785 Z1.40000 E15.71188 F1800.0
G1 X-2.47616 Y-9.64852 Z1.40000 E15.74063 F1800.0
G1 X-3.82683 Y-9.23880 Z1.40000 E15.81457 F1800.0
G1 X-4.31092 Y-8.98005 Z1.40000 E15.84332 F1800.0
G1 X-5.55570 Y-8.31470 Z1.40000 E15.91726 F1800.0
G1 X-5.98000 Y-7.96648 Z1.40000 E15.94601 F1800.0
G1 X-7.07107 Y-7.07107 Z1.40000 E16.01995 F1800.0
G1 X-7.41928 Y-6.64677 Z1.40000 E16.04871 F1800.0
G1 X-8.31470 Y-5.55570 Z1.40000 E16.12264 F1800.0
G1 X-8.57344 Y-5.07162 Z1.40000 E16.15140 F1800.0
G1 X-9.23880 Y-3.82683 Z1.40000 E16.22534 F1800.0
G1 X-9.39813 Y-3.30157 Z1.40000 E16.25409 F1800.0
G1 X-9.80785 Y-1.95090 Z1.40000 E16.32803 F1800.0
G1 X-9.86165 Y-1.40465 Z1.40000 E16.35678 F1800.0
G1 X-10.00000 Y0.00000 Z1.40000 E16.43072 F1800.0
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z4.680 F1200

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
G1 Z4.680 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z1.68000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 1.68000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 6/17
; LAYER_CHANGE
M73 P35 R0
G1 X-9.93544 Y0.65550 Z1.68000 E16.46522 F1800.0
G1 X-9.80785 Y1.95090 Z1.68000 E16.53341 F1800.0
G1 X-9.61665 Y2.58122 Z1.68000 E16.56792 F1800.0
G1 X-9.23880 Y3.82683 Z1.68000 E16.63610 F1800.0
G1 X-8.92830 Y4.40773 Z1.68000 E16.67061 F1800.0
G1 X-8.31470 Y5.55570 Z1.68000 E16.73880 F1800.0
G1 X-7.89684 Y6.06487 Z1.68000 E16.77330 F1800.0
G1 X-7.07107 Y7.07107 Z1.68000 E16.84149 F1800.0
G1 X-6.56190 Y7.48893 Z1.68000 E16.87599 F1800.0
G1 X-5.55570 Y8.31470 Z1.68000 E16.94418 F1800.0
G1 X-4.97480 Y8.62519 Z1.68000 E16.97868 F1800.0
G1 X-3.82683 Y9.23880 Z1.68000 E17.04687 F1800.0
G1 X-3.19652 Y9.43000 Z1.68000 E17.08138 F1800.0
G1 X-1.95090 Y9.80785 Z1.68000 E17.14956 F1800.0
G1 X-1.29540 Y9.87241 Z1.68000 E17.18407 F1800.0
G1 X0.00000 Y10.00000 Z1.68000 E17.25226 F1800.0
G1 X0.65550 Y9.93544 Z1.68000 E17.28676 F1800.0
G1 X1.95090 Y9.80785 Z1.68000 E17.35495 F1800.0
G1 X2.58122 Y9.61665 Z1.68000 E17.38945 F1800.0
G1 X3.82683 Y9.23880 Z1.68000 E17.45764 F1800.0
G1 X4.40773 Y8.92830 Z1.68000 E17.49214 F1800.0
G1 X5.55570 Y8.31470 Z1.68000 E17.56033 F1800.0
G1 X6.06487 Y7.89684 Z1.68000 E17.59484 F1800.0
G1 X7.07107 Y7.07107 Z1.68000 E17.66302 F1800.0
G1 X7.48893 Y6.56190 Z1.68000 E17.69753 F1800.0
G1 X8.31470 Y5.55570 Z1.68000 E17.76572 F1800.0
G1 X8.62519 Y4.97480 Z1.68000 E17.80022 F1800.0
G1 X9.23880 Y3.82683 Z1.68000 E17.86841 F1800.0
G1 X9.43000 Y3.19652 Z1.68000 E17.90291 F1800.0
G1 X9.80785 Y1.95090 Z1.68000 E17.97110 F1800.0
G1 X9.87241 Y1.29540 Z1.68000 E18.00560 F1800.0
G1 X10.00000 Y0.00000 Z1.68000 E18.07379 F1800.0
G1 X9.93544 Y-0.65550 Z1.68000 E18.10830 F1800.0
G1 X9.80785 Y-1.95090 Z1.68000 E18.17648 F1800.0
G1 X9.61665 Y-2.58122 Z1.68000 E18.21099 F1800.0
G1 X9.23880 Y-3.82683 Z1.68000 E18.27918 F1800.0
G1 X8.92830 Y-4.40773 Z1.68000 E18.31368 F1800.0
G1 X8.31470 Y-5.55570 Z1.68000 E18.38187 F1800.0
G1 X7.89684 Y-6.06487 Z1.68000 E18.41637 F1800.0
G1 X7.07107 Y-7.07107 Z1.68000 E18.48456 F1800.0
G1 X6.56190 Y-7.48893 Z1.68000 E18.51906 F1800.0
G1 X5.55570 Y-8.31470 Z1.68000 E18.58725 F1800.0
G1 X4.97480 Y-8.62519 Z1.68000 E18.62176 F1800.0
G1 X3.82683 Y-9.23880 Z1.68000 E18.68994 F1800.0
G1 X3.19652 Y-9.43000 Z1.68000 E18.72445 F1800.0
G1 X1.95090 Y-9.80785 Z1.68000 E18.79264 F1800.0
G1 X1.29540 Y-9.87241 Z1.68000 E18.82714 F1800.0
G1 X0.00000 Y-10.00000 Z1.68000 E18.89533 F1800.0
G1 X-0.65550 Y-9.93544 Z1.68000 E18.92983 F1800.0
G1 X-1.95090 Y-9.80785 Z1.68000 E18.99802 F1800.0
G1 X-2.58122 Y-9.61665 Z1.68000 E19.03252 F1800.0
G1 X-3.82683 Y-9.23880 Z1.68000 E19.10071 F1800.0
G1 X-4.40773 Y-8.92830 Z1.68000 E19.13522 F1800.0
G1 X-5.55570 Y-8.31470 Z1.68000 E19.20340 F1800.0
G1 X-6.06487 Y-7.89684 Z1.68000 E19.23791 F1800.0
G1 X-7.07107 Y-7.07107 Z1.68000 E19.30610 F1800.0
G1 X-7.48893 Y-6.56190 Z1.68000 E19.34060 F1800.0
G1 X-8.31470 Y-5.55570 Z1.68000 E19.40879 F1800.0
G1 X-8.62519 Y-4.97480 Z1.68000 E19.44329 F1800.0
G1 X-9.23880 Y-3.82683 Z1.68000 E19.51148 F1800.0
G1 X-9.43000 Y-3.19652 Z1.68000 E19.54598 F1800.0
G1 X-9.80785 Y-1.95090 Z1.68000 E19.61417 F1800.0
G1 X-9.87241 Y-1.29540 Z1.68000 E19.64868 F1800.0
G1 X-10.00000 Y0.00000 Z1.68000 E19.71686 F1800.0
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z4.960 F1200

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
G1 Z4.960 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z1.96000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 1.96000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 7/17
; LAYER_CHANGE
M73 P41 R0
G1 X-9.92468 Y0.76475 Z1.96000 E19.75712 F1800.0
G1 X-9.80785 Y1.95090 Z1.96000 E19.81956 F1800.0
G1 X-9.58478 Y2.68627 Z1.96000 E19.85981 F1800.0
G1 X-9.23880 Y3.82683 Z1.96000 E19.92225 F1800.0
G1 X-8.87655 Y4.50455 Z1.96000 E19.96250 F1800.0
G1 X-8.31470 Y5.55570 Z1.96000 E20.02494 F1800.0
G1 X-7.82719 Y6.14973 Z1.96000 E20.06520 F1800.0
G1 X-7.07107 Y7.07107 Z1.96000 E20.12763 F1800.0
G1 X-6.47704 Y7.55857 Z1.96000 E20.16789 F1800.0
G1 X-5.55570 Y8.31470 Z1.96000 E20.23032 F1800.0
G1 X-4.87799 Y8.67694 Z1.96000 E20.27058 F1800.0
G1 X-3.82683 Y9.23880 Z1.96000 E20.33302 F1800.0
G1 X-3.09147 Y9.46187 Z1.96000 E20.37327 F1800.0
G1 X-1.95090 Y9.80785 Z1.96000 E20.43571 F1800.0
G1 X-1.18615 Y9.88317 Z1.96000 E20.47596 F1800.0
G1 X0.00000 Y10.00000 Z1.96000 E20.53840 F1800.0
G1 X0.76475 Y9.92468 Z1.96000 E20.57865 F1800.0
G1 X1.95090 Y9.80785 Z1.96000 E20.64109 F1800.0
G1 X2.68627 Y9.58478 Z1.96000 E20.68135 F1800.0
G1 X3.82683 Y9.23880 Z1.96000 E20.74378 F1800.0
G1 X4.50455 Y8.87655 Z1.96000 E20.78404 F1800.0
G1 X5.55570 Y8.31470 Z1.96000 E20.84648 F1800.0
G1 X6.14973 Y7.82719 Z1.96000 E20.88673 F1800.0
G1 X7.07107 Y7.07107 Z1.96000 E20.94917 F1800.0
G1 X7.55857 Y6.47704 Z1.96000 E20.98942 F1800.0
G1 X8.31470 Y5.55570 Z1.96000 E21.05186 F1800.0
G1 X8.67694 Y4.87799 Z1.96000 E21.09211 F1800.0
G1 X9.23880 Y3.82683 Z1.96000 E21.15455 F1800.0
G1 X9.46187 Y3.09147 Z1.96000 E21.19481 F1800.0
G1 X9.80785 Y1.95090 Z1.96000 E21.25724 F1800.0
G1 X9.88317 Y1.18615 Z1.96000 E21.29750 F1800.0
G1 X10.00000 Y0.00000 Z1.96000 E21.35994 F1800.0
G1 X9.92468 Y-0.76475 Z1.96000 E21.40019 F1800.0
G1 X9.80785 Y-1.95090 Z1.96000 E21.46263 F1800.0
G1 X9.58478 Y-2.68627 Z1.96000 E21.50288 F1800.0
G1 X9.23880 Y-3.82683 Z1.96000 E21.56532 F1800.0
G1 X8.87655 Y-4.50455 Z1.96000 E21.60558 F1800.0
G1 X8.31470 Y-5.55570 Z1.96000 E21.66801 F1800.0
G1 X7.82719 Y-6.14973 Z1.96000 E21.70827 F1800.0
G1 X7.07107 Y-7.07107 Z1.96000 E21.77070 F1800.0
G1 X6.47704 Y-7.55857 Z1.96000 E21.81096 F1800.0
G1 X5.55570 Y-8.31470 Z1.96000 E21.87340 F1800.0
G1 X4.87799 Y-8.67694 Z1.96000 E21.91365 F1800.0
G1 X3.82683 Y-9.23880 Z1.96000 E21.97609 F1800.0
G1 X3.09147 Y-9.46187 Z1.96000 E22.01634 F1800.0
G1 X1.95090 Y-9.80785 Z1.96000 E22.07878 F1800.0
G1 X1.18615 Y-9.88317 Z1.96000 E22.11904 F1800.0
G1 X0.00000 Y-10.00000 Z1.96000 E22.18147 F1800.0
G1 X-0.76475 Y-9.92468 Z1.96000 E22.22173 F1800.0
G1 X-1.95090 Y-9.80785 Z1.96000 E22.28416 F1800.0
G1 X-2.68627 Y-9.58478 Z1.96000 E22.32442 F1800.0
G1 X-3.82683 Y-9.23880 Z1.96000 E22.38686 F1800.0
G1 X-4.50455 Y-8.87655 Z1.96000 E22.42711 F1800.0
G1 X-5.55570 Y-8.31470 Z1.96000 E22.48955 F1800.0
G1 X-6.14973 Y-7.82719 Z1.96000 E22.52980 F1800.0
G1 X-7.07107 Y-7.07107 Z1.96000 E22.59224 F1800.0
G1 X-7.55857 Y-6.47704 Z1.96000 E22.63250 F1800.0
G1 X-8.31470 Y-5.55570 Z1.96000 E22.69493 F1800.0
G1 X-8.67694 Y-4.87799 Z1.96000 E22.73519 F1800.0
G1 X-9.23880 Y-3.82683 Z1.96000 E22.79762 F1800.0
G1 X-9.46187 Y-3.09147 Z1.96000 E22.83788 F1800.0
G1 X-9.80785 Y-1.95090 Z1.96000 E22.90032 F1800.0
G1 X-9.88317 Y-1.18615 Z1.96000 E22.94057 F1800.0
G1 X-10.00000 Y0.00000 Z1.96000 E23.00301 F1800.0
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z5.240 F1200

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
G1 Z5.240 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z2.24000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 2.24000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 8/17
; LAYER_CHANGE
M73 P47 R0
G1 X-9.91392 Y0.87400 Z2.24000 E23.04901 F1800.0
G1 X-9.80785 Y1.95090 Z2.24000 E23.10570 F1800.0
G1 X-9.55291 Y2.79132 Z2.24000 E23.15171 F1800.0
G1 X-9.23880 Y3.82683 Z2.24000 E23.20839 F1800.0
G1 X-8.82480 Y4.60137 Z2.24000 E23.25440 F1800.0
G1 X-8.31470 Y5.55570 Z2.24000 E23.31108 F1800.0
G1 X-7.75755 Y6.23459 Z2.24000 E23.35709 F1800.0
G1 X-7.07107 Y7.07107 Z2.24000 E23.41378 F1800.0
G1 X-6.39218 Y7.62821 Z2.24000 E23.45978 F1800.0
G1 X-5.55570 Y8.31470 Z2.24000 E23.51647 F1800.0
G1 X-4.78117 Y8.72869 Z2.24000 E23.56247 F1800.0
G1 X-3.82683 Y9.23880 Z2.24000 E23.61916 F1800.0
G1 X-2.98642 Y9.49373 Z2.24000 E23.66517 F1800.0
G1 X-1.95090 Y9.80785 Z2.24000 E23.72185 F1800.0
G1 X-1.07690 Y9.89393 Z2.24000 E23.76786 F1800.0
G1 X0.00000 Y10.00000 Z2.24000 E23.82454 F1800.0
G1 X0.87400 Y9.91392 Z2.24000 E23.87055 F1800.0
G1 X1.95090 Y9.80785 Z2.24000 E23.92724 F1800.0
G1 X2.79132 Y9.55291 Z2.24000 E23.97324 F1800.0
G1 X3.82683 Y9.23880 Z2.24000 E24.02993 F1800.0
G1 X4.60137 Y8.82480 Z2.24000 E24.07593 F1800.0
G1 X5.55570 Y8.31470 Z2.24000 E24.13262 F1800.0
G1 X6.23459 Y7.75755 Z2.24000 E24.17863 F1800.0
G1 X7.07107 Y7.07107 Z2.24000 E24.23531 F1800.0
G1 X7.62821 Y6.39218 Z2.24000 E24.28132 F1800.0
G1 X8.31470 Y5.55570 Z2.24000 E24.33800 F1800.0
G1 X8.72869 Y4.78117 Z2.24000 E24.38401 F1800.0
G1 X9.23880 Y3.82683 Z2.24000 E24.44070 F1800.0
G1 X9.49373 Y2.98642 Z2.24000 E24.48670 F1800.0
G1 X9.80785 Y1.95090 Z2.24000 E24.54339 F1800.0
G1 X9.89393 Y1.07690 Z2.24000 E24.58939 F1800.0
G1 X10.00000 Y0.00000 Z2.24000 E24.64608 F1800.0
G1 X9.91392 Y-0.87400 Z2.24000 E24.69209 F1800.0
G1 X9.80785 Y-1.95090 Z2.24000 E24.74877 F1800.0
G1 X9.55291 Y-2.79132 Z2.24000 E24.79478 F1800.0
G1 X9.23880 Y-3.82683 Z2.24000 E24.85146 F1800.0
G1 X8.82480 Y-4.60137 Z2.24000 E24.89747 F1800.0
G1 X8.31470 Y-5.55570 Z2.24000 E24.95416 F1800.0
G1 X7.75755 Y-6.23459 Z2.24000 E25.00016 F1800.0
G1 X7.07107 Y-7.07107 Z2.24000 E25.05685 F1800.0
G1 X6.39218 Y-7.62821 Z2.24000 E25.10285 F1800.0
G1 X5.55570 Y-8.31470 Z2.24000 E25.15954 F1800.0
G1 X4.78117 Y-8.72869 Z2.24000 E25.20555 F1800.0
G1 X3.82683 Y-9.23880 Z2.24000 E25.26223 F1800.0
G1 X2.98642 Y-9.49373 Z2.24000 E25.30824 F1800.0
G1 X1.95090 Y-9.80785 Z2.24000 E25.36492 F1800.0
G1 X1.07690 Y-9.89393 Z2.24000 E25.41093 F1800.0
G1 X0.00000 Y-10.00000 Z2.24000 E25.46762 F1800.0
G1 X-0.87400 Y-9.91392 Z2.24000 E25.51362 F1800.0
G1 X-1.95090 Y-9.80785 Z2.24000 E25.57031 F1800.0
G1 X-2.79132 Y-9.55291 Z2.24000 E25.61631 F1800.0
G1 X-3.82683 Y-9.23880 Z2.24000 E25.67300 F1800.0
G1 X-4.60137 Y-8.82480 Z2.24000 E25.71901 F1800.0
G1 X-5.55570 Y-8.31470 Z2.24000 E25.77569 F1800.0
G1 X-6.23459 Y-7.75755 Z2.24000 E25.82170 F1800.0
G1 X-7.07107 Y-7.07107 Z2.24000 E25.87838 F1800.0
G1 X-7.62821 Y-6.39218 Z2.24000 E25.92439 F1800.0
G1 X-8.31470 Y-5.55570 Z2.24000 E25.98108 F1800.0
G1 X-8.72869 Y-4.78117 Z2.24000 E26.02708 F1800.0
G1 X-9.23880 Y-3.82683 Z2.24000 E26.08377 F1800.0
G1 X-9.49373 Y-2.98642 Z2.24000 E26.12977 F1800.0
G1 X-9.80785 Y-1.95090 Z2.24000 E26.18646 F1800.0
G1 X-9.89393 Y-1.07690 Z2.24000 E26.23247 F1800.0
G1 X-10.00000 Y0.00000 Z2.24000 E26.28915 F1800.0
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z5.520 F1200

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
G1 Z5.520 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z2.52000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 2.52000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 9/17
; LAYER_CHANGE
M73 P53 R0
G1 X-9.90469 Y-0.96765 Z2.52000 E26.34009 F1800.0
G1 X-9.80785 Y-1.95090 Z2.52000 E26.39184 F1800.0
G1 X-9.52560 Y-2.88137 Z2.52000 E26.44278 F1800.0
G1 X-9.23880 Y-3.82683 Z2.52000 E26.49454 F1800.0
G1 X-8.78044 Y-4.68435 Z2.52000 E26.54547 F1800.0
G1 X-8.31470 Y-5.55570 Z2.52000 E26.59723 F1800.0
G1 X-7.69786 Y-6.30732 Z2.52000 E26.64816 F1800.0
G1 X-7.07107 Y-7.07107 Z2.52000 E26.69992 F1800.0
G1 X-6.31945 Y-7.68791 Z2.52000 E26.75086 F1800.0
G1 X-5.55570 Y-8.31470 Z2.52000 E26.80261 F1800.0
G1 X-4.69818 Y-8.77305 Z2.52000 E26.85355 F1800.0
G1 X-3.82683 Y-9.23880 Z2.52000 E26.90530 F1800.0
G1 X-2.89637 Y-9.52105 Z2.52000 E26.95624 F1800.0
G1 X-1.95090 Y-9.80785 Z2.52000 E27.00800 F1800.0
G1 X-0.98326 Y-9.90316 Z2.52000 E27.05893 F1800.0
G1 X0.00000 Y-10.00000 Z2.52000 E27.11069 F1800.0
G1 X0.96765 Y-9.90469 Z2.52000 E27.16162 F1800.0
G1 X1.95090 Y-9.80785 Z2.52000 E27.21338 F1800.0
G1 X2.88137 Y-9.52560 Z2.52000 E27.26432 F1800.0
G1 X3.82683 Y-9.23880 Z2.52000 E27.31607 F1800.0
G1 X4.68435 Y-8.78044 Z2.52000 E27.36701 F1800.0
G1 X5.55570 Y-8.31470 Z2.52000 E27.41876 F1800.0
G1 X6.30732 Y-7.69786 Z2.52000 E27.46970 F1800.0
G1 X7.07107 Y-7.07107 Z2.52000 E27.52146 F1800.0
G1 X7.68791 Y-6.31945 Z2.52000 E27.57239 F1800.0
G1 X8.31470 Y-5.55570 Z2.52000 E27.62415 F1800.0
G1 X8.77305 Y-4.69818 Z2.52000 E27.67508 F1800.0
G1 X9.23880 Y-3.82683 Z2.52000 E27.72684 F1800.0
G1 X9.52105 Y-2.89637 Z2.52000 E27.77778 F1800.0
G1 X9.80785 Y-1.95090 Z2.52000 E27.82953 F1800.0
G1 X9.90316 Y-0.98326 Z2.52000 E27.88047 F1800.0
G1 X10.00000 Y0.00000 Z2.52000 E27.93222 F1800.0
G1 X9.90469 Y0.96765 Z2.52000 E27.98316 F1800.0
G1 X9.80785 Y1.95090 Z2.52000 E28.03492 F1800.0
G1 X9.52560 Y2.88137 Z2.52000 E28.08585 F1800.0
G1 X9.23880 Y3.82683 Z2.52000 E28.13761 F1800.0
G1 X8.78044 Y4.68435 Z2.52000 E28.18854 F1800.0
G1 X8.31470 Y5.55570 Z2.52000 E28.24030 F1800.0
G1 X7.69786 Y6.30732 Z2.52000 E28.29123 F1800.0
G1 X7.07107 Y7.07107 Z2.52000 E28.34299 F1800.0
G1 X6.31945 Y7.68791 Z2.52000 E28.39393 F1800.0
G1 X5.55570 Y8.31470 Z2.52000 E28.44568 F1800.0
G1 X4.69818 Y8.77305 Z2.52000 E28.49662 F1800.0
G1 X3.82683 Y9.23880 Z2.52000 E28.54838 F1800.0
G1 X2.89637 Y9.52105 Z2.52000 E28.59931 F1800.0
G1 X1.95090 Y9.80785 Z2.52000 E28.65107 F1800.0
G1 X0.98326 Y9.90316 Z2.52000 E28.70200 F1800.0
G1 X0.00000 Y10.00000 Z2.52000 E28.75376 F1800.0
G1 X-0.96765 Y9.90469 Z2.52000 E28.80470 F1800.0
G1 X-1.95090 Y9.80785 Z2.52000 E28.85645 F1800.0
G1 X-2.88137 Y9.52560 Z2.52000 E28.90739 F1800.0
G1 X-3.82683 Y9.23880 Z2.52000 E28.95914 F1800.0
G1 X-4.68435 Y8.78044 Z2.52000 E29.01008 F1800.0
G1 X-5.55570 Y8.31470 Z2.52000 E29.06184 F1800.0
G1 X-6.30732 Y7.69786 Z2.52000 E29.11277 F1800.0
G1 X-7.07107 Y7.07107 Z2.52000 E29.16453 F1800.0
G1 X-7.68791 Y6.31945 Z2.52000 E29.21546 F1800.0
G1 X-8.31470 Y5.55570 Z2.52000 E29.26722 F1800.0
G1 X-8.77305 Y4.69818 Z2.52000 E29.31816 F1800.0
G1 X-9.23880 Y3.82683 Z2.52000 E29.36991 F1800.0
G1 X-9.52105 Y2.89637 Z2.52000 E29.42085 F1800.0
G1 X-9.80785 Y1.95090 Z2.52000 E29.47260 F1800.0
G1 X-9.90316 Y0.98326 Z2.52000 E29.52354 F1800.0
G1 X-10.00000 Y0.00000 Z2.52000 E29.57530 F1800.0
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z5.800 F1200

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
G1 Z5.800 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z2.80000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 2.80000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 10/17
; LAYER_CHANGE
M73 P59 R0
G1 X-9.91546 Y-0.85840 Z2.80000 E29.62048 F1800.0
G1 X-9.80785 Y-1.95090 Z2.80000 E29.67799 F1800.0
G1 X-9.55747 Y-2.77631 Z2.80000 E29.72317 F1800.0
G1 X-9.23880 Y-3.82683 Z2.80000 E29.78068 F1800.0
G1 X-8.83219 Y-4.58754 Z2.80000 E29.82586 F1800.0
G1 X-8.31470 Y-5.55570 Z2.80000 E29.88337 F1800.0
G1 X-7.76750 Y-6.22246 Z2.80000 E29.92856 F1800.0
G1 X-7.07107 Y-7.07107 Z2.80000 E29.98606 F1800.0
G1 X-6.40431 Y-7.61826 Z2.80000 E30.03125 F1800.0
G1 X-5.55570 Y-8.31470 Z2.80000 E30.08876 F1800.0
G1 X-4.79500 Y-8.72130 Z2.80000 E30.13394 F1800.0
G1 X-3.82683 Y-9.23880 Z2.80000 E30.19145 F1800.0
G1 X-3.00142 Y-9.48918 Z2.80000 E30.23663 F1800.0
G1 X-1.95090 Y-9.80785 Z2.80000 E30.29414 F1800.0
G1 X-1.09251 Y-9.89240 Z2.80000 E30.33932 F1800.0
G1 X0.00000 Y-10.00000 Z2.80000 E30.39683 F1800.0
G1 X0.85840 Y-9.91546 Z2.80000 E30.44202 F1800.0
G1 X1.95090 Y-9.80785 Z2.80000 E30.49952 F1800.0
G1 X2.77631 Y-9.55747 Z2.80000 E30.54471 F1800.0
G1 X3.82683 Y-9.23880 Z2.80000 E30.60222 F1800.0
G1 X4.58754 Y-8.83219 Z2.80000 E30.64740 F1800.0
G1 X5.55570 Y-8.31470 Z2.80000 E30.70491 F1800.0
G1 X6.22246 Y-7.76750 Z2.80000 E30.75009 F1800.0
G1 X7.07107 Y-7.07107 Z2.80000 E30.80760 F1800.0
G1 X7.61826 Y-6.40431 Z2.80000 E30.85278 F1800.0
G1 X8.31470 Y-5.55570 Z2.80000 E30.91029 F1800.0
G1 X8.72130 Y-4.79500 Z2.80000 E30.95548 F1800.0
G1 X9.23880 Y-3.82683 Z2.80000 E31.01298 F1800.0
G1 X9.48918 Y-3.00142 Z2.80000 E31.05817 F1800.0
G1 X9.80785 Y-1.95090 Z2.80000 E31.11568 F1800.0
G1 X9.89240 Y-1.09251 Z2.80000 E31.16086 F1800.0
G1 X10.00000 Y0.00000 Z2.80000 E31.21837 F1800.0
G1 X9.91546 Y0.85840 Z2.80000 E31.26355 F1800.0
G1 X9.80785 Y1.95090 Z2.80000 E31.32106 F1800.0
G1 X9.55747 Y2.77631 Z2.80000 E31.36624 F1800.0
G1 X9.23880 Y3.82683 Z2.80000 E31.42375 F1800.0
G1 X8.83219 Y4.58754 Z2.80000 E31.46894 F1800.0
G1 X8.31470 Y5.55570 Z2.80000 E31.52644 F1800.0
G1 X7.76750 Y6.22246 Z2.80000 E31.57163 F1800.0
G1 X7.07107 Y7.07107 Z2.80000 E31.62914 F1800.0
G1 X6.40431 Y7.61826 Z2.80000 E31.67432 F1800.0
G1 X5.55570 Y8.31470 Z2.80000 E31.73183 F1800.0
G1 X4.79500 Y8.72130 Z2.80000 E31.77701 F1800.0
G1 X3.82683 Y9.23880 Z2.80000 E31.83452 F1800.0
G1 X3.00142 Y9.48918 Z2.80000 E31.87970 F1800.0
G1 X1.95090 Y9.80785 Z2.80000 E31.93721 F1800.0
G1 X1.09251 Y9.89240 Z2.80000 E31.98240 F1800.0
G1 X0.00000 Y10.00000 Z2.80000 E32.03990 F1800.0
G1 X-0.85840 Y9.91546 Z2.80000 E32.08509 F1800.0
G1 X-1.95090 Y9.80785 Z2.80000 E32.14260 F1800.0
G1 X-2.77631 Y9.55747 Z2.80000 E32.18778 F1800.0
G1 X-3.82683 Y9.23880 Z2.80000 E32.24529 F1800.0
G1 X-4.58754 Y8.83219 Z2.80000 E32.29047 F1800.0
G1 X-5.55570 Y8.31470 Z2.80000 E32.34798 F1800.0
G1 X-6.22246 Y7.76750 Z2.80000 E32.39316 F1800.0
G1 X-7.07107 Y7.07107 Z2.80000 E32.45067 F1800.0
G1 X-7.61826 Y6.40431 Z2.80000 E32.49586 F1800.0
G1 X-8.31470 Y5.55570 Z2.80000 E32.55336 F1800.0
G1 X-8.72130 Y4.79500 Z2.80000 E32.59855 F1800.0
G1 X-9.23880 Y3.82683 Z2.80000 E32.65606 F1800.0
G1 X-9.48918 Y3.00142 Z2.80000 E32.70124 F1800.0
G1 X-9.80785 Y1.95090 Z2.80000 E32.75875 F1800.0
G1 X-9.89240 Y1.09251 Z2.80000 E32.80393 F1800.0
G1 X-10.00000 Y0.00000 Z2.80000 E32.86144 F1800.0
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z6.080 F1200

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
G1 Z6.080 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z3.08000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 3.08000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 11/17
; LAYER_CHANGE
M73 P65 R0
G1 X-9.92622 Y-0.74915 Z3.08000 E32.90087 F1800.0
G1 X-9.80785 Y-1.95090 Z3.08000 E32.96413 F1800.0
G1 X-9.58933 Y-2.67126 Z3.08000 E33.00357 F1800.0
G1 X-9.23880 Y-3.82683 Z3.08000 E33.06682 F1800.0
G1 X-8.88394 Y-4.49072 Z3.08000 E33.10626 F1800.0
G1 X-8.31470 Y-5.55570 Z3.08000 E33.16952 F1800.0
G1 X-7.83714 Y-6.13760 Z3.08000 E33.20895 F1800.0
G1 X-7.07107 Y-7.07107 Z3.08000 E33.27221 F1800.0
G1 X-6.48917 Y-7.54862 Z3.08000 E33.31164 F1800.0
G1 X-5.55570 Y-8.31470 Z3.08000 E33.37490 F1800.0
G1 X-4.89182 Y-8.66955 Z3.08000 E33.41433 F1800.0
G1 X-3.82683 Y-9.23880 Z3.08000 E33.47759 F1800.0
G1 X-3.10648 Y-9.45731 Z3.08000 E33.51703 F1800.0
G1 X-1.95090 Y-9.80785 Z3.08000 E33.58028 F1800.0
G1 X-1.20176 Y-9.88164 Z3.08000 E33.61972 F1800.0
G1 X0.00000 Y-10.00000 Z3.08000 E33.68298 F1800.0
G1 X0.74915 Y-9.92622 Z3.08000 E33.72241 F1800.0
G1 X1.95090 Y-9.80785 Z3.08000 E33.78567 F1800.0
G1 X2.67126 Y-9.58933 Z3.08000 E33.82510 F1800.0
G1 X3.82683 Y-9.23880 Z3.08000 E33.88836 F1800.0
G1 X4.49072 Y-8.88394 Z3.08000 E33.92779 F1800.0
G1 X5.55570 Y-8.31470 Z3.08000 E33.99105 F1800.0
G1 X6.13760 Y-7.83714 Z3.08000 E34.03049 F1800.0
G1 X7.07107 Y-7.07107 Z3.08000 E34.09374 F1800.0
G1 X7.54862 Y-6.48917 Z3.08000 E34.13318 F1800.0
G1 X8.31470 Y-5.55570 Z3.08000 E34.19644 F1800.0
G1 X8.66955 Y-4.89182 Z3.08000 E34.23587 F1800.0
G1 X9.23880 Y-3.82683 Z3.08000 E34.29913 F1800.0
G1 X9.45731 Y-3.10648 Z3.08000 E34.33856 F1800.0
G1 X9.80785 Y-1.95090 Z3.08000 E34.40182 F1800.0
G1 X9.88164 Y-1.20176 Z3.08000 E34.44125 F1800.0
G1 X10.00000 Y0.00000 Z3.08000 E34.50451 F1800.0
G1 X9.92622 Y0.74915 Z3.08000 E34.54395 F1800.0
G1 X9.80785 Y1.95090 Z3.08000 E34.60720 F1800.0
G1 X9.58933 Y2.67126 Z3.08000 E34.64664 F1800.0
G1 X9.23880 Y3.82683 Z3.08000 E34.70990 F1800.0
G1 X8.88394 Y4.49072 Z3.08000 E34.74933 F1800.0
G1 X8.31470 Y5.55570 Z3.08000 E34.81259 F1800.0
G1 X7.83714 Y6.13760 Z3.08000 E34.85202 F1800.0
G1 X7.07107 Y7.07107 Z3.08000 E34.91528 F1800.0
G1 X6.48917 Y7.54862 Z3.08000 E34.95471 F1800.0
G1 X5.55570 Y8.31470 Z3.08000 E35.01797 F1800.0
G1 X4.89182 Y8.66955 Z3.08000 E35.05741 F1800.0
G1 X3.82683 Y9.23880 Z3.08000 E35.12066 F1800.0
G1 X3.10648 Y9.45731 Z3.08000 E35.16010 F1800.0
G1 X1.95090 Y9.80785 Z3.08000 E35.22336 F1800.0
G1 X1.20176 Y9.88164 Z3.08000 E35.26279 F1800.0
G1 X0.00000 Y10.00000 Z3.08000 E35.32605 F1800.0
G1 X-0.74915 Y9.92622 Z3.08000 E35.36548 F1800.0
G1 X-1.95090 Y9.80785 Z3.08000 E35.42874 F1800.0
G1 X-2.67126 Y9.58933 Z3.08000 E35.46817 F1800.0
G1 X-3.82683 Y9.23880 Z3.08000 E35.53143 F1800.0
G1 X-4.49072 Y8.88394 Z3.08000 E35.57087 F1800.0
G1 X-5.55570 Y8.31470 Z3.08000 E35.63412 F1800.0
G1 X-6.13760 Y7.83714 Z3.08000 E35.67356 F1800.0
G1 X-7.07107 Y7.07107 Z3.08000 E35.73682 F1800.0
G1 X-7.54862 Y6.48917 Z3.08000 E35.77625 F1800.0
G1 X-8.31470 Y5.55570 Z3.08000 E35.83951 F1800.0
G1 X-8.66955 Y4.89182 Z3.08000 E35.87894 F1800.0
G1 X-9.23880 Y3.82683 Z3.08000 E35.94220 F1800.0
G1 X-9.45731 Y3.10648 Z3.08000 E35.98163 F1800.0
G1 X-9.80785 Y1.95090 Z3.08000 E36.04489 F1800.0
G1 X-9.88164 Y1.20176 Z3.08000 E36.08433 F1800.0
G1 X-10.00000 Y0.00000 Z3.08000 E36.14758 F1800.0
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z6.360 F1200

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
G1 Z6.360 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z3.36000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 3.36000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 12/17
; LAYER_CHANGE
M73 P71 R0
G1 X-9.93698 Y-0.63990 Z3.36000 E36.18127 F1800.0
G1 X-9.80785 Y-1.95090 Z3.36000 E36.25028 F1800.0
G1 X-9.62120 Y-2.56621 Z3.36000 E36.28396 F1800.0
G1 X-9.23880 Y-3.82683 Z3.36000 E36.35297 F1800.0
G1 X-8.93569 Y-4.39390 Z3.36000 E36.38665 F1800.0
G1 X-8.31470 Y-5.55570 Z3.36000 E36.45566 F1800.0
G1 X-7.90679 Y-6.05274 Z3.36000 E36.48934 F1800.0
G1 X-7.07107 Y-7.07107 Z3.36000 E36.55835 F1800.0
G1 X-6.57403 Y-7.47898 Z3.36000 E36.59203 F1800.0
G1 X-5.55570 Y-8.31470 Z3.36000 E36.66104 F1800.0
G1 X-4.98863 Y-8.61780 Z3.36000 E36.69473 F1800.0
G1 X-3.82683 Y-9.23880 Z3.36000 E36.76374 F1800.0
G1 X-3.21153 Y-9.42545 Z3.36000 E36.79742 F1800.0
G1 X-1.95090 Y-9.80785 Z3.36000 E36.86643 F1800.0
G1 X-1.31101 Y-9.87088 Z3.36000 E36.90011 F1800.0
G1 X0.00000 Y-10.00000 Z3.36000 E36.96912 F1800.0
G1 X0.63990 Y-9.93698 Z3.36000 E37.00280 F1800.0
G1 X1.95090 Y-9.80785 Z3.36000 E37.07181 F1800.0
G1 X2.56621 Y-9.62120 Z3.36000 E37.10549 F1800.0
G1 X3.82683 Y-9.23880 Z3.36000 E37.17450 F1800.0
G1 X4.39390 Y-8.93569 Z3.36000 E37.20819 F1800.0
G1 X5.55570 Y-8.31470 Z3.36000 E37.27720 F1800.0
G1 X6.05274 Y-7.90679 Z3.36000 E37.31088 F1800.0
G1 X7.07107 Y-7.07107 Z3.36000 E37.37989 F1800.0
G1 X7.47898 Y-6.57403 Z3.36000 E37.41357 F1800.0
G1 X8.31470 Y-5.55570 Z3.36000 E37.48258 F1800.0
G1 X8.61780 Y-4.98863 Z3.36000 E37.51626 F1800.0
G1 X9.23880 Y-3.82683 Z3.36000 E37.58527 F1800.0
G1 X9.42545 Y-3.21153 Z3.36000 E37.61895 F1800.0
G1 X9.80785 Y-1.95090 Z3.36000 E37.68796 F1800.0
G1 X9.87088 Y-1.31101 Z3.36000 E37.72165 F1800.0
G1 X10.00000 Y0.00000 Z3.36000 E37.79066 F1800.0
G1 X9.93698 Y0.63990 Z3.36000 E37.82434 F1800.0
G1 X9.80785 Y1.95090 Z3.36000 E37.89335 F1800.0
G1 X9.62120 Y2.56621 Z3.36000 E37.92703 F1800.0
G1 X9.23880 Y3.82683 Z3.36000 E37.99604 F1800.0
G1 X8.93569 Y4.39390 Z3.36000 E38.02972 F1800.0
G1 X8.31470 Y5.55570 Z3.36000 E38.09873 F1800.0
G1 X7.90679 Y6.05274 Z3.36000 E38.13241 F1800.0
G1 X7.07107 Y7.07107 Z3.36000 E38.20142 F1800.0
G1 X6.57403 Y7.47898 Z3.36000 E38.23511 F1800.0
G1 X5.55570 Y8.31470 Z3.36000 E38.30412 F1800.0
G1 X4.98863 Y8.61780 Z3.36000 E38.33780 F1800.0
G1 X3.82683 Y9.23880 Z3.36000 E38.40681 F1800.0
G1 X3.21153 Y9.42545 Z3.36000 E38.44049 F1800.0
G1 X1.95090 Y9.80785 Z3.36000 E38.50950 F1800.0
G1 X1.31101 Y9.87088 Z3.36000 E38.54318 F1800.0
G1 X0.00000 Y10.00000 Z3.36000 E38.61219 F1800.0
G1 X-0.63990 Y9.93698 Z3.36000 E38.64587 F1800.0
G1 X-1.95090 Y9.80785 Z3.36000 E38.71488 F1800.0
G1 X-2.56621 Y9.62120 Z3.36000 E38.74857 F1800.0
G1 X-3.82683 Y9.23880 Z3.36000 E38.81758 F1800.0
G1 X-4.39390 Y8.93569 Z3.36000 E38.85126 F1800.0
G1 X-5.55570 Y8.31470 Z3.36000 E38.92027 F1800.0
G1 X-6.05274 Y7.90679 Z3.36000 E38.95395 F1800.0
G1 X-7.07107 Y7.07107 Z3.36000 E39.02296 F1800.0
G1 X-7.47898 Y6.57403 Z3.36000 E39.05664 F1800.0
G1 X-8.31470 Y5.55570 Z3.36000 E39.12565 F1800.0
G1 X-8.61780 Y4.98863 Z3.36000 E39.15933 F1800.0
G1 X-9.23880 Y3.82683 Z3.36000 E39.22834 F1800.0
G1 X-9.42545 Y3.21153 Z3.36000 E39.26203 F1800.0
G1 X-9.80785 Y1.95090 Z3.36000 E39.33104 F1800.0
G1 X-9.87088 Y1.31101 Z3.36000 E39.36472 F1800.0
G1 X-10.00000 Y0.00000 Z3.36000 E39.43373 F1800.0
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z6.640 F1200

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
G1 Z6.640 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z3.64000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 3.64000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 13/17
; LAYER_CHANGE
M73 P76 R0
G1 X-9.94774 Y-0.53065 Z3.64000 E39.46166 F1800.0
G1 X-9.80785 Y-1.95090 Z3.64000 E39.53642 F1800.0
G1 X-9.65307 Y-2.46116 Z3.64000 E39.56435 F1800.0
G1 X-9.23880 Y-3.82683 Z3.64000 E39.63911 F1800.0
G1 X-8.98744 Y-4.29709 Z3.64000 E39.66704 F1800.0
G1 X-8.31470 Y-5.55570 Z3.64000 E39.74180 F1800.0
G1 X-7.97643 Y-5.96788 Z3.64000 E39.76974 F1800.0
G1 X-7.07107 Y-7.07107 Z3.64000 E39.84450 F1800.0
G1 X-6.65889 Y-7.40933 Z3.64000 E39.87243 F1800.0
G1 X-5.55570 Y-8.31470 Z3.64000 E39.94719 F1800.0
G1 X-5.08545 Y-8.56605 Z3.64000 E39.97512 F1800.0
G1 X-3.82683 Y-9.23880 Z3.64000 E40.04988 F1800.0
G1 X-3.31658 Y-9.39358 Z3.64000 E40.07781 F1800.0
G1 X-1.95090 Y-9.80785 Z3.64000 E40.15257 F1800.0
G1 X-1.42026 Y-9.86012 Z3.64000 E40.18050 F1800.0
G1 X0.00000 Y-10.00000 Z3.64000 E40.25526 F1800.0
G1 X0.53065 Y-9.94774 Z3.64000 E40.28320 F1800.0
G1 X1.95090 Y-9.80785 Z3.64000 E40.35796 F1800.0
G1 X2.46116 Y-9.65307 Z3.64000 E40.38589 F1800.0
G1 X3.82683 Y-9.23880 Z3.64000 E40.46065 F1800.0
G1 X4.29709 Y-8.98744 Z3.64000 E40.48858 F1800.0
G1 X5.55570 Y-8.31470 Z3.64000 E40.56334 F1800.0
G1 X5.96788 Y-7.97643 Z3.64000 E40.59127 F1800.0
G1 X7.07107 Y-7.07107 Z3.64000 E40.66603 F1800.0
G1 X7.40933 Y-6.65889 Z3.64000 E40.69396 F1800.0
G1 X8.31470 Y-5.55570 Z3.64000 E40.76872 F1800.0
G1 X8.56605 Y-5.08545 Z3.64000 E40.79666 F1800.0
G1 X9.23880 Y-3.82683 Z3.64000 E40.87142 F1800.0
G1 X9.39358 Y-3.31658 Z3.64000 E40.89935 F1800.0
G1 X9.80785 Y-1.95090 Z3.64000 E40.97411 F1800.0
G1 X9.86012 Y-1.42026 Z3.64000 E41.00204 F1800.0
G1 X10.00000 Y0.00000 Z3.64000 E41.07680 F1800.0
G1 X9.94774 Y0.53065 Z3.64000 E41.10473 F1800.0
G1 X9.80785 Y1.95090 Z3.64000 E41.17949 F1800.0
G1 X9.65307 Y2.46116 Z3.64000 E41.20742 F1800.0
G1 X9.23880 Y3.82683 Z3.64000 E41.28218 F1800.0
G1 X8.98744 Y4.29709 Z3.64000 E41.31012 F1800.0
G1 X8.31470 Y5.55570 Z3.64000 E41.38488 F1800.0
G1 X7.97643 Y5.96788 Z3.64000 E41.41281 F1800.0
G1 X7.07107 Y7.07107 Z3.64000 E41.48757 F1800.0
G1 X6.65889 Y7.40933 Z3.64000 E41.51550 F1800.0
G1 X5.55570 Y8.31470 Z3.64000 E41.59026 F1800.0
G1 X5.08545 Y8.56605 Z3.64000 E41.61819 F1800.0
G1 X3.82683 Y9.23880 Z3.64000 E41.69295 F1800.0
G1 X3.31658 Y9.39358 Z3.64000 E41.72088 F1800.0
G1 X1.95090 Y9.80785 Z3.64000 E41.79564 F1800.0
G1 X1.42026 Y9.86012 Z3.64000 E41.82358 F1800.0
G1 X0.00000 Y10.00000 Z3.64000 E41.89834 F1800.0
G1 X-0.53065 Y9.94774 Z3.64000 E41.92627 F1800.0
G1 X-1.95090 Y9.80785 Z3.64000 E42.00103 F1800.0
G1 X-2.46116 Y9.65307 Z3.64000 E42.02896 F1800.0
G1 X-3.82683 Y9.23880 Z3.64000 E42.10372 F1800.0
G1 X-4.29709 Y8.98744 Z3.64000 E42.13165 F1800.0
G1 X-5.55570 Y8.31470 Z3.64000 E42.20641 F1800.0
G1 X-5.96788 Y7.97643 Z3.64000 E42.23434 F1800.0
G1 X-7.07107 Y7.07107 Z3.64000 E42.30910 F1800.0
G1 X-7.40933 Y6.65889 Z3.64000 E42.33704 F1800.0
G1 X-8.31470 Y5.55570 Z3.64000 E42.41180 F1800.0
G1 X-8.56605 Y5.08545 Z3.64000 E42.43973 F1800.0
G1 X-9.23880 Y3.82683 Z3.64000 E42.51449 F1800.0
G1 X-9.39358 Y3.31658 Z3.64000 E42.54242 F1800.0
G1 X-9.80785 Y1.95090 Z3.64000 E42.61718 F1800.0
G1 X-9.86012 Y1.42026 Z3.64000 E42.64511 F1800.0
G1 X-10.00000 Y0.00000 Z3.64000 E42.71987 F1800.0
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z6.920 F1200

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
G1 Z6.920 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z3.92000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 3.92000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 14/17
; LAYER_CHANGE
M73 P82 R0
G1 X-9.95850 Y-0.42140 Z3.92000 E42.74205 F1800.0
G1 X-9.80785 Y-1.95090 Z3.92000 E42.82256 F1800.0
G1 X-9.68494 Y-2.35610 Z3.92000 E42.84474 F1800.0
G1 X-9.23880 Y-3.82683 Z3.92000 E42.92526 F1800.0
G1 X-9.03919 Y-4.20027 Z3.92000 E42.94744 F1800.0
G1 X-8.31470 Y-5.55570 Z3.92000 E43.02795 F1800.0
G1 X-8.04607 Y-5.88302 Z3.92000 E43.05013 F1800.0
G1 X-7.07107 Y-7.07107 Z3.92000 E43.13064 F1800.0
G1 X-6.74375 Y-7.33969 Z3.92000 E43.15282 F1800.0
G1 X-5.55570 Y-8.31470 Z3.92000 E43.23333 F1800.0
G1 X-5.18227 Y-8.51430 Z3.92000 E43.25551 F1800.0
G1 X-3.82683 Y-9.23880 Z3.92000 E43.33602 F1800.0
G1 X-3.42163 Y-9.36171 Z3.92000 E43.35821 F1800.0
G1 X-1.95090 Y-9.80785 Z3.92000 E43.43872 F1800.0
G1 X-1.52951 Y-9.84936 Z3.92000 E43.46090 F1800.0
G1 X0.00000 Y-10.00000 Z3.92000 E43.54141 F1800.0
G1 X0.42140 Y-9.95850 Z3.92000 E43.56359 F1800.0
G1 X1.95090 Y-9.80785 Z3.92000 E43.64410 F1800.0
G1 X2.35610 Y-9.68494 Z3.92000 E43.66628 F1800.0
G1 X3.82683 Y-9.23880 Z3.92000 E43.74679 F1800.0
G1 X4.20027 Y-9.03919 Z3.92000 E43.76897 F1800.0
G1 X5.55570 Y-8.31470 Z3.92000 E43.84948 F1800.0
G1 X5.88302 Y-8.04607 Z3.92000 E43.87167 F1800.0
G1 X7.07107 Y-7.07107 Z3.92000 E43.95218 F1800.0
G1 X7.33969 Y-6.74375 Z3.92000 E43.97436 F1800.0
G1 X8.31470 Y-5.55570 Z3.92000 E44.05487 F1800.0
G1 X8.51430 Y-5.18227 Z3.92000 E44.07705 F1800.0
G1 X9.23880 Y-3.82683 Z3.92000 E44.15756 F1800.0
G1 X9.36171 Y-3.42163 Z3.92000 E44.17974 F1800.0
G1 X9.80785 Y-1.95090 Z3.92000 E44.26025 F1800.0
G1 X9.84936 Y-1.52951 Z3.92000 E44.28243 F1800.0
G1 X10.00000 Y0.00000 Z3.92000 E44.36294 F1800.0
G1 X9.95850 Y0.42140 Z3.92000 E44.38513 F1800.0
G1 X9.80785 Y1.95090 Z3.92000 E44.46564 F1800.0
G1 X9.68494 Y2.35610 Z3.92000 E44.48782 F1800.0
G1 X9.23880 Y3.82683 Z3.92000 E44.56833 F1800.0
G1 X9.03919 Y4.20027 Z3.92000 E44.59051 F1800.0
G1 X8.31470 Y5.55570 Z3.92000 E44.67102 F1800.0
G1 X8.04607 Y5.88302 Z3.92000 E44.69320 F1800.0
G1 X7.07107 Y7.07107 Z3.92000 E44.77371 F1800.0
G1 X6.74375 Y7.33969 Z3.92000 E44.79589 F1800.0
G1 X5.55570 Y8.31470 Z3.92000 E44.87640 F1800.0
G1 X5.18227 Y8.51430 Z3.92000 E44.89859 F1800.0
G1 X3.82683 Y9.23880 Z3.92000 E44.97910 F1800.0
G1 X3.42163 Y9.36171 Z3.92000 E45.00128 F1800.0
G1 X1.95090 Y9.80785 Z3.92000 E45.08179 F1800.0
G1 X1.52951 Y9.84936 Z3.92000 E45.10397 F1800.0
G1 X0.00000 Y10.00000 Z3.92000 E45.18448 F1800.0
G1 X-0.42140 Y9.95850 Z3.92000 E45.20666 F1800.0
G1 X-1.95090 Y9.80785 Z3.92000 E45.28717 F1800.0
G1 X-2.35610 Y9.68494 Z3.92000 E45.30935 F1800.0
G1 X-3.82683 Y9.23880 Z3.92000 E45.38986 F1800.0
G1 X-4.20027 Y9.03919 Z3.92000 E45.41205 F1800.0
G1 X-5.55570 Y8.31470 Z3.92000 E45.49256 F1800.0
G1 X-5.88302 Y8.04607 Z3.92000 E45.51474 F1800.0
G1 X-7.07107 Y7.07107 Z3.92000 E45.59525 F1800.0
G1 X-7.33969 Y6.74375 Z3.92000 E45.61743 F1800.0
G1 X-8.31470 Y5.55570 Z3.92000 E45.69794 F1800.0
G1 X-8.51430 Y5.18227 Z3.92000 E45.72012 F1800.0
G1 X-9.23880 Y3.82683 Z3.92000 E45.80063 F1800.0
G1 X-9.36171 Y3.42163 Z3.92000 E45.82281 F1800.0
G1 X-9.80785 Y1.95090 Z3.92000 E45.90332 F1800.0
G1 X-9.84936 Y1.52951 Z3.92000 E45.92551 F1800.0
G1 X-10.00000 Y0.00000 Z3.92000 E46.00602 F1800.0
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z7.200 F1200

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
G1 Z7.200 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z4.20000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 4.20000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 15/17
; LAYER_CHANGE
M73 P88 R0
G1 X-9.96926 Y-0.31214 Z4.20000 E46.02245 F1800.0
G1 X-9.80785 Y-1.95090 Z4.20000 E46.10871 F1800.0
G1 X-9.71680 Y-2.25105 Z4.20000 E46.12514 F1800.0
G1 X-9.23880 Y-3.82683 Z4.20000 E46.21140 F1800.0
G1 X-9.09094 Y-4.10345 Z4.20000 E46.22783 F1800.0
G1 X-8.31470 Y-5.55570 Z4.20000 E46.31409 F1800.0
G1 X-8.11572 Y-5.79816 Z4.20000 E46.33052 F1800.0
G1 X-7.07107 Y-7.07107 Z4.20000 E46.41678 F1800.0
G1 X-6.82861 Y-7.27005 Z4.20000 E46.43321 F1800.0
G1 X-5.55570 Y-8.31470 Z4.20000 E46.51948 F1800.0
G1 X-5.27908 Y-8.46255 Z4.20000 E46.53591 F1800.0
G1 X-3.82683 Y-9.23880 Z4.20000 E46.62217 F1800.0
G1 X-3.52669 Y-9.32984 Z4.20000 E46.63860 F1800.0
G1 X-1.95090 Y-9.80785 Z4.20000 E46.72486 F1800.0
G1 X-1.63876 Y-9.83860 Z4.20000 E46.74129 F1800.0
G1 X0.00000 Y-10.00000 Z4.20000 E46.82755 F1800.0
G1 X0.31214 Y-9.96926 Z4.20000 E46.84398 F1800.0
G1 X1.95090 Y-9.80785 Z4.20000 E46.93024 F1800.0
G1 X2.25105 Y-9.71680 Z4.20000 E46.94667 F1800.0
G1 X3.82683 Y-9.23880 Z4.20000 E47.03294 F1800.0
G1 X4.10345 Y-9.09094 Z4.20000 E47.04937 F1800.0
G1 X5.55570 Y-8.31470 Z4.20000 E47.13563 F1800.0
G1 X5.79816 Y-8.11572 Z4.20000 E47.15206 F1800.0
G1 X7.07107 Y-7.07107 Z4.20000 E47.23832 F1800.0
G1 X7.27005 Y-6.82861 Z4.20000 E47.25475 F1800.0
G1 X8.31470 Y-5.55570 Z4.20000 E47.34101 F1800.0
G1 X8.46255 Y-5.27908 Z4.20000 E47.35744 F1800.0
G1 X9.23880 Y-3.82683 Z4.20000 E47.44370 F1800.0
G1 X9.32984 Y-3.52669 Z4.20000 E47.46013 F1800.0
G1 X9.80785 Y-1.95090 Z4.20000 E47.54640 F1800.0
G1 X9.83860 Y-1.63876 Z4.20000 E47.56283 F1800.0
G1 X10.00000 Y0.00000 Z4.20000 E47.64909 F1800.0
G1 X9.96926 Y0.31214 Z4.20000 E47.66552 F1800.0
G1 X9.80785 Y1.95090 Z4.20000 E47.75178 F1800.0
G1 X9.71680 Y2.25105 Z4.20000 E47.76821 F1800.0
G1 X9.23880 Y3.82683 Z4.20000 E47.85447 F1800.0
G1 X9.09094 Y4.10345 Z4.20000 E47.87090 F1800.0
G1 X8.31470 Y5.55570 Z4.20000 E47.95716 F1800.0
G1 X8.11572 Y5.79816 Z4.20000 E47.97359 F1800.0
G1 X7.07107 Y7.07107 Z4.20000 E48.05986 F1800.0
G1 X6.82861 Y7.27005 Z4.20000 E48.07629 F1800.0
G1 X5.55570 Y8.31470 Z4.20000 E48.16255 F1800.0
G1 X5.27908 Y8.46255 Z4.20000 E48.17898 F1800.0
G1 X3.82683 Y9.23880 Z4.20000 E48.26524 F1800.0
G1 X3.52669 Y9.32984 Z4.20000 E48.28167 F1800.0
G1 X1.95090 Y9.80785 Z4.20000 E48.36793 F1800.0
G1 X1.63876 Y9.83860 Z4.20000 E48.38436 F1800.0
G1 X0.00000 Y10.00000 Z4.20000 E48.47062 F1800.0
G1 X-0.31214 Y9.96926 Z4.20000 E48.48705 F1800.0
G1 X-1.95090 Y9.80785 Z4.20000 E48.57332 F1800.0
G1 X-2.25105 Y9.71680 Z4.20000 E48.58975 F1800.0
G1 X-3.82683 Y9.23880 Z4.20000 E48.67601 F1800.0
G1 X-4.10345 Y9.09094 Z4.20000 E48.69244 F1800.0
G1 X-5.55570 Y8.31470 Z4.20000 E48.77870 F1800.0
G1 X-5.79816 Y8.11572 Z4.20000 E48.79513 F1800.0
G1 X-7.07107 Y7.07107 Z4.20000 E48.88139 F1800.0
G1 X-7.27005 Y6.82861 Z4.20000 E48.89782 F1800.0
G1 X-8.31470 Y5.55570 Z4.20000 E48.98408 F1800.0
G1 X-8.46255 Y5.27908 Z4.20000 E49.00051 F1800.0
G1 X-9.23880 Y3.82683 Z4.20000 E49.08678 F1800.0
G1 X-9.32984 Y3.52669 Z4.20000 E49.10321 F1800.0
G1 X-9.80785 Y1.95090 Z4.20000 E49.18947 F1800.0
G1 X-9.83860 Y1.63876 Z4.20000 E49.20590 F1800.0
G1 X-10.00000 Y0.00000 Z4.20000 E49.29216 F1800.0
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z7.480 F1200

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
G1 Z7.480 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z4.48000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 4.48000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 16/17
; LAYER_CHANGE
M73 P94 R0
G1 X-9.98002 Y-0.20289 Z4.48000 E49.30284 F1800.0
G1 X-9.80785 Y-1.95090 Z4.48000 E49.39485 F1800.0
G1 X-9.74867 Y-2.14600 Z4.48000 E49.40553 F1800.0
G1 X-9.23880 Y-3.82683 Z4.48000 E49.49754 F1800.0
G1 X-9.14269 Y-4.00664 Z4.48000 E49.50822 F1800.0
G1 X-8.31470 Y-5.55570 Z4.48000 E49.60024 F1800.0
G1 X-8.18536 Y-5.71330 Z4.48000 E49.61092 F1800.0
G1 X-7.07107 Y-7.07107 Z4.48000 E49.70293 F1800.0
G1 X-6.91347 Y-7.20041 Z4.48000 E49.71361 F1800.0
G1 X-5.55570 Y-8.31470 Z4.48000 E49.80562 F1800.0
G1 X-5.37590 Y-8.41080 Z4.48000 E49.81630 F1800.0
G1 X-3.82683 Y-9.23880 Z4.48000 E49.90831 F1800.0
G1 X-3.63174 Y-9.29798 Z4.48000 E49.91899 F1800.0
G1 X-1.95090 Y-9.80785 Z4.48000 E50.01100 F1800.0
G1 X-1.74801 Y-9.82784 Z4.48000 E50.02168 F1800.0
G1 X0.00000 Y-10.00000 Z4.48000 E50.11370 F1800.0
G1 X0.20289 Y-9.98002 Z4.48000 E50.12438 F1800.0
G1 X1.95090 Y-9.80785 Z4.48000 E50.21639 F1800.0
G1 X2.14600 Y-9.74867 Z4.48000 E50.22707 F1800.0
G1 X3.82683 Y-9.23880 Z4.48000 E50.31908 F1800.0
G1 X4.00664 Y-9.14269 Z4.48000 E50.32976 F1800.0
G1 X5.55570 Y-8.31470 Z4.48000 E50.42177 F1800.0
G1 X5.71330 Y-8.18536 Z4.48000 E50.43245 F1800.0
G1 X7.07107 Y-7.07107 Z4.48000 E50.52446 F1800.0
G1 X7.20041 Y-6.91347 Z4.48000 E50.53514 F1800.0
G1 X8.31470 Y-5.55570 Z4.48000 E50.62716 F1800.0
G1 X8.41080 Y-5.37590 Z4.48000 E50.63784 F1800.0
G1 X9.23880 Y-3.82683 Z4.48000 E50.72985 F1800.0
G1 X9.29798 Y-3.63174 Z4.48000 E50.74053 F1800.0
G1 X9.80785 Y-1.95090 Z4.48000 E50.83254 F1800.0
G1 X9.82784 Y-1.74801 Z4.48000 E50.84322 F1800.0
G1 X10.00000 Y0.00000 Z4.48000 E50.93523 F1800.0
G1 X9.98002 Y0.20289 Z4.48000 E50.94591 F1800.0
G1 X9.80785 Y1.95090 Z4.48000 E51.03792 F1800.0
G1 X9.74867 Y2.14600 Z4.48000 E51.04860 F1800.0
G1 X9.23880 Y3.82683 Z4.48000 E51.14062 F1800.0
G1 X9.14269 Y4.00664 Z4.48000 E51.15130 F1800.0
G1 X8.31470 Y5.55570 Z4.48000 E51.24331 F1800.0
G1 X8.18536 Y5.71330 Z4.48000 E51.25399 F1800.0
G1 X7.07107 Y7.07107 Z4.48000 E51.34600 F1800.0
G1 X6.91347 Y7.20041 Z4.48000 E51.35668 F1800.0
G1 X5.55570 Y8.31470 Z4.48000 E51.44869 F1800.0
G1 X5.37590 Y8.41080 Z4.48000 E51.45937 F1800.0
G1 X3.82683 Y9.23880 Z4.48000 E51.55138 F1800.0
G1 X3.63174 Y9.29798 Z4.48000 E51.56206 F1800.0
G1 X1.95090 Y9.80785 Z4.48000 E51.65408 F1800.0
G1 X1.74801 Y9.82784 Z4.48000 E51.66476 F1800.0
G1 X0.00000 Y10.00000 Z4.48000 E51.75677 F1800.0
G1 X-0.20289 Y9.98002 Z4.48000 E51.76745 F1800.0
G1 X-1.95090 Y9.80785 Z4.48000 E51.85946 F1800.0
G1 X-2.14600 Y9.74867 Z4.48000 E51.87014 F1800.0
G1 X-3.82683 Y9.23880 Z4.48000 E51.96215 F1800.0
G1 X-4.00664 Y9.14269 Z4.48000 E51.97283 F1800.0
G1 X-5.55570 Y8.31470 Z4.48000 E52.06484 F1800.0
G1 X-5.71330 Y8.18536 Z4.48000 E52.07552 F1800.0
G1 X-7.07107 Y7.07107 Z4.48000 E52.16754 F1800.0
G1 X-7.20041 Y6.91347 Z4.48000 E52.17822 F1800.0
G1 X-8.31470 Y5.55570 Z4.48000 E52.27023 F1800.0
G1 X-8.41080 Y5.37590 Z4.48000 E52.28091 F1800.0
G1 X-9.23880 Y3.82683 Z4.48000 E52.37292 F1800.0
G1 X-9.29798 Y3.63174 Z4.48000 E52.38360 F1800.0
G1 X-9.80785 Y1.95090 Z4.48000 E52.47561 F1800.0
G1 X-9.82784 Y1.74801 Z4.48000 E52.48629 F1800.0
G1 X-10.00000 Y0.00000 Z4.48000 E52.57830 F1800.0
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z7.760 F1200

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
G1 Z7.760 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 X-10.00000 Y0.00000 F30000
G1 Z4.76000 F1200
; CHANGE_LAYER
; Z_HEIGHT: 4.76000
; LAYER_HEIGHT: 0.28000
; layer num/total_layer_count: 17/17
; LAYER_CHANGE
M73 P100 R0
G1 X-9.99078 Y-0.09364 Z4.76000 E52.58323 F1800.0
G1 X-9.80785 Y-1.95090 Z4.76000 E52.68100 F1800.0
G1 X-9.78054 Y-2.04095 Z4.76000 E52.68593 F1800.0
G1 X-9.23880 Y-3.82683 Z4.76000 E52.78369 F1800.0
G1 X-9.19444 Y-3.90982 Z4.76000 E52.78862 F1800.0
G1 X-8.31470 Y-5.55570 Z4.76000 E52.88638 F1800.0
G1 X-8.25500 Y-5.62844 Z4.76000 E52.89131 F1800.0
G1 X-7.07107 Y-7.07107 Z4.76000 E52.98907 F1800.0
G1 X-6.99833 Y-7.13076 Z4.76000 E52.99400 F1800.0
G1 X-5.55570 Y-8.31470 Z4.76000 E53.09176 F1800.0
G1 X-5.47272 Y-8.35905 Z4.76000 E53.09669 F1800.0
G1 X-3.82683 Y-9.23880 Z4.76000 E53.19446 F1800.0
G1 X-3.73679 Y-9.26611 Z4.76000 E53.19938 F1800.0
G1 X-1.95090 Y-9.80785 Z4.76000 E53.29715 F1800.0
G1 X-1.85726 Y-9.81708 Z4.76000 E53.30208 F1800.0
G1 X0.00000 Y-10.00000 Z4.76000 E53.39984 F1800.0
G1 X0.09364 Y-9.99078 Z4.76000 E53.40477 F1800.0
G1 X1.95090 Y-9.80785 Z4.76000 E53.50253 F1800.0
G1 X2.04095 Y-9.78054 Z4.76000 E53.50746 F1800.0
G1 X3.82683 Y-9.23880 Z4.76000 E53.60522 F1800.0
G1 X3.90982 Y-9.19444 Z4.76000 E53.61015 F1800.0
G1 X5.55570 Y-8.31470 Z4.76000 E53.70792 F1800.0
G1 X5.62844 Y-8.25500 Z4.76000 E53.71285 F1800.0
G1 X7.07107 Y-7.07107 Z4.76000 E53.81061 F1800.0
G1 X7.13076 Y-6.99833 Z4.76000 E53.81554 F1800.0
G1 X8.31470 Y-5.55570 Z4.76000 E53.91330 F1800.0
G1 X8.35905 Y-5.47272 Z4.76000 E53.91823 F1800.0
G1 X9.23880 Y-3.82683 Z4.76000 E54.01599 F1800.0
G1 X9.26611 Y-3.73679 Z4.76000 E54.02092 F1800.0
G1 X9.80785 Y-1.95090 Z4.76000 E54.11868 F1800.0
G1 X9.81708 Y-1.85726 Z4.76000 E54.12361 F1800.0
G1 X10.00000 Y0.00000 Z4.76000 E54.22138 F1800.0
G1 X9.99078 Y0.09364 Z4.76000 E54.22630 F1800.0
G1 X9.80785 Y1.95090 Z4.76000 E54.32407 F1800.0
G1 X9.78054 Y2.04095 Z4.76000 E54.32900 F1800.0
G1 X9.23880 Y3.82683 Z4.76000 E54.42676 F1800.0
G1 X9.19444 Y3.90982 Z4.76000 E54.43169 F1800.0
G1 X8.31470 Y5.55570 Z4.76000 E54.52945 F1800.0
G1 X8.25500 Y5.62844 Z4.76000 E54.53438 F1800.0
G1 X7.07107 Y7.07107 Z4.76000 E54.63214 F1800.0
G1 X6.99833 Y7.13076 Z4.76000 E54.63707 F1800.0
G1 X5.55570 Y8.31470 Z4.76000 E54.73484 F1800.0
G1 X5.47272 Y8.35905 Z4.76000 E54.73976 F1800.0
G1 X3.82683 Y9.23880 Z4.76000 E54.83753 F1800.0
G1 X3.73679 Y9.26611 Z4.76000 E54.84246 F1800.0
G1 X1.95090 Y9.80785 Z4.76000 E54.94022 F1800.0
G1 X1.85726 Y9.81708 Z4.76000 E54.94515 F1800.0
G1 X0.00000 Y10.00000 Z4.76000 E55.04291 F1800.0
G1 X-0.09364 Y9.99078 Z4.76000 E55.04784 F1800.0
G1 X-1.95090 Y9.80785 Z4.76000 E55.14560 F1800.0
G1 X-2.04095 Y9.78054 Z4.76000 E55.15053 F1800.0
G1 X-3.82683 Y9.23880 Z4.76000 E55.24830 F1800.0
G1 X-3.90982 Y9.19444 Z4.76000 E55.25322 F1800.0
G1 X-5.55570 Y8.31470 Z4.76000 E55.35099 F1800.0
G1 X-5.62844 Y8.25500 Z4.76000 E55.35592 F1800.0
G1 X-7.07107 Y7.07107 Z4.76000 E55.45368 F1800.0
G1 X-7.13076 Y6.99833 Z4.76000 E55.45861 F1800.0
G1 X-8.31470 Y5.55570 Z4.76000 E55.55637 F1800.0
G1 X-8.35905 Y5.47272 Z4.76000 E55.56130 F1800.0
G1 X-9.23880 Y3.82683 Z4.76000 E55.65906 F1800.0
G1 X-9.26611 Y3.73679 Z4.76000 E55.66399 F1800.0
G1 X-9.80785 Y1.95090 Z4.76000 E55.76176 F1800.0
G1 X-9.81708 Y1.85726 Z4.76000 E55.76668 F1800.0
G1 X-10.00000 Y0.00000 Z4.76000 E55.86445 F1800.0
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
