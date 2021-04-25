function STRUCT = getMiddleBetter(STRUCT)
global N

for q = 1:5
    [upper_speed, lower_speed, top_wall_BL, splitter_plate_top_BL,...
    splitter_plate_bottom_BL, bottom_wall_BL,fully_developed_region_start,...
    fully_developed_region_stop] = getInfo(q)
    if (isfield(STRUCT(q),'x')&& length(STRUCT(q).x) > 0)
        for i = 1:N
            %[~,STRUCT(q).middle(i)] = min(STRUCT(q).u(j,i)- (STRUCT(q).top_vel(i) + STRUCT(q).bottom_vel(j)/2));
            %[upper_speed,lower_speed,~,~,~,~,~,~] = getInfo(q);
            %[~,STRUCT(q).middle(i)] = min(abs(STRUCT(q).u(:,i) - (STRUCT(q).top_vel(i)-STRUCT(q).bottom_vel(i))/2));
            %[~,STRUCT(q).middle(i)] = min(abs(STRUCT(q).u(:,i) - (STRUCT(q).top_vel(i)-STRUCT(q).bottom_vel(i))/2));

                %[~,STRUCT(q).middle(i)] = min(abs(STRUCT(q).u(:,i) - (upper_speed - lower_speed)/2));
            STRUCT(q).middle(i) = (STRUCT(q).y(STRUCT(q).thickness_upper(i)) + STRUCT(q).y(STRUCT(q).thickness_lower(i)))/2;
        end
    end
end


end