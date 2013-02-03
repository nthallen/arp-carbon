function cust_pHCIah(h)
% cust_pHCIah(h)
% Customize plot created by pHCIah

% pHCIah's definition:

% function pHCIah(varargin);
% % pHCIah( [...] );
% % Altimeter Ht
% h = timeplot({'MRA_Alt'}, ...
%       'Altimeter Ht', ...
%       'Ht', ...
%       {'MRA\_Alt'}, ...
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