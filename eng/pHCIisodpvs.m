function pHCIisodpvs(varargin);
% pHCIisodpvs( [...] );
% ISO_DPV Status
h = ne_dstat({
  'IDPV_HC_DS', 'DS851', 4; ...
	'IDPV_HC_S', 'DS86A', 4 }, 'Status', varargin{:} );
