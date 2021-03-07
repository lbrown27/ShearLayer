function [thick, middle] = find_negative_colorplot_vals(q)
global  x y
[numRows,numCols] = size(q);
for i = 1:numRows
    for j = numCols
        if q(i,j) < 0
        plot(x(j),y(i),'r.');
        end
    end
end
end