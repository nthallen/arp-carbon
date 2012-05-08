function pHCIisops(varargin);
% pHCIisops( [...] );
% ISO_ Pump Status
h = ne_dstat({
  'I_Pump_DS', 'DS851', 2; ...
	'I_Pump_S', 'DS86A', 2 }, 'Status', varargin{:} );
