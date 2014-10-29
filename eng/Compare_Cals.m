%%
R = (700e3:1000:3e6)';
lnR = log(R);
RM = [ones(size(R)) lnR lnR.^3];
%%
if exist('nalphas123.mat','file')
    % alphas123.mat contains the alphas cell array with 3 elements,
    % which presumably correspond to S1, S2 and S3.
    load('nalphas123.mat');
    alphas = nalphas123;
else
    % alpha.mat contains S1, S2, S3
    load alpha_v1.mat
end
S1 = alphas{1};
S2 = alphas{2};
S3 = alphas{3};
chans = fieldnames(S1);
C = load('Corrections.mat');
%%
stds = zeros(3,length(chans));
for i = 1:length(chans)
    chan = chans{i};
    T1 = -273.15 + 1./(RM*S1.(chan));
    T2 = -273.15 + 1./(RM*S2.(chan));
    T3 = -273.15 + 1./(RM*S3.(chan));
    stds(1,i) = mean(abs(T3-T2));
    stds(2,i) = mean(abs(T3-T1));
    stds(3,i) = mean(abs(T2-T1));
    %figure;
    %plot(T1, T3-T2, T1, T3-T1, T1, T2-T1);
    %legend('S3-S2','S3-S1','S2-S1');
    %title(sprintf('Channel %s', chan));
end
%%
figure;
x = 1:length(chans);
plot(x,stds','*-');
legend('S3-S2','S3-S1','S2-S1');
% set(gca,'XTick',x,'XTickLabel',chans);
set(gca,'XTick',[],'xlim',[0.5 x(end)+0.5]);
lbls = zeros(length(chans),1);
for i=x
    lbls(i) = text(i,-.05,chans{i});
    if isfield(C,chans{i})
        set(lbls(i),'Color','blue');
    end
end
set(lbls,'Rotation',90)
set(lbls,'HorizontalAlignment','right');
ylabel('Celcius');
title('std of differences between cal curves');
