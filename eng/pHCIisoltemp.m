function pHCIisoltemp(varargin);
% pHCIisoltemp( [...] );
% ISO_ Laser Temp
h = timeplot({'ILH_T'}, ...
      'ISO_ Laser Temp', ...
      'Temp', ...
      {'ILH\_T'}, ...
      varargin{:} );
