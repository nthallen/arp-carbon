function pHCIminils(varargin);
% pHCIminils( [...] );
% MINI_ Laser Status
h = ne_dstat({
  'MLPV_TEC_DS', 'DS868', 5; ...
	'MLTEC_DS', 'DS868', 4 }, 'Status', varargin{:} );