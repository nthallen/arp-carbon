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
xdata = get(h,'xdata');
ydata = get(h,'ydata');
vstale = ydata >= 655.355;
ydata(vstale) = ydata(vstale) - 655.36;
vbad = ydata >= 327.675;
ydata(vbad) = ydata(vbad) - 327.68;
vstale = vstale & ~vbad;
ax = get(h(1),'parent');
if any(vstale)
    line(xdata(vstale), ydata(vstale), 'Parent', ax, 'LineStyle','none','Marker','.','Color',[0 1 0]);
end
if any(vbad)
    line(xdata(vbad), ydata(vbad), 'Parent', ax, 'LineStyle','none','Marker','*','Color',[1 0 0]);
end
ydata(vbad | vstale) = NaN;
set(h,'ydata',ydata);
yl = get(ax,'YLim');
nyl = [ min(yl(1), 0) max(yl(2), 20) ];
if any(nyl ~= yl)
    set(ax,'YLim',nyl);
end