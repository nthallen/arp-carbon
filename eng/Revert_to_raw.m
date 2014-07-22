%% Revert to raw
Conv.AI_T30K = [
    240, 149.77374
    304, 139.94016
    360, 133.22126
    424, 126.81630
    480, 122.07367
    544, 117.37692
    656, 110.44108
    776, 104.44295
    896, 99.40565
    1016, 95.03216
    1184, 89.86683
    1368, 85.05750
    1600, 79.94779
    1888, 74.65638
    2184, 70.01943
    2480, 66.11000
    2592, 64.69045
    3000, 60.16219
    3528, 55.19444
    4176, 50.04177
    4928, 45.00872
    5808, 39.98948
    6800, 35.13474
    7040, 34.10256
    7976, 30.14900
    8096, 29.68644
    9376, 24.95493
    10904, 19.93996
    12536, 15.09820
    14288, 10.28893
    14528, 9.65120
    16160, 5.42143
    16632, 4.22154
    20376, -5.19987
    22248, -10.07644
    24008, -14.94382
    25640, -19.91098
    27048, -24.77442
    27160, -25.18974
    28328, -29.91959
    29384, -35.05450
    30200, -39.95834
];
Conv.AI_T1M250KU = [
    216, 257.85
    280, 242.31
    344, 230.49
    408,  221.1
    472, 213.33
    536,  206.7
    600, 200.93
    664, 195.85
    728, 191.34
    856, 183.54
    920, 180.07
    984,    177
    1112, 171.35
    1296, 164.43
    1424, 160.24
    1616, 154.71
    1744, 151.49
    1872, 148.48
    2000, 145.64
    2248, 140.76
    2376, 138.49
    2568, 135.23
    2888, 130.46
    3264, 125.51
    3392,    124
    3520, 122.54
    3776, 119.68
    4032, 117.13
    4280, 114.71
    4792, 110.22
    5424, 105.34
    5552, 104.43
    6192, 100.08
    6952, 95.501
    7080,  94.76
    7968, 89.995
    8984, 85.102
    10128, 80.099
    11392, 75.059
    12664, 70.382
    12920, 69.476
    14192, 65.087
    15712, 60.093
    17480, 54.483
    20528, 44.942
    22056, 40.025
    23576, 34.907
    24976, 29.853
    26248, 24.852
    27264, 20.379
    27392,  19.79
    28344, 15.039
    29232, 9.8874
    29928, 5.1303
    30568, -0.12809
    31072, -5.1857
    31456, -9.9581
    31768, -14.835
    32024, -19.92
    32208, -24.66
    32336, -28.911
    32400, -31.448
    32464, -34.343
    32560, -39.957
    32592, -42.59
    32656, -48.982
    32712, -58.501
];
Conv.PC100Torr = [
    0, 0
    26666.7, 100
];
Conv.AI16 = [
    0, 0
    32768, 4.096
];
%%
ChanType.CRv1T = 'AI_T30K';
ChanType.CRv2T = 'AI_T30K';
ChanType.CRv3T = 'AI_T30K';
ChanType.CRv4T = 'AI_T30K';
ChanType.CRv5T = 'AI_T30K';
ChanType.CSk1T = 'AI_T30K';
ChanType.CSk2T = 'AI_T30K';
ChanType.CSk3T = 'AI_T30K';
ChanType.ICel1T = 'AI_T1M250KU';
ChanType.ICel2T = 'AI_T1M250KU';
ChanType.IRv1T = 'AI_T30K';
ChanType.IRv2T = 'AI_T30K';
ChanType.IRv3T = 'AI_T30K';
ChanType.IRv4T = 'AI_T30K';
ChanType.IRv5T = 'AI_T30K';
ChanType.ISk1T = 'AI_T1M250KU';
ChanType.ISk2T = 'AI_T1M250KU';
ChanType.ISk3T = 'AI_T1M250KU';
ChanType.MCelP = 'PC100Torr';
ChanType.MRv1T = 'AI_T30K';
ChanType.MRv2T = 'AI_T30K';
ChanType.MRv3T = 'AI_T30K';
ChanType.MRv4T = 'AI_T30K';
ChanType.MRv5T = 'AI_T30K';
ChanType.MSG1T = 'AI_T30K';
ChanType.MSSPT = 'AI_T30K';
ChanType.MSk1T = 'AI_T30K';
ChanType.MSk2T = 'AI_T30K';
ChanType.MSk3T = 'AI_T30K';
ChanType.CCel1T = 'AI_T1M250KU';
ChanType.AICD6 = 'AI16';
ChanType.CCel2T = 'AI_T1M250KU';
ChanType.AICD4 = 'AI16';
ChanType.MCel1T = 'AI_T1M250KU';
ChanType.AIC48 = 'AI16';
ChanType.MCel2T = 'AI_T1M250KU';
%%
chans = fieldnames(ChanType);
%%
E1 = load('HCIeng_1.mat');
E10 = load('HCIeng_10.mat');
R1.THCIraw_1 = E1.THCIeng_1;
R10.THCIraw_10 = E10.THCIeng_10;
%%
ait = Conv.AI16;
for i = 1:length(chans)
    chan = chans{i};
    rawchan = [chan '_raw'];
    V = [];
    if isfield(E1, chan)
        V = E1.(chan);
    elseif isfield(E10, chan)
        V = E10.(chan);
    else
        fprintf(1,'Skipping channel "%s"\n', chan);
    end
    if ~isempty(V)
        lut = Conv.(ChanType.(chan));
        RV = interp1(lut(:,2), lut(:,1), V);
        RV = interp1(ait(:,1), ait(:,2), RV);
        if isfield(E1, chan)
            R1.(rawchan) = RV;
        else
            R10.(rawchan) = RV;
        end
    end
