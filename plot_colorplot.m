function [thick_KE, middle_KE] = plot_colorplot(j,title1,q)
global X Y upper_speed lower_speed x y
subplot(3,2,j);
h = pcolor(X,Y,q);
%[x_idx, y_idx] = find(q < 0);
title(title1);
set(h,'EdgeColor','none')
colorbar();
hold on;
[upper_speed,lower_speed] = find_avg_vel(q,y);
caxis([(lower_speed - 30) (upper_speed + 30)]);
[thick_KE, middle_KE] = plotThicknesses(x,y,q);
end