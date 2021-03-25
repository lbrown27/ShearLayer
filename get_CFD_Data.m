function STRUCT = get_CFD_Data(filename,StructName)
global X Y
names = ["x_coordinate","y_coordinate","pressure","density",...
    "velocity_magnitude","x_velocity","y_velocity","mach_number"];
indices = [2,3,4,10,12,13,14,18];
names = cellstr(names);
x_idx = 2;
y_idx = 3;
StructName.exists = 1; % make sure that the struct exists before doing stuff
for i = 1:length(indices)
    if (isfield(StructName,(names{i})) == 0)
        F = unstructured_reader(filename,x_idx, y_idx,indices(i));
        STRUCT.(names{i}) = F(X,Y);
    else 
        STRUCT.(names{i}) = StructName.(names{i});
    end
    %q = F(X,Y);
    %[STRUCT.thick, STRUCT.middle] = plot_colorplot(2,filename,q, 50);%last
    %num is the grade
end
end