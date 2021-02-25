function plot_vels(x,F, title1,q, thick, middle, x_val)
global N lower_speed upper_speed delta_U y
[upper_speed,lower_speed] = find_avg_vel(q,y);
u_graph = F(ones(1,N)*x_val,y);
plot(u_graph, y);
hold on;
end