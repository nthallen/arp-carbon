function pHCIhkgds(varargin);
% pHCIhkgds( [...] );
% GD Status
h = ne_dstat({
  'Gas_Flw_Clsd_DS', 'DS868', 0; ...
	'Gas_Flw_Open_DS', 'DS855', 7; ...
	'GD_Vlv_Clsed_S', 'DS855', 1 }, 'Status', varargin{:} );
