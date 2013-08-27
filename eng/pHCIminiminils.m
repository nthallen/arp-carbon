function pHCIminiminils(varargin);
% pHCIminiminils( [...] );
% MINI Laser Status
h = ne_dstat({	'MLTEC_DS', 'DS868', 4 }, 'Status', varargin{:} );
