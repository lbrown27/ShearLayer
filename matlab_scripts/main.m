%% setup
close all;
global N lower_length upper_length grade
N = 1000; % # grid points in each direction
grade = 85;

%% Grab Data
data_on = input('\ncollect or refresh data? 1 = yes, other = no. \n','s');
if (strcmp('1',data_on) == 1)
    if (exist('EMP')== 0)
        EMP= struct;
        fprintf('Emp doesnt exist!');
    end
    if (exist('KW')== 0)
        KW = struct;
    end
    if (exist('KE')== 0)
        KE = struct;
        fprintf('KE doesnt exist!');
    end
    if (exist('SA')== 0)
        SA = struct;
    end
    if (exist('RS')== 0)
        RS = struct;
    end
    
    [KW,KE,SA,RS,EMP] = grab_all_data(KW,KE,SA,RS,EMP);
end
%% compare by case
% comparison_view("u", EMP, KW,KE,SA,RS,'KW','thicknesslines_on');
% comparison_view("u", EMP, KW,KE,SA,RS,'KE','thicknesslines_on');
% comparison_view("u", EMP, KW,KE,SA,RS,'SA','thicknesslines_on');
% comparison_view("u", EMP, KW,KE,SA,RS,'RS','thicknesslines_on');
% comparison_view("u", EMP, KW,KE,SA,RS,'EMP','thicknesslines_on');

%% thickness
close all;
figure();

plot_colorplot("e",KW(1),grade, 1, 'u',EMP,'thicknesslines_on');


plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,1);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,2);
hold on;
T = readtable('Default Dataset.csv');
T = table2array(T);
plot(T(:,1),T(:,2),'k--', 'LineWidth', 4);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,3);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,4);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,5);

comparison_view('u', EMP, KW,KE,SA,RS,1,'thicknesslines_on');
comparison_view('u', EMP, KW,KE,SA,RS,2,'thicknesslines_on');
comparison_view('u', EMP, KW,KE,SA,RS,3,'thicknesslines_on');
comparison_view('u', EMP, KW,KE,SA,RS,4,'thicknesslines_on');
comparison_view('u', EMP, KW,KE,SA,RS,5,'thicknesslines_on');

%% growth rate calculations


EMP_growth = [1.07,.9,.71,.61,.58];
figure();
size = 5;
Mc = [.185,.381,.546,.690,.883];

for i = 1:5
    KW_normed_grs(i) = KW(i).normed_gr;
    KE_normed_grs(i) = KE(i).normed_gr;
    SA_normed_grs(i) = SA(i).normed_gr;
    RS_normed_grs(i) = RS(i).normed_gr;
end
for i = 1:5
    plot(Mc,KW_normed_grs,'o','MarkerSize',size);
    hold on;
    plot(Mc,KE_normed_grs,'^','MarkerSize',size);
    plot(Mc,SA_normed_grs,'+','MarkerSize',size);
    plot(Mc,RS_normed_grs,'s','MarkerSize',size);
end
plot(Mc,EMP_growth);
legend('K - omega','K - epsilon','Spalart Allmaras','Reynolds Stress','Empirical Data');

title('growth rate comparison');
xlabel('Mc, convective mach number');
ylabel('db/dx, shear layer growth rate');
% ylim([0,1.2]);
% xlim([0,2.5]);

%% 
plot_all_profiles(KW,1);
yvec = linspace(-2,2,N);
plot(zeros(1,N),yvec);