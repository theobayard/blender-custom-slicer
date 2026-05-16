; HEADER_BLOCK_START
; BambuStudio 02.05.00.66
; model printing time: 16m 53s; total estimated time: 25m 13s
; total layer number: 72
; total filament length [mm] : 685.87,867.26
; total filament volume [cm^3] : 1649.71,2086.01
; total filament weight [g] : 2.05,2.59
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
; enable_prime_tower = 1
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
; flush_volumes_matrix = 0,90,90,0
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
; independent_support_layer_height = 0
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
; wipe_tower_x = 212.875
; wipe_tower_y = 214.698
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
M73 P0 R25
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
M73 P6 R23
G1 E50 F200
M400
M104 S220
G92 E0
M73 P23 R19
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P24 R19
G1 E-0.5 F300

M73 P25 R18
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
M73 P26 R18
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
    G29 A X98.4454 Y129.653 I139.206 J110.053
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
M73 P27 R18
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
M73 P28 R18
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
    G1 X160.000 E0.31181 F1200
    G1 X165.000 E0.31181 F4800
    G1 X170.000 E0.31181 F1200
M73 P28 R17
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
M73 P29 R17
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
M204 S10000
G1 Z.2 F30000
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 1/72
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
G1 E-.8 F1800
M204 S6000
G1 Z.6 F30000
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

M204 S6000
G1 X231.902 Y231.474
G1 Z.2
G1 E.8 F1800
; LAYER_HEIGHT: 0.200000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S500
G1  X215.402 Y231.474  E0.6271 F3000
G1  Y215.224  E0.6176
G1  X231.902  E0.6271
G1  Y231.474  E0.6176
M204 S6000
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #2
M204 S500
G1  Y215.724  E0.0190
G1  X231.402  E0.5701
G1  Y216.232  E0.0193
G1  X215.902  E0.5891
M73 P30 R17
G1  Y216.741  E0.0193
G1  X231.402  E0.5891
G1  Y217.249  E0.0193
G1  X215.902  E0.5891
G1  Y217.757  E0.0193
G1  X231.402  E0.5891
G1  Y218.266  E0.0193
G1  X215.902  E0.5891
G1  Y218.774  E0.0193
G1  X231.402  E0.5891
G1  Y219.282  E0.0193
G1  X215.902  E0.5891
G1  Y219.791  E0.0193
G1  X231.402  E0.5891
G1  Y220.299  E0.0193
G1  X215.902  E0.5891
G1  Y220.807  E0.0193
G1  X231.402  E0.5891
G1  Y221.316  E0.0193
G1  X215.902  E0.5891
G1  Y221.824  E0.0193
G1  X231.402  E0.5891
G1  Y222.332  E0.0193
G1  X215.902  E0.5891
G1  Y222.841  E0.0193
G1  X231.402  E0.5891
G1  Y223.349  E0.0193
G1  X215.902  E0.5891
G1  Y223.857  E0.0193
G1  X231.402  E0.5891
G1  Y224.366  E0.0193
G1  X215.902  E0.5891
G1  Y224.874  E0.0193
G1  X231.402  E0.5891
G1  Y225.382  E0.0193
G1  X215.902  E0.5891
M73 P32 R17
G1  Y225.891  E0.0193
G1  X231.402  E0.5891
G1  Y226.399  E0.0193
G1  X215.902  E0.5891
G1  Y226.907  E0.0193
G1  X231.402  E0.5891
G1  Y227.416  E0.0193
G1  X215.902  E0.5891
G1  Y227.924  E0.0193
G1  X231.402  E0.5891
G1  Y228.432  E0.0193
G1  X215.902  E0.5891
G1  Y228.941  E0.0193
G1  X231.402  E0.5891
G1  Y229.449  E0.0193
G1  X215.902  E0.5891
G1  Y229.957  E0.0193
G1  X231.402  E0.5891
G1  Y230.466  E0.0193
G1  X215.902  E0.5891
G1  Y230.974  E0.0193
G1  X231.402  E0.5891
G1  Y231.474  E0.0190
; CP EMPTY GRID END
;------------------






M204 S6000
G1  X232.402 Y232.474  
M204 S500
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1199
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1124
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2028
G2  X218.463 Y234.356   I1.244 J7.183 E0.1619
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.0840
G1  X214.902 Y232.474   E0.0807
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1190
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1157
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2054
G2  X213.058 Y218.417   I-5.717 J0.475 E0.1626
M73 P32 R16
G3  X213.429 Y216.176   I1.759 J-0.860 E0.0921
G3  X216.639 Y213.044   I18.772 J16.028 E0.1707
G3  X219.738 Y213.852   I1.088 J2.175 E0.1329
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1081
G2  X227.420 Y213.954   I1.255 J-8.586 E0.1960
G3  X229.706 Y212.698   I2.651 J2.117 E0.1018
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0504
G1  X232.402 Y214.724   E0.0807
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1190
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1157
G2  X232.406 Y225.028   I8.340 J3.921 E0.2054
G2  X234.246 Y228.781   I5.717 J-0.475 E0.1626
G3  X233.875 Y231.022   I-1.759 J0.860 E0.0921
G1  X232.402 Y232.474   E0.0786
M204 S6000
G1  X234.202 Y231.341  
M204 S500
G3  X230.932 Y234.526   I-18.953 J-16.193 E0.1737
M73 P33 R16
G3  X227.295 Y233.715   I-1.390 J-2.327 E0.1561
G2  X224.903 Y232.931   I-2.408 J3.310 E0.0972
G2  X220.140 Y233.622   I-1.251 J8.136 E0.1856
G3  X216.686 Y234.715   I-2.480 J-1.836 E0.1471
G3  X216.099 Y234.296   I1.499 J-2.722 E0.0275
G3  X212.863 Y231.064   I15.957 J-19.217 E0.1740
G3  X213.647 Y227.326   I2.364 J-1.456 E0.1601
G2  X214.445 Y224.840   I-3.521 J-2.502 E0.1008
G2  X213.740 Y220.009   I-8.407 J-1.241 E0.1882
G3  X212.519 Y216.797   I2.010 J-2.603 E0.1374
G3  X213.102 Y215.857   I2.519 J0.911 E0.0424
G3  X216.372 Y212.672   I18.948 J16.188 E0.1737
G3  X220.009 Y213.483   I1.390 J2.327 E0.1561
G2  X222.402 Y214.267   I2.409 J-3.310 E0.0973
G2  X227.164 Y213.576   I1.250 J-8.136 E0.1856
G3  X229.739 Y212.242   I2.696 J2.053 E0.1139
G3  X231.205 Y212.902   I-0.178 J2.354 E0.0624
G3  X234.441 Y216.134   I-15.957 J19.216 E0.1740
G3  X233.657 Y219.872   I-2.364 J1.456 E0.1601
G2  X232.859 Y222.357   I3.521 J2.502 E0.1008
G2  X233.564 Y227.189   I8.406 J1.242 E0.1882
G3  X234.785 Y230.401   I-2.010 J2.603 E0.1374
G3  X234.202 Y231.341   I-2.519 J-0.912 E0.0424
M204 S6000
G1  X234.529 Y231.660  
M204 S500
G3  X231.198 Y234.898   I-19.171 J-16.397 E0.1768
G3  X226.908 Y234.001   I-1.644 J-2.845 E0.1823
G2  X224.898 Y233.388   I-2.007 J2.979 E0.0811
G2  X220.514 Y233.924   I-1.246 J7.999 E0.1700
G3  X217.314 Y235.388   I-3.222 J-2.815 E0.1378
G3  X215.784 Y234.627   I0.500 J-2.926 E0.0659
G3  X212.495 Y231.336   I16.165 J-19.445 E0.1771
G3  X213.275 Y227.059   I2.575 J-1.740 E0.1830
G2  X213.988 Y222.362   I-6.968 J-3.460 E0.1835
G2  X212.240 Y218.826   I-6.214 J0.872 E0.1525
G3  X212.775 Y215.538   I2.590 J-1.267 E0.1350
G3  X216.106 Y212.300   I19.171 J16.396 E0.1768
G3  X220.396 Y213.197   I1.644 J2.845 E0.1823
G2  X222.406 Y213.810   I2.007 J-2.978 E0.0811
G2  X226.790 Y213.274   I1.246 J-8.000 E0.1700
G3  X229.772 Y211.786   I3.207 J2.695 E0.1303
G3  X231.520 Y212.571   I-0.213 J2.813 E0.0743
G3  X234.809 Y215.862   I-16.164 J19.444 E0.1771
G3  X234.029 Y220.139   I-2.575 J1.740 E0.1830
G2  X233.316 Y224.837   I6.968 J3.460 E0.1835
G2  X235.064 Y228.372   I6.215 J-0.873 E0.1525
G3  X234.529 Y231.660   I-2.590 J1.267 E0.1350
M204 S6000
G1  X234.856 Y231.980  
M204 S500
G3  X231.464 Y235.269   I-19.423 J-16.635 E0.1799
G3  X226.653 Y234.380   I-1.933 J-3.000 E0.2049
G2  X224.894 Y233.845   I-1.751 J2.599 E0.0709
G2  X220.862 Y234.250   I-1.242 J7.916 E0.1557
G3  X217.500 Y235.868   I-3.653 J-3.287 E0.1455
G3  X215.470 Y234.959   I0.247 J-3.273 E0.0862
G3  X212.126 Y231.607   I16.396 J-19.697 E0.1802
G3  X212.977 Y226.685   I3.099 J-1.999 E0.2086
G2  X213.531 Y224.832   I-2.804 J-1.847 E0.0746
G2  X213.047 Y220.622   I-7.828 J-1.233 E0.1630
G3  X211.742 Y216.266   I2.674 J-3.175 E0.1829
G3  X212.447 Y215.218   I3.139 J1.353 E0.0483
G3  X215.840 Y211.929   I19.420 J16.631 E0.1799
G3  X220.651 Y212.818   I1.933 J3.000 E0.2049
G2  X222.411 Y213.353   I1.751 J-2.599 E0.0709
G2  X226.442 Y212.948   I1.241 J-7.918 E0.1557
G3  X229.804 Y211.330   I3.653 J3.287 E0.1455
G3  X231.834 Y212.239   I-0.247 J3.273 E0.0862
G3  X235.178 Y215.591   I-16.392 J19.693 E0.1802
G3  X234.327 Y220.513   I-3.099 J1.999 E0.2086
G2  X233.773 Y222.366   I2.804 J1.847 E0.0746
G2  X234.257 Y226.576   I7.827 J1.233 E0.1630
G3  X235.562 Y230.932   I-2.674 J3.175 E0.1829
G3  X234.856 Y231.980   I-3.139 J-1.353 E0.0483
M204 S6000
G1  X235.184 Y232.299  
M204 S500
M73 P34 R16
G3  X231.730 Y235.641   I-19.694 J-16.891 E0.1829
G3  X226.308 Y234.702   I-2.191 J-3.473 E0.2292
G2  X224.889 Y234.302   I-1.418 J2.319 E0.0567
G2  X221.180 Y234.598   I-1.237 J7.905 E0.1427
G3  X218.049 Y236.321   I-4.519 J-4.506 E0.1377
G3  X215.155 Y235.291   I-0.307 J-3.717 E0.1203
G3  X211.758 Y231.879   I16.654 J-19.976 E0.1833
G3  X212.656 Y226.339   I3.602 J-2.259 E0.2330
G2  X213.074 Y224.827   I-2.528 J-1.512 E0.0603
G2  X212.712 Y220.956   I-7.752 J-1.228 E0.1493
G3  X211.075 Y216.937   I3.432 J-3.741 E0.1704
G3  X212.120 Y214.899   I3.929 J0.729 E0.0883
G3  X215.574 Y211.557   I19.690 J16.887 E0.1829
G3  X220.996 Y212.497   I2.191 J3.473 E0.2292
G2  X222.415 Y212.896   I1.418 J-2.319 E0.0567
G2  X226.125 Y212.600   I1.237 J-7.904 E0.1427
G3  X229.255 Y210.877   I4.518 J4.504 E0.1377
G3  X229.837 Y210.873   I0.317 J3.701 E0.0221
G3  X232.149 Y211.907   I-0.282 J3.732 E0.0982
G3  X235.546 Y215.319   I-16.649 J19.972 E0.1833
G3  X234.648 Y220.859   I-3.602 J2.259 E0.2330
G2  X234.230 Y222.370   I2.527 J1.512 E0.0603
G2  X234.592 Y226.242   I7.751 J1.229 E0.1493
G3  X236.229 Y230.261   I-3.432 J3.741 E0.1704
G3  X235.184 Y232.299   I-3.929 J-0.729 E0.0883
M204 S6000
G1  X235.511 Y232.618  
M204 S500
G3  X231.997 Y236.013   I-19.980 J-17.164 E0.1860
G3  X225.992 Y235.046   I-2.443 J-3.956 E0.2520
G2  X224.885 Y234.759   I-1.092 J1.937 E0.0440
G2  X221.467 Y234.966   I-1.233 J7.985 E0.1311
G3  X217.761 Y236.791   I-4.649 J-4.763 E0.1596
G3  X214.841 Y235.623   I0.035 J-4.321 E0.1224
G3  X211.390 Y232.150   I16.920 J-20.264 E0.1863
G3  X212.265 Y226.102   I3.727 J-2.548 E0.2551
G2  X212.617 Y224.823   I-2.129 J-1.273 E0.0510
G2  X212.357 Y221.262   I-7.754 J-1.224 E0.1369
G3  X210.577 Y217.853   I4.786 J-4.667 E0.1482
G3  X211.793 Y214.580   I4.234 J-0.290 E0.1368
G3  X215.307 Y211.185   I19.977 J17.161 E0.1860
G3  X221.312 Y212.152   I2.443 J3.956 E0.2520
G2  X222.420 Y212.439   I1.092 J-1.936 E0.0440
G2  X225.837 Y212.232   I1.232 J-7.988 E0.1311
G3  X229.543 Y210.407   I4.650 J4.764 E0.1597
G1  X229.870 Y210.417   E0.0124
G3  X232.463 Y211.575   I-0.316 J4.191 E0.1101
G3  X235.914 Y215.048   I-16.919 J20.263 E0.1863
G3  X235.039 Y221.096   I-3.727 J2.548 E0.2551
G2  X234.687 Y222.374   I2.128 J1.273 E0.0510
G2  X234.947 Y225.936   I7.753 J1.225 E0.1369
G3  X236.727 Y229.345   I-4.786 J4.667 E0.1482
G3  X235.511 Y232.618   I-4.234 J0.290 E0.1367
M204 S6000
G1  X235.838 Y232.937  
M204 S500
G3  X232.263 Y236.385   I-20.276 J-17.446 E0.1891
G3  X225.706 Y235.411   I-2.709 J-4.321 E0.2743
G2  X224.880 Y235.216   I-0.814 J1.610 E0.0325
G2  X221.660 Y235.380   I-1.228 J7.589 E0.1235
G3  X217.041 Y237.197   I-4.231 J-3.977 E0.1949
G3  X214.526 Y235.955   I0.827 J-4.839 E0.1081
G3  X211.022 Y232.422   I17.198 J-20.564 E0.1894
G3  X211.912 Y225.799   I4.171 J-2.811 E0.2778
G2  X212.160 Y224.819   I-1.742 J-0.961 E0.0388
G2  X211.981 Y221.536   I-7.856 J-1.220 E0.1258
G3  X210.109 Y217.518   I5.021 J-4.785 E0.1715
G3  X211.466 Y214.261   I4.851 J0.108 E0.1373
G3  X215.041 Y210.813   I20.275 J17.446 E0.1891
G3  X221.598 Y211.787   I2.709 J4.321 E0.2743
G2  X222.424 Y211.982   I0.814 J-1.610 E0.0326
G2  X225.644 Y211.818   I1.228 J-7.593 E0.1234
G3  X229.902 Y209.961   I4.312 J4.076 E0.1814
G3  X232.778 Y211.243   I-0.351 J4.651 E0.1221
G3  X236.282 Y214.776   I-17.194 J20.560 E0.1894
G3  X235.392 Y221.399   I-4.171 J2.811 E0.2778
G2  X235.144 Y222.379   I1.742 J0.960 E0.0388
G2  X235.323 Y225.662   I7.849 J1.220 E0.1259
G3  X237.195 Y229.679   I-5.018 J4.783 E0.1715
G3  X235.838 Y232.937   I-4.851 J-0.108 E0.1373
M204 S6000
G1  X236.166 Y233.256  
M204 S500
G3  X232.529 Y236.757   I-20.575 J-17.732 E0.1921
G3  X225.451 Y235.795   I-2.976 J-4.623 E0.2955
G2  X224.876 Y235.673   I-0.552 J1.195 E0.0225
G2  X221.899 Y235.774   I-1.224 J7.867 E0.1139
G3  X215.458 Y237.169   I-4.224 J-3.937 E0.2666
G3  X214.212 Y236.286   I3.272 J-5.940 E0.0582
G3  X210.654 Y232.693   I17.480 J-20.867 E0.1925
G3  X211.565 Y225.472   I4.679 J-3.077 E0.3011
G2  X211.383 Y221.425   I-6.644 J-1.729 E0.1563
G3  X211.138 Y213.942   I3.494 J-3.860 E0.3176
G3  X214.775 Y210.441   I20.574 J17.731 E0.1921
G3  X221.853 Y211.403   I2.976 J4.624 E0.2955
G2  X222.429 Y211.525   I0.552 J-1.195 E0.0225
G2  X225.404 Y211.424   I1.223 J-7.879 E0.1138
G3  X229.935 Y209.504   I4.397 J4.072 E0.1927
G3  X233.092 Y210.912   I-0.385 J5.110 E0.1340
G3  X236.650 Y214.505   I-17.474 J20.861 E0.1925
G3  X235.738 Y221.726   I-4.680 J3.077 E0.3011
G2  X235.921 Y225.773   I6.645 J1.728 E0.1563
G3  X236.166 Y233.256   I-3.494 J3.860 E0.3176
; WIPE_TOWER_END

