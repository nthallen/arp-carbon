function pHCIbpa(varargin);
% pHCIbpa( [...] );
% Best Pos Age
h = timeplot({'BP_DiffAge','BP_SolAge'}, ...
      'Best Pos Age', ...
      'Age', ...
      {'BP\_DiffAge','BP\_SolAge'}, ...
      varargin{:} );
