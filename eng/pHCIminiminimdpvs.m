function pHCIminiminimdpvs(varargin);
% pHCIminiminimdpvs( [...] );
% MINI MDPV Status
h = ne_dstat({
  'MDPV_HC_DS', 'DS868', 3 }, 'Status', varargin{:} );
