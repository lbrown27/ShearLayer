%% setup
clear all;
close all;
clc;
global upper_speed lower_speed N splitter_idx  delta_U top_wall_BL ...
    splitter_plate_top_BL splitter_plate_bottom_BL bottom_wall_BL X Y x y
idx = 4; % for u velocity
N = 500; % # grid points in each direction
caseNum = 1;

[upper_speed, lower_speed, top_wall_BL, splitter_plate_top_BL, splitter_plate_bottom_BL, bottom_wall_BL] = getInfo(caseNum);
delta_U = upper_speed - lower_speed;
addpath('Data');
addpath('Data/Case 4 Empirical Data');
%addpath('Data/Case 3 Empirical Data');
%addpath('Data/Case 5 Empirical Data');

lower_length = .0762; % in m
upper_length = .0508; % in m
x = linspace(0,.762, N);
y = linspace(-lower_length, upper_length, N);
[X,Y] = meshgrid(x,y);
x_idx = 2;
y_idx = 3;
grade = 50;

%=============================Setup Complete===============================
%% experimental data
T = readtable('FOV 1');
T = table2array(T);
T2 = readtable('FOV 2');
T2 = table2array(T2);
T3 = readtable('FOV 3');
T3 = table2array(T3);
 %T4 = readtable('FOV 4');
 %T4 = table2array(T4);
% T = [T;T2;T3;T4];
T = [T;T2;T3];
x_empirical = T(:,1)/1e3;
y_empirical = T(:,2)/1e3;
v_empirical = T(:,4);
x_new = linspace(min(x_empirical), max(x_empirical), N); 
y_new = linspace(min(y_empirical), max(y_empirical), N);
F_ED = scatteredInterpolant(x_empirical, y_empirical, v_empirical);
[X_empirical,Y_empirical] = meshgrid(x_new,y_new);
X = X_empirical;
Y = Y_empirical;
x = x_new;
y = y_new;
q_ED = F_ED(X_empirical,Y_empirical);
[thick_ED, middle_ED] = plot_colorplot(1,'v velocity case 3',q_ED, grade);
[upper, lower] = find_avg_vel(q_ED,y);


u_empirical = T(:,7);
x_new = linspace(min(x_empirical), max(x_empirical), N); 
y_new = linspace(min(y_empirical), max(y_empirical), N);
F_ED = scatteredInterpolant(x_empirical, y_empirical, u_empirical);
[X_empirical,Y_empirical] = meshgrid(x_new,y_new);
X = X_empirical;
Y = Y_empirical;
x = x_new;
y = y_new;
q_ED = F_ED(X_empirical,Y_empirical);
[thick_ED, middle_ED] = plot_colorplot(2,'Rexx case 3',q_ED, grade);
[upper, lower] = find_avg_vel(q_ED,y);

u_empirical = T(:,3);
x_new = linspace(min(x_empirical), max(x_empirical), N); 
y_new = linspace(min(y_empirical), max(y_empirical), N);
F_ED = scatteredInterpolant(x_empirical, y_empirical, u_empirical);
[X_empirical,Y_empirical] = meshgrid(x_new,y_new);
X = X_empirical;
Y = Y_empirical;
x = x_new;
y = y_new;
q_ED = F_ED(X_empirical,Y_empirical);
[thick_ED, middle_ED] = plot_colorplot(4,'U velocity case 3',q_ED, grade);
[upper, lower] = find_avg_vel(q_ED,y);


u_empirical = T(:,10);
x_new = linspace(min(x_empirical), max(x_empirical), N); 
y_new = linspace(min(y_empirical), max(y_empirical), N);
F_ED = scatteredInterpolant(x_empirical, y_empirical, u_empirical);
[X_empirical,Y_empirical] = meshgrid(x_new,y_new);
X = X_empirical;
Y = Y_empirical;
x = x_new;
y = y_new;
q_ED = F_ED(X_empirical,Y_empirical);
[thick_ED, middle_ED] = plot_colorplot(3,'Rexy case 3',q_ED, grade);
[upper, lower] = find_avg_vel(q_ED,y);

% %% CFD
% %k omega
% F_KW = unstructured_reader('k-e Case 1',x_idx, y_idx,idx);
% q_KW = F_KW(X,Y);
% [thick_KW, middle_KW] = plot_colorplot(2,'k-e',q_KW, grade);
% %find_negative_colorplot_vals(q_KW);
% %plot inlet velocity profiles
% figure();
% subplot(3,2,1)
% plot_vels(x,F_ED, 'numerical',q_ED, thick_ED, middle_ED, .01);
% title('empirical data');
% 
% subplot(3,2,2);
% plot_vels(x,F_KW, 'kw',q_KW, thick_KW, middle_KW, 0.01);
% title('k - epsilon data');
% 
% 
% %% page 140 graphs
 %plot_normalized_vels(x,F_KW,'k-e Profiles', q_KW, thick_KW, middle_KW);
 plot_normalized_vels(x, F_ED, 'empirical profiles', q_ED, thick_ED, middle_ED);
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