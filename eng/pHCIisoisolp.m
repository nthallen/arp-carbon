function pHCIisoisolp(varargin);
% pHCIisoisolp( [...] );
% ISO Laser P
h = timeplot({'ILPV_P'}, ...
      'ISO Laser P', ...
      'P', ...
      {'ILPV_P'}, ...
      varargin{:} );
