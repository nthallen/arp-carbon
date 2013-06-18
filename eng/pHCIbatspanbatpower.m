function pHCIbatspanbatpower(varargin);
% pHCIbatspanbatpower( [...] );
% BAT Power
h = ne_dstat({
  'BAT_Pwr_DS', 'DS84A', 4; ...
	'BAT_Pwr_S', 'DS873', 4; ...
	'BAT_Purge_DS', 'DS848', 5 }, 'Power', varargin{:} );
