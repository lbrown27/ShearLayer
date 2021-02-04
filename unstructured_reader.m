function F = unstructured_reader(fname,x_idx, y_idx, idx)
% Reads column-formatted data, resorts according to x,y coordinates
% Needs to be generalized for reading multiple indices and for 3D coords

T = readtable(fname);
A = table2array(T);
Asize = size(A);
nrows = Asize(1);

%%
x = A(:,x_idx);
y = A(:,y_idx);
q = A(:,idx);
min(q)
F = scatteredInterpolant(x,y,q);

end