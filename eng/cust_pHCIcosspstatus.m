function cust_pHCIcosspstatus(h)
% cust_pHCIcosspstatus(h)
% Customize plot created by pHCIcosspstatus

% pHCIcosspstatus's definition:

% function pHCIcosspstatus(varargin);
% % pHCIcosspstatus( [...] );
% % CO2_SSP Status
% h = timeplot({'SSP_C_Status'}, ...
%       'CO2_SSP Status', ...
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
