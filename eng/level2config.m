%configuration file for level2datacreate
regions={'R1','R2','R3'}; % List of regions to load
suffix={'3p3e'}; % List of suffix to load, usally just one but could be more. 
OFILE='ISO131108.2.L2a.mat'; % Output file name
linen=[1,2]; % List of lines to load. Line numbers are same as in mixlines
remove_OA='y'; % remove data if there is overflow. So far just for ISO
chilimit=1e-5; % remove data with chi-squared over limit. Use 1 if you don't want any data removed. 
