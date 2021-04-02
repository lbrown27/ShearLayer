function plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,caseNum)
figure();
eta = KW(1).eta;
legendvec = [];
if (~KW(caseNum).avg_normed_vel_profile == 0)
    plot(KW(caseNum).avg_normed_vel_profile , eta);
    legendvec = ['KW'];
end
hold on;
if (~KE(caseNum).avg_normed_vel_profile == 0)
    plot(KE(caseNum).avg_normed_vel_profile , eta);
    legendvec = [legendvec,"KE"];
end
if (~SA(caseNum).avg_normed_vel_profile == 0)
    plot(SA(caseNum).avg_normed_vel_profile , eta);
    legendvec = [legendvec,"SA"];
end
if (~RS(caseNum).avg_normed_vel_profile == 0)
    plot(RS(caseNum).avg_normed_vel_profile , eta);
    legendvec = [legendvec,"RS"];
end
if (~EMP(caseNum).avg_normed_vel_profile == 0)
    plot(EMP(caseNum).avg_normed_vel_profile , eta);
    legendvec = [legendvec,"EMP"];
end
legendvec = cellstr(legendvec);
legend(legendvec);
title(append(' case ',num2str(caseNum), ' average normalized velocity profile'));
end