; WIPE_START
G1 F24000
M204 S500
G1 X236.398 Y233.008 E-.12931
G1 X236.65 Y232.693 E-.15323
G1 X236.876 Y232.359 E-.15315
G1 X237.075 Y232.009 E-.15315
G1 X237.247 Y231.644 E-.15325
G1 X237.264 Y231.6 E-.01792
; WIPE_END
G1 E-.04 F1800
M204 S6000
G17
G3 Z.6 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S6000
G1 X107.588 Y136.796
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
; LAYER_HEIGHT: 0.2
G1 F3000
M204 S500
G1 X99.302 Y136.796 E.30862
G1 X99.302 Y128.51 E.30862
G1 X107.588 Y128.51 E.30862
G1 X107.588 Y136.736 E.30638
M204 S6000
G1 X108.045 Y137.253 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X98.845 Y137.253 E.34267
G1 X98.845 Y128.053 E.34267
G1 X108.045 Y128.053 E.34267
G1 X108.045 Y137.193 E.34043
; WIPE_START
G1 X106.045 Y137.206 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X106.413 Y129.583 Z.6 F30000
G1 X106.455 Y128.693 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51231
G1 F6300
M204 S500
G1 X107.2 Y129.437 E.04027
G1 X107.2 Y130.101 E.02539
G1 X105.997 Y128.899 E.06505
G1 X105.333 Y128.899 E.02539
G1 X107.2 Y130.765 E.10096
G1 X107.2 Y131.429 E.02539
G1 X104.67 Y128.899 E.13686
G1 X104.006 Y128.899 E.02539
G1 X107.2 Y132.093 E.17277
G1 X107.2 Y132.757 E.02539
G1 X103.342 Y128.899 E.20868
G1 X102.678 Y128.899 E.02539
G1 X107.2 Y133.42 E.24459
G1 X107.2 Y134.084 E.02539
G1 X102.014 Y128.899 E.28049
G1 X101.351 Y128.899 E.02539
G1 X107.2 Y134.748 E.3164
G1 X107.2 Y135.412 E.02539
G1 X100.687 Y128.899 E.35231
G1 X100.023 Y128.899 E.02539
G1 X107.2 Y136.076 E.38822
G1 X107.2 Y136.408 E.0127
G1 X106.868 Y136.408 E.01269
G1 X99.691 Y129.231 E.38822
G1 X99.691 Y129.894 E.02539
G1 X106.204 Y136.408 E.35232
G1 X105.54 Y136.408 E.02539
G1 X99.691 Y130.558 E.31641
G1 X99.691 Y131.222 E.02539
G1 X104.876 Y136.408 E.2805
G1 X104.213 Y136.408 E.02539
G1 X99.691 Y131.886 E.24459
G1 X99.691 Y132.55 E.02539
G1 X103.549 Y136.408 E.20868
G1 X102.885 Y136.408 E.02539
G1 X99.691 Y133.214 E.17278
G1 X99.691 Y133.877 E.02539
G1 X102.221 Y136.408 E.13687
G1 X101.557 Y136.408 E.02539
G1 X99.691 Y134.541 E.10096
G1 X99.691 Y135.205 E.02539
G1 X100.894 Y136.408 E.06505
G1 X100.23 Y136.408 E.02539
G1 X99.485 Y135.663 E.04027
; CHANGE_LAYER
; Z_HEIGHT: 0.48
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6300
G1 X100.23 Y136.408 E-.4001
G1 X100.894 Y136.408 E-.25225
G1 X100.693 Y136.207 E-.10765
; WIPE_END
M73 P35 R16
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

