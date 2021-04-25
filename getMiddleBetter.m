function STRUCT = getMiddleBetter(STRUCT)
global N
for q = 1:5
    if (isfield(STRUCT(q),'x')&& length(STRUCT(q).x) > 0)
        for i = 1:N
            lower_thick_idx = STRUCT(q).thickness_lower(i);
            upper_thick_idx = STRUCT(q).thickness_upper(i);
            lowest = 100000;
            for j = lower_thick_idx : upper_thick_idx
                val = abs(STRUCT(q).u(j,i)- (STRUCT(q).top_vel(i) + STRUCT(q).bottom_vel(i))/2);
                if val < lowest
                    lowest = val;
                    idx = j;
                end
                STRUCT(q).middle(i) = STRUCT(q).y(idx);
            end
        end
    end
end
end