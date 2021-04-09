function [STRUCT] = plotThicknesses(STRUCT,caseNum)
x = STRUCT(caseNum).X(1,:);
y = STRUCT(caseNum).Y(:,1);
plot(x,y(STRUCT(caseNum).thickness_upper));
plot(x,y(STRUCT(caseNum).thickness_lower));
end