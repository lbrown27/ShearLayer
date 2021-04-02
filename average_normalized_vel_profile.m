function [avg_normed_vel_profiles] = average_normalized_vel_profile(STRUCT, caseNum)
[x_size, y_size] = size(STRUCT(caseNum).normed_profiles);
if (~(length(STRUCT(caseNum).X) == 0))
    for i = 1: y_size
        avg_normed_vel_profiles(i) = sum(STRUCT(caseNum).normed_profiles(:,i))/x_size;
    end
else if (length(STRUCT(caseNum).X) == 0)
        avg_normed_vel_profiles = [];
    end
end
end