function pHCIminiminipt(varargin);
% pHCIminiminipt( [...] );
% MINI Pump Temp
h = timeplot({'MPmpT','MPMtT'}, ...
      'MINI Pump Temp', ...
      'Temp', ...
      {'MPmpT','MPMtT'}, ...
      varargin{:} );
