function cust_pHCIminiminisspw(h)
% cust_pHCIminiminisspw(h)
% Customize plot created by pHCIminiminisspw

% pHCIminiminisspw's definition:

% function pHCIminiminisspw(varargin);
% % pHCIminiminisspw( [...] );
% % MINI SSP Wave
% h = timeplot({'QCLI_M_Wave'}, ...
%       'MINI SSP Wave', ...
%       'Wave', ...
%       {'QCLI\_M\_Wave'}, ...
%       varargin{:} );

set(h,'LineStyle','none','Marker','.');
ax = get(h,'parent');
waves = load_wavespecs('QCLI_M.m');
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

function WaveSpecs = load_wavespecs(filename)
HCIdir = HCI_Data_Dir;
rundir = getrun(1);
dirs = { filesep [filesep 'Base' filesep] };
for i=1:length(dirs)
    path = [HCIdir filesep rundir dirs{i} filename];
    if exist(path,'file')
        eval(['run ' path ';'])
        return;
    end
end
WaveSpecs = [];
