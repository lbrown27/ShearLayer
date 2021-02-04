function [top_vel, bottom_vel] = find_avg_vel(q,y)
global top_wall_BL splitter_plate_top_BL splitter_plate_bottom_BL ...
    bottom_wall_BL splitter_idx N delta_U
find_splitter_idx(y);
% top velocity
for i = splitter_idx:N
    if y(i) > splitter_plate_top_BL
        upper_idx = i;
        break;
    end
end
top_vel = mean(q(upper_idx:N,1));
% bottom velocity
for i = splitter_idx:-1:1
    if y(i) < splitter_plate_bottom_BL
        lower_idx = i;
        break;
    end
end
bottom_vel = mean(q(1:lower_idx,1));
delta_U = top_vel - bottom_vel;
end