end
%%
if exist('HCIraw_1.mat','file') || exist('HCIraw_10.mat','file')
    % Now check it against the raw file
    R1a = load('HCIraw_1.mat');
    R10a = load('HCIraw_10.mat');
    L1 = length(R1.THCIraw_1);
    L1a = length(R1a.THCIraw_1);
    i1 = interp1(R1a.THCIraw_1,1:L1a,R1.THCIraw_1,'nearest','extrap');
    L10 = length(R10.THCIraw_10);
    L10a = length(R10.THCIraw_10);
    i10 = interp1(R10a.THCIraw_10,1:L10a,R10.THCIraw_10,'nearest','extrap');
    %%
    diff1 = zeros(length(chans),1);
    fdiff1 = zeros(length(chans),1);
    for i = 1:length(chans)
        chan = chans{i};
        rawchan = [chan '_raw'];
        if isfield(R1, rawchan)
            V = R1.(rawchan);
            Va = R1a.(rawchan);
            Va = Va(i1);
        elseif isfield(R10, rawchan)
            V = R10.(rawchan);
            Va = R10a.(rawchan);
            Va = Va(i10);
        else
            fprintf(1,'Skipping channel "%s"\n', chan);
        end
        if ~isempty(V)
            dV = max(abs(V-Va));
            fdV = dV/(max(V)-min(V));
            diff1(i) = dV;
            fdiff1(i) = fdV;
        end
    end
    x = 1:length(chans);
    plots = [0 0];
    figure;
    plots(1) = nsubplot(2,1,1);
    plot(x,diff1,'*');
    set(gca,'XTick',x,'XTickLabel',[],'YAxisLocation','Right');
    plots(2) = nsubplot(2,1,2);
    plot(x,fdiff1,'*');
    set(gca,'XTick',x,'XTickLabel',chans);
    linkaxes(plots, 'x');
    %%
    chan = 'IRv3T';
    rawchan = [chan '_raw'];
    dV = R1.(rawchan) - R1a.(rawchan)(i1);
    figure; plot(dV,'.');
    T1 = time2d(R1.THCIraw_1);
    figure; plot(T1,R1.IRv3T_raw,'.-',T1,R1a.IRv3T_raw(i1),'.-')
    legend('R1','R1a');
else
    save('HCIraw_1a.mat', '-struct', 'R1');
    save('HCIraw_10a.mat', '-struct','R10');
end