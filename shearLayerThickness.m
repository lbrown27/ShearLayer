function [ydown, yup, thickness, middle] = shearLayerThickness(x,y,q, grade)
global upper_speed lower_speed N splitter_idx 
%calculate upper shear layer thickness
ydown = ones(1, N)*5;
find_splitter_idx(y);
for i = 2:N
    bool = 0;
    for j = splitter_idx:-1:150
       if (q(j,i) < (2 -  grade/100) * lower_speed && bool == 0)
           ydown(i) = j;
           bool = 1;
       end  
    end
end

yup = (N-1)* ones(1,N);
for i = 2:N
    bool = 0;
    for j = splitter_idx:N
       if (q(j,i) > (grade/100 * upper_speed) && bool == 0)
           yup(i) = j;
           bool = 1;
       end  
    end
end
thickness = zeros(N,1);
middle = zeros(N,1);
for i = 2:N
thickness(i) = y(1,yup(i)) - y(1,ydown(i));
middle(i) = (y(1,yup(i)) + y(1,ydown(i))) / 2;
end
end