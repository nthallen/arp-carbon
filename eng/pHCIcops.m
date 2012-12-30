function pHCIcops(varargin);
% pHCIcops( [...] );
% CO2 Pump Status
h = ne_dstat({
  'C_Pump_DS', 'DS851', 1; ...
	'C_Pump_S', 'DS86A', 1 }, 'Status', varargin{:} );
