%%
% Script currently to be run in the RAW/RUN directory
clear all
close all
if exist('HCIraw_1.csv','file') && ~exist('HCIraw_1.mat','file')
    csv2mat('HCIraw_1.csv');
end    
if exist('HCIraw_10.csv','file') && ~exist('HCIraw_10.mat','file')
    csv2mat('HCIraw_10.csv');
end
%%
draw_fig = [0 0 0 1];
E1 = load('HCIeng_1.mat');
E10 = load('HCIeng_10.mat');
R1 = load('HCIraw_1.mat');
R10 = load('HCIraw_10.mat');
LE1 = length(E1.THCIeng_1);
LR1 = length(R1.THCIraw_1);
% i1: indices into R1 vectors that correspond to elements of E1
i1 = interp1(R1.THCIraw_1,1:LR1,E1.THCIeng_1,'nearest','extrap');
LE10 = length(E10.THCIeng_10);
LR10 = length(R10.THCIraw_10);
% i1: indices into R10 vectors that correspond to elements of E10
i10 = interp1(R10.THCIraw_10,1:LR10,E10.THCIeng_10,'nearest','extrap');
C = load('../Corrections.mat');
load('../alpha.mat'); % for S1, S2 and S3
Cals = S3;
%%
chans = fieldnames(Cals);
%%
Vref = 4.096;
for col = 1:length(chans)
    chan = chans{col};
    raw_rep = [chan '_raw'];
    if isfield(R1,raw_rep)
        raw_rep_rate = 1;
        Vrep = R1.(raw_rep)(i1);
        Trep = E1.THCIeng_1;
    elseif isfield(R10,raw_rep)
        raw_rep_rate = 10;
        Vrep = R10.(raw_rep)(i10);
        Trep = E10.THCIeng_10;
    else
        error('Unable to locate reported voltage %s', raw_rep);
    end
    if isfield(C,chan)
        corr = C.(chan);
        raw_pri = [corr.Prior '_raw'];
        if isfield(R1,raw_pri)
            raw_pri_rate = 1;
            Vpri = R1.(raw_pri)(i1);
            Tpri = E1.THCIeng_1;
        elseif isfield(R10,raw_pri)
            raw_pri_rate = 10;
            Vpri = R10.(raw_pri)(i10);
            Tpri = E10.THCIeng_10;
        else
            error('Unable to locate prior voltage %s', raw_pri);
        end
        if any(Vpri > 4)
            fprintf(1,'Vprior %s for %s is > 4V %.2f%% of the time\n', ...
                raw_pri, chan, 100*sum(Vpri>4)/length(Vpri));
        end
        if raw_pri_rate ~= raw_rep_rate
            Vpri = interp1(Tpri, Vpri, Trep, 'nearest', 'extrap');
        end
        Vtrue = interp2(corr.X,corr.Y,corr.Z,Vpri,Vrep);
        Rpu = corr.Rpu;
        if draw_fig(1)
            Trep = time2d(Trep);
            h = [0 0];
            figure;
            h(1) = nsubplot(2,1,1);
            plot(Trep,Vrep,Trep,Vtrue);
            title(sprintf('%s: Channel %s\\_raw', getrun, chan));
            set(gca, 'XTickLabel',[],'YAxisLocation','right');
            ylabel('Volts');
            legend('reported','corrected');
            h(2) = nsubplot(2,1,2);
            plot(Trep,Vtrue-Vrep);
            ylabel('Corr Volts');
            xlabel('UTC Seconds');
            linkaxes(h,'x');
        end
        meancorr = mean(Vtrue-Vrep);
        span = abs(diff(minmax(Vtrue')));
        fprintf(1,'%s/%s: %.2f%%\n', chan, corr.Prior, 100*meancorr/span);
    else
        Vtrue = Vrep;
        Rpu = 75e3;
    end
    
    % Now we have Vtrue. We also have the pullup resistance
    Rth = Vtrue.*Rpu./(Vref-Vtrue);
    cal = Cals.(chan).alpha;
    lnR = log(Rth);
    TempTrue = (1./([ones(size(lnR)), lnR, lnR.^3]*cal)) - 273.15;
    Tcorr.(chan) = TempTrue;
    
    % Now update the engineering data
    r0 = [chan '_r0'];
    if raw_rep_rate == 1
        if ~isfield(E1,r0)
            E1.(r0) = E1.(chan);
        end
        E1.(chan) = TempTrue;
        TempRep = E1.(r0);
    elseif raw_rep_rate == 10
        if ~isfield(E10,r0)
            E10.(r0) = E10.(chan);
        end
        E10.(chan) = TempTrue;
        TempRep = E10.(r0);
    else
        error('raw_rep_rate for channel %s is %d', chan, raw_rep_rate);
    end
    if draw_fig(2)
        Trep = time2d(Trep);
        plots = [0 0];
        figure;
        plots(1) = nsubplot(2,1,1);
        plot(Trep,TempRep,Trep,TempTrue);
        set(gca,'XTickLabel',[],'YAxisLocation','Right');
        title(sprintf('%s: Channel %s', getrun, chan));
        ylabel('Celcius');
        legend('Reported','Corrected','Location','Southeast');
        plots(2) = nsubplot(2,1,2);
        plot(Trep, TempTrue - TempRep);
        ylabel('Correction Celcius');
        xlabel('UTC Seconds');
        linkaxes(plots,'x');
    end
end
save('HCIeng_1.mat','-struct','E1');
save('HCIeng_10.mat','-struct','E10');
%%
if draw_fig(3)
    figure;
    plots = [0 0];
    plots(1) = nsubplot(2,1,1);
    Trep = time2d(E1.THCIeng_1);
    plot(Trep, Tcorr.ICel1T, Trep, Tcorr.ICel2T);
    title(sprintf('%s: Corrected', getrun));
    legend('ICel1T','ICel2T','Location','SouthEast');
    set(gca,'XTickLabel',[],'YAxisLocation','Right');
    ylabel('Celcius');
    plots(2) = nsubplot(2,1,2);
    plot(Trep, Tcorr.ICel1T - Tcorr.ICel2T);
    set(gca,'ygrid','on');
    ylabel('dT Celcius');
    xlabel('UTC Seconds');
    linkaxes(plots,'x');
    figure;
    plots = [0 0];
    plots(1) = nsubplot(2,1,1);
    Trep = time2d(E1.THCIeng_1);
    plot(Trep, E1.ICel1T, Trep, E1.ICel2T);
    title(sprintf('%s: Uncorrected', getrun));
    legend('ICel1T','ICel2T','Location','SouthEast');
    set(gca,'XTickLabel',[],'YAxisLocation','Right');
    ylabel('Celcius');
    plots(2) = nsubplot(2,1,2);
    plot(Trep, E1.ICel1T - E1.ICel2T);
    set(gca,'ygrid','on');
    ylabel('dT Celcius');
    xlabel('UTC Seconds');
    linkaxes(plots,'x');
    
    figure;
    plots = [0 0];
    plots(1) = nsubplot(2,1,1);
    Trep = time2d(E10.THCIeng_10);
    plot(Trep, Tcorr.MCel1T, Trep, Tcorr.MCel2T);
    title(sprintf('%s: Corrected', getrun));
    legend('MCel1T','MCel2T','Location','SouthEast');
    set(gca,'XTickLabel',[],'YAxisLocation','Right');
    ylabel('Celcius');
    plots(2) = nsubplot(2,1,2);
    plot(Trep, Tcorr.MCel1T - Tcorr.MCel2T);
    set(gca,'ygrid','on');
    ylabel('dT Celcius');
    xlabel('UTC Seconds');
    linkaxes(plots,'x');
    figure;
    plots = [0 0];
    plots(1) = nsubplot(2,1,1);
    Trep = time2d(E10.THCIeng_10);
    plot(Trep, E10.MCel1T, Trep, E10.MCel2T);
    title(sprintf('%s: Uncorrected', getrun));
    legend('MCel1T','MCel2T','Location','SouthEast');
    set(gca,'XTickLabel',[],'YAxisLocation','Right');
    ylabel('Celcius');
    plots(2) = nsubplot(2,1,2);
    plot(Trep, E10.MCel1T - E10.MCel2T);
    set(gca,'ygrid','on');
    ylabel('dT Celcius');
    xlabel('UTC Seconds');
    linkaxes(plots,'x');
   
    figure;
    plots = [0 0];
    plots(1) = nsubplot(2,1,1);
    Trep = time2d(E10.THCIeng_10);
    plot(Trep, Tcorr.CCel1T, Trep, Tcorr.CCel2T);
    title(sprintf('%s: Corrected', getrun));
    legend('CCel1T','CCel2T','Location','SouthEast');
    set(gca,'XTickLabel',[],'YAxisLocation','Right');
    ylabel('Celcius');
    plots(2) = nsubplot(2,1,2);
    plot(Trep, Tcorr.CCel1T - Tcorr.CCel2T);
    set(gca,'ygrid','on');
    ylabel('dT Celcius');
    xlabel('UTC Seconds');
    linkaxes(plots,'x');
    figure;
    plots = [0 0];
    plots(1) = nsubplot(2,1,1);
    Trep = time2d(E10.THCIeng_10);
    plot(Trep, E10.CCel1T, Trep, E10.CCel2T);
    title(sprintf('%s: Uncorrected', getrun));
    legend('CCel1T','CCel2T','Location','SouthEast');
    set(gca,'XTickLabel',[],'YAxisLocation','Right');
    ylabel('Celcius');
    plots(2) = nsubplot(2,1,2);
    plot(Trep, E10.CCel1T - E10.CCel2T);
    set(gca,'ygrid','on');
    ylabel('dT Celcius');
    xlabel('UTC Seconds');
    linkaxes(plots,'x');
end
%%
if draw_fig(4)
    for cell = 'MCI'
        plots = zeros(2,2);
        suffixes = { '_r0', '' };
        desc = { 'Uncorrected', 'Corrected' };
        figure;
        for col = [1,2]
            for row = [1,2]
                plots(col,row) = nsubplot(2,2,row,col);
            end
        end
        chan = [cell 'Cel1T'];
        if isfield(E1,chan)
            raw_rep_rate = 1;
            T = E1.THCIeng_1;
        elseif isfield(E10,chan)
            raw_rep_rate = 10;
            T = E10.THCIeng_10;
        else
            error('Cannot locate channel "%s"', chan);
        end
        T = time2d(T);
        for col = [1,2]
            chan1 = [ cell 'Cel1T' suffixes{col} ];
            chan2 = [ cell 'Cel2T' suffixes{col} ];
            if raw_rep_rate == 1
                T1 = E1.(chan1);
                T2 = E1.(chan2);
            else
                T1 = E10.(chan1);
                T2 = E10.(chan2);
            end
            plot(plots(col,1), T, T1, T, T2);
            title(plots(col,1), sprintf('%s: %s Cell %s', getrun, ...
                desc{col}, cell));
            legend(plots(col,1),[cell 'Cel1T'], [cell 'Cell2T']);
            set(plots(col,1),'XTickLabel',[]);
            if col == 2
                set(plots(col,1),'YAxisLocation', 'Right');
            end
            ylabel('Celcius');
            plot(plots(col,2),T,T1-T2);
            set(plots(col,2),'ygrid','on');
            if col == 2
                set(plots(col,2),'YAxisLocation','Right');
            end
            ylabel('dT Celcius');
            xlabel(plots(col,2),'UTC Seconds');
        end
        % linkaxes(plots(:,1)','y');
        % linkaxes(plots(:,2)','y');
        linkaxes(plots(1,:),'x');
        linkaxes(plots(2,:),'x');
        for row = [1,2]
            yl1 = get(plots(1,row),'ylim');
            yl2 = get(plots(2,row),'ylim');
            yl = minmax([yl1, yl2]);
            set(plots(:,row),'ylim',yl);
        end
    end
end
