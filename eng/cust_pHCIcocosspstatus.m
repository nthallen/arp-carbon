function cust_pHCIcocosspstatus(h)
% cust_pHCIcocosspstatus(h)
% Customize plot created by pHCIcocosspstatus

% pHCIcocosspstatus's definition:

% function pHCIcocosspstatus(varargin);
% % pHCIcocosspstatus( [...] );
% % CO2 SSP Status
% h = timeplot({'SSP_C_Status'}, ...
%       'CO2 SSP Status', ...
%       'Status', ...
%       {'SSP\_C\_Status'}, ...
%       varargin{:} );

ticks = {'Gone','Connect','Ready','Armed','Trig'};
set(h,'LineStyle','none','Marker','.');
ax = get(h(1),'parent');
yl = get(ax,'ylim');
yticks = yl(1):yl(2);
yl = yl + [-.25 .25];
set(ax,'ylim',yl,'ytick',yticks,'yticklabel',{ticks{yticks+1}});