M204 S10000
G1 X231.902 Y231.474
G1 Z.48
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #3
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
G1  X234.190 Y231.329  
G3  X230.922 Y234.512   I-18.950 J-16.191 E0.2339
G3  X227.305 Y233.701   I-1.380 J-2.315 E0.2093
G2  X224.903 Y232.914   I-2.419 J3.324 E0.1316
G2  X220.130 Y233.608   I-1.251 J8.152 E0.2507
G3  X216.860 Y234.775   I-2.510 J-1.870 E0.1885
G3  X216.110 Y234.283   I0.921 J-2.222 E0.0462
G3  X212.876 Y231.054   I15.959 J-19.217 E0.2344
G3  X213.660 Y227.336   I2.353 J-1.446 E0.2146
G2  X214.462 Y224.840   I-3.536 J-2.512 E0.1364
G2  X213.755 Y219.999   I-8.424 J-1.241 E0.2541
G3  X212.483 Y216.982   I2.059 J-2.644 E0.1752
G3  X213.114 Y215.869   I2.342 J0.593 E0.0663
G3  X216.382 Y212.686   I18.950 J16.191 E0.2339
G3  X219.999 Y213.497   I1.380 J2.315 E0.2093
G2  X222.401 Y214.284   I2.419 J-3.324 E0.1316
G2  X227.174 Y213.590   I1.251 J-8.153 E0.2507
G3  X229.738 Y212.259   I2.687 J2.043 E0.1528
G3  X231.194 Y212.915   I-0.177 J2.337 E0.0834
G3  X234.427 Y216.144   I-15.953 J19.212 E0.2344
G3  X233.644 Y219.862   I-2.353 J1.446 E0.2146
G2  X232.842 Y222.357   I3.535 J2.512 E0.1363
G2  X233.549 Y227.199   I8.423 J1.242 E0.2541
G3  X234.821 Y230.216   I-2.059 J2.644 E0.1752
G3  X234.190 Y231.329   I-2.342 J-0.593 E0.0663
G1  X234.505 Y231.636  
G3  X231.178 Y234.870   I-19.166 J-16.393 E0.2379
G3  X227.044 Y234.055   I-1.650 J-2.521 E0.2389
G2  X224.899 Y233.354   I-2.156 J2.964 E0.1175
G2  X220.496 Y233.895   I-1.247 J8.032 E0.2301
G3  X217.319 Y235.354   I-3.207 J-2.795 E0.1845
G3  X215.808 Y234.602   I0.494 J-2.890 E0.0877
G3  X212.522 Y231.316   I16.148 J-19.427 E0.2383
G3  X213.303 Y227.079   I2.551 J-1.720 E0.2444
G2  X214.022 Y222.362   I-6.997 J-3.480 E0.2483
G2  X212.271 Y218.811   I-6.230 J0.865 E0.2063
G3  X212.799 Y215.562   I2.559 J-1.251 E0.1797
G3  X216.126 Y212.328   I19.162 J16.389 E0.2379
G3  X220.260 Y213.143   I1.650 J2.521 E0.2389
G2  X222.405 Y213.844   I2.156 J-2.964 E0.1175
G2  X226.928 Y213.225   I1.247 J-7.721 E0.2372
G3  X229.769 Y211.820   I2.905 J2.299 E0.1677
G3  X231.496 Y212.596   I-0.210 J2.779 E0.0989
G3  X234.782 Y215.882   I-16.147 J19.426 E0.2383
G3  X234.001 Y220.119   I-2.551 J1.720 E0.2444
G2  X233.282 Y224.836   I6.996 J3.480 E0.2483
G2  X235.033 Y228.387   I6.231 J-0.866 E0.2063
G3  X234.505 Y231.636   I-2.559 J1.251 E0.1797
G1  X234.820 Y231.944  
G3  X231.434 Y235.228   I-19.409 J-16.622 E0.2419
G3  X226.681 Y234.338   I-1.905 J-2.964 E0.2729
G2  X224.895 Y233.794   I-1.780 J2.642 E0.0971
G2  X220.836 Y234.205   I-1.243 J7.964 E0.2112
G3  X217.503 Y235.817   I-3.732 J-3.466 E0.1940
G3  X215.505 Y234.922   I0.243 J-3.221 E0.1144
G3  X212.168 Y231.577   I16.375 J-19.674 E0.2423
G3  X213.020 Y226.714   I3.065 J-1.969 E0.2778
G2  X213.582 Y222.367   I-7.002 J-3.115 E0.2276
G2  X212.000 Y219.232   I-4.568 J0.338 E0.1846
G3  X212.484 Y215.254   I2.795 J-1.678 E0.2210
G3  X215.870 Y211.970   I19.405 J16.618 E0.2419
G3  X220.623 Y212.861   I1.905 J2.964 E0.2729
G2  X222.410 Y213.404   I1.780 J-2.641 E0.0971
G2  X226.468 Y212.993   I1.242 J-7.965 E0.2112
G3  X229.801 Y211.381   I3.732 J3.466 E0.1940
G3  X231.799 Y212.276   I-0.243 J3.221 E0.1144
G3  X235.136 Y215.621   I-16.370 J19.669 E0.2423
G3  X234.284 Y220.484   I-3.065 J1.969 E0.2778
G2  X233.722 Y224.832   I7.001 J3.115 E0.2277
G2  X235.304 Y227.966   I4.569 J-0.339 E0.1845
G3  X234.820 Y231.944   I-2.795 J1.678 E0.2210
G1  X235.135 Y232.251  
G3  X231.690 Y235.586   I-19.662 J-16.862 E0.2459
G3  X226.344 Y234.643   I-2.136 J-3.518 E0.3036
G2  X224.891 Y234.234   I-1.454 J2.378 E0.0783
G2  X221.148 Y234.537   I-1.239 J7.966 E0.1941
G3  X218.043 Y236.252   I-4.505 J-4.487 E0.1841
G3  X215.202 Y235.241   I-0.301 J-3.649 E0.1591
G3  X211.814 Y231.838   I16.615 J-19.934 E0.2463
G3  X212.715 Y226.374   I3.560 J-2.219 E0.3097
G2  X213.142 Y224.827   I-2.587 J-1.548 E0.0832
G2  X212.772 Y220.923   I-7.824 J-1.228 E0.2029
G3  X211.142 Y216.948   I3.394 J-3.713 E0.2273
G3  X212.169 Y214.947   I3.857 J0.716 E0.1168
G3  X215.614 Y211.612   I19.662 J16.862 E0.2459
G3  X220.960 Y212.555   I2.136 J3.518 E0.3036
G2  X222.414 Y212.964   I1.454 J-2.378 E0.0783
G2  X226.156 Y212.661   I1.238 J-7.969 E0.1940
G3  X229.261 Y210.946   I4.506 J4.488 E0.1841
G3  X229.832 Y210.942   I0.311 J3.629 E0.0293
G3  X232.102 Y211.957   I-0.277 J3.663 E0.1299
G3  X235.490 Y215.360   I-16.611 J19.930 E0.2463
G3  X234.589 Y220.824   I-3.560 J2.219 E0.3097
G2  X234.162 Y222.371   I2.587 J1.548 E0.0832
G2  X234.532 Y226.275   I7.823 J1.228 E0.2029
G3  X236.162 Y230.250   I-3.394 J3.713 E0.2273
G3  X235.135 Y232.251   I-3.857 J-0.716 E0.1168
G1  X235.450 Y232.558  
G3  X231.947 Y235.944   I-19.935 J-17.121 E0.2498
G3  X226.034 Y234.971   I-2.393 J-3.908 E0.3344
G2  X224.886 Y234.674   I-1.134 J2.011 E0.0614
G2  X221.431 Y234.888   I-1.234 J8.058 E0.1787
G3  X217.761 Y236.706   I-4.636 J-4.748 E0.2132
G3  X214.900 Y235.560   I0.035 J-4.232 E0.1615
G3  X211.459 Y232.099   I16.867 J-20.207 E0.2503
G3  X212.338 Y226.146   I3.670 J-2.499 E0.3386
G2  X212.702 Y224.822   I-2.203 J-1.318 E0.0712
G2  X212.433 Y221.223   I-7.840 J-1.223 E0.1865
G3  X210.663 Y217.847   I4.765 J-4.650 E0.1980
G3  X211.854 Y214.640   I4.148 J-0.284 E0.1805
G3  X215.357 Y211.254   I19.932 J17.118 E0.2498
G3  X221.269 Y212.227   I2.393 J3.907 E0.3344
G2  X222.418 Y212.524   I1.134 J-2.011 E0.0615
G2  X225.873 Y212.310   I1.234 J-8.060 E0.1786
G3  X229.543 Y210.492   I4.636 J4.747 E0.2132
G1  X229.864 Y210.503   E0.0164
G3  X232.404 Y211.638   I-0.310 J4.105 E0.1454
G3  X235.845 Y215.099   I-16.866 J20.207 E0.2503
G3  X234.965 Y221.052   I-3.671 J2.499 E0.3386
G2  X234.602 Y222.375   I2.204 J1.318 E0.0711
G2  X234.871 Y225.975   I7.838 J1.224 E0.1865
G3  X236.641 Y229.351   I-4.765 J4.650 E0.1980
G3  X235.450 Y232.558   I-4.148 J0.284 E0.1805
; WIPE_TOWER_END

; WIPE_START
G1 F6300
G1 X235.642 Y232.353 E-.1069
G1 X235.844 Y232.099 E-.12334
G1 X236.027 Y231.831 E-.12331
G1 X236.187 Y231.549 E-.12332
G1 X236.325 Y231.255 E-.12336
G1 X236.44 Y230.951 E-.12329
G1 X236.466 Y230.859 E-.03647
; WIPE_END
G1 E-.04 F1800
G17
G3 Z.88 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F6594.904
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
M73 P36 R16
G1 E-.04 F1800
G1 X106.962 Y136.912 Z.88 F30000
G1 Z.48
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.426609
G1 F7015.794
G1 X107.542 Y136.332 E.03428
G1 X107.542 Y135.814 E.02167
G1 X106.606 Y136.75 E.05535
G1 X106.087 Y136.75 E.02167
G1 X107.542 Y135.295 E.086
G1 X107.542 Y134.777 E.02167
G1 X105.569 Y136.75 E.11665
G1 X105.051 Y136.75 E.02167
G1 X107.542 Y134.259 E.1473
G1 X107.542 Y133.74 E.02167
G1 X104.532 Y136.75 E.17795
G1 X104.014 Y136.75 E.02167
G1 X107.542 Y133.222 E.2086
G1 X107.542 Y132.704 E.02167
G1 X103.496 Y136.75 E.23926
G1 X102.977 Y136.75 E.02167
G1 X107.542 Y132.185 E.26991
G1 X107.542 Y131.667 E.02167
G1 X102.459 Y136.75 E.30056
G1 X101.941 Y136.75 E.02167
G1 X107.542 Y131.149 E.33121
G1 X107.542 Y130.63 E.02167
G1 X101.422 Y136.75 E.36186
G1 X100.904 Y136.75 E.02167
G1 X107.542 Y130.112 E.39251
G1 X107.542 Y129.594 E.02167
G1 X100.386 Y136.75 E.42316
G1 X99.867 Y136.75 E.02167
G1 X107.542 Y129.075 E.45381
G1 X107.542 Y128.557 E.02167
G1 X99.349 Y136.75 E.48447
G1 X99.349 Y136.231 E.02167
G1 X107.024 Y128.557 E.45383
G1 X106.505 Y128.557 E.02167
G1 X99.349 Y135.713 E.42317
G1 X99.349 Y135.195 E.02167
G1 X105.987 Y128.557 E.39252
G1 X105.469 Y128.557 E.02167
G1 X99.349 Y134.676 E.36187
G1 X99.349 Y134.158 E.02167
G1 X104.95 Y128.557 E.33122
G1 X104.432 Y128.557 E.02167
G1 X99.349 Y133.64 E.30057
G1 X99.349 Y133.121 E.02167
G1 X103.914 Y128.557 E.26992
G1 X103.395 Y128.557 E.02167
G1 X99.349 Y132.603 E.23927
G1 X99.349 Y132.085 E.02167
G1 X102.877 Y128.557 E.20862
G1 X102.359 Y128.557 E.02167
G1 X99.349 Y131.566 E.17797
G1 X99.349 Y131.048 E.02167
G1 X101.84 Y128.557 E.14732
G1 X101.322 Y128.557 E.02167
G1 X99.349 Y130.53 E.11667
G1 X99.349 Y130.011 E.02167
G1 X100.804 Y128.557 E.08601
G1 X100.285 Y128.557 E.02167
G1 X99.349 Y129.493 E.05536
G1 X99.349 Y128.975 E.02167
G1 X99.929 Y128.395 E.03429
; CHANGE_LAYER
; Z_HEIGHT: 0.76
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F7015.794
G1 X99.349 Y128.975 E-.31162
G1 X99.349 Y129.493 E-.19697
G1 X99.817 Y129.025 E-.25141
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

M204 S10000
G1 X231.902 Y231.474
G1 Z.76
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #4
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
G1  X234.190 Y231.329  
G3  X230.922 Y234.512   I-18.950 J-16.191 E0.2339
G3  X227.305 Y233.701   I-1.380 J-2.315 E0.2093
G2  X224.903 Y232.914   I-2.419 J3.324 E0.1316
G2  X220.130 Y233.608   I-1.251 J8.152 E0.2507
G3  X216.860 Y234.775   I-2.510 J-1.870 E0.1885
G3  X216.110 Y234.283   I0.921 J-2.222 E0.0462
G3  X212.876 Y231.054   I15.959 J-19.217 E0.2344
G3  X213.660 Y227.336   I2.353 J-1.446 E0.2146
G2  X214.462 Y224.840   I-3.536 J-2.512 E0.1364
G2  X213.755 Y219.999   I-8.424 J-1.241 E0.2541
G3  X212.483 Y216.982   I2.059 J-2.644 E0.1752
G3  X213.114 Y215.869   I2.342 J0.593 E0.0663
G3  X216.382 Y212.686   I18.950 J16.191 E0.2339
G3  X219.999 Y213.497   I1.380 J2.315 E0.2093
G2  X222.401 Y214.284   I2.419 J-3.324 E0.1316
G2  X227.174 Y213.590   I1.251 J-8.153 E0.2507
G3  X229.738 Y212.259   I2.687 J2.043 E0.1528
G3  X231.194 Y212.915   I-0.177 J2.337 E0.0834
G3  X234.427 Y216.144   I-15.953 J19.212 E0.2344
G3  X233.644 Y219.862   I-2.353 J1.446 E0.2146
G2  X232.842 Y222.357   I3.535 J2.512 E0.1363
G2  X233.549 Y227.199   I8.423 J1.242 E0.2541
G3  X234.821 Y230.216   I-2.059 J2.644 E0.1752
G3  X234.190 Y231.329   I-2.342 J-0.593 E0.0663
G1  X234.505 Y231.636  
G3  X231.178 Y234.870   I-19.166 J-16.393 E0.2379
G3  X227.044 Y234.055   I-1.650 J-2.521 E0.2389
G2  X224.899 Y233.354   I-2.156 J2.964 E0.1175
G2  X220.496 Y233.895   I-1.247 J8.032 E0.2301
G3  X217.319 Y235.354   I-3.207 J-2.795 E0.1845
G3  X215.808 Y234.602   I0.494 J-2.890 E0.0877
G3  X212.522 Y231.316   I16.148 J-19.427 E0.2383
G3  X213.303 Y227.079   I2.551 J-1.720 E0.2444
G2  X214.022 Y222.362   I-6.997 J-3.480 E0.2483
G2  X212.271 Y218.811   I-6.230 J0.865 E0.2063
G3  X212.799 Y215.562   I2.559 J-1.251 E0.1797
G3  X216.126 Y212.328   I19.162 J16.389 E0.2379
G3  X220.260 Y213.143   I1.650 J2.521 E0.2389
G2  X222.405 Y213.844   I2.156 J-2.964 E0.1175
G2  X226.928 Y213.225   I1.247 J-7.721 E0.2372
G3  X229.769 Y211.820   I2.905 J2.299 E0.1677
G3  X231.496 Y212.596   I-0.210 J2.779 E0.0989
G3  X234.782 Y215.882   I-16.147 J19.426 E0.2383
G3  X234.001 Y220.119   I-2.551 J1.720 E0.2444
G2  X233.282 Y224.836   I6.996 J3.480 E0.2483
G2  X235.033 Y228.387   I6.231 J-0.866 E0.2063
G3  X234.505 Y231.636   I-2.559 J1.251 E0.1797
G1  X234.820 Y231.944  
G3  X231.434 Y235.228   I-19.409 J-16.622 E0.2419
G3  X226.681 Y234.338   I-1.905 J-2.964 E0.2729
G2  X224.895 Y233.794   I-1.780 J2.642 E0.0971
G2  X220.836 Y234.205   I-1.243 J7.964 E0.2112
G3  X217.503 Y235.817   I-3.732 J-3.466 E0.1940
G3  X215.505 Y234.922   I0.243 J-3.221 E0.1144
G3  X212.168 Y231.577   I16.375 J-19.674 E0.2423
G3  X213.020 Y226.714   I3.065 J-1.969 E0.2778
G2  X213.582 Y222.367   I-7.002 J-3.115 E0.2276
G2  X212.000 Y219.232   I-4.568 J0.338 E0.1846
G3  X212.484 Y215.254   I2.795 J-1.678 E0.2210
G3  X215.870 Y211.970   I19.405 J16.618 E0.2419
G3  X220.623 Y212.861   I1.905 J2.964 E0.2729
G2  X222.410 Y213.404   I1.780 J-2.641 E0.0971
G2  X226.468 Y212.993   I1.242 J-7.965 E0.2112
G3  X229.801 Y211.381   I3.732 J3.466 E0.1940
G3  X231.799 Y212.276   I-0.243 J3.221 E0.1144
G3  X235.136 Y215.621   I-16.370 J19.669 E0.2423
G3  X234.284 Y220.484   I-3.065 J1.969 E0.2778
G2  X233.722 Y224.832   I7.001 J3.115 E0.2277
G2  X235.304 Y227.966   I4.569 J-0.339 E0.1845
G3  X234.820 Y231.944   I-2.795 J1.678 E0.2210
G1  X235.135 Y232.251  
M73 P36 R15
G3  X231.690 Y235.586   I-19.662 J-16.862 E0.2459
G3  X226.344 Y234.643   I-2.136 J-3.518 E0.3036
G2  X224.891 Y234.234   I-1.454 J2.378 E0.0783
G2  X221.148 Y234.537   I-1.239 J7.966 E0.1941
G3  X218.043 Y236.252   I-4.505 J-4.487 E0.1841
G3  X215.202 Y235.241   I-0.301 J-3.649 E0.1591
G3  X211.814 Y231.838   I16.615 J-19.934 E0.2463
G3  X212.715 Y226.374   I3.560 J-2.219 E0.3097
G2  X213.142 Y224.827   I-2.587 J-1.548 E0.0832
G2  X212.772 Y220.923   I-7.824 J-1.228 E0.2029
G3  X211.142 Y216.948   I3.394 J-3.713 E0.2273
G3  X212.169 Y214.947   I3.857 J0.716 E0.1168
G3  X215.614 Y211.612   I19.662 J16.862 E0.2459
G3  X220.960 Y212.555   I2.136 J3.518 E0.3036
G2  X222.414 Y212.964   I1.454 J-2.378 E0.0783
G2  X226.156 Y212.661   I1.238 J-7.969 E0.1940
G3  X229.261 Y210.946   I4.506 J4.488 E0.1841
G3  X229.832 Y210.942   I0.311 J3.629 E0.0293
G3  X232.102 Y211.957   I-0.277 J3.663 E0.1299
G3  X235.490 Y215.360   I-16.611 J19.930 E0.2463
G3  X234.589 Y220.824   I-3.560 J2.219 E0.3097
G2  X234.162 Y222.371   I2.587 J1.548 E0.0832
G2  X234.532 Y226.275   I7.823 J1.228 E0.2029
G3  X236.162 Y230.250   I-3.394 J3.713 E0.2273
G3  X235.135 Y232.251   I-3.857 J-0.716 E0.1168
; WIPE_TOWER_END

