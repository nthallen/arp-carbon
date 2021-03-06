function val = load_BS_var(var, v)
% val = load_BS_var(varname);
% val = load_BS_var(varname, v);
%  v is a logical vector specifying which of the raw values to include
%  in the output vector.
fi = 'BAT_SPAN.ncr';
val = double(ncread(fi,var));
val = val(:);
finfo = ncinfo('BAT_SPAN.ncr');
vars = {finfo.Variables.Name};
i = find(strcmp(vars, var));
coefi = find(strcmp({finfo.Variables(1,i).Attributes.Name},'cal_coef'),1);
cal_coef = double(finfo.Variables(1,i).Attributes(1,coefi).Value);
val = val * cal_coef(2) + cal_coef(1);
if nargin > 1
    val = val(v);
end
