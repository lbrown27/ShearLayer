function [STRUCT] = find_avg_vel(STRUCT)
global N lower_length upper_length
for x_idx = 1:N
    for i = 1:length(STRUCT(5).case_vec)
        caseNum = STRUCT(5).case_vec(i);
        [~, ~, top_wall_BL, ~, ~,bottom_wall_BL,~,~] = getInfo(caseNum);
        [STRUCT] = find_splitter_idx(STRUCT);
        % top velocity
        for i = STRUCT(caseNum).splitter_idx:N
            if STRUCT(caseNum).y(i) > STRUCT(caseNum).y(STRUCT(caseNum).thickness_upper(x_idx))
                upper_idx = i;
                break;
            end
        end
        for i = STRUCT(caseNum).splitter_idx:N
            if STRUCT(caseNum).y(i) < upper_length - top_wall_BL
                upper_stop_idx = i;
            end
        end
        STRUCT(caseNum).top_vel(x_idx) = mean(STRUCT(caseNum).u(upper_idx:upper_stop_idx,x_idx));
        % bottom velocity
        for i = STRUCT(caseNum).splitter_idx:-1:1
            if STRUCT(caseNum).y(i) < (STRUCT(caseNum).y(STRUCT(caseNum).thickness_lower(x_idx)))
                lower_idx = i;
                break;
            end
        end
         for i = STRUCT(caseNum).splitter_idx:-1:1
            if STRUCT(caseNum).y(i) > -1 * lower_length + bottom_wall_BL
                lower_stop_idx = i;
            end
        end
        STRUCT(caseNum).bottom_vel(x_idx) = mean(STRUCT(caseNum).u(lower_stop_idx:lower_idx,x_idx));
    end
end