; WIPE_START
G1 F7015.794
G1 X235.309 Y232.064 E-.09705
G1 X235.49 Y231.838 E-.11021
G1 X235.653 Y231.598 E-.11018
G1 X235.796 Y231.346 E-.11018
G1 X235.92 Y231.083 E-.11022
G1 X236.022 Y230.812 E-.11016
G1 X236.103 Y230.534 E-.11019
G1 X236.103 Y230.529 E-.00182
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.16 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F6594.904
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.571 Y129.881 Z1.16 F30000
G1 X107.704 Y129.136 Z1.16
G1 Z.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.426609
G1 F7015.794
G1 X107.124 Y128.557 E.03428
G1 X106.606 Y128.557 E.02167
G1 X107.542 Y129.493 E.05535
G1 X107.542 Y130.011 E.02167
G1 X106.087 Y128.557 E.086
G1 X105.569 Y128.557 E.02167
G1 X107.542 Y130.529 E.11665
G1 X107.542 Y131.048 E.02167
G1 X105.051 Y128.557 E.1473
G1 X104.532 Y128.557 E.02167
G1 X107.542 Y131.566 E.17795
G1 X107.542 Y132.084 E.02167
G1 X104.014 Y128.557 E.2086
G1 X103.496 Y128.557 E.02167
G1 X107.542 Y132.603 E.23926
G1 X107.542 Y133.121 E.02167
G1 X102.977 Y128.557 E.26991
G1 X102.459 Y128.557 E.02167
G1 X107.542 Y133.639 E.30056
G1 X107.542 Y134.158 E.02167
G1 X101.941 Y128.557 E.33121
G1 X101.422 Y128.557 E.02167
G1 X107.542 Y134.676 E.36186
G1 X107.542 Y135.195 E.02167
G1 X100.904 Y128.557 E.39251
G1 X100.386 Y128.557 E.02167
G1 X107.542 Y135.713 E.42316
G1 X107.542 Y136.231 E.02167
G1 X99.867 Y128.557 E.45381
G1 X99.349 Y128.557 E.02167
G1 X107.542 Y136.75 E.48447
G1 X107.024 Y136.75 E.02167
G1 X99.349 Y129.075 E.45383
G1 X99.349 Y129.593 E.02167
G1 X106.505 Y136.75 E.42317
G1 X105.987 Y136.75 E.02167
G1 X99.349 Y130.112 E.39252
G1 X99.349 Y130.63 E.02167
G1 X105.469 Y136.75 E.36187
G1 X104.95 Y136.75 E.02167
G1 X99.349 Y131.148 E.33122
G1 X99.349 Y131.667 E.02167
G1 X104.432 Y136.75 E.30057
G1 X103.914 Y136.75 E.02167
G1 X99.349 Y132.185 E.26992
G1 X99.349 Y132.703 E.02167
G1 X103.395 Y136.75 E.23927
G1 X102.877 Y136.75 E.02167
G1 X99.349 Y133.222 E.20862
G1 X99.349 Y133.74 E.02167
G1 X102.359 Y136.75 E.17797
G1 X101.84 Y136.75 E.02167
G1 X99.349 Y134.258 E.14732
G1 X99.349 Y134.777 E.02167
G1 X101.322 Y136.75 E.11666
G1 X100.804 Y136.75 E.02167
G1 X99.349 Y135.295 E.08601
G1 X99.349 Y135.813 E.02167
G1 X100.285 Y136.75 E.05536
G1 X99.767 Y136.75 E.02167
G1 X99.187 Y136.17 E.03429
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F7015.794
G1 X99.767 Y136.75 E-.31162
G1 X100.285 Y136.75 E-.19697
G1 X99.817 Y136.282 E-.25141
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

M204 S10000
G1 X231.902 Y231.474
G1 Z1.04
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #5
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
M73 P37 R15
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
G1  X234.190 Y231.329  
G3  X230.922 Y234.512   I-18.950 J-16.191 E0.2339
G3  X227.305 Y233.701   I-1.380 J-2.315 E0.2093
G2  X224.903 Y232.914   I-2.419 J3.324 E0.1316
G2  X220.130 Y233.608   I-1.251 J8.152 E0.2507
G3  X216.860 Y234.775   I-2.510 J-1.870 E0.1885
G3  X216.110 Y234.283   I0.921 J-2.222 E0.0462
G3  X212.876 Y231.054   I15.959 J-19.217 E0.2344
G3  X213.660 Y227.336   I2.353 J-1.446 E0.2146
G2  X214.462 Y224.840   I-3.536 J-2.512 E0.1364
G2  X213.755 Y219.999   I-8.424 J-1.241 E0.2541
G3  X212.483 Y216.982   I2.059 J-2.644 E0.1752
G3  X213.114 Y215.869   I2.342 J0.593 E0.0663
G3  X216.382 Y212.686   I18.950 J16.191 E0.2339
G3  X219.999 Y213.497   I1.380 J2.315 E0.2093
G2  X222.401 Y214.284   I2.419 J-3.324 E0.1316
G2  X227.174 Y213.590   I1.251 J-8.153 E0.2507
G3  X229.738 Y212.259   I2.687 J2.043 E0.1528
G3  X231.194 Y212.915   I-0.177 J2.337 E0.0834
G3  X234.427 Y216.144   I-15.953 J19.212 E0.2344
G3  X233.644 Y219.862   I-2.353 J1.446 E0.2146
G2  X232.842 Y222.357   I3.535 J2.512 E0.1363
G2  X233.549 Y227.199   I8.423 J1.242 E0.2541
G3  X234.821 Y230.216   I-2.059 J2.644 E0.1752
G3  X234.190 Y231.329   I-2.342 J-0.593 E0.0663
G1  X234.505 Y231.636  
G3  X231.178 Y234.870   I-19.166 J-16.393 E0.2379
G3  X227.044 Y234.055   I-1.650 J-2.521 E0.2389
G2  X224.899 Y233.354   I-2.156 J2.964 E0.1175
G2  X220.496 Y233.895   I-1.247 J8.032 E0.2301
G3  X217.319 Y235.354   I-3.207 J-2.795 E0.1845
G3  X215.808 Y234.602   I0.494 J-2.890 E0.0877
G3  X212.522 Y231.316   I16.148 J-19.427 E0.2383
G3  X213.303 Y227.079   I2.551 J-1.720 E0.2444
G2  X214.022 Y222.362   I-6.997 J-3.480 E0.2483
G2  X212.271 Y218.811   I-6.230 J0.865 E0.2063
G3  X212.799 Y215.562   I2.559 J-1.251 E0.1797
G3  X216.126 Y212.328   I19.162 J16.389 E0.2379
G3  X220.260 Y213.143   I1.650 J2.521 E0.2389
G2  X222.405 Y213.844   I2.156 J-2.964 E0.1175
G2  X226.928 Y213.225   I1.247 J-7.721 E0.2372
G3  X229.769 Y211.820   I2.905 J2.299 E0.1677
G3  X231.496 Y212.596   I-0.210 J2.779 E0.0989
G3  X234.782 Y215.882   I-16.147 J19.426 E0.2383
G3  X234.001 Y220.119   I-2.551 J1.720 E0.2444
G2  X233.282 Y224.836   I6.996 J3.480 E0.2483
G2  X235.033 Y228.387   I6.231 J-0.866 E0.2063
G3  X234.505 Y231.636   I-2.559 J1.251 E0.1797
G1  X234.820 Y231.944  
G3  X231.434 Y235.228   I-19.409 J-16.622 E0.2419
G3  X226.681 Y234.338   I-1.905 J-2.964 E0.2729
G2  X224.895 Y233.794   I-1.780 J2.642 E0.0971
G2  X220.836 Y234.205   I-1.243 J7.964 E0.2112
G3  X217.503 Y235.817   I-3.732 J-3.466 E0.1940
G3  X215.505 Y234.922   I0.243 J-3.221 E0.1144
G3  X212.168 Y231.577   I16.375 J-19.674 E0.2423
G3  X213.020 Y226.714   I3.065 J-1.969 E0.2778
G2  X213.582 Y222.367   I-7.002 J-3.115 E0.2276
G2  X212.000 Y219.232   I-4.568 J0.338 E0.1846
G3  X212.484 Y215.254   I2.795 J-1.678 E0.2210
G3  X215.870 Y211.970   I19.405 J16.618 E0.2419
G3  X220.623 Y212.861   I1.905 J2.964 E0.2729
G2  X222.410 Y213.404   I1.780 J-2.641 E0.0971
G2  X226.468 Y212.993   I1.242 J-7.965 E0.2112
G3  X229.801 Y211.381   I3.732 J3.466 E0.1940
G3  X231.799 Y212.276   I-0.243 J3.221 E0.1144
G3  X235.136 Y215.621   I-16.370 J19.669 E0.2423
G3  X234.284 Y220.484   I-3.065 J1.969 E0.2778
G2  X233.722 Y224.832   I7.001 J3.115 E0.2277
G2  X235.304 Y227.966   I4.569 J-0.339 E0.1845
G3  X234.820 Y231.944   I-2.795 J1.678 E0.2210
; WIPE_TOWER_END

