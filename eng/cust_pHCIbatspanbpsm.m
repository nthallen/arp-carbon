function cust_pHCIbatspanbpsm(h)
% cust_pHCIbatspanbpsm(h)
% Customize plot created by pHCIbatspanbpsm

% pHCIbatspanbpsm's definition:

% function pHCIbatspanbpsm(varargin);
% % pHCIbatspanbpsm( [...] );
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
