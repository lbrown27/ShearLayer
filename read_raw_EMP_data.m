function Q = read_raw_EMP_data(caseNum)
global x y X Y N x_emp y_emp
for j = 1:5
myString = append('Data/Case ', num2str(j), ' Empirical Data');
addpath(myString);
myString = append('Case ', num2str(j), ' Empirical Data/FOV ',num2str(1));
T = readtable(myString);
T = table2array(T);
myString = append('Case ', num2str(j), ' Empirical Data/FOV ',num2str(2));
T2 = readtable(myString);
T2 = table2array(T2);
myString = append('Case ', num2str(j), ' Empirical Data/FOV ',num2str(3));
T3 = readtable(myString);
T3 = table2array(T3);
if (caseNum == 1 || caseNum == 2 || caseNum == 5)
    myString = append('Case ', num2str(j), ' Empirical Data/FOV ',num2str(4));
    T4 = readtable(myString);
    T4 = table2array(T4);
    T3 = [T3;T4];
end
T = [T;T2;T3];
T = T(:,1:10);
x_emp = T(:,1)/1e3;
y_emp = T(:,2)/1e3;
x = linspace(min(x_emp), max(x_emp), N); % resize otherwise matrix created will be too large for matlab.
y = linspace(min(y_emp), max(y_emp), N);
[X,Y] = meshgrid(x,y);
names = ["case_1","case_2","case_3","case_4","case_5"];
names = cellstr(names);
Q.(names{j}) = T;
end
end

