function pHCIcocols(varargin);
% pHCIcocols( [...] );
% CO2 Laser Status
h = ne_dstat({
  'CLPV_HC_DS', 'DS84C', 2; ...
	'CLTEC_DS', 'DS84C', 4 }, 'Status', varargin{:} );
