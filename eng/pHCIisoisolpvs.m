function pHCIisoisolpvs(varargin);
% pHCIisoisols( [...] );
% ISO Laser Status
h = ne_dstat({
  'ILPV_HC_DS', 'DS851', 5; ...
	'ILPV_HC_S', 'DS86A', 5}, 'Status', varargin{:} );
