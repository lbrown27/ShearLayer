function STRUCT = get_CFD_Data(turb_method,StructName,EMP,params)
global X Y N
names = ["x","y","pressure","density","u","v"];
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
        if (isfield(StructName(j),(names{1})) == 0) % x
            fprintf('not a field.\n');
            F = unstructured_reader(filename,x_idx, y_idx,indices(1));
            T = readtable(filename);
            A = table2array(T);
            x = A(:,x_idx);
            y = A(:,y_idx);
            x_grid = linspace(0,max(max(EMP(1).X)),N);
            y_grid = linspace(min(min(EMP(1).Y)),max(max(EMP(1).Y)),N);
            [X,Y] = meshgrid(x_grid,y_grid);
            STRUCT(j).x = x_grid;
            STRUCT(j).X = X;
            STRUCT(j).y = y_grid;
            STRUCT(j).Y = Y;
        else
            STRUCT(j).x = StructName(j).x;
            STRUCT(j).X = StructName(j).X;
            STRUCT(j).y = StructName(j).y;
            STRUCT(j).Y = StructName(j).Y;
        end
        for i = 3:length(indices)
            if (isfield(StructName(j),(names{i})) == 0)
                fprintf('not a field.\n');
                F = unstructured_reader(filename,x_idx, y_idx,indices(i));
                STRUCT(j).(names{i}) = F(STRUCT(j).X,STRUCT(j).Y);
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