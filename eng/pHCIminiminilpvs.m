function pHCIminiminilpvs(varargin);
% pHCIminiminils( [...] );
% MINI Laser Status
h = ne_dstat({
  'MLPV_TEC_DS', 'DS868', 5}, 'Status', varargin{:} );
