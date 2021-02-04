function vt = vorticityThickness(x,y,v)
global upper_speed lower_speed N splitter_idx delta_U
for i = 1:200
    vt(i) = (274.4-68.6)/max(v(10:90,i));
end
end