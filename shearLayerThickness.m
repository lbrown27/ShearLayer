function [STRUCT] = shearLayerThickness(STRUCT, grade)
global N splitter_idx
%calculate upper shear layer thickness
ydown = ones(1, N)*5;
for q = 1:5
    [upper_speed, lower_speed, ~, ~, ~, ~] = getInfo(q);
    for i = 1:N
        bool = 0;
        for j = STRUCT(q).splitter_idx:-1:N
            if (STRUCT(q).u(j,i) < (2 -  grade/100) * lower_speed && bool == 0)
                ydown(i) = j;
                bool = 1;
            end
        end
    end
    
    yup = (N-1)* ones(1,N);
    for i = 2:N
        bool = 0;
        for j = STRUCT(q).splitter_idx:N
            if (STRUCT(q).u(j,i) > (grade/100 * upper_speed) && bool == 0)
                yup(i) = j;
                bool = 1;
            end
        end
    end
    % thickness = zeros(N,1);
    % middle = zeros(N,1);
    if (isfield(STRUCT(q),'x')&& length(STRUCT(q).x) > 0)
        for i = 1:N
            STRUCT(q).thickness(i) = STRUCT(q).y(yup(i)) - STRUCT(q).y(ydown(i));
            STRUCT(q).middle(i) = (STRUCT(q).y(yup(i)) + STRUCT(q).y(ydown(i))) / 2;
        end
        STRUCT(q).yup = yup;
        STRUCT(q).ydown = ydown;
    end
end
end