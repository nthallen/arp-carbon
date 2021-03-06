function pHCIcococs(varargin);
% pHCIcococs( [...] );
% CO2 Cell Status
h = ne_dstat({
  'CCell_HC_DS', 'DS84C', 3; ...
	'CGas_Ex_Vlv_DS', 'DS84C', 7; ...
	'CGas_Vlv_DS', 'DS84C', 6; ...
	'CPrs_Reg_DS', 'DS84C', 5 }, 'Status', varargin{:} );
