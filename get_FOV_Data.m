function [STRUCT] = get_FOV_Data(Q, StructName)
global N

names = ["x","y","u","v","w","absv","Rexx","Reyy","Rezz","Rexy"];
names = cellstr(names);
STRUCT = repmat(struct,5,1);
for j = 1:5
    StructName(j).exists = 1;
    str = append("case_",num2str(j));
    mat = Q.(str);
    mat(:,1) = mat(:,1)/1e3;
    mat(:,2) = mat(:,2)/1e3;
    x = linspace(min(mat(:,1)), max(mat(:,1)), N); % resize otherwise matrix created will be too large for matlab.
    y = linspace(min(mat(:,2)), max(mat(:,2)), N); % and convert mm to meters.
    [X,Y] = meshgrid(x,y);
    STRUCT(j).x = x;
    STRUCT(j).y = y;
    STRUCT(j).X = X;
    STRUCT(j).Y = Y;
    for i = 3:length(names)
        if (isfield(StructName(j),(names{i})) == 0)
            
            F = scatteredInterpolant(mat(:,1), mat(:,2), mat(:,i));
            STRUCT(j).(names{i}) = F(X,Y);
            if (i == 3)
                STRUCT(j).F_u = F;
            end
        else
            STRUCT(j).(names{i}) = StructName(j).(names{i});
            if (i == 3)
                STRUCT(j).F_u = StructName(j).F_u;
            end
        end
    end
end
end