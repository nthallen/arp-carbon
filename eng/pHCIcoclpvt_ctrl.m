function pHCIcoclpvt_ctrl(varargin);
% pHCIcoclpvt_ctrl( [...] );
% CO2 CLPV T ctrl
h = timeplot({'CLPVCT','CLPVTSt'}, ...
      'CO2 CLPV T ctrl', ...
      'T ctrl', ...
      {'CLPVCT','CLPVTSt'}, ...
      varargin{:} );
