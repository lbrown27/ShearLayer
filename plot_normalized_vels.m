function [profile, eta] = plot_normalized_vels(title1, STRUCT, caseNum,grade)
% plots vel profiles from .02 to .22 with step size of .02.
if (~(length(STRUCT(caseNum).X) == 0))
[~, ~, ~, ~, ~, ~,fully_developed_region_start,fully_developed_region_stop] = getInfo(caseNum);
count = 1;
profile = [];
eta = 1;
    for i = fully_developed_region_start:.01:fully_developed_region_stop
        [profile(count,:), eta] = plot_normalized_vel(STRUCT, i, caseNum,grade);
        count = count + 1;
        
    end
    count
    title(title1);
else
    profile = [];
    eta = [];
end
end