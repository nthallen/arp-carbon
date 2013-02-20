function cust_pHCIspanhkinss(h)
% cust_pHCIspanhkinss(h)
% Customize plot created by pHCIspanhkinss

% pHCIspanhkinss's definition:

% function pHCIspanhkinss(varargin);
% % pHCIspanhkinss( [...] );
% % SPAN HK INS Status
% h = timeplot({'INS_Status'}, ...
%       'SPAN HK INS Status', ...
%       'INS Status', ...
%       {'INS\_Status'}, ...
%       varargin{:} );

% Example customizations include:
set(h,'LineStyle','none','Marker','.');
%   ax = get(h(1),'parent');
%   set(ax,'ylim',[0 800]);
