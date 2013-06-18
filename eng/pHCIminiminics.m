function pHCIminiminics(varargin);
% pHCIminiminics( [...] );
% MINI Cell Status
h = ne_dstat({
  'MCell_HC_DS', 'DS868', 2; ...
	'IGas_Ex_Vlv_DS', 'DS855', 4; ...
	'MGas_Vlv_DS', 'DS868', 7; ...
	'MPrs_Reg_DS', 'DS868', 6 }, 'Status', varargin{:} );
