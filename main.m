%% setup
close all;
clc;
global upper_speed lower_speed N splitter_idx  delta_U top_wall_BL ...
    splitter_plate_top_BL splitter_plate_bottom_BL bottom_wall_BL X Y x y
N = 250; % # grid points in each direction
caseNum = 4;
[upper_speed, lower_speed, top_wall_BL, splitter_plate_top_BL, splitter_plate_bottom_BL, bottom_wall_BL] = getInfo(caseNum);
delta_U = upper_speed - lower_speed;
lower_length = .0762; % in m
upper_length = .0508; % in m
test_section_length = .762; % in m
x = linspace(0,test_section_length, N);
y = linspace(-lower_length, upper_length, N);
grade = 50;

%=============================Setup Complete===============================
Q = read_raw_EMP_data(caseNum);
if (exist('EMP')== 0)
    EMP= struct;
end
%[EMP] = get_FOV_Data(x, y, Q, EMP);

%[~, ~] = plot_colorplot(1,append('u velocity case ', num2str(caseNum)),EMP.u, grade);

%% CFD
%k omega
if (exist('KW_4')== 0)
    KW= struct;
end
KW = get_CFD_Data('k-w', KW);
figure();
subplot(3,2,1)
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
% %% get data at outlet
% % x_outlet = 2.0319* ones(1, 1000);
% % y_outlet = linspace(-.13335, .10795, 1000);
% % q_outlet = F_KW(x_outlet, y_outlet);
%
% % figure();
% % plot_normalized_vel(x,F_KW, q_KW,thick_KW,middle_KW,0.007);
% % title('old');
% % pause(1);
% % hold on;
% % clf;
% % plot_normalized_vel(x,F_KW, q_KW,thick_KW,middle_KW,0.07);
% % title('new');
% % pause(1);
% % clf;
% % plot_normalized_vel(x,F_KW, q_KW,thick_KW,middle_KW,0.15);
% % title('3');
% % pause(1);
% % clf;
% plot_normalized_vel(x,F_KW, q_KW,thick_KW,middle_KW,0.2);
% title('4');
% pause(1);
% clf;
% plot_normalized_vel(x,F_KW, q_KW,thick_KW,middle_KW,0.3);
% title('5');
% pause(1);
% clf;
% plot_normalized_vel(x,F_KW, q_KW,thick_KW,middle_KW,0.4);
% title('6');


% figure();
% plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, 0);
% title('old');
% pause(2);
% hold on;
% clf;
% plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, .05);
% title('new');
% pause(2);
% clf;
% plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, .1);
% title('3');
% pause(2);
% clf;
% plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, .15);
% title('4');
% pause(2);
% clf;
% plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, .2);
% title('5');
% pause(2);
% clf;
% plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, .25);
% title('6');
% pause(2);
% clf;
% plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, .3);
% title('7');