; WIPE_START
G1 F7015.794
G1 X234.976 Y231.776 E-.08719
G1 X235.136 Y231.576 E-.09707
G1 X235.279 Y231.365 E-.09705
G1 X235.405 Y231.143 E-.09704
G1 X235.514 Y230.912 E-.09707
G1 X235.604 Y230.673 E-.09704
G1 X235.675 Y230.428 E-.09705
G1 X235.723 Y230.195 E-.09049
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.44 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F4196
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4196
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z1.44 F30000
G1 X99.364 Y130.942 Z1.44
G1 Z1.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4196
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 1.32
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z1.32
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #6
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
G1  X234.190 Y231.329  
G3  X230.922 Y234.512   I-18.950 J-16.191 E0.2339
G3  X227.305 Y233.701   I-1.380 J-2.315 E0.2093
G2  X224.903 Y232.914   I-2.419 J3.324 E0.1316
G2  X220.130 Y233.608   I-1.251 J8.152 E0.2507
G3  X216.860 Y234.775   I-2.510 J-1.870 E0.1885
G3  X216.110 Y234.283   I0.921 J-2.222 E0.0462
G3  X212.876 Y231.054   I15.959 J-19.217 E0.2344
G3  X213.660 Y227.336   I2.353 J-1.446 E0.2146
G2  X214.462 Y224.840   I-3.536 J-2.512 E0.1364
G2  X213.755 Y219.999   I-8.424 J-1.241 E0.2541
G3  X212.483 Y216.982   I2.059 J-2.644 E0.1752
G3  X213.114 Y215.869   I2.342 J0.593 E0.0663
G3  X216.382 Y212.686   I18.950 J16.191 E0.2339
G3  X219.999 Y213.497   I1.380 J2.315 E0.2093
G2  X222.401 Y214.284   I2.419 J-3.324 E0.1316
G2  X227.174 Y213.590   I1.251 J-8.153 E0.2507
G3  X229.738 Y212.259   I2.687 J2.043 E0.1528
G3  X231.194 Y212.915   I-0.177 J2.337 E0.0834
G3  X234.427 Y216.144   I-15.953 J19.212 E0.2344
G3  X233.644 Y219.862   I-2.353 J1.446 E0.2146
G2  X232.842 Y222.357   I3.535 J2.512 E0.1363
G2  X233.549 Y227.199   I8.423 J1.242 E0.2541
G3  X234.821 Y230.216   I-2.059 J2.644 E0.1752
G3  X234.190 Y231.329   I-2.342 J-0.593 E0.0663
G1  X234.505 Y231.636  
G3  X231.178 Y234.870   I-19.166 J-16.393 E0.2379
G3  X227.044 Y234.055   I-1.650 J-2.521 E0.2389
G2  X224.899 Y233.354   I-2.156 J2.964 E0.1175
G2  X220.496 Y233.895   I-1.247 J8.032 E0.2301
G3  X217.319 Y235.354   I-3.207 J-2.795 E0.1845
G3  X215.808 Y234.602   I0.494 J-2.890 E0.0877
G3  X212.522 Y231.316   I16.148 J-19.427 E0.2383
G3  X213.303 Y227.079   I2.551 J-1.720 E0.2444
G2  X214.022 Y222.362   I-6.997 J-3.480 E0.2483
G2  X212.271 Y218.811   I-6.230 J0.865 E0.2063
G3  X212.799 Y215.562   I2.559 J-1.251 E0.1797
G3  X216.126 Y212.328   I19.162 J16.389 E0.2379
G3  X220.260 Y213.143   I1.650 J2.521 E0.2389
G2  X222.405 Y213.844   I2.156 J-2.964 E0.1175
G2  X226.928 Y213.225   I1.247 J-7.721 E0.2372
G3  X229.769 Y211.820   I2.905 J2.299 E0.1677
G3  X231.496 Y212.596   I-0.210 J2.779 E0.0989
G3  X234.782 Y215.882   I-16.147 J19.426 E0.2383
G3  X234.001 Y220.119   I-2.551 J1.720 E0.2444
G2  X233.282 Y224.836   I6.996 J3.480 E0.2483
G2  X235.033 Y228.387   I6.231 J-0.866 E0.2063
G3  X234.505 Y231.636   I-2.559 J1.251 E0.1797
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X234.643 Y231.488 E-.07735
G1 X234.781 Y231.315 E-.08393
G1 X234.905 Y231.132 E-.08392
G1 X235.015 Y230.941 E-.08391
G1 X235.108 Y230.741 E-.08393
G1 X235.186 Y230.534 E-.08391
G1 X235.248 Y230.322 E-.08391
G1 X235.292 Y230.106 E-.08392
G1 X235.32 Y229.887 E-.08392
G1 X235.321 Y229.857 E-.01132
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.72 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z1.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F2620
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2620
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z1.72 F30000
G1 Z1.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2620
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
M73 P38 R15
G1 X231.902 Y231.474
G1 Z1.6
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #7
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
G1  X234.190 Y231.329  
G3  X230.922 Y234.512   I-18.950 J-16.191 E0.2339
G3  X227.305 Y233.701   I-1.380 J-2.315 E0.2093
G2  X224.903 Y232.914   I-2.419 J3.324 E0.1316
G2  X220.130 Y233.608   I-1.251 J8.152 E0.2507
G3  X216.860 Y234.775   I-2.510 J-1.870 E0.1885
G3  X216.110 Y234.283   I0.921 J-2.222 E0.0462
G3  X212.876 Y231.054   I15.959 J-19.217 E0.2344
G3  X213.660 Y227.336   I2.353 J-1.446 E0.2146
G2  X214.462 Y224.840   I-3.536 J-2.512 E0.1364
G2  X213.755 Y219.999   I-8.424 J-1.241 E0.2541
G3  X212.483 Y216.982   I2.059 J-2.644 E0.1752
G3  X213.114 Y215.869   I2.342 J0.593 E0.0663
G3  X216.382 Y212.686   I18.950 J16.191 E0.2339
G3  X219.999 Y213.497   I1.380 J2.315 E0.2093
G2  X222.401 Y214.284   I2.419 J-3.324 E0.1316
G2  X227.174 Y213.590   I1.251 J-8.153 E0.2507
G3  X229.738 Y212.259   I2.687 J2.043 E0.1528
G3  X231.194 Y212.915   I-0.177 J2.337 E0.0834
G3  X234.427 Y216.144   I-15.953 J19.212 E0.2344
G3  X233.644 Y219.862   I-2.353 J1.446 E0.2146
G2  X232.842 Y222.357   I3.535 J2.512 E0.1363
G2  X233.549 Y227.199   I8.423 J1.242 E0.2541
G3  X234.821 Y230.216   I-2.059 J2.644 E0.1752
G3  X234.190 Y231.329   I-2.342 J-0.593 E0.0663
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X234.311 Y231.199 E-.06749
G1 X234.427 Y231.054 E-.07078
G1 X234.532 Y230.9 E-.07079
G1 X234.624 Y230.738 E-.07078
G1 X234.703 Y230.569 E-.07078
G1 X234.769 Y230.395 E-.07078
G1 X234.82 Y230.216 E-.07077
G1 X234.858 Y230.034 E-.07078
G1 X234.881 Y229.849 E-.07079
G1 X234.89 Y229.663 E-.07077
G1 X234.885 Y229.517 E-.05548
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1927
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1927
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z2 F30000
G1 X99.364 Y130.942 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1927
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z1.88
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #8
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.28 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z2.28 F30000
G1 Z1.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 2.16
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z2.16
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #9
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
M73 P39 R15
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.56 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z2.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z2.56 F30000
G1 X99.364 Y130.942 Z2.56
G1 Z2.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 2.44
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z2.44
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #10
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.84 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z2.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z2.84 F30000
G1 Z2.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z2.72
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
M73 P40 R15
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #11
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.12 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z3.12 F30000
G1 X99.364 Y130.942 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z3
M73 P40 R14
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #12
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.4 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
M73 P41 R14
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 3.28
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z3.28
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #13
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.68 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z3.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z3.68 F30000
G1 X99.364 Y130.942 Z3.68
G1 Z3.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z3.56
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #14
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.96 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z3.96 F30000
M73 P42 R14
G1 Z3.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 3.84
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z3.84
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #15
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.24 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z3.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z4.24 F30000
G1 X99.364 Y130.942 Z4.24
G1 Z3.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 4.12
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z4.12
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #16
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
M73 P43 R14
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.52 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z4.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z4.52 F30000
G1 Z4.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z4.4
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #17
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z4.8 F30000
G1 X99.364 Y130.942 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 4.68
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z4.68
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #18
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
M73 P44 R14
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.08 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z4.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z5.08 F30000
G1 Z4.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 4.96
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z4.96
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
M73 P44 R13
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #19
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.36 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z4.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z5.36 F30000
G1 X99.364 Y130.942 Z5.36
G1 Z4.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
M73 P45 R13
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z5.24
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #20
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.64 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z5.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z5.64 F30000
G1 Z5.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 5.52
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z5.52
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #21
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5.92 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z5.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
M204 S250
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z5.92 F30000
G1 X99.364 Y130.942 Z5.92
G1 Z5.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P46 R13
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
;--------------------
; CP TOOLCHANGE START
; toolchange #1
; material : PLA -> PLA
;--------------------
M220 B
M220 S100
; WIPE_TOWER_START
G1 E-1.2 F1800
; filament end gcode 


;=X1 20251031=
M620 S1A
M204 S9000
G1 Z8.8 F1200

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
M73 E3
M620.1 E F299.339 T240



M620.11 S0

G92 E0

M83
; FLUSH_START
; always use highest temperature to flush
M400

M109 S240


G1 E23.7 F299.339 ; do not need pulsatile flushing for start part
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339

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
G1 Z8.8 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
G1 X207.651 Y215.224 F30000
M204 S10000
G1 Z5.8

; filament start gcode
M106 P3 S150


G1 X215.284 Y215.224 Z6.2
G1 X215.402 Y215.224 Z6.2
G1 Z5.8
G1 E2 F1800

G4 S0
; CP_TOOLCHANGE_WIPE CT0
M204 S10000
G1  X218.402 Y215.224  E0.1536 F1782
G1 E-0.8000 F1800
G1  X213.902  F600
G1  X218.402  F240
G1 E0.8000 F1800
G1  X231.902  E0.6913 F1782
G1  Y215.974  E0.0384
G1  X215.402  E0.8450 F2025
G1  Y216.724  E0.0384
G1  X231.902  E0.8450 F2473
G1  Y217.474  E0.0384
G1  X215.402  E0.8450 F4725
G1  Y218.224  E0.0384
G1  X231.902  E0.8450 F4775
G1  Y218.974  E0.0384
G1  X215.402  E0.8450
G1  Y219.724  E0.0384
G1  X231.902  E0.8450
G1  Y220.474  E0.0384
G1  X215.402  E0.8450
G1  Y221.224  E0.0384
G1  X231.902  E0.8450
G1  Y221.974  E0.0384
G1  X215.402  E0.8450
G1  Y222.724  E0.0384
G1  X231.902  E0.8450
G1  Y223.474  E0.0384
G1  X215.402  E0.8450
G1  Y224.224  E0.0384
G1  X231.902  E0.8450
G1  Y224.974  E0.0384
G1  X215.402  E0.8450
G1  Y225.724  E0.0384
G1  X231.902  E0.8450
G1  Y226.474  E0.0384
G1  X215.402  E0.8450
G1  Y227.224  E0.0384
G1  X231.902  E0.8450
G1  Y227.974  E0.0384
G1  X215.402  E0.8450
G1  Y228.724  E0.0384
G1  X231.902  E0.8450
G1  Y229.474  E0.0384
G1  X215.402  E0.8450
G1  Y230.224  E0.0384
G1  X231.902  E0.8450
G1  Y230.974  E0.0384
G1  X215.402  E0.8450
G1  Y231.724  E0.0384
G1  X231.902  E0.8450
; WIPE_TOWER_END
M220 R
G1 F30000
G4 S0
G92 E0
; CP TOOLCHANGE END
;------------------


