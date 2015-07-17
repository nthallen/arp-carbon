%configuration file for level2datacreate
Inst='MM'; %Instrument
FConfig='B'; %Plumbing configuration
if strcmp(Inst,'CO2')
    regions={'CO2130828.3.mat'};
elseif strcmp(Inst,'MM')
    regions={'R1','R2'}; % List of regions to load
    calregions={'C1','C2'}; % List of calibration regions to use
    suffix={'1pPTEF'}; % List of suffix to load, usally just one but could be more. 
end
tanknum='Tank3'; % Which tank was used in thecalibration
OFILE='MM130828.4.L2a.mat'; % Output file name
linen=[3,4]; % List of lines to load. Line numbers are same as in mixlines
remove_OA='n'; % remove data if there is overflow. So far just for ISO
chilimit=1; % remove data with chi-squared over limit. Use 1 if you don't want any data removed. 
