function [thickness, middle] = plotThicknesses(x,y,q, grade)
global N
[lowerShearThickness, upperShearThickness, thickness, middle] = shearLayerThickness(x,y,q, grade);
hold on;

thicknessVecLow = ones(1,N-1);
thicknessVecHigh = ones(1, N-1);
for i = 2:N
    thicknessVecLow(i) = y(1,lowerShearThickness(1,i));
    thicknessVecHigh(i) = y(1,upperShearThickness(1,i));
end
%plot(x(1,2:end), thicknessVecLow(2:end),'Color','r');
%plot(x(1,2:end), thicknessVecHigh(2:end),'Color','r');
end