function [STRUCT] = plotThicknesses(STRUCT,caseNum, grade)
STRUCT = shearLayerThickness(STRUCT, grade);
plot(STRUCT(caseNum).x,STRUCT(caseNum).y(STRUCT(caseNum).thickness_upper));
title('up thickness');
plot(STRUCT(caseNum).x,STRUCT(caseNum).y(STRUCT(caseNum).thickness_lower));
title('down thickness');
end