function pHCIpps(varargin);
% pHCIpps( [...] );
% Pilot Panel Status
h = ne_dstat({
  'lk204_init', 'PPstat', 0; ...
	'pca9554_init', 'PPstat', 1; ...
	'lk204_ack', 'PPstat', 2; ...
	'pca9554_ack', 'PPstat', 3; ...
	'Key_Pressed', 'PPstat', 4; ...
	'WQ_NonEmpty', 'PPstat', 5; ...
	'WQ_Full', 'PPstat', 6; ...
	'LKWrEn', 'PPstat', 7; ...
	'BAT_Purge_Req', 'PPstat', 8; ...
	'Land_Req', 'PPstat', 9; ...
	'BAT_Purge_LED', 'PPstat', 12; ...
	'Data_LED', 'PPstat', 13 }, 'Status', varargin{:} );
