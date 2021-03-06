function level2datacombine(date,ext)
% level2datacombine(date,ext)
%   date : date of run eg. '130828.3'
%   ext : extension for run eg. 'L2a'
%script to combine ISO, CO2, and MM files into a single file
%Combine will also create dry mixing ratios. MM data must exist. 
%Assumptions: MM has one CH4, one H2O, and optionally a N2O
%             ISO has one CH4 and one 13CH4
%             CO2 has one CO2, one 13CO2, and optionally a C18OO
% A wet H2O and CO2 are interpolated over the entire region so that they
% can be subtracted to create dry mixing ratios. 
%

% Loading data into program
useISO='y'; useCO2='y'; useMM='y';
run('calcoeffs');
if exist(['MM' date '.' ext '.mat'],'file')~=2
    disp(['Error: File MM' date '.' ext '.mat does not exist. Exiting']);
    return
end
try
eval(['MM = load(''MM' date '.' ext '.mat'',''T1*'',''lines_used'');']);
lu=struct2cell(MM.lines_used);
eval(['MMCH4 = struct2array(load(''MM' date '.' ext '.mat'',''-regexp'',''CH4[a-z]?$''));']);
MMCH4ncal=find([cal_coeffs.line]==MM.lines_used(find(strncmp('CH4',lu(1,:,:),3))).nu);
eval(['MMH2O = struct2array(load(''MM' date '.' ext '.mat'',''-regexp'',''H2O[a-z]?$''));']);
MMH2Oncal=find([cal_coeffs.line]==MM.lines_used(find(strncmp('H2O',lu(1,:,:),3))).nu);
eval(['MMCH4sntime = struct2array(load(''MM' date '.' ext '.mat'',''-regexp'',''CH4[a-z]?sntime''));']);
eval(['MMH2Osntime = struct2array(load(''MM' date '.' ext '.mat'',''-regexp'',''H2O[a-z]?sntime''));']);
load(['MM' date '.' ext '.mat'],'sntime');
catch
    disp(['Error: File MM' date '.' ext '.mat does not contain CH4 or H2O or lines_used variables. Can not continue. Exiting']);
    return
end
try
eval(['MMN2O = struct2array(load(''MM' date '.' ext '.mat'',''-regexp'',''N2O[a-z]?$''));']);
MMN2Oncal=find([cal_coeffs.line]==MM.lines_used(find(strncmp('N2O',lu(1,:,:),3))).nu);
catch
    disp(['Warning: No N2O Data. Continuing with no N2O data']);
end
if exist(['ISO' date '.' ext '.mat'],'file')~=2
    disp(['Warning: File ISO' date '.' ext '.mat does not exist. Continuing with no ISO data']);
    useISO='n';
else
    try
        eval(['ISO = load(''ISO' date '.' ext '.mat'',''T1*'',''lines_used'');']);
        lu=struct2cell(ISO.lines_used);
        eval(['ISOCH4 = struct2array(load(''ISO' date '.' ext '.mat'',''-regexp'',''CH4[a-z]?$''));']);
        ISOCH4ncal=find([cal_coeffs.line]==ISO.lines_used(find(strncmp('CH4',lu(1,:,:),3))).nu);
        eval(['ISOC13H4 = struct2array(load(''ISO' date '.' ext '.mat'',''-regexp'',''C13H4[a-z]?$''));']);
        ISOC13H4ncal=find([cal_coeffs.line]==ISO.lines_used(find(strncmp('C13',lu(1,:,:),3))).nu);
    catch
            disp(['Warning: File ISO' date '.' ext '.mat does not contain CH4 or 13CH4 or lines_used. Continuing with no ISO data']);
            useISO='n';
    end
end
if exist(['CO2' date '.' ext '.mat'],'file')~=2
    disp(['Warning: File CO2' date '.' ext '.mat does not exist. Continuing with no CO2 data']);
    useCO2='n';
else
    try
        eval(['CO2 = load(''CO2' date '.' ext '.mat'',''T1*'',''lines_used'');']);
        lu=struct2cell(CO2.lines_used);
        eval(['CO2CO2 = struct2array(load(''CO2' date '.' ext '.mat'',''-regexp'',''CO2[a-z]?$''));']);
        CO2CO2ncal=find([cal_coeffs.line]==CO2.lines_used(find(strncmp('CO2',lu(1,:,:),3))).nu);
        eval(['CO2C13O2 = struct2array(load(''CO2' date '.' ext '.mat'',''-regexp'',''C13O2[a-z]?$''));']);
        CO2C13O2ncal=find([cal_coeffs.line]==CO2.lines_used(find(strncmp('C13O2',lu(1,:,:),3))).nu);
%eval(['CO2C18OO = struct2array(load(''CO2' date '.' ext '.mat'',''C18OO*''));']);
%CO2C18OOncal=find([cal_coeffs.line]==CO2.lines_used(find(strncmp('C18OO',lu(1,:,:),3))).nu);
    catch
            disp(['Warning: File CO2' date '.' ext '.mat does not contain CO2 or 13CO2 or lines_used. Continuing with no CO2 data']);
            useCO2='n';
    end
