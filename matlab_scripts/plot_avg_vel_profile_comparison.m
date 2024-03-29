function plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,caseNum)
figure();
eta = KW(1).eta;
legendvec = [];
if (ismember(caseNum, KW(5).case_vec))
    plot(KW(caseNum).avg_normed_vel_profile , eta, 'm', 'LineWidth', 2);
    legendvec = ['K - omega', "k-w + one standard deviation", "k-w - one standard deviation"];
    hold on;
    plot(KW(caseNum).standard_dev_vel_prof + KW(caseNum).avg_normed_vel_profile , eta, 'm--', 'LineWidth', 2);
    plot(-1*KW(caseNum).standard_dev_vel_prof + KW(caseNum).avg_normed_vel_profile , eta, 'm:', 'LineWidth', 2);
end
hold on;
if (ismember(caseNum, KE(5).case_vec))
    plot(KE(caseNum).avg_normed_vel_profile , eta,'c', 'LineWidth', 2);
    plot(KE(caseNum).standard_dev_vel_prof + KE(caseNum).avg_normed_vel_profile , eta, 'c--', 'LineWidth', 2);
    plot(-1*KE(caseNum).standard_dev_vel_prof + KE(caseNum).avg_normed_vel_profile , eta, 'c:', 'LineWidth', 2);
    legendvec = [legendvec,"K - Epsilon", "k-e + one standard deviation", "k-e - one standard deviation"];
% end
% if (ismember(caseNum, SA(5).case_vec))
%     plot(SA(caseNum).avg_normed_vel_profile , eta,'r', 'LineWidth', 2);
%     plot(SA(caseNum).standard_dev_vel_prof + SA(caseNum).avg_normed_vel_profile , eta, 'r--', 'LineWidth', 2);
%     plot(-1*SA(caseNum).standard_dev_vel_prof + SA(caseNum).avg_normed_vel_profile , eta, 'r:', 'LineWidth', 2);
%     legendvec = [legendvec,"Spalart Allmaras", "SA + one standard deviation", "SA - one standard deviation"];
% end
if (ismember(caseNum, RS(5).case_vec))
    plot(RS(caseNum).avg_normed_vel_profile , eta, 'g', 'LineWidth', 2);
    plot(RS(caseNum).standard_dev_vel_prof + RS(caseNum).avg_normed_vel_profile , eta, 'g--', 'LineWidth', 2);
    plot(-1*RS(caseNum).standard_dev_vel_prof + RS(caseNum).avg_normed_vel_profile , eta, 'g:', 'LineWidth', 2);
    legendvec = [legendvec,"Reynolds Stress", "RS + one standard deviation", "RS - one standard deviation"];
end
if (caseNum == 4 && ismember(caseNum, EMP(5).case_vec))
    plot(EMP(caseNum).avg_normed_vel_profile , eta,'b', 'LineWidth', 2);
    plot(EMP(caseNum).standard_dev_vel_prof + EMP(caseNum).avg_normed_vel_profile , eta, 'b--', 'LineWidth', 2);
    plot(-1*EMP(caseNum).standard_dev_vel_prof + EMP(caseNum).avg_normed_vel_profile , eta, 'b:', 'LineWidth', 2);
    legendvec = [legendvec,"Empirical Data", "Empirical Data + one standard deviation", "Empirical Data - one standard deviation"];
end
    legendvec = [legendvec,"Reynolds Stress", "RS + one standard deviation", "RS - one standard deviation", "data digitized from paper"];

legendvec = cellstr(legendvec);
legend(legendvec);
title(append(' case ',num2str(caseNum), ' average normalized velocity profile'),'FontSize' , 20);
xlabel('(U-U2) / delta U','FontSize' , 20);
ylabel('eta, or (y - y0) / b','FontSize' , 20)
ylim([-1.5 1.5]);
end