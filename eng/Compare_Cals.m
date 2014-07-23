%%
R = (700e3:1000:3e6)';
lnR = log(R);
RM = [ones(size(R)) lnR lnR.^3];
chans = fieldnames(S1);
%%
stds = zeros(3,length(chans));
for i = 1:length(chans)
    chan = chans{i};
    T1 = 1./(RM*S1.(chan).alpha);
    T2 = 1./(RM*S2.(chan).alpha);
    T3 = 1./(RM*S3.(chan).alpha);
    stds(1,i) = std(T3-T2);
    stds(2,i) = std(T3-T1);
    stds(3,i) = std(T2-T1);
    figure;
    plot(T1-273.15,T2-T1,T1-273.15,T3-T1,T1-273.15,T3-T2);
    legend('S2-S1','S3-S1','S3-S2');
    title(sprintf('Channel %s', chan));
end
%%
figure;
x = 1:length(chans);
plot(x,stds','*-');
legend('S3-S2','S3-S1','S2-S1');
set(gca,'XTickLabel',chans);
ylabel('Celcius');
title('std of differences between cal curves');
