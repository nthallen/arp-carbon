function cust_pHCIbpsm(h)
% cust_pHCIbpsm(h)
% Customize plot created by pHCIbpsm

% pHCIbpsm's definition:

% function pHCIbpsm(varargin);
% % pHCIbpsm( [...] );
% % Best Pos Sig Mask
% h = timeplot({'SigMask'}, ...
%       'Best Pos Sig Mask', ...
%       'Sig Mask', ...
%       {'SigMask'}, ...
%       varargin{:} );

% Example customizations include:
set(h,'LineStyle','none','Marker','.');
%   ax = get(h(1),'parent');
%   set(ax,'ylim',[0 800]);
