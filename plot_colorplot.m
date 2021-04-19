% grade is the thickness u wanna see (ex: 90 or 95)
function plot_colorplot(title1,plotvector,grade, caseNum, parameter,EMP,toggle_thicknesslines)
global upper_speed lower_speed x y
h = pcolor(EMP(caseNum).X,plotvector(caseNum).Y,plotvector(caseNum).(char(parameter)));
title(title1); 
set(h,'EdgeColor','none')
colorbar();
hold on;
caxis([min(min(plotvector(caseNum).(char(parameter)))) max(max(plotvector(caseNum).(char(parameter))))]);
if (strcmp(toggle_thicknesslines, 'thicknesslines_on'))
    plotThicknesses(plotvector,caseNum);
end
end