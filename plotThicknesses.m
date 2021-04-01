function [STRUCT] = plotThicknesses(STRUCT,caseNum, grade)
STRUCT = shearLayerThickness(STRUCT, grade);
plot(STRUCT(caseNum).x,STRUCT(caseNum).y(STRUCT(caseNum).yup));
title('up thickness');
plot(STRUCT(caseNum).x,STRUCT(caseNum).y(STRUCT(caseNum).ydown));
title('down thickness');
end