function pHCIminidt_ctrl(varargin);
% pHCIminidt_ctrl( [...] );
% MINI_ Detector T_ctrl
h = timeplot({'MDPVCT','MDPVTSt'}, ...
      'MINI_ Detector T_ctrl', ...
      'T_ctrl', ...
      {'MDPVCT','MDPVTSt'}, ...
      varargin{:} );
