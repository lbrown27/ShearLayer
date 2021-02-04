%% setup
clear all;
close all;
clc;
global upper_speed lower_speed N splitter_idx  delta_U top_wall_BL ...
    splitter_plate_top_BL splitter_plate_bottom_BL bottom_wall_BL X Y x y
idx = 8; % for u velocity
N = 950;
upper_speed = 314.89;
lower_speed = 64.75;
delta_U = upper_speed - lower_speed;
top_wall_BL = 2.278*1e-3; % in m
splitter_plate_top_BL = 1.397*1e-3; % in m
splitter_plate_bottom_BL = 5.161*1e-3; % in m
bottom_wall_BL = 4.606*1e-3; % in m
addpath('Run 1 Data');
addpath('Case 1 Empirical Data');
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
% reynolds stress
F_RS = unstructured_reader('Reynolds stress data',x_idx, y_idx, idx);
q_RS = F_RS(X,Y);
[thick_RS, middle_RS] =  plot_colorplot(2,'Reynolds Stress',q_RS);
% figure();
% plot_vels(x,F_RS, 'Reynolds Stress',q_RS, thick_RS, middle_RS);
% figure();
% k epsilon
F_KE = unstructured_reader('k epsilon data',x_idx, y_idx, idx);
q_KE = F_KE(X,Y);
[thick_KE, middle_KE] = plot_colorplot(3,'k epsilon',q_KE);

%k omega
F_KW = unstructured_reader('k-w Case 1',x_idx, y_idx,idx);
q_KW = F_KW(X,Y);
[thick_KW, middle_KW] = plot_colorplot(4,'k-w',q_KW);
x_outlet = 2.0319* ones(1, 1000);
y_outlet = linspace(-.13335, .10795, 1000);
q_outlet = F_KW(x_outlet, y_outlet);
%SA
F_SA = unstructured_reader('1-7 Data short',x_idx, y_idx,idx);
q_SA = F_SA(X,Y);
[thick_SA, middle_SA] = plot_colorplot(5,'Spalart Allmaras new',q_SA);

figure();
plot(x,thick_RS, 'LineWidth', 2);
hold on;
plot(x,thick_ED,'LineWidth', 2);
plot(x,thick_KE,'LineWidth', 2);
plot(x,thick_KW,'LineWidth', 2);
plot(x,thick_SA,'LineWidth', 2);
title('Thicknesses');
legend('1','2','3','4','5');

% figure();
% % use convective velocity to define middle point
% plot(x,middle_RS);
% hold on;
% plot(x,middle_ED);
% plot(x,middle_KE);
% plot(x,middle_KW);
% plot(x,middle_SA);
% title('middle');
figure();
subplot(3,2,1)
plot_vels(x,F_ED, 'numerical',q, thick_ED, middle_ED);
title('empirical data');
subplot(3,2,2)
plot_vels(x,F_RS, 'numerical',q_RS, thick_RS, middle_RS);
title('Reynolds Stress');
subplot(3,2,3)
plot_vels(x,F_KE, 'numerical',q_KE, thick_KE, middle_KE);
title('k-e');
subplot(3,2,4)
plot_vels(x,F_SA, 'numerical',q_SA, thick_SA, middle_SA);
title('SA');
subplot(3,2,5)
plot_vels(x,F_KW, 'numerical',q_KW, thick_KW, middle_KW);
title('k-w');



% figure();

%% page 140 graphs
plot_normalized_vels(x,F_RS, 'Reynolds Stress Profiles',q_RS, thick_RS, middle_RS);
plot_normalized_vels(x,F_KE,'k-e Profiles', q_KE, thick_KE, middle_KE);
plot_normalized_vels(x,F_KW,'k-w Profiles', q_KW, thick_KW, thick_KW);
plot_normalized_vels(x,F_SA,'Spalart Allmaras Profiles', q_SA, thick_SA, thick_SA);

%% Functions
function [y95down, y95up, thickness, middle] = shearLayerThickness(x,y,q)
global upper_speed lower_speed N splitter_idx 
%calculate upper shear layer thickness
y95down = ones(1, N)*5;
find_splitter_idx(y);
for i = 2:N
    bool = 0;
    for j = splitter_idx:-1:150
       if (q(j,i) < 1.1 * lower_speed && bool == 0)
           y95down(i) = j;
           bool = 1;
       end  
    end
end

y95up = (N-1)* ones(1,N);
for i = 2:N
    bool = 0;
    for j = splitter_idx:N
       if (q(j,i) > (.9 * upper_speed) && bool == 0)
           y95up(i) = j;
           bool = 1;
       end  
    end
end
thickness = zeros(N,1);
middle = zeros(N,1);
for i = 2:N
thickness(i) = y(1,y95up(i)) - y(1,y95down(i));
middle(i) = (y(1,y95up(i)) + y(1,y95down(i))) / 2;
end
end