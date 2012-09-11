%INTERFACE <dccc:dccc>
&command
  : &dccc_off_on &off_on * { if_dccc.Turf("D%d\n", $1 * 2 + $2); }
  : &dccc_cl_op &cl_op * { if_dccc.Turf("D%d\n", $1 * 2 + $2); }
  : &dccc_op_cl &op_cl * { if_dccc.Turf("D%d\n", $1 * 2 + $2); }
  ;
&off_on <int>
  : Off { $0 = 1; }
  : On { $0 = 0; }
  ;
&cl_op <int>
  : Closed { $0 = 1; }
  : Open { $0 = 0; }
  ;
&op_cl <int>
  : Closed { $0 = 0; }
  : Open { $0 = 1; }
  ;
&dccc_off_on <int>
  : CO2 Cell Htr Ctl { $0 = 27; }
  : CO2 Laser PV Htr Ctl { $0 = 26; }
  : CO2 QCLI Reset { $0 = 25; }
  : CO2 Scroll Pump { $0 = 1; }
  : CO2 Laser TEC { $0 = 28; }
  : ISO Cell Htr Ctl { $0 = 3; }
  : ISO Detector PV Htr Ctl { $0 = 4; }
  : ISO LPV Ext TEC { $0 = 5; }
  : ISO QCLI Reset { $0 = 32; }
  : ISO Scroll Pump { $0 = 2; }
  : ISO Laser TEC { $0 = 6; }
  : Lab Command 1 { $0 = 7; }
  : Lab Command 2 { $0 = 8; }
  : MINI Cell Htr Ctl { $0 = 42; }
  : MINI Detector PV Htr Ctl { $0 = 43; }
  : MINI LPV TEC { $0 = 45; }
  : MINI QCLI Reset { $0 = 41; }
  : MINI Scroll Pump { $0 = 0; }
  : MINI Laser TEC { $0 = 44; }
  : Sample Htr Ctl { $0 = 37; }
  : Space Heater Controller { $0 = 38; }
  : Gas Deck Flow Controller Closed { $0 = 40; }
  : Gas Deck Flow Controller Open { $0 = 39; }
  : Gas Deck Valve Closed { $0 = 33; }
  ;
&dccc_cl_op <int>
  : CO2 Exhaust Valve { $0 = 31; }
  : CO2 Gas Valve { $0 = 30; }
  : CO2 Pressure Reg { $0 = 29; }
  : ISO Exhaust Valve { $0 = 36; }
  : ISO Gas Valve { $0 = 35; }
  : MINI Exhaust Valve { $0 = 24; }
  : MINI Gas Valve { $0 = 47; }
  ;
&dccc_op_cl <int>
  : CO2 Pressure Reg { $0 = 29; }
  : MINI Pressure Reg { $0 = 46; }
  : ISO Pressure Reg { $0 = 34; }
  ;
