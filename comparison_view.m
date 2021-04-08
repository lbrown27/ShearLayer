function comparison_view(parameter, EMP, KW,KE,SA,RS,comp_type) % comp_type is comparison type
% comparison_type is either case or method
% case: plot all the same case across different methods.
% method: plot all one method, but different cases.
figure();
if (strcmp('KW',comp_type))
    plotvector = KW;
    for i = 1:5
        subplot(3,2,i);
        if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
elseif (strcmp('KE',comp_type))
    parameter = cellstr(parameter);
    plotvector = KE;
    for i = 1:5
        subplot(3,2,i);
        if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
elseif (strcmp('SA',comp_type))
    parameter = cellstr(parameter);
    plotvector = SA;
    for i = 1:5
        subplot(3,2,i);
        if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
elseif (strcmp('RS',comp_type))
    parameter = cellstr(parameter);
    plotvector = RS;
    for i = 1:5
        subplot(3,2,i);
        if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
elseif (strcmp('EMP',comp_type))
    parameter = cellstr(parameter);
    plotvector = EMP;
    for i = 1:5
        subplot(3,2,i);
        if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
else
    caseNum = 0;
    for j = 1:5
        if (comp_type == j)
            caseNum = j;
        end
    end
    if (~caseNum == 0)
        parameter = cellstr(parameter);
        plotvector(1).(char(parameter)) = KW(caseNum).(char(parameter));
        plotvector(2).(char(parameter)) = KE(caseNum).(char(parameter));
        plotvector(3).(char(parameter)) = RS(caseNum).(char(parameter));
        plotvector(4).(char(parameter)) = SA(caseNum).(char(parameter));
        %plotvector(5).(char(parameter)) = EMP(caseNum).(char(parameter));
        
        plotvector(1).X = KW(caseNum).X;
        plotvector(2).X = KE(caseNum).X;
        plotvector(3).X = RS(caseNum).X;
        plotvector(4).X = SA(caseNum).X;
        %plotvector(5).X = EMP(caseNum).X;
        
        plotvector(1).Y = KW(caseNum).Y;
        plotvector(2).Y = KE(caseNum).Y;
        plotvector(3).Y = RS(caseNum).Y;
        plotvector(4).Y = SA(caseNum).Y;
        %plotvector(5).Y = EMP(caseNum).Y;
        legendvec = ["KW","KE", "RS", "SA", "EMP"];
        for i = 1:4
            subplot(3,2,i);
            if (~(length(plotvector(i).(char(parameter))) == 0))
                plot_colorplot(append(legendvec(i), ' case ', num2str(caseNum)),plotvector, 90,i,parameter);
            end
        end
    end
end
end
