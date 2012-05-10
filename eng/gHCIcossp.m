function fig = gHCIcossp(varargin);
% gHCIcossp(...)
% CO2_SSP
ffig = ne_group(varargin,'CO2_SSP','pHCIcosspt','pHCIcosspf','pHCIcosspo','pHCIcossps','pHCIcosspskipped','pHCIcosspstatus','pHCIcosspstale');
if nargout > 0 fig = ffig; end
