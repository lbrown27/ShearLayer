function [y95down, y95up, thickness, middle] = shearLayerThickness(x,y,q)
global upper_speed lower_speed N splitter_idx 
%calculate upper shear layer thickness
y95down = ones(1, N)*5;
find_splitter_idx(y);
for i = 2:N
    bool = 0;
    for j = splitter_idx:-1:150
       if (q(j,i) < 1.1 * lower_speed && bool == 0)
           y95down(i) = j;
           bool = 1;
       end  
    end
end

y95up = (N-1)* ones(1,N);
for i = 2:N
    bool = 0;
    for j = splitter_idx:N
       if (q(j,i) > (.9 * upper_speed) && bool == 0)
           y95up(i) = j;
           bool = 1;
       end  
    end
end
thickness = zeros(N,1);
middle = zeros(N,1);
for i = 2:N
thickness(i) = y(1,y95up(i)) - y(1,y95down(i));
middle(i) = (y(1,y95up(i)) + y(1,y95down(i))) / 2;
end
end