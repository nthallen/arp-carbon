function pHCIminiminilt(varargin);
% pHCIminiminilt( [...] );
% MINI Laser Temp
h = timeplot({'MLH_T','MQCL_T1C','MQCL_T2C'}, ...
      'MINI Laser Temp', ...
      'Temp', ...
      {'MLH\_T','MQCL\_T1C','MQCL\_T2C'}, ...
      varargin{:} );