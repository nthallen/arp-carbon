function pHCIisoisolpvt_ctrl(varargin);
% pHCIisoisolt_ctrl( [...] );
% ISO Laser T ctrl
h = timeplot({'ILPVTSt','ILPVCT'}, ...
      'ISO LPV T ctrl', ...
      'T ctrl', ...
      {'ILPVTSt','ILPVCT'}, ...
      varargin{:} );