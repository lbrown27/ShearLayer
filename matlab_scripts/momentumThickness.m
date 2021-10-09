function ms = momentumThickness(x,y,q)
global upper_speed lower_speed N splitter_idx delta_U
sumBottom = 0;
sumTop = 0;
for i = 1:200
for j = 51:-1:5
    k = q(j,i)/68.6;
    sumBottom = sumBottom + k*(1-k)*(y(j+1,1) - y(j,1));
end
for j = 52:98
    k = q(j,i)/274.4;
    sumTop = sumTop + k*(1-k)*(y(j+1,1) - y(j,1));
end
ms(i) = sumTop - sumBottom;
sumBottom = 0;
sumTop = 0;
end

end