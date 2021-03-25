function [STRUCT] = get_FOV_Data(Q, StructName)
global X Y N

names = ["x","y","u","v","w","absv","Rexx","Reyy","Rezz","Rexy"];
names = cellstr(names);
STRUCT = repmat(struct,5,1);
for j = 1:5
StructName(j).exists = 1;
for i = 1:length(names)
    if (isfield(StructName(j),(names{i})) == 0)
        str = append("case_",num2str(j));
        mat = Q.(str);
        F = scatteredInterpolant(mat(:,1), mat(:,2), mat(:,i));
        x = linspace(min(mat(:,1)), max(mat(:,1)), N); % resize otherwise matrix created will be too large for matlab.
        y = linspace(min(mat(:,2)), max(mat(:,2)), N);
        [X,Y] = meshgrid(x,y);
        STRUCT(j).(names{i}) = F(X,Y);
    else
        STRUCT(j).(names{i}) = StructName(j).(names{i});
    end    
end
end
end