G1  Y231.474   F5400.000000
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
M73 P50 R12
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
M73 P51 R12
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.505 Y216.102   I1.742 J-0.864 E0.1297
G1 E-0.8000 F1800
G1  X215.285 Y214.346   F600
G1 E0.8000 F1800
G3  X218.038 Y212.719   I2.974 J1.888 E0.1700 F5400
G3  X220.342 Y214.226   I-4.110 J8.796 E0.1415
G2  X227.271 Y214.051   I3.249 J-8.612 E0.3639
G3  X229.706 Y212.698   I3.186 J2.868 E0.1453
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
M73 P52 R12
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.2 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F6594.904
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z6.2 F30000
G1 Z5.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
M73 P52 R11
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z6.08
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #23
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.48 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z6.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z6.48 F30000
G1 X99.364 Y130.942 Z6.48
G1 Z6.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 6.36
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z6.36
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #24
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
M73 P53 R11
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.76 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z6.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z6.76 F30000
G1 Z6.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 6.64
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z6.64
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #25
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.04 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z6.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z7.04 F30000
G1 X99.364 Y130.942 Z7.04
G1 Z6.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z6.92
M73 P54 R11
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #26
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.32 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z6.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z7.32 F30000
G1 Z6.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 7.2
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z7.2
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #27
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.6 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z7.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z7.6 F30000
G1 X99.364 Y130.942 Z7.6
G1 Z7.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
M73 P55 R11
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 7.48
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z7.48
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #28
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z7.88 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z7.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z7.88 F30000
G1 Z7.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 7.76
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z7.76
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #29
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.16 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z7.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z8.16 F30000
G1 X99.364 Y130.942 Z8.16
M73 P56 R11
G1 Z7.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 8.04
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z8.04
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #30
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
M73 P56 R10
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.44 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z8.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z8.44 F30000
G1 Z8.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 8.32
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z8.32
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #31
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
M73 P57 R10
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z8.72 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z8.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z8.72 F30000
G1 X99.364 Y130.942 Z8.72
G1 Z8.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z8.6
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #32
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z9 F30000
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 8.88
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z8.88
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #33
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
M73 P58 R10
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.28 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z8.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z9.28 F30000
G1 X99.364 Y130.942 Z9.28
G1 Z8.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 9.16
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z9.16
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #34
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.56 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z9.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z9.56 F30000
G1 Z9.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 9.44
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
M73 P59 R10
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z9.44
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #35
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z9.84 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z9.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z9.84 F30000
G1 X99.364 Y130.942 Z9.84
G1 Z9.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 9.72
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z9.72
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #36
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.12 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z9.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z10.12 F30000
G1 Z9.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
M73 P60 R10
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 10
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z10
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #37
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
M73 P60 R9
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.4 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z10
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z10.4 F30000
G1 X99.364 Y130.942 Z10.4
G1 Z10
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 10.28
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z10.28
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #38
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.68 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z10.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
M73 P61 R9
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z10.68 F30000
G1 Z10.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 10.56
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z10.56
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #39
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z10.96 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z10.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z10.96 F30000
G1 X99.364 Y130.942 Z10.96
G1 Z10.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 10.84
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z10.84
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #40
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
M73 P62 R9
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.24 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z10.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z11.24 F30000
G1 Z10.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 11.12
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z11.12
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #41
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.52 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z11.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z11.52 F30000
G1 X99.364 Y130.942 Z11.52
G1 Z11.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 11.4
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z11.4
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
M73 P63 R9
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #42
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z11.8 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z11.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z11.8 F30000
G1 Z11.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 11.68
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z11.68
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #43
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.08 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z11.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z12.08 F30000
G1 X99.364 Y130.942 Z12.08
G1 Z11.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
M73 P64 R9
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 11.96
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z11.96
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #44
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
M73 P64 R8
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.36 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z11.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z12.36 F30000
G1 Z11.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 12.24
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z12.24
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #45
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.64 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z12.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z12.64 F30000
G1 X99.364 Y130.942 Z12.64
G1 Z12.24
M73 P65 R8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 12.52
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z12.52
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #46
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z12.92 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z12.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z12.92 F30000
G1 Z12.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 12.8
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z12.8
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #47
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
M73 P66 R8
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.2 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z13.2 F30000
G1 X99.364 Y130.942 Z13.2
G1 Z12.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 13.08
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z13.08
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #48
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.48 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z13.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z13.48 F30000
G1 Z13.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 13.36
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z13.36
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #49
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
M73 P67 R8
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z13.76 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z13.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z13.76 F30000
G1 X99.364 Y130.942 Z13.76
G1 Z13.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 13.64
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z13.64
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #50
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.04 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z13.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z14.04 F30000
G1 Z13.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 13.92
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
M73 P68 R8
G1 X231.902 Y231.474
G1 Z13.92
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #51
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.32 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z13.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
M73 P68 R7
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z14.32 F30000
G1 X99.364 Y130.942 Z14.32
G1 Z13.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 14.2
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z14.2
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #52
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.6 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z14.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z14.6 F30000
G1 Z14.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
M73 P69 R7
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 14.48
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z14.48
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #53
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z14.88 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z14.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z14.88 F30000
G1 X99.364 Y130.942 Z14.88
G1 Z14.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 14.76
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z14.76
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #54
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.16 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z14.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
M73 P70 R7
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z15.16 F30000
G1 Z14.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 15.04
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z15.04
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #55
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.44 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z15.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z15.44 F30000
G1 X99.364 Y130.942 Z15.44
G1 Z15.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 15.32
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z15.32
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #56
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
M73 P71 R7
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z15.72 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z15.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z15.72 F30000
G1 Z15.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 15.6
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z15.6
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #57
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z15.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z16 F30000
G1 X99.364 Y130.942 Z16
G1 Z15.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 15.88
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z15.88
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
M73 P72 R7
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #58
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.28 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z15.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z16.28 F30000
M73 P72 R6
G1 Z15.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 16.16
; LAYER_HEIGHT: 0.28
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z16.16
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #59
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.56 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z16.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z16.56 F30000
G1 X99.364 Y130.942 Z16.56
G1 Z16.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
M73 P73 R6
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 16.44
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z16.44
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #60
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z16.84 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z16.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z16.84 F30000
G1 Z16.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 16.72
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z16.72
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #61
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.12 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z16.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z17.12 F30000
G1 X99.364 Y130.942 Z17.12
G1 Z16.72
M73 P74 R6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 17
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z17
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #62
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.4 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z17.4 F30000
G1 Z17
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 17.28
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z17.28
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #63
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
M73 P75 R6
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.68 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z17.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z17.68 F30000
G1 X99.364 Y130.942 Z17.68
G1 Z17.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 17.56
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z17.56
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #64
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z17.96 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z17.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z17.96 F30000
G1 Z17.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 17.84
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z17.84
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #65
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
M73 P76 R6
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.24 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z17.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z18.24 F30000
G1 X99.364 Y130.942 Z18.24
G1 Z17.84
M73 P76 R5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 18.12
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z18.12
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #66
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.52 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z18.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z18.52 F30000
G1 Z18.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 18.4
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
M73 P77 R5
G1 X231.902 Y231.474
G1 Z18.4
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #67
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z18.8 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z18.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z18.8 F30000
G1 X99.364 Y130.942 Z18.8
G1 Z18.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 18.68
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z18.68
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #68
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.08 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z18.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1521
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1521
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.364 Y134.364 Z19.08 F30000
G1 Z18.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1521
G1 X99.364 Y135.924 E.06938
G1 X100.175 Y136.735 E.05099
G1 X99.364 Y136.735 E.03606
M73 P78 R5
G1 X107.527 Y128.572 E.5135
G1 X106.716 Y128.572 E.03606
G1 X107.527 Y129.382 E.05099
G1 X107.527 Y135.924 E.29098
G1 X106.716 Y136.735 E.05099
G1 X107.527 Y136.735 E.03606
G1 X99.364 Y128.572 E.5135
G1 X100.175 Y128.572 E.03606
G1 X99.364 Y129.382 E.05099
G1 X99.364 Y130.942 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 18.96
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F6594.904
G1 X99.364 Y129.382 E-.59267
G1 X99.675 Y129.071 E-.16733
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

M204 S10000
G1 X231.902 Y231.474
G1 Z18.96
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X215.402 Y231.474  E0.8450 F5400
G1  Y215.224  E0.8322
G1  X231.902  E0.8450
G1  Y231.474  E0.8322
G1  X216.402 Y215.224  
;--------------------
; CP EMPTY GRID START
; layer #69
G1  Y231.474  E0.8322
G1  X223.652 
G1  Y215.224  E0.8322
G1  X230.902 
G1  Y231.474  E0.8322
; CP EMPTY GRID END
;------------------






G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END

; WIPE_START
G1 F6594.904
G1 X232.402 Y232.474 E-.00002
G1 X232.402 Y232.474 E-.00001
G1 X233.826 Y231.07 E-.75997
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.36 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.86 Y137.068
G1 Z18.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F1525
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1525
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.672 Y132.171 Z19.36 F30000
G1 X99.364 Y130.942 Z19.36
G1 Z18.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1525
G1 X99.364 Y129.382 E.06938
G1 X100.175 Y128.572 E.05099
G1 X99.364 Y128.572 E.03606
G1 X107.527 Y136.735 E.5135
G1 X106.716 Y136.735 E.03606
G1 X107.527 Y135.924 E.05099
G1 X107.527 Y129.382 E.29098
G1 X106.716 Y128.572 E.05099
G1 X107.527 Y128.572 E.03606
G1 X99.364 Y136.735 E.5135
G1 X100.175 Y136.735 E.03606
G1 X99.364 Y135.924 E.05099
G1 X99.364 Y134.364 E.06938
; CHANGE_LAYER
; Z_HEIGHT: 19.24
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F6594.904
G1 X99.364 Y135.924 E-.59267
G1 X99.675 Y136.235 E-.16733
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

; OBJECT_ID: 679
G1 X100.2 Y129.783
G1 Z19.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F6594.904
G1 X100.2 Y129.408 E.01668
G1 X106.691 Y129.408 E.2887
G1 X106.691 Y135.898 E.2887
G1 X100.2 Y135.898 E.2887
G1 X100.2 Y129.843 E.26936
G1 X100.575 Y129.783 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X106.316 Y129.783 E.2357
G1 X106.316 Y135.523 E.2357
G1 X100.575 Y135.523 E.2357
G1 X100.575 Y129.843 E.23324
; WIPE_START
M204 S10000
G1 X102.575 Y129.822 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.073 Y135.988 Z19.64 F30000
G1 X107.86 Y137.068 Z19.64
G1 Z19.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.303 Y129.838 Z19.64 F30000
G1 X107.437 Y128.89 Z19.64
G1 Z19.24
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.517018
G1 F5627.62
G1 X107.437 Y128.662 E.01191
; LINE_WIDTH: 0.500288
G1 F5841.501
G1 X107.161 Y128.645 E.01387
; LINE_WIDTH: 0.450744
G1 F6582.337
G1 X106.885 Y128.628 E.01231
G1 X100.005 Y128.628 E.30663
; LINE_WIDTH: 0.466824
G1 F6322.122
G1 X99.729 Y128.645 E.01282
; LINE_WIDTH: 0.489123
G1 F5993.517
G1 X99.454 Y128.662 E.01352
G1 X99.42 Y129.213 E.02705
; LINE_WIDTH: 0.450099
G1 F6593.237
G1 X99.42 Y136.093 E.30612
; LINE_WIDTH: 0.466824
G1 F6322.122
G1 X99.437 Y136.369 E.01282
; LINE_WIDTH: 0.489123
G1 F5993.517
G1 X99.454 Y136.645 E.01352
G1 X100.005 Y136.678 E.02705
; LINE_WIDTH: 0.450099
G1 F6593.237
M73 P79 R5
G1 X106.885 Y136.678 E.30612
; LINE_WIDTH: 0.466828
G1 F6322.045
G1 X107.161 Y136.662 E.01282
; LINE_WIDTH: 0.489135
G1 F5993.354
G1 X107.437 Y136.645 E.01352
G1 X107.471 Y136.093 E.02705
; LINE_WIDTH: 0.450099
G1 F6593.237
G1 X107.471 Y129.213 E.30612
; LINE_WIDTH: 0.466828
G1 F6322.045
G1 X107.457 Y129.081 E.00614
; LINE_WIDTH: 0.500288
G1 F5841.501
G1 X107.443 Y128.95 E.00665
G1 X99.81 Y129.213 F30000
; LINE_WIDTH: 0.466824
G1 F6322.122
G1 X99.827 Y129.132 E.00383
; LINE_WIDTH: 0.489124
G1 F5993.515
G1 X99.844 Y129.052 E.00404
G1 X100.005 Y129.018 E.00807
; LINE_WIDTH: 0.450099
G1 F6593.237
G1 X106.885 Y129.018 E.30612
; LINE_WIDTH: 0.466828
G1 F6322.045
G1 X106.966 Y129.035 E.00383
; LINE_WIDTH: 0.489135
G1 F5993.352
G1 X107.047 Y129.052 E.00404
G1 X107.08 Y129.213 E.00808
; LINE_WIDTH: 0.450099
G1 F6593.237
G1 X107.08 Y136.093 E.30612
; LINE_WIDTH: 0.466828
G1 F6322.045
G1 X107.064 Y136.174 E.00383
; LINE_WIDTH: 0.489135
G1 F5993.352
G1 X107.047 Y136.255 E.00404
G1 X106.885 Y136.288 E.00808
; LINE_WIDTH: 0.450099
G1 F6593.237
G1 X100.005 Y136.288 E.30612
; LINE_WIDTH: 0.466824
G1 F6322.122
G1 X99.924 Y136.272 E.00383
; LINE_WIDTH: 0.489124
G1 F5993.515
G1 X99.844 Y136.255 E.00404
G1 X99.81 Y136.093 E.00807
; LINE_WIDTH: 0.450099
G1 F6593.237
G1 X99.81 Y129.273 E.30346
; WIPE_START
M204 S10000
G1 X99.81 Y131.273 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.64 I-.735 J.97 P1  F30000
G1 X231.902 Y231.474 Z19.64
G1 Z19.24
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X232.402 Y232.474  
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616 F5400
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.505 Y216.102   I1.742 J-0.864 E0.1297
G1 E-0.8000 F1800
G1  X215.285 Y214.346   F600
G1 E0.8000 F1800
G3  X218.038 Y212.719   I2.974 J1.888 E0.1700 F5400
G3  X220.342 Y214.226   I-4.110 J8.796 E0.1415
G2  X227.271 Y214.051   I3.249 J-8.612 E0.3639
G3  X229.706 Y212.698   I3.186 J2.868 E0.1453
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X233.875 Y231.022   I-1.759 J0.860 E0.1241
G1  X232.402 Y232.474   E0.1059
; WIPE_TOWER_END
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
;--------------------
; CP TOOLCHANGE START
; toolchange #2
; material : PLA -> PLA
;--------------------
M220 B
M220 S100
; WIPE_TOWER_START
G1 E-2 F1800
G17
G3 Z19.64 I1.217 J0 P1  F5400
; filament end gcode 


