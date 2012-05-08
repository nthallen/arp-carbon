function pHCIcols(varargin);
% pHCIcols( [...] );
% CO2_ Laser Status
h = ne_dstat({
  'CLPV_HC_DS', 'DS84C', 2; ...
	'CLTEC_DS', 'DS84C', 4 }, 'Status', varargin{:} );
