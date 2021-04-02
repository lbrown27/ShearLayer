function [normalized_vel, eta] = plot_normalized_vel(STRUCT, x0,caseNum,grade)
global N 
[upper_speed, lower_speed, ~, ~, ~, ~,~,~] = getInfo(caseNum);
%[upper_speed,lower_speed] = find_avg_vel(q,y);
delta_U = upper_speed - lower_speed;
[~, x_idx] = min(abs(STRUCT(caseNum).x-x0)); % find x val closest to each x point needed
eta = linspace(-1.2,1.2, N);
STRUCT = shearLayerThickness(STRUCT,grade);
b0 = STRUCT(caseNum).thickness(x_idx);
y0 = STRUCT(caseNum).middle(x_idx);
y_graph = eta * b0 + y0; %convert eta to a y value to graph
u_graph = STRUCT(caseNum).F_u(x0*ones(1,N),y_graph);
normalized_vel = (u_graph - lower_speed)/delta_U;
plot(normalized_vel, eta);
end