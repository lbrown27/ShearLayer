function plot_vels(x,F, title1,q, thick, middle)
global N lower_speed upper_speed delta_U y
[upper_speed,lower_speed] = find_avg_vel(q,y);
    x0 = 0;
u_graph = F(zeros(1,N),y);
plot(u_graph, y);
hold on;
end