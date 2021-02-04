function [] = find_splitter_idx(y)
global splitter_idx
[splitter,splitter_idx]= min(abs(y));
end