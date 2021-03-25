function [STRUCT] = get_FOV_Data(x_empirical, y_empirical, Q, StructName)
global X Y
names = ["x","y","u","v","w","absv","Rexx","Reyy","Rezz","Rexy"];
names = cellstr(names);
for j = 1:5
StructName(j).exists = 1;
for i = 1:length(names)
    if (isfield(StructName(j),(names{i})) == 0)
        str = append("case_",num2str(j));
        mat = Q.(str);
        F = scatteredInterpolant(mat(:,2), mat(:,2), mat(:,i));
        STRUCT(j).(names{i}) = F(X,Y);
    else
        STRUCT(j).(names{i}) = StructName(j).(names{i});
    end    
end
end
end