function cust_pHCIbatspanah(h)
% cust_pHCIbatspanah(h)
% Customize plot created by pHCIbatspanah

% pHCIbatspanah's definition:

% function pHCIbatspanah(varargin);
% % pHCIbatspanah( [...] );
% % Altimeter Ht
% h = timeplot({'MRA_Alt_a'}, ...
%       'Altimeter Ht', ...
%       'Ht', ...
%       {'MRA\_Alt\_a'}, ...
%       varargin{:} );

% Example customizations include:
%   set(h,'LineStyle','none','Marker','.');
%   ax = get(h(1),'parent');
%   set(ax,'ylim',[0 800]);
ax = get(h(1),'parent');
yl = get(ax,'YLim');
nyl = [ min(yl(1), 0) max(yl(2), 10) ];
if any(nyl ~= yl)
    set(ax,'YLim',nyl);
end
