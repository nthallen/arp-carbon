%Various Calibration Coefficients for Carbon Instrument
%Please note date of updates

%ISO lines
cal_coeffs(1)=struct('line',1294.3792,'s_m',1,'s_b',0,'g_m',1); %CH4
cal_coeffs(2)=struct('line',1294.1964,'s_m',1,'s_b',0,'g_m',1); %13CH4

%MINI lines
cal_coeffs(3)=struct('line',1292.6779,'s_m',1,'s_b',0,'g_m',1); %CH4
cal_coeffs(4)=struct('line',1292.8269,'s_m',1,'s_b',0,'g_m',1); %H2O
cal_coeffs(5)=struct('line',1293.0898,'s_m',1,'s_b',0,'g_m',1); %N2O

%CO2 lines
cal_coeffs(6)=struct('line',2309.8062,'s_m',1,'s_b',0,'g_m',1); %CO2
cal_coeffs(7)=struct('line',2310.0025,'s_m',1,'s_b',0,'g_m',1); %CO2
cal_coeffs(8)=struct('line',2310.2056,'s_m',1,'s_b',0,'g_m',1); %CO18O
cal_coeffs(9)=struct('line',2310.3470,'s_m',1,'s_b',0,'g_m',1); %13CO2

%Travel time from inlet to cell (units seconds)

t_inlet.CO2=1.2; 
t_inlet.MINI=0.6;
t_inlet.ISO=2;
