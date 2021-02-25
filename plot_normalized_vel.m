function plot_normalized_vel(x,F, title1,q, thick, middle, x0)
global N lower_speed upper_speed delta_U y
[upper_speed,lower_speed] = find_avg_vel(q,y);
delta_U = upper_speed - lower_speed;
[val, x_idx] = min(abs(x-x0)); % find x val closest to each x point needed
eta = linspace(-1.2,1.2, N);
b0 = thick(x_idx);
y0 = middle(x_idx);
y_graph = eta * b0 + y0; %convert eta to a y value
u_graph = F(x0*ones(1,N),y_graph);
normalized_vel = (u_graph - lower_speed)/delta_U;
plot(normalized_vel, eta);
end