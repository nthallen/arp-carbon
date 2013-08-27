function pHCIminiminimlpvs(varargin);
% pHCIminiminimlpvs( [...] );
% MINI MLPV Status
h = ne_dstat({
  'MLPV_TEC_DS', 'DS868', 5 }, 'Status', varargin{:} );
