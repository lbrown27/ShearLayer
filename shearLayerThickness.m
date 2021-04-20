function [STRUCT] = shearLayerThickness(STRUCT, grade)
global N
%if (~isfield(STRUCT, 'thickness'))
%calculate upper shear layer thickness
ydown = ones(1, N)*5;
for q = 1:length(STRUCT(5).case_vec)
    caseNum = STRUCT(5).case_vec(q);
    if (isfield(STRUCT(caseNum),'top_vel') && isfield(STRUCT(caseNum),'bottom_vel'))
        upper_speed = STRUCT(caseNum).top_vel;
        lower_speed = STRUCT(caseNum).bottom_vel;
        
    else
        [upper_speed, lower_speed, ~, ~, ~, ~] = getInfo(caseNum);
        upper_speed = upper_speed * ones(1,N);
        lower_speed = lower_speed * ones(1,N);
        fprintf('\nyou should call top vel and bottom vel first or again for more accurate results.\n');
    end
    for i = 1:N
        for j = STRUCT(caseNum).splitter_idx:-1:1
            if (STRUCT(caseNum).u(j,i) < (2 - grade/100) * lower_speed(i))
                ydown(i) = j;
                break;
            end
        end
    end
    
    yup = (N-1)* ones(1,N);
    for i = 1:N
        
        for j = STRUCT(caseNum).splitter_idx:N
            if (STRUCT(caseNum).u(j,i) > (grade/100 * upper_speed(i)))
                yup(i) = j;                
                break;
            end
        end
    end
    for i = 1:N
        
        STRUCT(caseNum).thickness(i) = STRUCT(caseNum).y(yup(i)) - STRUCT(caseNum).y(ydown(i));
    end
        STRUCT(caseNum).thickness_upper_previous = STRUCT(caseNum).thickness_upper;
        STRUCT(caseNum).thickness_lower_previous = STRUCT(caseNum).thickness_lower;
        STRUCT(caseNum).thickness_upper = yup;
        STRUCT(caseNum).thickness_lower = ydown;
end
end
