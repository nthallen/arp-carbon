function fig = gHCIi(varargin);
% gHCIi(...)
% Inverter
ffig = ne_group(varargin,'Inverter','pHCIiv','pHCIil','pHCIis','pHCIiq','pHCIistale');
if nargout > 0 fig = ffig; end
