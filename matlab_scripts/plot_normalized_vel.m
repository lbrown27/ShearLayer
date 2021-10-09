function [normalized_vel, eta] = plot_normalized_vel(STRUCT, x0,caseNum,grade)
global N 
[~, x_idx] = min(abs(STRUCT(caseNum).x-x0)); % find x val closest to each x point needed
upper_speed = STRUCT(caseNum).top_vel(1);
lower_speed = STRUCT(caseNum).bottom_vel(1);
%delta_U = upper_speed - lower_speed;
%delta_U = STRUCT(caseNum).top_vel(x_idx) - STRUCT(caseNum).bottom_vel(x_idx);
eta = linspace(-1.5,1.3, N);
%STRUCT = thickness(STRUCT,grade);
y0 = STRUCT(caseNum).middle(x_idx);
b0 = STRUCT(caseNum).thickness(x_idx);
y_graph = eta * b0 + y0;
%y_graph = STRUCT(caseNum).


u_graph = STRUCT(caseNum).F_u(x0*ones(1,N),y_graph);
upper_speed = STRUCT(caseNum).u(STRUCT(caseNum).thickness_upper(x_idx));
lower_speed = STRUCT(caseNum).u(STRUCT(caseNum).thickness_lower(x_idx));

upper_speed = u_graph(end);
lower_speed = u_graph(1);

delta_U = upper_speed - lower_speed;
%STRUCT(caseNum).F_u(x0,y0) - (upper_speed + lower_speed)/2;
%normalized_vel = u_graph;
normalized_vel = (u_graph - lower_speed)/delta_U;
plot(normalized_vel, eta);
end