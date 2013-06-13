function pHCIisoisoqclistatus(varargin);
% pHCIisoisoqclistatus( [...] );
% ISO QCLI Status
h = ne_dstat({
  'FIFOOvf', 'QCLI_I_CS', 12; ...
	'IQCLI_Reset_DS', 'DS855', 0; ...
	'QCLI_I_Busy', 'QCLI_I_s', 15; ...
	'QCLI_I_cksum', 'QCLI_I_s', 14; ...
	'QCLI_I_cmderr', 'QCLI_I_s', 13; ...
	'QCLI_I_dot', 'QCLI_I_s', 5; ...
	'QCLI_I_InvCmd', 'QCLI_I_s', 11; ...
	'QCLI_I_laser', 'QCLI_I_s', 12; ...
	'QCLI_I_loc', 'QCLI_I_s', 3; ...
	'QCLI_I_lot', 'QCLI_I_s', 4; ...
	'QCLI_I_ready', 'QCLI_I_s', 9; ...
	'QCLI_I_waveerr', 'QCLI_I_s', 8; ...
	'QCLIResponding', 'QCLI_I_CS', 11; ...
	'RBComplete', 'QCLI_I_CS', 9; ...
	'RBPending', 'QCLI_I_CS', 8; ...
	'Reading', 'QCLI_I_CS', 14; ...
	'RWConflict', 'QCLI_I_CS', 13; ...
	'WQPending', 'QCLI_I_CS', 10 }, 'Status', varargin{:} );
