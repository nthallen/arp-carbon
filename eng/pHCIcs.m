function pHCIcs(varargin);
% pHCIcs( [...] );
% Coolant Status
h = ne_dstat({
  'CoolPump_DS', 'DS848', 4 }, 'Status', varargin{:} );
