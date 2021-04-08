function [avg_normed_vel_profiles, standard_dev] = average_normalized_vel_profile(STRUCT, caseNum)
[x_size, y_size] = size(STRUCT(caseNum).normed_profiles);
if (~(length(STRUCT(caseNum).X) == 0))
    for i = 1: y_size
        avg_normed_vel_profiles(i) = sum(STRUCT(caseNum).normed_profiles(:,i))/x_size;
                standard_dev(i) =std(STRUCT(caseNum).normed_profiles(:,i));

    end
else if (length(STRUCT(caseNum).X) == 0)
        avg_normed_vel_profiles = [];
        standard_dev = [];
    end
end
end