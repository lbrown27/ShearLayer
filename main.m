%% setup
clear all;
close all;
clc;
global upper_speed lower_speed N splitter_idx  delta_U top_wall_BL ...
    splitter_plate_top_BL splitter_plate_bottom_BL bottom_wall_BL X Y x y
N = 250; % # grid points in each direction
prompt = 'which case? ';
caseNum = input(prompt);

[upper_speed, lower_speed, top_wall_BL, splitter_plate_top_BL, splitter_plate_bottom_BL, bottom_wall_BL] = getInfo(caseNum);
delta_U = upper_speed - lower_speed;
addpath('Data');
myString = append('Data/Case ', num2str(caseNum), ' Empirical Data');
addpath(myString);

lower_length = .0762; % in m
upper_length = .0508; % in m
x = linspace(0,.762, N);
y = linspace(-lower_length, upper_length, N);
grade = 50;

%=============================Setup Complete===============================
%% experimental data
T = readtable('FOV 1');
T = table2array(T);
T2 = readtable('FOV 2');
T2 = table2array(T2);
T3 = readtable('FOV 3');
T3 = table2array(T3);
if (caseNum == 1 || caseNum == 2 || caseNum == 5)
    T4 = readtable('FOV 4');
    T4 = table2array(T4);
    T3 = [T3;T4];
end
T = [T;T2;T3];
x_emp = T(:,1)/1e3;
y_emp = T(:,2)/1e3;
x = linspace(min(x_emp), max(x_emp), N); % you have to resize otherwise the matrix created will be too large for matlab.
y = linspace(min(y_emp), max(y_emp), N);
[X,Y] = meshgrid(x,y);
[EMP] = get_FOV_Data(x_emp, y_emp, T);

 %[~, ~] = plot_colorplot(1,append('u velocity case ', num2str(caseNum)),EMP.u, grade);

%% CFD
%k omega
F = unstructured_reader('k-e Case 1',x_idx, y_idx,idx);
q_KW = F_KW(X,Y);
[thick_KW, middle_KW] = plot_colorplot(2,'k-e',q_KW, grade);
%find_negative_colorplot_vals(q_KW);
%plot inlet velocity profiles
figure();
subplot(3,2,1)
plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, .01);
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