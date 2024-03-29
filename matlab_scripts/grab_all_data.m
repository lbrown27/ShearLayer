function [KW,KE,SA,RS,EMP] = grab_all_data(KW,KE,SA,RS,EMP)
%% setup
close all;
clc;
global N lower_length upper_length grade
N = 500; % # grid points in each direction
caseNum = 4;
lower_length = .0762; % in m
upper_length = .0508; % in m
test_section_length = .762; % in m
%=============================Setup Complete===============================

% read the Empirical (EMP) FOV data
Q = read_raw_EMP_data(caseNum);
[EMP] = get_FOV_Data(Q, EMP);
max_XL = .33;
%plot_colorplot(append('u velocity empirical case ', num2str(caseNum)),EMP, grade, caseNum,'u');

%% Load CFD Data
%KW = get_CFD_Data('k-w', KW,EMP,[],max(EMP(1).x));
KW = get_CFD_Data('k-w', KW,EMP,[],max_XL);
KE = get_CFD_Data('k-e', KE,EMP,[],max_XL);
SA = get_CFD_Data('SA', SA,EMP,[],max_XL);
RS = get_CFD_Data('RS', RS,EMP,[],max_XL);

RS = find_splitter_idx(RS);
KE = find_splitter_idx(KE);
KW = find_splitter_idx(KW);
SA = find_splitter_idx(SA);
EMP = find_splitter_idx(EMP);



get_thicknesses = input('\ncollect or refresh thickness data? 1 = yes, other = no. \n','s');
if (strcmp(get_thicknesses, '1'))
    for caseNum = 1:5
        KW(caseNum).thickness_upper = 5*ones(1,N);
        KW(caseNum).thickness_lower = 5*ones(1,N);
        KE(caseNum).thickness_upper = 1;
        KE(caseNum).thickness_lower = 1;
        SA(caseNum).thickness_upper = 1;
        SA(caseNum).thickness_lower = 1;
        RS(caseNum).thickness_upper = 1;
        RS(caseNum).thickness_lower = 1;
        EMP(caseNum).thickness_upper = 1;
        EMP(caseNum).thickness_lower = 1;
    end
    for i = 1:3
        KW = thickness(KW, grade);
        KE = thickness(KE, grade);
        SA = thickness(SA, grade);
        RS = thickness(RS, grade);
        EMP = thickness(EMP, grade);
        
        KE = find_avg_vel(KE);
        RS = find_avg_vel(RS);
        KW = find_avg_vel(KW);
        SA = find_avg_vel(SA);
        EMP = find_avg_vel(EMP);
        
        KW = getMiddleBetter(KW);
        KE = getMiddleBetter(KE);
        SA = getMiddleBetter(SA);
        RS = getMiddleBetter(RS);
        EMP = getMiddleBetter(EMP);
    end
end
% count = 0;
% sum(abs(KW(1).y(KW(1).thickness_upper_previous) - KW(1).y(KW(1).thickness_upper)))
% for i = 1:5
% while (sum(abs(KW(i).y(KW(i).thickness_upper_previous) - KW(i).y(KW(i).thickness_upper))) > 1e-3)
%     KW = shearLayerThickness(KW, grade);
%     KW = find_avg_vel(KW);
%     KW = getMiddleBetter(KW);
%     count = count + 1;
% end
% end
% fprintf('\ndone after %f iterations\n',count);



KW = get_profiles(KW, grade);
KE = get_profiles(KE, grade);
SA = get_profiles(SA, grade);
RS = get_profiles(RS, grade);
EMP = get_profiles(EMP, grade);


[KW] = find_normed_gr(KW,EMP,'k-w');
[KE] = find_normed_gr(KE,EMP,'k-e');
[SA] = find_normed_gr(SA,EMP,'SA');
[RS] = find_normed_gr(RS,EMP,'RS');


for i = 1:5
    if (KW(i).normed_gr == 0)
        KW(i).normed_gr = NaN;
    end
    if (KE(i).normed_gr == 0)
        KE(i).normed_gr = NaN;
    end
    if (SA(i).normed_gr == 0)
        SA(i).normed_gr = NaN;
    end
    if (RS(i).normed_gr == 0)
        RS(i).normed_gr = NaN;
    end
end

end