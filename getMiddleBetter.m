function STRUCT = getMiddleBetter(STRUCT)
global N
for q = 1:5
    if (isfield(STRUCT(q),'x')&& length(STRUCT(q).x) > 0)
        for i = 1:N
            %[~,STRUCT(q).middle(i)] = min(STRUCT(q).u(j,i)- (STRUCT(q).top_vel(i) + STRUCT(q).bottom_vel(j)/2));
            %[upper_speed,lower_speed,~,~,~,~,~,~] = getInfo(q);
            [~,STRUCT(q).middle(i)] = min(abs(STRUCT(q).u(:,i) - (STRUCT(q).top_vel(i)-STRUCT(q).bottom_vel(i))/2));
            STRUCT(q).middle(i) = STRUCT(q).y(STRUCT(q).middle(i));
        end
    end
end


end