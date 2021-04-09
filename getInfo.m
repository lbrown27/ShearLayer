function [upper_speed, lower_speed, top_wall_BL, splitter_plate_top_BL,...
    splitter_plate_bottom_BL, bottom_wall_BL,fully_developed_region_start,...
    fully_developed_region_stop] = getInfo(num)
upper_speed_vec = [156.25, 314.89, 434.76, 509.24,564.16];
lower_speed_vec = [30.35, 64.75, 97.28, 92.57, 59.76];
top_wall_BL_vec = [2.877, 2.278, 3.054, 3.599, 4.605];
splitter_plate_top_BL_vec = [2.237, 1.397, 2.25, 2.847, 3.108];
splitter_plate_bottom_BL_vec = [5.137,5.168, 4.394, 4.271, 4.007];
bottom_wall_BL_vec = [4.692, 4.606, 4.673, 4.212, 3.06];
fully_developed_region_start_vec = [.29,.25,.21,.21,.22];
fully_developed_region_stop_vec = [.32,.3,.23,.225,.232];
upper_speed = upper_speed_vec(num);
lower_speed = lower_speed_vec(num);
top_wall_BL = top_wall_BL_vec(num)*1e-3;
splitter_plate_top_BL = splitter_plate_top_BL_vec(num)*1e-3;
splitter_plate_bottom_BL = splitter_plate_bottom_BL_vec(num)*1e-3;
bottom_wall_BL = bottom_wall_BL_vec(num)*1e-3;
fully_developed_region_start = fully_developed_region_start_vec(num);
fully_developed_region_stop = fully_developed_region_stop_vec(num);

end