function pHCIminilt(varargin);
% pHCIminilt( [...] );
% MINI_ Laser T_ctrl
h = timeplot({'MLPVCT','MLPVTSt','MLTE7R7T','MLTETSt'}, ...
      'MINI_ Laser T_ctrl', ...
      'T_ctrl', ...
      {'MLPVCT','MLPVTSt','MLTE7R7T','MLTETSt'}, ...
      varargin{:} );