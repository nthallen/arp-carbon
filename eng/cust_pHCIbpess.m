function cust_pHCIbpess(h)
% cust_pHCIbpess(h)
% Customize plot created by pHCIbpess

% pHCIbpess's definition:

% function pHCIbpess(varargin);
% % pHCIbpess( [...] );
% % Best Pos ES Stat
% h = timeplot({'ExtSolnStatus'}, ...
%       'Best Pos ES Stat', ...
%       'ES Stat', ...
%       {'ExtSolnStatus'}, ...
%       varargin{:} );

% Example customizations include:
set(h,'LineStyle','none','Marker','.');
%   ax = get(h(1),'parent');
%   set(ax,'ylim',[0 800]);
