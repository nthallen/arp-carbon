function pHCIisolp(varargin);
% pHCIisolp( [...] );
% ISO_ Laser P
h = timeplot({'ILPVCT'}, ...
      'ISO_ Laser P', ...
      'P', ...
      {'ILPVCT'}, ...
      varargin{:} );
