function pHCIcp(varargin);
% pHCIcp( [...] );
% Coolant Pressure
h = timeplot({'CoolP'}, ...
      'Coolant Pressure', ...
      'Pressure', ...
      {'CoolP'}, ...
      varargin{:} );