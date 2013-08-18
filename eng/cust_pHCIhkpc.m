function cust_pHCIhkpc(h)
% cust_pHCIhkpc(h)
% Customize plot created by pHCIhkpc

% pHCIhkpc's definition:

% function pHCIhkpc(varargin);
% % pHCIhkpc( [...] );
% % Power Current
% h = timeplot({'PM0I1','PM0I2','PM1I1'}, ...
%       'Power Current', ...
%       'Current', ...
%       {'PM0I1','PM0I2','PM1I1'}, ...
%       varargin{:} );

% Example customizations include:
%   set(h,'LineStyle','none','Marker','.');
ax = get(h(1),'parent');
%   set(ax,'ylim',[0 800]);
ydata = get(h(3),'YData');
run = getrun(1,ax);
if ~isdigit(run(end))
    run = run(1:end-1);
end
if str2double(run) > 130619.0
    ydata = ydata * 2;
    set(h(3),'YData',ydata);
end
ylabel(ax,'Amps');
