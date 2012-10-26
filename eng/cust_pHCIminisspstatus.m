function cust_pHCIminisspstatus(h)
% cust_pHCIminisspstatus(h)
% Customize plot created by pHCIminisspstatus

% pHCIminisspstatus's definition:

% function pHCIminisspstatus(varargin);
% % pHCIminisspstatus( [...] );
% % MINI_SSP Status
% h = timeplot({'SSP_M_Status'}, ...
%       'MINI_SSP Status', ...
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
