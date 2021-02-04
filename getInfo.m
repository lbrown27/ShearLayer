function [upper_speed, lower_speed] = getInfo(num)
upper_speed_vec = [156.25, 314.89, 434.76, 509.24,564.16];
lower_speed_vec = [30.35, 64.75, 97.28, 92.57, 59.76];
upper_speed = upper_speed_vec(num);
lower_speed = lower_speed_vec(num);
end