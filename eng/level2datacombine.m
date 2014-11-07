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
try
eval(['MM = load(''MM' date '.' ext '.mat'',''T1*'');']);
eval(['MMCH4 = struct2array(load(''MM' date '.' ext '.mat'',''CH4*''));']);
eval(['MMH2O = struct2array(load(''MM' date '.' ext '.mat'',''H2O*''));']);
eval(['MMN2O = struct2array(load(''MM' date '.' ext '.mat'',''N2O*''));']);
catch
    disp(['Warning: File MM' date '.' ext '.mat does not exist. Exiting']);
    return
end
try
eval(['ISO = load(''ISO' date '.' ext '.mat'',''T1*'');']);
eval(['ISOCH4 = struct2array(load(''ISO' date '.' ext '.mat'',''CH4*''));']);
eval(['ISOC13H4 = struct2array(load(''ISO' date '.' ext '.mat'',''C13H4*''));']);
catch
    disp(['Warning: File ISO' date '.' ext '.mat does not exist. Continuing with no ISO data']);
    useISO='n';
end
try
% eval(['CO2 = load(''C' date '.' ext '.mat'',''T1*'');']);
% eval(['CO2CO2 = struct2array(load(''C' date '.' ext '.mat'',''CO2*''));']);
% eval(['CO2C13O2 = struct2array(load(''C' date '.' ext '.mat'',''C13O2*''));']);
% eval(['CO2C18OO = struct2array(load(''C' date '.' ext '.mat'',''C18OO*''));']);
eval(['temp = load(''C' date '.' ext '.mat'');']);
CO2.T10Hz_GPS_msec=temp(:,1);
CO2CO2=temp(:,3);
CO2C13O2=temp(:,4);
catch
    disp(['Warning: File C' date '.' ext '.mat does not exist. Continuing with no CO2 data']);
    useCO2='n';
end

eval(['load(''MM' date '.' ext '.mat'',''T*'',''A*'',''L*'',''Ht'',''run'');']);

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
H2Owet=interp1(T10Hz_ftime(~isnan(MMH2O)),MMH2O(~isnan(MMH2O)),T10Hz_ftime);
if useCO2=='y'
    CO2wet=( interp1(T10Hz_ftime(~isnan(CO2CO2)),CO2CO2(~isnan(CO2CO2)),T10Hz_ftime)*isovals(21,'abundance') + ...
        interp1(T10Hz_ftime(~isnan(CO2C13O2)),CO2C13O2(~isnan(CO2C13O2)),T10Hz_ftime)*isovals(22,'abundance') )/(isovals(21,'abundance')+isovals(22,'abundance'));
else
    CO2wet=ones(size(T10Hz_ftime))*400e-6; %if we don't have CO2 assume mean troposhere. Not very good.
end
H2Odry=MMH2O./(1-H2Owet-CO2wet);
if ~isempty(MMCH4); CH4dry=MMCH4./(1-H2Owet-CO2wet)*isovals(61,'abundance'); end
if ~isempty(MMN2O); N2Odry=MMN2O./(1-H2Owet-CO2wet)*isovals(41,'abundance'); end
if useCO2=='y'
    if ~isempty(CO2CO2); CO2dry=CO2CO2./(1-H2Owet-CO2wet)*isovals(21,'abundance'); end
    if ~isempty(CO2C13O2); C13O2dry=CO2C13O2./(1-H2Owet-CO2wet)*isovals(22,'abundance'); end
    if ~isempty(CO2C18OO); C18OOdry=CO2C18OO./(1-H2Owet-CO2wet)*isovals(23,'abundance'); end
    TCO2dry=(CO2dry+C13O2dry)/(isovals(21,'abundance')+isovals(22,'abundance'));
end
if useISO=='y'
    if ~isempty(ISOCH4); CH4ISOdry=ISOCH4./fastavg((1-H2Owet-CO2wet),10)*isovals(61,'abundance'); end
    if ~isempty(ISOC13H4); C13H4dry=ISOC13H4./fastavg((1-H2Owet-CO2wet),10)*isovals(62,'abundance'); end
    TCH4dry=(CH4dry+interp1(T1Hz_ftime(~isnan(C13H4dry)),C13H4dry(~isnan(C13H4dry)),T10Hz_ftime))/(isovals(61,'abundance')+isovals(62,'abundance'));
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





