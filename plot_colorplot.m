% grade is the thickness u wanna see (ex: 90 or 95)
function plot_colorplot(title1,plotvector,grade, caseNum, parameter)
global upper_speed lower_speed x y
% % subplot(3,2,j);
%parameter = cellstr(parameter);
h = pcolor(plotvector(caseNum).X,plotvector(caseNum).Y,plotvector(caseNum).(char(parameter)));
%[x_idx, y_idx] = find(q < 0);
title(title1); 
set(h,'EdgeColor','none')
colorbar();
hold on;
%[upper_speed,lower_speed] = find_avg_vel(q,y);
caxis([min(min(plotvector(caseNum).(char(parameter)))) max(max(plotvector(caseNum).(char(parameter))))]);
%[thick, middle] = plotThicknesses(x,y,q, grade);
end