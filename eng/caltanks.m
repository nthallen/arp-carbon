%Values for cal tanks NOAA and secondary standard
% Order of delta values should follow HITRAN order of isotopologues.
% Value should be given in fractional mixing ratio. (i.e. 1.8e-9, not 1.8)
Tank0.Analysis=struct('Cylinder','N2','Org','N2','Date','May, 2012');
Tank0.CH4(1)=struct('molec','Total','value',0,'Sdev',0.3,'unit','ppbv');
Tank0.CH4(2)=struct('molec','D13C','value',0,'Sdev',20,'unit','permil');
Tank0.CH4(3)=struct('molec','DD','value',0,'Sdev',20,'unit','permil');
Tank0.CO2(1)=struct('molec','Total','value',0,'Sdev',0.011,'unit','ppmv');
Tank0.CO2(2)=struct('molec','D13C','value',0,'Sdev',0.002,'unit','permil');
Tank0.CO2(3)=struct('molec','D18O','value',0,'Sdev',0.007,'unit','permil');
Tank0.N2O(1)=struct('molec','Total','value',0,'Sdev',0.10,'unit','ppbv');

Tank1.Analysis=struct('Cylinder','ND47847','Org','NOAA/GMD','Date','May, 2012');
Tank1.CH4(1)=struct('molec','Total','value',1883.996e-9,'Sdev',0.3,'unit','ppbv');
Tank1.CH4(2)=struct('molec','D13C','value',-36.00,'Sdev',.16,'unit','permil');
Tank1.CH4(3)=struct('molec','DD','value',-142.2,'Sdev',.7,'unit','permil');
Tank1.CO2(1)=struct('molec','Total','value',397.261e-6,'Sdev',0.011,'unit','ppmv');
Tank1.CO2(2)=struct('molec','D13C','value',-12.189,'Sdev',0.07,'unit','permil');
Tank1.CO2(3)=struct('molec','D18O','value',-1.197,'Sdev',0.007,'unit','permil');
Tank1.N2O(1)=struct('molec','Total','value',325.42,'Sdev',0.10,'unit','ppbv');

Tank2.Analysis=struct('Cylinder','CA03687','Org','AirGas/Wofsy','Date','Nov, 2013');
Tank2.CH4(1)=struct('molec','Total','value',1898.5944e-9,'Sdev',0.3,'unit','ppbv');
Tank2.CH4(2)=struct('molec','D13C','value',0,'Sdev',20,'unit','permil');
Tank2.CH4(3)=struct('molec','DD','value',0,'Sdev',NaN,'unit','permil');
Tank2.CO2(1)=struct('molec','Total','value',392.56967e-6,'Sdev',0.043,'unit','ppmv');
Tank2.CO2(2)=struct('molec','D13C','value',0,'Sdev',0.002,'unit','permil');
Tank2.CO2(3)=struct('molec','D18O','value',0,'Sdev',0.007,'unit','permil');
Tank2.N2O(1)=struct('molec','Total','value',NaN,'Sdev',0.10,'unit','ppbv');

Tank3.Analysis=struct('Cylinder','CC130206','Org','AirGas/Wofsy','Date','Nov, 2013');
Tank3.CH4(1)=struct('molec','Total','value',1882.0873e-9,'Sdev',0.38,'unit','ppbv');
Tank3.CH4(2)=struct('molec','D13C','value',0,'Sdev',20,'unit','permil');
Tank3.CH4(3)=struct('molec','DD','value',0,'Sdev',NaN,'unit','permil');
Tank3.CO2(1)=struct('molec','Total','value',398.29126e-6,'Sdev',0.05,'unit','ppmv');
Tank3.CO2(2)=struct('molec','D13C','value',0,'Sdev',0.002,'unit','permil');
Tank3.CO2(3)=struct('molec','D18O','value',0,'Sdev',0.007,'unit','permil');
Tank3.N2O(1)=struct('molec','Total','value',.3e-6,'Sdev',0.10,'unit','ppbv');
Tank3.N2O(2)=struct('molec','D15N','value',0,'Sdev',0.10,'unit','ppbv');
Tank3.N2O(3)=struct('molec','D18O','value',0,'Sdev',0.10,'unit','ppbv');

