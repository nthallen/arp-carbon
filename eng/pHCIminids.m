function pHCIminids(varargin);
% pHCIminids( [...] );
% MINI Detector Status
h = ne_dstat({
  'MDPV_HC_DS', 'DS868', 3 }, 'Status', varargin{:} );
