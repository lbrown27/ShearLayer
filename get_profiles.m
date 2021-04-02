function STRUCT = get_profiles(STRUCT,grade)
for i = 1:5
    [profile, eta] = plot_normalized_vels("normalized vels", STRUCT, i,grade);
    STRUCT(i).normed_profiles = profile;
    STRUCT(i).eta = eta;
    STRUCT(i).avg_normed_vel_profile = average_normalized_vel_profile(STRUCT,i);
end
end