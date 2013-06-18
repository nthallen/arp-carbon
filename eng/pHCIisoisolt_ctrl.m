function pHCIisoisolt_ctrl(varargin);
% pHCIisoisolt_ctrl( [...] );
% ISO Laser T ctrl
h = timeplot({'ILPVTSt','ILTE7R7T','ILTETSt'}, ...
      'ISO Laser T ctrl', ...
      'T ctrl', ...
      {'ILPVTSt','ILTE7R7T','ILTETSt'}, ...
      varargin{:} );