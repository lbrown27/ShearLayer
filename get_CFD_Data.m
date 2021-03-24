function STRUCT = get_CFD_Data(x_empirical, y_empirical, T)
global X Y
dim = size(T);
len = dim(2);
names = ["x","y","u","v","w","absv","Rexx","Reyy","Rezz","Rexy"];
names = cellstr(names);
for i = 1:len
    F = scatteredInterpolant(x_empirical, y_empirical, T(:,i));
    STRUCT.(names{i}) = F(X,Y);
end
end