function [STRUCT] = get_FOV_Data(x_empirical, y_empirical, T)
global X Y N
dim = size(T);
len = dim(2);
for i = 1:len
 F = scatteredInterpolant(x_empirical, y_empirical, T(:,i));
 data(i,:,:) = F(X,Y);
end
STRUCT_Table = table(data(1,:,:), data(2,:,:), data(3,:,:), 'VariableNames',{'x_mat' 'y_mat' 'u_mat'});
STRUCT = table2struct(STRUCT_Table);
STRUCT.x_mat = reshape(STRUCT.x_mat, N,[]);
STRUCT.y_mat = reshape(STRUCT.y_mat, N,[]);
STRUCT.u_mat = reshape(STRUCT.u_mat, N,[]);
end