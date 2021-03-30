% grade is the thickness u wanna see (ex: 90 or 95)
function plot_colorplot(title1,plotvector, grade,caseNum) 
global X Y upper_speed lower_speed x y
% % subplot(3,2,j);
h = pcolor(X,Y,plotvector(1).u);
%[x_idx, y_idx] = find(q < 0);
title(title1); 
set(h,'EdgeColor','none')
colorbar();
hold on;
%[upper_speed,lower_speed] = find_avg_vel(q,y);
caxis([min(min(plotvector(1).u)) max(max(plotvector(1).u))]);
%[thick, middle] = plotThicknesses(x,y,q, grade);
end