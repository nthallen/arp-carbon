function cust_pHCIminiminisspstatus(h)
% cust_pHCIminiminisspstatus(h)
% Customize plot created by pHCIminiminisspstatus

% pHCIminiminisspstatus's definition:

% function pHCIminiminisspstatus(varargin);
% % pHCIminiminisspstatus( [...] );
% % MINI SSP Status
% h = timeplot({'SSP_M_Status'}, ...
%       'MINI SSP Status', ...
%       'Status', ...
%       {'SSP\_M\_Status'}, ...
%       varargin{:} );

ticks = {'Gone','Connect','Ready','Armed','Trig'};
set(h,'LineStyle','none','Marker','.');
ax = get(h(1),'parent');
yl = get(ax,'ylim');
yticks = yl(1):yl(2);
yl = yl + [-.25 .25];
set(ax,'ylim',yl,'ytick',yticks,'yticklabel',{ticks{yticks+1}});
