function [STRUCT] = shearLayerThickness(STRUCT, grade)
global N
%if (~isfield(STRUCT, 'thickness'))
    %calculate upper shear layer thickness
    ydown = ones(1, N)*5;
    for q = 1:5
        if (isfield(STRUCT(q),'top_vel') && isfield(STRUCT(q),'bottom_vel'))
            upper_speed = STRUCT(q).top_vel;
            lower_speed = STRUCT(q).bottom_vel;
        else
            [upper_speed, lower_speed, ~, ~, ~, ~] = getInfo(q);
            upper_speed = upper_speed*ones(1,N);
            lower_speed = lower_speed*ones(1,N);
        end
        for i = 1:N
            bool = 0;
            for j = STRUCT(q).splitter_idx:-1:1
                if (STRUCT(q).u(j,i) < (2 - grade/100) * lower_speed(i) && bool == 0)
                    ydown(i) = j;
                    bool = 1;
                end
            end
        end
        
        yup = (N-1)* ones(1,N);
        for i = 1:N
            bool = 0;
            for j = STRUCT(q).splitter_idx:N
                if (STRUCT(q).u(j,i) > (grade/100 * upper_speed(i)) && bool == 0)
                    yup(i) = j;
                    bool = 1;
                end
            end
        end
        if (isfield(STRUCT(q),'x')&& length(STRUCT(q).x) > 0)
            for i = 1:N
                STRUCT(q).thickness(i) = STRUCT(q).y(yup(i)) - STRUCT(q).y(ydown(i));
            end
            STRUCT(q).thickness_upper = yup;
            STRUCT(q).thickness_lower = ydown;
        end
    end
    
%else
    %fprintf('\nwe already have the thicknesses \n');
end