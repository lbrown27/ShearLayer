function plot_all_profiles(STRUCT, caseNum)
STRUCT(5).case_vec
if (sum(ismember(STRUCT(5).case_vec,caseNum)) ~= 0)
    len = size(STRUCT(caseNum).normed_profiles);
    figure();
    for i = 1:len(1)
        plot(STRUCT(caseNum).normed_profiles(i,:),STRUCT(caseNum).eta);
        hold on;
        title('all normed vels');
    end
end


end