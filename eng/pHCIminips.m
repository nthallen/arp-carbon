function pHCIminips(varargin);
% pHCIminips( [...] );
% MINI Pump Status
h = ne_dstat({
  'MM_Pump_DS', 'DS851', 0; ...
	'MM_Pump_S', 'DS86A', 0 }, 'Status', varargin{:} );
