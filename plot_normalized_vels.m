function plot_normalized_vels(x,F, title1,q, thick, middle)
global N lower_speed upper_speed delta_U y
[upper_speed,lower_speed] = find_avg_vel(q,y);
delta_U = upper_speed - lower_speed;
figure();
for i = 0:2
    x0 = .18 + i * .02;
plot_normalized_vel(x,F,q,thick,middle,x0);
hold on;
end
title(title1);
end