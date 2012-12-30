function pHCIhkshs(varargin);
% pHCIhkshs( [...] );
% HK Sample Ht Status
h = ne_dstat({
  'SH_HC_DS', 'DS855', 5 }, 'Status', varargin{:} );
