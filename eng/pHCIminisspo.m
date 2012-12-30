function pHCIminisspo(varargin);
% pHCIminisspo( [...] );
% MINI SSP Overflow
h = ne_dstat({
  'CAOVF1', 'SSP_M_Flags', 0; ...
	'CAOVF2', 'SSP_M_Flags', 1; ...
	'CAOVF3', 'SSP_M_Flags', 2; ...
	'PAOVF1', 'SSP_M_Flags', 3; ...
	'PAOVF2', 'SSP_M_Flags', 4; ...
	'PAOVF3', 'SSP_M_Flags', 5; ...
	'ADOVF1', 'SSP_M_Flags', 6; ...
	'ADOVF2', 'SSP_M_Flags', 7; ...
	'ADOVF3', 'SSP_M_Flags', 8 }, 'Overflow', varargin{:} );
