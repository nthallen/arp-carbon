function pHCIcoct(varargin);
% pHCIcoct( [...] );
% CO2 Cell Temp
h = timeplot({'CCel1T','CCel2T'}, ...
      'CO2 Cell Temp', ...
      'Temp', ...
      {'CCel1T','CCel2T'}, ...
      varargin{:} );
