function pHCIcocoqclis(varargin);
% pHCIcocoqclis( [...] );
% CO2 QCLI Stale
h = timeplot({'QCLI_C_Stale','SSP_C_Stale'}, ...
      'CO2 QCLI Stale', ...
      'Stale', ...
      {'QCLI','SSP'}, ...
      varargin{:} );