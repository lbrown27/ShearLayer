function [profile, eta] = plot_normalized_vels(title1, STRUCT, caseNum,grade)
% plots vel profiles from .02 to .22 with step size of .02.
if (~(length(STRUCT(caseNum).X) == 0))
    for i = 1:11
        [profile(i,:), eta] = plot_normalized_vel(STRUCT, i*.02, caseNum,grade);
        hold on;
    end
    title(title1);
else
    profile = [];
    eta = [];
end
end