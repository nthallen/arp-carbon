function pHCIis(varargin);
% pHCIis( [...] );
% Inverter Status
h = ne_dstat({
  'InvCmdS', 'InvQury3', 1; ...
	'InvFailS', 'InvQury2', 2; ...
	'InvFailedS', 'InvQury0', 0; ...
	'InvCmdErrS', 'InvStat', 3; ...
	'InvErrS', 'InvStat', 2; ...
	'InvPwrS', 'InvStat', 1; ...
	'Arm', 'DS842', 0 }, 'Status', varargin{:} );
