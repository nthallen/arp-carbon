function pHCIminiqclistatus(varargin);
% pHCIminiqclistatus( [...] );
% MINI_QCLI Status
h = ne_dstat({
  'FIFOOvf', 'QCLI_M_CS', 12; ...
	'MQCLI_Reset_DS', 'DS868', 1; ...
	'QCLI_M_Busy', 'QCLI_M_s', 15; ...
	'QCLI_M_cksum', 'QCLI_M_s', 14; ...
	'QCLI_M_cmderr', 'QCLI_M_s', 13; ...
	'QCLI_M_dot', 'QCLI_M_s', 5; ...
	'QCLI_M_InvCmd', 'QCLI_M_s', 11; ...
	'QCLI_M_laser', 'QCLI_M_s', 12; ...
	'QCLI_M_loc', 'QCLI_M_s', 3; ...
	'QCLI_M_lot', 'QCLI_M_s', 4; ...
	'QCLI_M_ready', 'QCLI_M_s', 9; ...
	'QCLI_M_waveerr', 'QCLI_M_s', 8; ...
	'QCLIResponding', 'QCLI_M_CS', 11; ...
	'RBComplete', 'QCLI_M_CS', 9; ...
	'RBPending', 'QCLI_M_CS', 8; ...
	'Reading', 'QCLI_M_CS', 14; ...
	'RWConflict', 'QCLI_M_CS', 13; ...
	'WQPending', 'QCLI_M_CS', 10 }, 'Status', varargin{:} );
