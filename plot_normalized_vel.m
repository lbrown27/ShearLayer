function [normalized_vel, eta] = plot_normalized_vel(STRUCT, x0,caseNum,grade)
global N 
[~, x_idx] = min(abs(STRUCT(caseNum).x-x0)); % find x val closest to each x point needed
upper_speed = STRUCT(caseNum).top_vel(1);
lower_speed = STRUCT(caseNum).bottom_vel(1);
%delta_U = upper_speed - lower_speed;
%delta_U = STRUCT(caseNum).top_vel(x_idx) - STRUCT(caseNum).bottom_vel(x_idx);
eta = linspace(-1,1, N);
%STRUCT = thickness(STRUCT,grade);
y0 = STRUCT(caseNum).middle(x_idx);
lower_thick = STRUCT(caseNum).y(STRUCT(caseNum).thickness_lower(x_idx));
upper_thick = STRUCT(caseNum).y(STRUCT(caseNum).thickness_upper(x_idx));
b0_lower = abs(lower_thick-y0);
b0_upper = abs(upper_thick-y0);

y_graph = linspace(lower_thick, upper_thick, N); %convert eta to a y value to graph
%y_graph = STRUCT(caseNum).
u_graph = STRUCT(caseNum).F_u(x0*ones(1,N),y_graph);
upper_speed = u_graph(length(u_graph));
lower_speed = u_graph(1);
delta_U = upper_speed - lower_speed;
%normalized_vel = u_graph;
normalized_vel = (u_graph - lower_speed)/delta_U;
plot(normalized_vel, eta);
end