function pHCIas(varargin);
% pHCIas( [...] );
% Altimeter Status
h = ne_dstat({
  'Stale', 'MRA_Alt', 15; ...
	'Invalid', 'MRA_Alt', 14 }, 'Status', varargin{:} );
