function STRUCT = get_CFD_Data(turb_method,StructName, params)
global X Y N
names = ["x","y","pressure","density"...
    "velocity_magnitude","u","v"];
names = [names,params];
indices = data_key(names);
names = cellstr(names);
x_idx = 2;
y_idx = 3;
addpath('Data');
STRUCT = repmat(struct,5,1);

%% this section just copied and pasted in to test something
% x = linspace(0,.762,N);
% y = linspace(-.0762,.0508,N);
% [X,Y] = meshgrid(x,y);
%%
for j = 1:5
    filename = append('Data/',turb_method, ' Case ', num2str(j));
    fprintf(filename);
    if isfile(filename)
        fprintf(' file found\n');
        StructName(j).exists = 1; % make sure that the struct exists before doing stuff
        if (isfield(StructName(j),(names{1})) == 0)
                F = unstructured_reader(filename,x_idx, y_idx,indices(1));
                STRUCT(j).(names{1}) = F(X,Y);
        end
        if (isfield(StructName(j),(names{2})) == 0)
                F = unstructured_reader(filename,x_idx, y_idx,indices(2));
                STRUCT(j).(names{2}) = F(X,Y);
        end
        for i = 3:length(indices)
            if (isfield(StructName(j),(names{i})) == 0)
                F = unstructured_reader(filename,x_idx, y_idx,indices(i));
                STRUCT(j).(names{i}) = F(STRUCT(j).x,STRUCT(j).y);
            end
            %[STRUCT.thick, STRUCT.middle] = plot_colorplot(2,filename,q, 50);%last
            %num is the grade
        end
    else
        fprintf(' not a file\n');
    end
end
end