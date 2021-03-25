function plot_colorplot(j,title1,EMP, grade)
global X Y upper_speed lower_speed x y
% % subplot(3,2,j);
h = pcolor(EMP.x,EMP.y,EMP.u);
%[x_idx, y_idx] = find(q < 0);
title(title1);
set(h,'EdgeColor','none')
colorbar();
hold on;
%[upper_speed,lower_speed] = find_avg_vel(q,y);
caxis([min(min(EMP.u)) max(max(EMP.u))]);
%[thick, middle] = plotThicknesses(x,y,q, grade);
end