Tank4.Analysis=struct('Cylinder','CA02295','Org','ToddSower','Date','Jan, 2011');
Tank4.CH4(1)=struct('molec','Total','value',1476e-9,'Sdev',NaN,'unit','ppbv');
Tank4.CH4(2)=struct('molec','D13C','value',-19.6,'Sdev',0.1,'unit','permil');
Tank4.CH4(3)=struct('molec','DD','value',NaN,'Sdev',NaN,'unit','permil');
Tank4.CO2(1)=struct('molec','Total','value',NaN,'Sdev',0.05,'unit','ppmv');
Tank4.CO2(2)=struct('molec','D13C','value',NaN,'Sdev',0.002,'unit','permil');
Tank4.CO2(3)=struct('molec','D18O','value',NaN,'Sdev',0.007,'unit','permil');
Tank4.N2O(1)=struct('molec','Total','value',NaN,'Sdev',0.10,'unit','ppbv');

Tank5.Analysis=struct('Cylinder','CA04826','Org','ToddSower','Date','Jan, 2011');
Tank5.CH4(1)=struct('molec','Total','value',1718e-9,'Sdev',NaN,'unit','ppbv');
Tank5.CH4(2)=struct('molec','D13C','value',-47.13,'Sdev',0.01,'unit','permil');
Tank5.CH4(3)=struct('molec','DD','value',-84.3,'Sdev',1.6,'unit','permil');
Tank5.CO2(1)=struct('molec','Total','value',NaN,'Sdev',0.05,'unit','ppmv');
Tank5.CO2(2)=struct('molec','D13C','value',NaN,'Sdev',0.002,'unit','permil');
Tank5.CO2(3)=struct('molec','D18O','value',NaN,'Sdev',0.007,'unit','permil');
Tank5.N2O(1)=struct('molec','Total','value',NaN,'Sdev',0.10,'unit','ppbv');

Tank6.Analysis=struct('Cylinder','CC212760','Org','AirGas/Wofsy','Date','Jul, 2014');
Tank6.CH4(1)=struct('molec','Total','value',2539.083e-9,'Sdev',0.5,'unit','ppbv');
Tank6.CH4(2)=struct('molec','D13C','value',-35.87,'Sdev',.16,'unit','permil');
Tank6.CH4(3)=struct('molec','DD','value',-187.1,'Sdev',.7,'unit','permil');
Tank6.CO2(1)=struct('molec','Total','value',424.19989e-6,'Sdev',0.044,'unit','ppmv');
Tank6.CO2(2)=struct('molec','D13C','value',-26.20,'Sdev',0.07,'unit','permil');
Tank6.CO2(3)=struct('molec','D18O','value',0,'Sdev',0.007,'unit','permil');
Tank6.N2O(1)=struct('molec','Total','value',NaN,'Sdev',0.10,'unit','ppbv');

Tank7.Analysis=struct('Cylinder','CC427487','Org','AirGas/Wofsy','Date','Jul, 2014');
Tank7.CH4(1)=struct('molec','Total','value',1610.9431e-9,'Sdev',0.3,'unit','ppbv');
Tank7.CH4(2)=struct('molec','D13C','value',-35.66,'Sdev',.16,'unit','permil');
Tank7.CH4(3)=struct('molec','DD','value',-199.8,'Sdev',.7,'unit','permil');
Tank7.CO2(1)=struct('molec','Total','value',372.09839e-6,'Sdev',0.046,'unit','ppmv');
Tank7.CO2(2)=struct('molec','D13C','value',-26.29,'Sdev',0.07,'unit','permil');
Tank7.CO2(3)=struct('molec','D18O','value',0,'Sdev',0.007,'unit','permil');
Tank7.N2O(1)=struct('molec','Total','value',NaN,'Sdev',0.10,'unit','ppbv');