function pHCIhktscan(varargin);
% pHCIhktscan( [...] );
% HK_ Throttle Scan
h = timeplot({'IXStt'}, ...
      'HK_ Throttle Scan', ...
      'Scan', ...
      {'IXStt'}, ...
      varargin{:} );