end

eval(['load(''MM' date '.' ext '.mat'',''T*'',''A*'',''L*'',''Ht'');']);

%Check to make sure time bases are the same
if useISO=='y'
    I=issame(MM.T10Hz_GPS_msec,ISO.T10Hz_GPS_msec);
    if I~=2
        disp('Error: ISO and MM time bases do not match');
        return
    end
elseif useCO2=='y'
    I=issame(MM.T10Hz_GPS_msec,CO2.T10Hz_GPS_msec);
    if I~=2
        disp('Error: CO2 and MM time bases do not match');
        return
    end
end

% Now create dry mixing ratios using H2O from MM
if isempty(MMH2O)
    disp('No H2O data. Can not calculate dry mixing ratios. Exiting.');
    return
end
% Interpolate water vapor for points where we don't have measurements.
y=fastavg(MMH2O,10);
index=(find(~isnan(y))-1)*10*ones(1,10);
index=index+ones(size(index,1),1)*[1:10];
[row,col]=size(index');
index=reshape(index',1,row*col);
H2Owet=ones(size(T10Hz_GPS_msec))*NaN;
H2Owet(index)=interp1(T10Hz_GPS_msec(~isnan(MMH2O)),MMH2O(~isnan(MMH2O)),T10Hz_GPS_msec(index));

if useCO2=='y'
    CO2wet=( interp1(T10Hz_ftime(~isnan(CO2CO2)),CO2CO2(~isnan(CO2CO2)),T10Hz_ftime)*isovals(21,'abundance') + ...
        interp1(T10Hz_ftime(~isnan(CO2C13O2)),CO2C13O2(~isnan(CO2C13O2)),T10Hz_ftime)*isovals(22,'abundance') )/(isovals(21,'abundance')+isovals(22,'abundance'));
else
    CO2wet=ones(size(T10Hz_ftime))*400e-6; %if we don't have CO2 assume mean troposhere. Not very good.
end
H2Odry=H2Owet./(1-H2Owet-CO2wet);
if ~isempty(MMCH4); CH4dry=(MMCH4./(1-H2Owet-CO2wet))*isovals(61,'abundance')+H2Owet*cal_coeffs(MMCH4ncal).g_m; end
if ~isempty(MMN2O); N2Odry=(MMN2O./(1-H2Owet-CO2wet))*isovals(41,'abundance')+H2Owet*cal_coeffs(MMN2Oncal).g_m; end
if ~isempty(MMCH4sntime); CH4drysntime=(MMCH4sntime./(1-MMH2Osntime))+MMH2Osntime*cal_coeffs(MMCH4ncal).g_m; end
if ~isempty(MMH2Osntime); H2Odrysntime=(MMH2Osntime./(1-MMH2Osntime))+MMH2Osntime*cal_coeffs(MMH2Oncal).g_m; end
if useCO2=='y'
    if ~isempty(CO2CO2); CO2dry=(CO2CO2./(1-H2Owet-CO2wet))*isovals(21,'abundance')+H2Owet*cal_coeffs(CO2CO2ncal).g_m; end
    if ~isempty(CO2C13O2); C13O2dry=(CO2C13O2./(1-H2Owet-CO2wet))*isovals(22,'abundance')+H2Owet*cal_coeffs(CO2C13O2ncal).g_m; end
%    if ~isempty(CO2C18OO); C18OOdry=(CO2C18OO./(1-H2Owet-CO2wet)+H2Owet*cal_coeffs(CO2C18OOncal).g_m)*isovals(23,'abundance'); end
    TCO2dry=(CO2dry+C13O2dry)/(isovals(21,'abundance')+isovals(22,'abundance'));
end
if useISO=='y'
    %dilution and water broadening correction and switch to non-scaled
    %units of 12CH4 and 13CH4
    if ~isempty(ISOCH4); CH4ISOdry=(ISOCH4./fastavg((1-H2Owet-CO2wet),10))*isovals(61,'abundance')+fastavg(H2Owet*cal_coeffs(ISOCH4ncal).g_m,10); end
    if ~isempty(ISOC13H4); C13H4dry=(ISOC13H4./fastavg((1-H2Owet-CO2wet),10))*isovals(62,'abundance')+fastavg(H2Owet*cal_coeffs(ISOC13H4ncal).g_m,10); end
    TCH4dry=(CH4dry+interp1(T1Hz_GPS_msec(~isnan(C13H4dry)),C13H4dry(~isnan(C13H4dry)),T10Hz_GPS_msec))/(isovals(61,'abundance')+isovals(62,'abundance'));
else
    TCH4dry=CH4dry/isovals(61,'abundance');
end
if useCO2=='y'
    d13CO2=1000*(C13O2dry./CO2dry/0.0112372-1);
end
if useISO=='y'
    d13CH4=1000*(C13H4dry./CH4ISOdry/0.0112372-1);
end
clear MM CO2 ISO I sspnum
save(['F' date '.L2b.mat'])





