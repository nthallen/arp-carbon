function fig = gHCIcossp(varargin);
% gHCIcossp(...)
% CO2_SSP
ffig = ne_group(varargin,'CO2_SSP','pHCIcosspf','pHCIcosspo','pHCIcossps','pHCIcosspskipped','pHCIcosspstale','pHCIcosspstatus','pHCIcosspt');
if nargout > 0 fig = ffig; end
