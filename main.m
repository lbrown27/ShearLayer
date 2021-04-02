%% setup
close all;
clc;
global N
N = 70; % # grid points in each direction
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
plot_colorplot(append('u velocity empirical case ', num2str(caseNum)),EMP, grade, caseNum,'u');

%% Load CFD Data
if (exist('KW')== 0)
    KW = struct;
end
KW = get_CFD_Data('k-w', KW,EMP,[]);
if (exist('KE')== 0)
    KE = struct;
    fprintf('KE doesnt exist!');
end
KE = get_CFD_Data('k-e', KE,EMP,[]);

if (exist('SA')== 0)
    SA = struct;
end
SA = get_CFD_Data('SA', SA,EMP,[]);
if (exist('RS')== 0)
    RS = struct;
end
RS = get_CFD_Data('RS', RS,EMP,[]);

RS = find_splitter_idx(RS);
KE = find_splitter_idx(KE);
KW = find_splitter_idx(KW);
SA = find_splitter_idx(SA);
EMP = find_splitter_idx(EMP);
%%
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
figure();
plot_colorplot(append('k-e case ', num2str(caseNum)),KE, grade, caseNum, 'u');
figure();
comparison_view("u", EMP, KW,KE,SA,RS,'KW');
figure();
comparison_view("u", EMP, KW,KE,SA,RS,'KE');
figure();
comparison_view("u", EMP, KW,KE,SA,RS,'SA');
figure();
comparison_view("u", EMP, KW,KE,SA,RS,'RS');
figure();
comparison_view("u", EMP, KW,KE,SA,RS,'EMP');
%comparison_view(cellstr("u"), EMP, KW,KE,SA,RS, 'KW');
%% thickness
figure();
grade = 90;
plot_colorplot("e",KW(1),grade, 1, 'u')
hold on;
KW = plotThicknesses(KW,1,grade);
figure();
[profile, eta] = plot_normalized_vels("normalized vels", KW, 1,grade);
KW(1).normed_profiles = profile;
KW(1).eta = eta;

KW(1).avg_normed_vel_profile = average_normalized_vel_profile(KW,1);
plot(KW(1).avg_normed_vel_profile,eta,'LineWidth',2);

%%
close all;
KW = get_profiles(KW, grade);
KE = get_profiles(KE, grade);
SA = get_profiles(SA, grade);
RS = get_profiles(RS, grade);
EMP = get_profiles(EMP, grade);

plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,1);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,2);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,3);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,4);
plot_avg_vel_profile_comparison(KW,KE,SA,RS,EMP,5);

comparison_view('u', EMP, KW,KE,SA,RS,1);
comparison_view('u', EMP, KW,KE,SA,RS,2);
comparison_view('u', EMP, KW,KE,SA,RS,3);
comparison_view('u', EMP, KW,KE,SA,RS,4);
comparison_view('u', EMP, KW,KE,SA,RS,5);