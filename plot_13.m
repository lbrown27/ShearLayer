function [frog,STRUCT,Mc] = plot_13(STRUCT,EMP, name)

STRUCT = find_splitter_idx(STRUCT);
STRUCT = shearLayerThickness(STRUCT,90);
frog = calculate_growth_rate(STRUCT);
Mc = [.185,.381,.546,.69,.883];
rho_1 = [1.1527,1.1418,1.1344,1.188,1.3555];
rho_2 = [1.1206,.9633,.7941,.729,.5980];
for i = 1:5
[upper_speed, lower_speed,~,~,~,~,~,~] = getInfo(i);
r = lower_speed/upper_speed;
s = rho_2(i)/rho_1(i);
db_dx_0 = .165*(1-r)*(1+s^.5)/(2*(1+r*s^.5));
frog(i) = frog(i)/db_dx_0;
end
%figure();
%plot(Mc,frog,'.','MarkerSize',20);
%title(append(name,' normalized growth rates'));
end