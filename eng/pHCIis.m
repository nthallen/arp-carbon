function pHCIis(varargin);
% pHCIis( [...] );
% Inverter Status
h = ne_dstat({
  'Error', 'InvStat', 2; ...
	'Power', 'InvStat', 1; ...
	'Arm', 'DS842', 0 }, 'Status', varargin{:} );
