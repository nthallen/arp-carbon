function pHCIminisspt(varargin);
% pHCIminisspt( [...] );
% MINI_SSP Temp
h = timeplot({'M24VT','MPampT','MSSPT','SSP_M_T_FPGA','SSP_M_T_HtSink'}, ...
      'MINI_SSP Temp', ...
      'Temp', ...
      {'M24VT','MPampT','MSSPT','SSP\_M\_T\_FPGA','SSP\_M\_T\_HtSink'}, ...
      varargin{:} );