;=X1 20251031=
M620 S0A
M204 S9000
G1 Z22.24 F1200

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

; get travel path for change filament
M620.1 X54 Y0 F21000 P0
M620.1 X54 Y0 F21000 P1
M620.1 X54 Y245 F21000 P2

M620.1 E F299.339 T240
T0
M73 E2
M620.1 E F299.339 T240



M620.11 S0

G92 E0

M83
; FLUSH_START
; always use highest temperature to flush
M400

M109 S240


G1 E23.7 F299.339 ; do not need pulsatile flushing for start part
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339

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
G1 Z22.24 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
G1 X207.651 Y215.224 F30000
G1 Z19.24

; filament start gcode
M106 P3 S150


G1 X215.284 Y215.224 Z19.64
G1 X215.402 Y215.224 Z19.64
G1 Z19.24
G1 E2 F1800

G4 S0
; CP_TOOLCHANGE_WIPE CT0
M204 S10000
G1  X218.402 Y215.224  E0.1536 F1782
G1 E-0.8000 F1800
G1  X213.902  F600
G1  X218.402  F240
G1 E0.8000 F1800
G1  X231.902  E0.6913 F1782
G1  Y215.974  E0.0384
G1  X215.402  E0.8450 F2025
G1  Y216.724  E0.0384
G1  X231.902  E0.8450 F2473
G1  Y217.474  E0.0384
G1  X215.402  E0.8450 F4725
G1  Y218.224  E0.0384
G1  X231.902  E0.8450 F4775
G1  Y218.974  E0.0384
G1  X215.402  E0.8450
G1  Y219.724  E0.0384
G1  X231.902  E0.8450
G1  Y220.474  E0.0384
G1  X215.402  E0.8450
G1  Y221.224  E0.0384
G1  X231.902  E0.8450
G1  Y221.974  E0.0384
G1  X215.402  E0.8450
G1  Y222.724  E0.0384
G1  X231.902  E0.8450
G1  Y223.474  E0.0384
G1  X215.402  E0.8450
G1  Y224.224  E0.0384
G1  X231.902  E0.8450
G1  Y224.974  E0.0384
G1  X215.402  E0.8450
G1  Y225.724  E0.0384
G1  X231.902  E0.8450
G1  Y226.474  E0.0384
G1  X215.402  E0.8450
G1  Y227.224  E0.0384
G1  X231.902  E0.8450
G1  Y227.974  E0.0384
G1  X215.402  E0.8450
G1  Y228.724  E0.0384
G1  X231.902  E0.8450
G1  Y229.474  E0.0384
G1  X215.402  E0.8450
G1  Y230.224  E0.0384
G1  X231.902  E0.8450
G1  Y230.974  E0.0384
G1  X215.402  E0.8450
G1  Y231.724  E0.0384
G1  X231.902  E0.8450
; WIPE_TOWER_END
M220 R
G1 F30000
G4 S0
G92 E0
; CP TOOLCHANGE END
;------------------



; WIPE_START
G1 F6593.237
G1 X229.902 Y231.724 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.64 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X105.521 Y134.729
G1 Z19.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F6594.904
M73 P83 R4
G1 X101.37 Y134.729 E.18463
M73 P84 R4
G1 X101.37 Y130.578 E.18463
G1 X105.521 Y130.578 E.18463
G1 X105.521 Y134.669 E.18196
M204 S250
M73 P84 R3
G1 X105.896 Y135.103 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X100.995 Y135.103 E.20121
G1 X100.995 Y130.203 E.20121
G1 X105.896 Y130.203 E.20121
G1 X105.896 Y135.043 E.19875
; WIPE_START
M204 S10000
G1 X103.896 Y135.068 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.436 Y134.567 Z19.64 F30000
G1 Z19.24
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40647
; LAYER_HEIGHT: 0.4
G1 F3000
G1 X105.157 Y133.846 E.0539
G1 X105.157 Y133.201 E.03413
G1 X103.993 Y134.365 E.08703
G1 X103.348 Y134.365 E.03413
G1 X105.157 Y132.555 E.13529
G1 X105.157 Y131.91 E.03413
G1 X102.702 Y134.365 E.18356
G1 X102.056 Y134.365 E.03413
G1 X105.157 Y131.264 E.23183
G1 X105.157 Y130.942 E.01706
G1 X104.834 Y130.942 E.01707
G1 X101.734 Y134.042 E.23182
G1 X101.734 Y133.397 E.03413
G1 X104.189 Y130.942 E.18355
G1 X103.543 Y130.942 E.03413
G1 X101.734 Y132.751 E.13529
G1 X101.734 Y132.105 E.03413
G1 X102.898 Y130.942 E.08702
M73 P85 R3
G1 X102.252 Y130.942 E.03413
G1 X101.531 Y131.662 E.05389
; CHANGE_LAYER
; Z_HEIGHT: 19.52
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F3000
G1 X102.252 Y130.942 E-.38736
G1 X102.898 Y130.942 E-.24531
G1 X102.661 Y131.178 E-.12733
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

; OBJECT_ID: 679
G1 X106.301 Y135.508
G1 Z19.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F6594.904
G1 X100.59 Y135.508 E.25402
G1 X100.59 Y129.798 E.25402
G1 X106.301 Y129.798 E.25402
G1 X106.301 Y135.448 E.25135
M204 S250
G1 X106.676 Y135.883 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X100.215 Y135.883 E.26526
G1 X100.215 Y129.423 E.26526
G1 X106.676 Y129.423 E.26526
G1 X106.676 Y135.823 E.2628
; WIPE_START
M204 S10000
G1 X104.676 Y135.842 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.696 Y132.653 Z19.92 F30000
G1 Z19.52
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.560959
G1 F5133.924
G1 X103.696 Y132.403 E.01431
G1 X103.195 Y132.403 E.02862
G1 X103.195 Y132.904 E.02862
G1 X103.696 Y132.904 E.02862
G1 X103.696 Y132.713 E.01088
G1 X104.126 Y132.653 F30000
; LINE_WIDTH: 0.419998
G1 F7144.644
G1 X104.126 Y131.972 E.02795
G1 X102.765 Y131.972 E.05591
G1 X102.765 Y133.334 E.05591
G1 X104.126 Y133.334 E.05591
G1 X104.126 Y132.713 E.02549
G1 X104.486 Y132.653 F30000
G1 F7144.644
G1 X104.486 Y131.612 E.04273
G1 X102.405 Y131.612 E.08546
G1 X102.405 Y133.694 E.08546
G1 X104.486 Y133.694 E.08546
G1 X104.486 Y132.713 E.04027
G1 X104.846 Y132.653 F30000
G1 F7144.644
G1 X104.846 Y131.253 E.05751
G1 X102.045 Y131.253 E.11502
G1 X102.045 Y134.054 E.11502
G1 X104.846 Y134.054 E.11502
G1 X104.846 Y132.713 E.05505
G1 X105.206 Y132.653 F30000
G1 F7144.644
G1 X105.206 Y130.893 E.07229
G1 X101.685 Y130.893 E.14457
G1 X101.685 Y134.414 E.14457
G1 X105.206 Y134.414 E.14457
G1 X105.206 Y132.713 E.06982
G1 X105.566 Y132.653 F30000
G1 F7144.644
G1 X105.566 Y130.533 E.08707
G1 X101.325 Y130.533 E.17413
G1 X101.325 Y134.774 E.17413
G1 X105.566 Y134.774 E.17413
G1 X105.566 Y132.713 E.0846
G1 X105.926 Y132.653 F30000
G1 F7144.644
G1 X105.926 Y130.173 E.10184
G1 X100.965 Y130.173 E.20369
G1 X100.965 Y135.134 E.20369
G1 X105.926 Y135.134 E.20369
G1 X105.926 Y132.713 E.09938
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
;--------------------
; CP TOOLCHANGE START
; toolchange #3
; material : PLA -> PLA
;--------------------
M220 B
M220 S100
; WIPE_TOWER_START
; WIPE_START
G1 F5400
M204 S10000
G1 X105.926 Y134.713 E-1.9
; WIPE_END
G1 E-.1 F1800
G17
G3 Z19.92 I1.217 J0 P1  F5400
; filament end gcode 


;=X1 20251031=
M620 S1A
M204 S9000
G1 Z22.52 F1200

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
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339

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
G1 Z22.52 F3000

M204 S10000


M621 S1A
M106 S255
M106 P2 S178
G1 X215.105 Y239.706 F30000
G1 Z19.52
G1 X222.738 Y239.706 Z19.92
G1 X239.652 Y239.706 Z19.92
G1 X239.652 Y231.724

; filament start gcode
M106 P3 S150


G1 X231.902 Y231.724
G1 Z19.52
G1 E2 F1800

G4 S0
; CP_TOOLCHANGE_WIPE CT0
M204 S10000
G1  X228.902 Y231.724  E0.1536 F1782
G1 E-0.8000 F1800
G1  X233.402  F600
G1  X228.902  F240
G1 E0.8000 F1800
G1  X215.402  E0.6913 F1782
G1  Y230.974  E0.0384
G1  X231.902  E0.8450 F2025
G1  Y230.224  E0.0384
G1  X215.402  E0.8450 F2473
G1  Y229.474  E0.0384
G1  X231.902  E0.8450 F4725
G1  Y228.724  E0.0384
G1  X215.402  E0.8450 F4775
G1  Y227.974  E0.0384
G1  X231.902  E0.8450
G1  Y227.224  E0.0384
G1  X215.402  E0.8450
G1  Y226.474  E0.0384
G1  X231.902  E0.8450
G1  Y225.724  E0.0384
G1  X215.402  E0.8450
G1  Y224.974  E0.0384
G1  X231.902  E0.8450
G1  Y224.224  E0.0384
G1  X215.402  E0.8450
G1  Y223.474  E0.0384
G1  X231.902  E0.8450
G1  Y222.724  E0.0384
G1  X215.402  E0.8450
G1  Y221.974  E0.0384
G1  X231.902  E0.8450
G1  Y221.224  E0.0384
G1  X215.402  E0.8450
G1  Y220.474  E0.0384
G1  X231.902  E0.8450
G1  Y219.724  E0.0384
G1  X215.402  E0.8450
G1  Y218.974  E0.0384
G1  X231.902  E0.8450
G1  Y218.224  E0.0384
G1  X215.402  E0.8450
G1  Y217.474  E0.0384
G1  X231.902  E0.8450
G1  Y216.724  E0.0384
G1  X215.402  E0.8450
G1  Y215.974  E0.0384
G1  X231.902  E0.8450
G1  Y215.224  E0.0384
G1  X215.402  E0.8450
; WIPE_TOWER_END
M220 R
G1 F30000
G4 S0
G92 E0
; CP TOOLCHANGE END
;------------------


G1  Y231.474   F5400.000000
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X214.902 Y232.474  
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
M73 P89 R2
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
M73 P90 R2
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X230.891 Y213.234   I-0.144 J1.895 E0.0679
G1  X232.402 Y214.724   E0.1087
G3  X234.394 Y217.087   I-3.194 J4.712 E0.1603
G3  X233.182 Y219.757   I-3.205 J0.155 E0.1559
G2  X232.406 Y225.028   I8.340 J3.921 E0.2768
G2  X234.246 Y228.781   I5.717 J-0.475 E0.2191
G3  X234.040 Y230.834   I-1.732 J0.863 E0.1114
G1 E-0.8000 F1800
G1  X232.273 Y232.602   F600
G1 E0.8000 F1800
G3  X229.853 Y234.483   I-4.106 J-2.782 E0.1596 F5400
G3  X227.420 Y233.244   I0.122 J-3.245 E0.1443
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
M73 P91 R2
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
; WIPE_TOWER_END

; WIPE_START
G1 X214.902 Y232.474 E0
G1 X214.902 Y232.474 E0
G1 X216.326 Y233.878 E-.75999
; WIPE_END
G1 E-.04 F1800
G17
G3 Z19.92 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X99.42 Y129.003
G1 Z19.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F6594.904
G1 X99.42 Y128.628 E.01668
G1 X107.47 Y128.628 E.35809
G1 X107.47 Y136.678 E.35809
G1 X99.42 Y136.678 E.35809
G1 X99.42 Y129.063 E.33874
G1 X99.795 Y129.003 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X107.096 Y129.003 E.29975
G1 X107.096 Y136.303 E.29975
G1 X99.795 Y136.303 E.29975
G1 X99.795 Y129.063 E.29729
; WIPE_START
M204 S10000
G1 X101.795 Y129.047 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.398 Y135.135 Z19.92 F30000
G1 X107.86 Y137.068 Z19.92
G1 Z19.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6594.904
G1 X99.03 Y137.068 E.39278
G1 X99.03 Y128.238 E.39278
G1 X107.86 Y128.238 E.39278
G1 X107.86 Y137.008 E.39012
G1 X108.235 Y137.443 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; CHANGE_LAYER
; Z_HEIGHT: 19.8
; LAYER_HEIGHT: 0.279999
; WIPE_START
G1 F7144.614
M204 S10000
G1 X106.235 Y137.396 E-.76
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

