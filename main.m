%% setup
close all;
clc;
global N lower_length upper_length
N = 60; % # grid points in each direction
caseNum = 4;
lower_length = .0762; % in m
upper_length = .0508; % in m
test_section_length = .762; % in m
%=============================Setup Complete===============================

% read the Empirical (EMP) FOV data
Q = read_raw_EMP_data(caseNum);
if (exist('EMP')== 0)
    EMP= struct;
    fprintf('Emp doesnt exist!');
end
[EMP] = get_FOV_Data(Q, EMP);
grade = 99;
max_XL = .33;
%plot_colorplot(append('u velocity empirical case ', num2str(caseNum)),EMP, grade, caseNum,'u');

%% Load CFD Data
if (exist('KW')== 0)
    KW = struct;
end
%KW = get_CFD_Data('k-w', KW,EMP,[],max(EMP(1).x));
KW = get_CFD_Data('k-w', KW,EMP,[],max_XL);
if (exist('KE')== 0)
    KE = struct;
    fprintf('KE doesnt exist!');
end
KE = get_CFD_Data('k-e', KE,EMP,[],max_XL);

if (exist('SA')== 0)
    SA = struct;
end
SA = get_CFD_Data('SA', SA,EMP,[],max_XL);
if (exist('RS')== 0)
    RS = struct;
end
RS = get_CFD_Data('RS', RS,EMP,[],max_XL);

RS = find_splitter_idx(RS);
KE = find_splitter_idx(KE);
KW = find_splitter_idx(KW);
SA = find_splitter_idx(SA);
EMP = find_splitter_idx(EMP);
%%

x = 1;
[KE] = find_avg_vel(KE,x,grade);
[RS] = find_avg_vel(RS,x,grade);
[KW] = find_avg_vel(KW,x,grade);
[SA] = find_avg_vel(SA,x,grade);
[EMP] = find_avg_vel(EMP,x,grade);
% figure();
% subplot(3,2,1)
%plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, .01);
% title('empirical data');
%
% subplot(3,2,2);
% plot_vels(x,F_KW, 'kw',q_KW, thick_KW, middle_KW, 0.01);
% title('k - epsilon data');
%
%
% %% page 140 graphs
%plot_normalized_vels(x,F_KW,'k-e Profiles', q_KW, thick_KW, middle_KW);
%plot_normalized_vels(x, F_ED, 'empirical profiles', q_ED, thick_ED, middle_ED);
%

%% testing
caseNum = 1;
%figure();
%plot_colorplot(append('k-e case ', num2str(caseNum)),KE, grade, caseNum, 'u');
comparison_view("u", EMP, KW,KE,SA,RS,'KW');
comparison_view("u", EMP, KW,KE,SA,RS,'KE');
comparison_view("u", EMP, KW,KE,SA,RS,'SA');
comparison_view("u", EMP, KW,KE,SA,RS,'RS');
comparison_view("u", EMP, KW,KE,SA,RS,'EMP');
%comparison_view(cellstr("u"), EMP, KW,KE,SA,RS, 'KW');


%% find average velocities (put this back in if thing breaks)
% x = 1;
% [KE] = find_avg_vel(KE,x,grade);
% [RS] = find_avg_vel(RS,x,grade);
% [KW] = find_avg_vel(KW,x,grade);
% [SA] = find_avg_vel(SA,x,grade);
% [EMP] = find_avg_vel(EMP,x,grade);

%% thickness
figure();
plot_colorplot("e",KW(1),grade, 1, 'u',EMP)
hold on;
KW = plotThicknesses(KW,1,grade);
KE = shearLayerThickness(KE,grade);
SA = shearLayerThickness(SA, grade);
RS = shearLayerThickness(RS,grade);
EMP = shearLayerThickness(EMP,grade);
KW = getMiddleBetter(KW);
KE = getMiddleBetter(KE);
SA = getMiddleBetter(SA);
RS = getMiddleBetter(RS);
EMP = getMiddle(EMP);
figure();
[profile, eta] = plot_normalized_vels("normalized vels", KW, 1,grade);
KW(1).normed_profiles = profile;
KW(1).eta = eta;

KW(1).avg_normed_vel_profile = average_normalized_vel_profile(KW,1);
%plot(KW(1).avg_normed_vel_profile,eta,'LineWidth',2);

%%
KW = get_profiles(KW, grade);
KE = get_profiles(KE, grade);
SA = get_profiles(SA, grade);
RS = get_profiles(RS, grade);
EMP = get_profiles(EMP, grade);

plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,1);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,2);
hold on;
T = readtable('Default Dataset.csv');
T = table2array(T);
plot(T(:,1),T(:,2),'k--', 'LineWidth', 4);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,3);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,4);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,5);

comparison_view('u', EMP, KW,KE,SA,RS,1);
comparison_view('u', EMP, KW,KE,SA,RS,2);
comparison_view('u', EMP, KW,KE,SA,RS,3);
comparison_view('u', EMP, KW,KE,SA,RS,4);
comparison_view('u', EMP, KW,KE,SA,RS,5);

%% growth rate calculations

[normed_KW_grs, KW,Mc] = plot_13(KW,EMP, 'k-w');
[normed_KE_grs, KE,Mc] = plot_13(KE,EMP,'k-e');
[normed_SA_grs,SA,Mc] = plot_13(SA,EMP,'SA');
[normed_RS_grs,RS,Mc] = plot_13(RS,EMP,'RS');
for i = 1:5
    if (normed_KW_grs(i) == 0)
        normed_KW_grs(i) = NaN;
    end
    if (normed_KE_grs(i) == 0)
        normed_KE_grs(i) = NaN;
    end
    if (normed_SA_grs(i) == 0)
        normed_SA_grs(i) = NaN;
    end
    if (normed_RS_grs(i) == 0)
        normed_RS_grs(i) = NaN;
    end
end

EMP_growth = [1.07,.9,.71,.61,.58];
figure();
size = 5;
plot(Mc,normed_KW_grs,'o','MarkerSize',size);
hold on;
plot(Mc,normed_KE_grs,'^','MarkerSize',size);
plot(Mc,normed_SA_grs,'+','MarkerSize',size);
plot(Mc,normed_RS_grs,'s','MarkerSize',size);
plot(Mc,EMP_growth,'d','MarkerSize',size);
legend('K - omega','K cc- epsilon','Spalart Allmaras','Reynolds Stress','Empirical Data');

title('growth rate comparison');
xlabel('Mc, convective mach number');
ylabel('db/dx, shear layer growth rate');
ylim([0,1.2]);
xlim([0,2.5]);