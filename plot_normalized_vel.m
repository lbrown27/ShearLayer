function [normalized_vel, eta] = plot_normalized_vel(STRUCT, x0,caseNum,grade)
global N 
%[upper_speed, lower_speed, ~, ~, ~, ~,~,~] = getInfo(caseNum);
[~, x_idx] = min(abs(STRUCT(caseNum).x-x0)); % find x val closest to each x point needed
upper_speed = STRUCT(caseNum).top_vel(1);
lower_speed = STRUCT(caseNum).bottom_vel(1);
delta_U = upper_speed - lower_speed;
fprintf("doing new thing");
eta = linspace(-1.05,1.05, N);
STRUCT = shearLayerThickness(STRUCT,grade);
b0 = STRUCT(caseNum).thickness(x_idx);
y0 = STRUCT(caseNum).middle(x_idx);
y_graph = eta * b0 + y0; %convert eta to a y value to graph
u_graph = STRUCT(caseNum).F_u(x0*ones(1,N),y_graph);
normalized_vel = (u_graph - lower_speed)/delta_U;
plot(normalized_vel, eta);
end