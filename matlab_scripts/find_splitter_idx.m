function [STRUCT] = find_splitter_idx(STRUCT)
for i = 1:5
    [~,STRUCT(i).splitter_idx]= min(abs(STRUCT(i).y));
end
end