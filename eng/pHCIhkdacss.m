function pHCIhkdacss(varargin);
% pHCIhkdacss( [...] );
% HK DACS Status
h = ne_dstat({
  'SW0', 'IOSwS', 0; ...
	'SW1', 'IOSwS', 1; ...
	'Flt', 'IOSwS', 2 }, 'Status', varargin{:} );
