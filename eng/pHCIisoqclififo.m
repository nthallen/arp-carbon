function pHCIisoqclififo(varargin);
% pHCIisoqclififo( [...] );
% ISO_QCLI FIFO
h = timeplot({'QCLI_I_fifodep'}, ...
      'ISO_QCLI FIFO', ...
      'FIFO', ...
      {'QCLI\_I\_fifodep'}, ...
      varargin{:} );
