function comparison_view(parameter, EMP, KW,KE,SA,RS,comp_type) % comp_type is comparison type
% comparison_type is either case or method
% case: plot all the same case across different methods.
% method: plot all one method, but different cases.

%% method:
%plotvector = repmat(struct,5,1);
if (strcmp('KW',comp_type))
    parameter = cellstr(parameter)
    plotvector = KW;
end
if (strcmp('KE',comp_type) && ~(isEmpty(KE)))
    plotvector = KE;
end
if (strcmp('SA',comp_type) && ~isEmpty(SA))
    plotvector = SA;
end
if (strcmp('RS',comp_type))
    plotvector = RS;
end
if (strcmp('EMP',comp_type)&& ~isEmpty(EMP))
    plotvector = EMP;
end
grade = 1;
plot_colorplot('frog',plotvector, grade)
end