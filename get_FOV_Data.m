function [STRUCT] = get_FOV_Data(x_empirical, y_empirical, Q, StructName)
global X Y
%dim = size(Q);
names = ["x","y","u","v","w","absv","Rexx","Reyy","Rezz","Rexy"];
names = cellstr(names);
for j = 1:5
StructName(j).exists = 1;
for i = 1:length(names)
    if (isfield(StructName,(names{i})) == 0)
        mat = Q.j;
        F = scatteredInterpolant(x_empirical, y_empirical, mat(:,i));
        STRUCT(j).(names{i}) = F(X,Y);
    else
        STRUCT(j).(names{i}) = StructName.(names{i});
    end    
end
end
end