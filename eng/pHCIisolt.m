function pHCIisolt(varargin);
% pHCIisolt( [...] );
% ISO_ Laser Temp
h = timeplot({'ILH_T'}, ...
      'ISO_ Laser Temp', ...
      'Temp', ...
      {'ILH\_T'}, ...
      varargin{:} );
