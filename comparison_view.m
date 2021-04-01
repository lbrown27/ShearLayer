function comparison_view(parameter, EMP, KW,KE,SA,RS,comp_type) % comp_type is comparison type
% comparison_type is either case or method
% case: plot all the same case across different methods.
% method: plot all one method, but different cases.

%% method:
%plotvector = repmat(struct,5,1);
if (strcmp('KW',comp_type))
    plotvector = KW;
    for i = 1:5
        subplot(3,2,i);
        if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
end
if (strcmp('KE',comp_type))
      parameter = cellstr(parameter);
    plotvector = KE;
    for i = 1:5
        subplot(3,2,i);
 if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
end
if (strcmp('SA',comp_type))
     parameter = cellstr(parameter);
    plotvector = SA;
    for i = 1:5
        subplot(3,2,i);
  if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
end
if (strcmp('RS',comp_type))
    parameter = cellstr(parameter);
    plotvector = RS;
    for i = 1:5
        subplot(3,2,i);
     if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
end
if (strcmp('EMP',comp_type))
   parameter = cellstr(parameter);
    plotvector = EMP;
    for i = 1:5
        subplot(3,2,i);
     if (~(length(plotvector(i).(char(parameter))) == 0))
            plot_colorplot(append(comp_type, ' case',num2str(i)),plotvector, 90,i,parameter);
        end
    end
end
grade = 1;
%plot_colorplot('frog',plotvector, grade)
end