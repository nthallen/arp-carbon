function pHCIisoisols(varargin);
% pHCIisoisols( [...] );
% ISO Laser Status
h = ne_dstat({
  'ILTEC_DS', 'DS851', 6; ...
	'ILTEC_S', 'DS86A', 6 }, 'Status', varargin{:} );
