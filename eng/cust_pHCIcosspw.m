function cust_pHCIcosspw(h)
% cust_pHCIcosspw(h)
% Customize plot created by pHCIcosspw

% pHCIcosspw's definition:

% function pHCIcosspw(varargin);
% % pHCIcosspw( [...] );
% % CO2_SSP Wave
% h = timeplot({'QCLI_C_Wave'}, ...
%       'CO2_SSP Wave', ...
%       'Wave', ...
%       {'QCLI\_C\_Wave'}, ...
%       varargin{:} );

set(h,'LineStyle','none','Marker','.');
ax = get(h,'parent');
waves = load_waves(1);
ydata = get(h,'ydata');
if ~isempty(waves)
    wvnos = unique(ydata)+1;
    map = zeros(max(wvnos),1);
    map(wvnos) = 1:length(wvnos);
    ydata = map(ydata+1);
    set(h,'ydata',ydata);
    set(ax,'ylim', [ 0.9 length(wvnos)+0.1 ], 'ytick', 1:length(wvnos), ...
        'yticklabel', {waves(wvnos).Name});
else
    set(ax,'ylim', [ min(ydata)-0.1 max(ydata)+0.1]);
end
