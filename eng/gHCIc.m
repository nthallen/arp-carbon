function fig = gHCIc(varargin);
% gHCIc(...)
% Coolant
ffig = ne_group(varargin,'Coolant','pHCIct','pHCIcp','pHCIcs');
if nargout > 0 fig = ffig; end