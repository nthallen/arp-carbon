function cust_pHCIcoqcliw(h)
% cust_pHCIcoqcliw(h)
% Customize plot created by pHCIcoqcliw

% pHCIcoqcliw's definition:

% function pHCIcoqcliw(varargin);
% % pHCIcoqcliw( [...] );
% % CO2_QCLI Wave
% h = timeplot({'QCLI_C_Wave'}, ...
%       'CO2_QCLI Wave', ...
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