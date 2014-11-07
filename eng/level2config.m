%configuration file for level2datacreate
regions={'R1','R2','R3','R4'}; % List of regions to load
calregions={'C1','C2'}; % List of calibration regions to use
tanknum='Tank3'; % Which tank was used in thecalibration
suffix={'1p4e'}; % List of suffix to load, usally just one but could be more. 
OFILE='ISO130828.3.L2a.mat'; % Output file name
linen=[1,2]; % List of lines to load. Line numbers are same as in mixlines
remove_OA='y'; % remove data if there is overflow. So far just for ISO
chilimit=1e-5; % remove data with chi-squared over limit. Use 1 if you don't want any data removed. 
