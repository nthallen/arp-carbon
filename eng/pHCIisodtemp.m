function pHCIisodtemp(varargin);
% pHCIisodtemp( [...] );
% ISO_ Detector Temp
h = timeplot({'IDetT'}, ...
      'ISO_ Detector Temp', ...
      'Temp', ...
      {'IDetT'}, ...
      varargin{:} );
