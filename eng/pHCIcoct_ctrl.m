function pHCIcoct_ctrl(varargin);
% pHCIcoct_ctrl( [...] );
% CO2_ Cell T_ctrl
h = timeplot({'CCelCT','CCelTSt'}, ...
      'CO2_ Cell T_ctrl', ...
      'T_ctrl', ...
      {'CCelCT','CCelTSt'}, ...
      varargin{:} );