%% setup
clear all;
close all;
clc;
global upper_speed lower_speed N splitter_idx  delta_U top_wall_BL ...
    splitter_plate_top_BL splitter_plate_bottom_BL bottom_wall_BL X Y x y
idx = 13; % for u velocity
N = 950; % # grid points in each direction
caseNum = 2;

[upper_speed, lower_speed] = getInfo(caseNum);
delta_U = upper_speed - lower_speed;
top_wall_BL = 2.278*1e-3; % in m
splitter_plate_top_BL = 1.397*1e-3; % in m
splitter_plate_bottom_BL = 5.161*1e-3; % in m
bottom_wall_BL = 4.606*1e-3; % in m
addpath('Data');
addpath('Data/Case 2 Empirical Data');

lower_length = .0762; % in m
upper_length = .0508; % in m
x = linspace(0,.762, N);
y = linspace(-lower_length, upper_length, N);
[X,Y] = meshgrid(x,y);
x_idx = 2;
y_idx = 3;

%=============================Setup Complete===============================
%% experimental data
T = readtable('FOV 1');
T = table2array(T);
T2 = readtable('FOV 2');
T2 = table2array(T2);
T3 = readtable('FOV 3');
T3 = table2array(T3);
 T4 = readtable('FOV 4');
 T4 = table2array(T4);
 T = [T;T2;T3;T4];
%T = [T;T2;T3];
x_empirical = T(:,1)/1e3;
y_empirical = T(:,2)/1e3;
u_empirical = T(:,3);
x_new = linspace(min(x_empirical), max(x_empirical), N); 
y_new = linspace(min(y_empirical), max(y_empirical), N);
F_ED = scatteredInterpolant(x_empirical, y_empirical, u_empirical);
[X_empirical,Y_empirical] = meshgrid(x_new,y_new);
X = X_empirical;
Y = Y_empirical;
x = x_new;
y = y_new;
q = F_ED(X_empirical,Y_empirical);
[thick_ED, middle_ED] = plot_colorplot(1,'Experimental Data',q);
[upper, lower] = find_avg_vel(q,y);

%% CFD
%k omega
F_KW = unstructured_reader('k-w Case 1',x_idx, y_idx,idx);
q_KW = F_KW(X,Y);
[thick_KW, middle_KW] = plot_colorplot(4,'k-w',q_KW);
x_outlet = 2.0319* ones(1, 1000);
y_outlet = linspace(-.13335, .10795, 1000);
q_outlet = F_KW(x_outlet, y_outlet);

figure();
subplot(3,2,1)
plot_vels(x,F_ED, 'numerical',q, thick_ED, middle_ED);
title('empirical data');

% figure();

%% page 140 graphs
plot_normalized_vels(x,F_KW,'k-w Profiles', q_KW, thick_KW, thick_KW);
%% Functions
