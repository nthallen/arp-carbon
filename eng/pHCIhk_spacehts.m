function pHCIhk_spacehts(varargin);
% pHCIhk_spacehts( [...] );
% Space Ht Status
h = ne_dstat({
  'SpHt_HC_DS', 'DS855', 6 }, 'Status', varargin{:} );
