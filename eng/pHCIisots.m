function pHCIisots(varargin);
% pHCIisots( [...] );
% Temps Sample
h = timeplot({'ISG1T','ISG2T'}, ...
      'Temps Sample', ...
      'Sample', ...
      {'ISG1T','ISG2T'}, ...
      varargin{:} );
