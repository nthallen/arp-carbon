%Various Calibration Coefficients for Carbon Instrument
%Please note date of updates
%Calibration coeffs are assumed to based on actual concentrations of
%isotope, not scaled as in HITRAN.

%ISO lines                 
cal_coeffs(1)=struct('line',1294.378648,'s_m',1.0113,'s_b',-3.7024e-8,'g_m',9.1350e-7); %CH4 Based on 141008.1 and 150323.3
cal_coeffs(13)=struct('line',1294.3792,'s_m',1.0113,'s_b',-3.7024e-8,'g_m',9.1350e-7);
cal_coeffs(2)=struct('line',1294.1964,'s_m',1.0250,'s_b',1.2937e-9,'g_m',2.4920e-9); %13CH4 Based on 141008.1 and 150323.3

%MINI lines
cal_coeffs(3)=struct('line',1292.5776,'s_m',1.100,'s_b',3.445e-9,'g_m',0); %CH4
cal_coeffs(4)=struct('line',1292.6104,'s_m',1.01589,'s_b',2.91e-9,'g_m',0); %CH4
cal_coeffs(5)=struct('line',1292.6779,'s_m',0.9878,'s_b',1.343e-8,'g_m',0); %CH4 from 141009.1
cal_coeffs(6)=struct('line',1292.8269,'s_m',1.6924,'s_b',-2.6418e-4,'g_m',0); %H2O from 150323.3
cal_coeffs(7)=struct('line',1293.0898,'s_m',1,'s_b',0,'g_m',0); %N2O

%CO2 lines
cal_coeffs(8)=struct('line',2309.8062,'s_m',1,'s_b',0,'g_m',0); %CO2
cal_coeffs(9)=struct('line',2310.0025,'s_m',1,'s_b',0,'g_m',0); %CO2
cal_coeffs(10)=struct('line',2310.2056,'s_m',1,'s_b',0,'g_m',0); %CO18O
cal_coeffs(11)=struct('line',2310.3472,'s_m',1,'s_b',0,'g_m',4.451e-3); %13CO2 line used by Jason
cal_coeffs(12)=struct('line',2310.6861,'s_m',1,'s_b',0,'g_m',3.638e-4); %CO2 line used by Jason


%Travel time from inlet to cell (units seconds)

t_inlet.A.CO2=0; 
t_inlet.A.MINI=0;
t_inlet.A.ISO=0;
t_inlet.B.CO2=0.85; %based on 150519.2
t_inlet.B.MINI=0.55; %based on 150519.2
t_inlet.B.ISO=1.6; %based on 150519.2