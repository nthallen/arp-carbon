function pHCIbatspanspanhkbatp(varargin);
% pHCIbatspanspanhkbatp( [...] );
% SPAN HK BAT Pwr
h = ne_dstat({
  'BAT_Pwr_DS', 'DS84A', 4; ...
	'BAT_Pwr_S', 'DS873', 4 }, 'BAT Pwr', varargin{:} );
