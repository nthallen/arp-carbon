function pHCIisocs(varargin);
% pHCIisocs( [...] );
% ISO_ Cell Status
h = ne_dstat({
  'ICell_HC_DS', 'DS851', 3; ...
	'ICell_HC_S', 'DS86A', 3; ...
	'IGas_Ex_Vlv_DS', 'DS855', 4; ...
	'IGas_Vlv_DS', 'DS855', 3; ...
	'IPrs_Reg_DS', 'DS855', 2 }, 'Status', varargin{:} );
