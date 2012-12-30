function pHCIcolc(varargin);
% pHCIcolc( [...] );
% CO2 Laser Current
h = timeplot({'CLasI'}, ...
      'CO2 Laser Current', ...
      'Current', ...
      {'CLasI'}, ...
      varargin{:} );
