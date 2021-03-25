function STRUCT = get_CFD_Data(turb_method,StructName)
global X Y
names = ["x_coordinate","y_coordinate","pressure","density",...
    "velocity_magnitude","x_velocity","y_velocity"];
indices = [2,3,4,10,12,13,14];
names = cellstr(names);
x_idx = 2;
y_idx = 3;
addpath('Data');
STRUCT = repmat(struct,5,1);
for j = 1:5
    filename = append('Data/',turb_method, ' Case ', num2str(j));
    fprintf(filename);
    if isfile(filename)
        fprintf(' file found\n');
        StructName(j).exists = 1; % make sure that the struct exists before doing stuff
        for i = 1:length(indices)
            if (isfield(StructName(j),(names{i})) == 0)
                
                F = unstructured_reader(filename,x_idx, y_idx,indices(i));
                STRUCT(j).(names{i}) = F(X,Y);
            else
                STRUCT(j).(names{i}) = StructName(j).(names{i});
            end
            %[STRUCT.thick, STRUCT.middle] = plot_colorplot(2,filename,q, 50);%last
            %num is the grade
        end
    else
        fprintf(' not a file\n');
    end
end
end