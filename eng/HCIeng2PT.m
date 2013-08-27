function HCIeng2PT
%This is a customized eng to PT file conversion program for HCI.
%This creates the PT.mat file required by the ICOSfit programs.
cfg = load_ICOSfit_cfg;
runs = ne_load_runsdir('HCI_Data_Dir');
run = getrun(1);
E = load_eng('HCIeng_1.mat', runs, run);
E10 = load_eng('HCIeng_10.mat', runs, run);
if isempty(E) || isempty(E10)
    return;
end
T1 = E.THCIeng_1;
T10 = E10.THCIeng_10;

if strcmp(cfg.ScanDir,'SSP_C')
    PT.TPT = T10;
    PT.CellP = E10.CCelLP; %cell pressure (in Torr) to use for fit
    % These two interpolations are here just to deal with legacy
    % data.
    if ~isfield(E10,'CCel1T')
        E10.CCel1T = interp1(T1,E.CCel1T,T10,'linear');
    end
    if ~isfield(E10,'CCel2T')
        E10.CCel2T = interp1(T1,E.CCel2T,T10,'linear');
    end
    PT.Tavg = 273.15 + (E10.CCel1T + E10.CCel2T)/2; %gas temp (in K) to use for fit
    PT.ScanNum = round(interp1(T1,E.SSP_C_Num,T10,'linear','extrap'));
    PT.QCLI_Wave = interp1(T1,E.QCLI_C_Wave,T10,'nearest','extrap'); %for example QCLI_C_Wave
elseif strcmp(cfg.ScanDir,'SSP_M')
    PT.TPT = T10;
    PT.CellP = E10.MCelLP; %cell pressure (in Torr) to use for fit
    PT.Tavg = 273.15 + (E10.MCel1T + E10.MCel2T)/2; %gas temp (in K) to use for fit
    PT.ScanNum = round(interp1(T1,E.SSP_M_Num,T10,'linear','extrap'));
    PT.QCLI_Wave = interp1(T1,E.QCLI_M_Wave,T10,'nearest','extrap'); %for example QCLI_C_Wave
elseif strcmp(cfg.ScanDir,'SSP_I')
    PT.TPT = T1;
    PT.CellP = fastavg(E10.ICelLP,10);
    PT.Tavg = 273.15 + (E.ICel1T + E.ICel2T)/2;
    PT.ScanNum = E.SSP_I_Num;
    PT.QCLI_Wave = E.QCLI_I_Wave;
else
    fprintf(1,'Unable to identify instrument from ScanDir "%s"\n', ...
        cfg.ScanDir);
    return;
end
save PT.mat -STRUCT PT

function E = load_eng(base, runs, run)
file = base;
if ~exist(file, 'file')
    file = [runs '/' run '/' file];
end
if exist(file, 'file')
    E = load(file);
else
    fprintf(1,'Unable to locate engineering data file "%s"\n', base);
    E = [];
end
