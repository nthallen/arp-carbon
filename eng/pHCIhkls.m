function pHCIhkls(varargin);
% pHCIhkls( [...] );
% Lab Status
h = ne_dstat({
  'L1_DS', 'DS851', 7; ...
	'L1_S', 'DS86A', 7 }, 'Status', varargin{:} );
