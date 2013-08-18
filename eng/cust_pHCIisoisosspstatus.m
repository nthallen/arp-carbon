function cust_pHCIisoisosspstatus(h)
% cust_pHCIisoisosspstatus(h)
% Customize plot created by pHCIisoisosspstatus

% pHCIisoisosspstatus's definition:

% function pHCIisoisosspstatus(varargin);
% % pHCIisoisosspstatus( [...] );
% % ISO SSP Status
% h = timeplot({'SSP_I_Status'}, ...
%       'ISO SSP Status', ...
%       'Status', ...
%       {'SSP\_I\_Status'}, ...
%       varargin{:} );

% Example customizations include:
%   set(h,'LineStyle','none','Marker','.');
%   ax = get(h(1),'parent');
%   set(ax,'ylim',[0 800]);

ticks = {'Gone','Connect','Ready','Armed','Trig'};
set(h,'LineStyle','none','Marker','.');
ax = get(h(1),'parent');
yl = get(ax,'ylim');
yticks = yl(1):yl(2);
yl = yl + [-.25 .25];
set(ax,'ylim',yl,'ytick',yticks,'yticklabel',{ticks{yticks+1}});
