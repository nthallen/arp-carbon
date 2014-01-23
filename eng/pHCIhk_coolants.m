function pHCIhk_coolants(varargin);
% pHCIhk_coolants( [...] );
% Coolant Status
h = ne_dstat({
  'CoolPump_DS', 'DS851', 7; ...
	'CoolDivert_DS', 'DS848', 4 }, 'Status', varargin{:} );