; OBJECT_ID: 679
G1 X99.015 Y128.223
G1 Z19.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.28
G1 F7144.614
M204 S5000
G1 X107.875 Y128.223 E.36379
G1 X107.875 Y137.083 E.36379
G1 X99.015 Y137.083 E.36379
G1 X99.015 Y128.283 E.36133
; WIPE_START
M204 S10000
G1 X101.015 Y128.27 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.736 Y134.267 Z20.2 F30000
G1 X108.235 Y137.443 Z20.2
G1 Z19.8
G1 E.8 F1800
G1 F7144.614
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
; WIPE_START
M204 S10000
G1 X106.235 Y137.396 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.2 I-.794 J.922 P1  F30000
G1 X215.402 Y231.474 Z20.2
G1 Z19.8
G1 E.8 F1800
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X214.902 Y232.474  
G3  X212.910 Y230.111   I3.194 J-4.712 E0.1603 F5400
G3  X214.122 Y227.441   I3.205 J-0.155 E0.1559
G2  X214.898 Y222.170   I-8.342 J-3.922 E0.2768
G2  X213.058 Y218.417   I-5.717 J0.475 E0.2191
G3  X213.429 Y216.176   I1.759 J-0.860 E0.1241
G3  X216.639 Y213.044   I18.772 J16.028 E0.2299
G3  X219.738 Y213.852   I1.088 J2.175 E0.1791
G2  X222.397 Y214.724   I2.681 J-3.685 E0.1457
G2  X227.420 Y213.954   I1.255 J-8.586 E0.2641
G3  X229.706 Y212.698   I2.651 J2.117 E0.1371
G3  X232.019 Y214.346   I-0.852 J3.642 E0.1492
G1 E-0.8000 F1800
G1  X233.799 Y216.102   F600
G1 E0.8000 F1800
G3  X233.396 Y219.459   I-1.513 J1.521 E0.1994 F5400
G2  X232.402 Y222.353   I3.733 J2.900 E0.1596
G2  X233.182 Y227.441   I8.857 J1.246 E0.2674
G3  X234.351 Y230.256   I-1.910 J2.444 E0.1632
G3  X232.402 Y232.474   I-5.593 J-2.951 E0.1526
G3  X229.998 Y234.456   I-4.715 J-3.271 E0.1616
G3  X227.420 Y233.244   I-0.105 J-3.123 E0.1514
G2  X222.219 Y232.478   I-3.846 J8.067 E0.2733
G2  X218.463 Y234.356   I1.244 J7.183 E0.2182
G3  X216.413 Y233.964   I-0.729 J-1.738 E0.1132
G1  X214.902 Y232.474   E0.1087
; WIPE_TOWER_END
; LAYER_HEIGHT: 0.280000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
;--------------------
; CP TOOLCHANGE START
; toolchange #4
; material : PLA -> PLA
;--------------------
M220 B
M220 S100
; WIPE_TOWER_START
G1 E-2 F1800
G17
G3 Z20.2 I1.217 J0 P1  F5400
; filament end gcode 


;=X1 20251031=
M620 S0A
M204 S9000
G1 Z22.8 F1200

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
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339
G1 E0.357503 F50
G1 E4.11129 F299.339

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
G1 Z22.8 F3000

M204 S10000


M621 S0A
M106 S255
M106 P2 S178
G1 X207.651 Y232.703 F30000
G1 Z19.8
G1 X207.651 Y239.706 Z20.2
G1 X239.652 Y239.706
G1 X239.652 Y215.224

; filament start gcode
M106 P3 S150


G1 X231.902 Y215.224
G1 Z19.8
G1 E2 F1800

G4 S0
; CP_TOOLCHANGE_WIPE CT0
M204 S10000
G1  X228.902 Y215.224  E0.1536 F1782
G1 E-0.8000 F1800
G1  X233.402  F600
G1  X228.902  F240
G1 E0.8000 F1800
G1  X215.402  E0.6913 F1782
G1  Y215.974  E0.0384
G1  X231.902  E0.8450 F2025
G1  Y216.724  E0.0384
G1  X215.402  E0.8450 F2473
G1  Y217.474  E0.0384
G1  X231.902  E0.8450 F4725
M73 P92 R2
G1  Y218.224  E0.0384
G1  X215.402  E0.8450 F4775
G1  Y218.974  E0.0384
G1  X231.902  E0.8450
G1  Y219.724  E0.0384
G1  X215.402  E0.8450
G1  Y220.474  E0.0384
G1  X231.902  E0.8450
G1  Y221.224  E0.0384
G1  X215.402  E0.8450
G1  Y221.974  E0.0384
G1  X231.902  E0.8450
G1  Y222.724  E0.0384
G1  X215.402  E0.8450
G1  Y223.474  E0.0384
G1  X231.902  E0.8450
G1  Y224.224  E0.0384
G1  X215.402  E0.8450
G1  Y224.974  E0.0384
G1  X231.902  E0.8450
G1  Y225.724  E0.0384
G1  X215.402  E0.8450
G1  Y226.474  E0.0384
G1  X231.902  E0.8450
G1  Y227.224  E0.0384
M73 P92 R1
G1  X215.402  E0.8450
G1  Y227.974  E0.0384
G1  X231.902  E0.8450
G1  Y228.724  E0.0384
G1  X215.402  E0.8450
G1  Y229.474  E0.0384
G1  X231.902  E0.8450
G1  Y230.224  E0.0384
G1  X215.402  E0.8450
G1  Y230.974  E0.0384
G1  X231.902  E0.8450
G1  Y231.724  E0.0384
G1  X215.402  E0.8450
; WIPE_TOWER_END
M220 R
G1 F30000
G4 S0
G92 E0
; CP TOOLCHANGE END
;------------------



; WIPE_START
G1 F7144.614
G1 X217.402 Y231.724 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z20.2 I1.217 J0 P1  F30000
; OBJECT_ID: 679
M204 S10000
G1 X107.081 Y136.288
G1 Z19.8
M73 P96 R0
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.28
G1 F6594.904
G1 X99.81 Y136.288 E.3234
G1 X99.81 Y129.018 E.3234
G1 X107.081 Y129.018 E.3234
G1 X107.081 Y136.228 E.32073
M204 S250
G1 X107.455 Y136.663 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7144.614
M204 S5000
G1 X99.435 Y136.663 E.32931
G1 X99.435 Y128.643 E.32931
G1 X107.455 Y128.643 E.32931
G1 X107.455 Y136.603 E.32684
; WIPE_START
M204 S10000
G1 X105.456 Y136.618 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P97 R0
G1 X106.924 Y129.916 Z20.2 F30000
G1 Z19.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.426359
G1 F7020.582
G1 X106.345 Y129.337 E.03422
G1 X105.827 Y129.337 E.02164
G1 X106.762 Y130.272 E.05526
G1 X106.762 Y130.79 E.02164
G1 X105.309 Y129.337 E.08587
G1 X104.791 Y129.337 E.02164
G1 X106.762 Y131.308 E.11648
G1 X106.762 Y131.826 E.02164
G1 X104.273 Y129.337 E.14709
G1 X103.755 Y129.337 E.02164
G1 X106.762 Y132.344 E.1777
G1 X106.762 Y132.862 E.02164
G1 X103.237 Y129.337 E.20831
G1 X102.719 Y129.337 E.02164
G1 X106.762 Y133.38 E.23891
G1 X106.762 Y133.898 E.02164
G1 X102.201 Y129.337 E.26952
G1 X101.683 Y129.337 E.02164
G1 X106.762 Y134.416 E.30013
G1 X106.762 Y134.934 E.02164
G1 X101.165 Y129.337 E.33074
G1 X100.647 Y129.337 E.02164
G1 X106.762 Y135.452 E.36135
G1 X106.762 Y135.97 E.02164
G1 X100.129 Y129.337 E.39196
G1 X100.129 Y129.855 E.02164
G1 X106.244 Y135.97 E.36136
G1 X105.726 Y135.97 E.02164
G1 X100.129 Y130.373 E.33075
G1 X100.129 Y130.891 E.02164
G1 X105.208 Y135.97 E.30014
G1 X104.69 Y135.97 E.02164
G1 X100.129 Y131.409 E.26954
G1 X100.129 Y131.926 E.02164
G1 X104.172 Y135.97 E.23893
G1 X103.654 Y135.97 E.02164
G1 X100.129 Y132.444 E.20832
G1 X100.129 Y132.962 E.02164
G1 X103.136 Y135.97 E.17771
G1 X102.618 Y135.97 E.02164
G1 X100.129 Y133.48 E.1471
G1 X100.129 Y133.998 E.02164
G1 X102.1 Y135.97 E.11649
G1 X101.582 Y135.97 E.02164
G1 X100.129 Y134.516 E.08588
G1 X100.129 Y135.034 E.02164
G1 X101.064 Y135.97 E.05527
G1 X100.546 Y135.97 E.02164
G1 X99.967 Y135.39 E.03423
; CHANGE_LAYER
; Z_HEIGHT: 20.08
; LAYER_HEIGHT: 0.280001
; WIPE_START
G1 F7020.582
G1 X100.546 Y135.97 E-.31132
G1 X101.064 Y135.97 E-.19683
G1 X100.596 Y135.501 E-.25185
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

; OBJECT_ID: 679
G1 X108.235 Y137.443
G1 Z20.08
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2205
M204 S5000
G1 X98.655 Y137.443 E.39335
G1 X98.655 Y127.863 E.39335
G1 X108.235 Y127.863 E.39335
G1 X108.235 Y137.383 E.39089
M204 S10000
G1 X108.036 Y136.61 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.45
G1 F2205
M204 S2000
G1 X107.402 Y137.244 E.0399
M73 P98 R0
G1 X106.85 Y137.244
G1 X108.036 Y136.058 E.07459
G1 X108.036 Y135.507
G1 X106.299 Y137.244 E.10928
G1 X105.747 Y137.244
G1 X108.036 Y134.955 E.14396
G1 X108.036 Y134.404
G1 X105.196 Y137.244 E.17865
G1 X104.645 Y137.244
G1 X108.036 Y133.852 E.21334
G1 X108.036 Y133.301
G1 X104.093 Y137.244 E.24803
G1 X103.542 Y137.244
G1 X108.036 Y132.75 E.28271
G1 X108.036 Y132.198
G1 X102.99 Y137.244 E.3174
G1 X102.439 Y137.244
G1 X108.036 Y131.647 E.35209
G1 X108.036 Y131.095
G1 X101.888 Y137.244 E.38678
G1 X101.336 Y137.244
G1 X108.036 Y130.544 E.42147
G1 X108.036 Y129.993
G1 X100.785 Y137.244 E.45615
G1 X100.233 Y137.244
G1 X108.036 Y129.441 E.49084
G1 X108.036 Y128.89
G1 X99.682 Y137.244 E.52553
G1 X99.13 Y137.244
G1 X108.036 Y128.338 E.56022
G1 X107.76 Y128.063
G1 X98.855 Y136.968 E.56021
G1 X98.855 Y136.417
G1 X107.209 Y128.063 E.52552
G1 X106.657 Y128.063
G1 X98.855 Y135.865 E.49083
G1 X98.855 Y135.314
G1 X106.106 Y128.063 E.45615
G1 X105.555 Y128.063
G1 X98.855 Y134.762 E.42146
G1 X98.855 Y134.211
G1 X105.003 Y128.063 E.38677
G1 X104.452 Y128.063
G1 X98.855 Y133.66 E.35208
G1 X98.855 Y133.108
G1 X103.9 Y128.063 E.31739
G1 X103.349 Y128.063
G1 X98.855 Y132.557 E.28271
G1 X98.855 Y132.005
G1 X102.797 Y128.063 E.24802
G1 X102.246 Y128.063
G1 X98.855 Y131.454 E.21333
G1 X98.855 Y130.902
G1 X101.695 Y128.063 E.17864
G1 X101.143 Y128.063
G1 X98.855 Y130.351 E.14396
G1 X98.855 Y129.8
G1 X100.592 Y128.063 E.10927
G1 X100.04 Y128.063
G1 X98.855 Y129.248 E.07458
G1 X98.855 Y128.697
G1 X99.489 Y128.063 E.03989
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F6594.904
M204 S10000
G1 X98.855 Y128.697 E-.34078
G1 X98.855 Y129.248 E-.20954
G1 X99.245 Y128.858 E-.20968
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

