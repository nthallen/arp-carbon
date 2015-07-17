%Various Calibration Coefficients for Carbon Instrument
%Please note date of updates

%ISO lines
cal_coeffs(1)=struct('line',1294.3792,'s_m',1.185491,'s_b',1.4023e-8,'g_m',5.898e-7); %CH4 Based on 141008.1 and 150323.3
cal_coeffs(2)=struct('line',1294.1964,'s_m',1.142617,'s_b',9.86e-10,'g_m',4.9893e-6); %13CH4 Based on 141008.1 and 150323.3

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

t_inlet.A.CO2=1.2; 
t_inlet.A.MINI=0.6;
t_inlet.A.ISO=2;
t_inlet.B.CO2=1.2; 
t_inlet.B.MINI=0.6;
t_inlet.B.ISO=2;
