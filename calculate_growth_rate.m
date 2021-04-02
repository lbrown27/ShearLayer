function db_dx = calculate_growth_rate(STRUCT)
db_dx = zeros(5,1);
for i = 1:5
    [~, ~, ~, ~, ~, ~,fully_developed_region_start,fully_developed_region_stop] = getInfo(i);
    [~,x_idx_start] = min(abs(STRUCT(i).x-fully_developed_region_start));
    [~,x_idx_stop] = min(abs(STRUCT(i).x-fully_developed_region_stop));
    if (isfield(STRUCT(i),'thickness') && ~isempty(STRUCT(i).thickness))
    db_dx(i) = (STRUCT(i).thickness(x_idx_stop) - STRUCT(i).thickness(x_idx_start))...
        /(STRUCT(i).x(x_idx_stop) - STRUCT(i).x(x_idx_start));
    else 
        fprintf('\ntoad\n');
    end
   
end
end