function pHCIcocodt(varargin);
% pHCIcocodt( [...] );
% CO2 Detector Temp
h = timeplot({'CDetT'}, ...
      'CO2 Detector Temp', ...
      'Temp', ...
      {'CDetT'}, ...
      varargin{:} );
