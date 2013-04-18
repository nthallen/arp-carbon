function pHCIhkdacss(varargin);
% pHCIhkdacss( [...] );
% DACS Status
h = ne_dstat({
  'SW0', 'IOSwS', 0; ...
	'SW1', 'IOSwS', 1; ...
	'FltMd', 'IOSwS', 2 }, 'Status', varargin{:} );
