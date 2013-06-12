%INTERFACE <dccc:dccc>
&command
  : &dccc_off_on &off_on * { if_dccc.Turf("D%d\n", $1 * 2 + $2); }
  : &dccc_cl_op &cl_op * { if_dccc.Turf("D%d\n", $1 * 2 + $2); }
  : &dccc_op_cl &op_cl * { if_dccc.Turf("D%d\n", $1 * 2 + $2); }
  : &dccc_on_off &on_off * { if_dccc.Turf("D%d\n", $1 * 2 + $2); }
  : &dccc_set &on_off * { if_dccc.Turf("S%d=%d\n", $1, $2); }
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
&on_off <int>
  : Off { $0 = 0; }
  : On { $0 = 1; }
  ;
&dccc_off_on <int>
  : BAT Power { $0 = 12; }
  : CO2 Cell Htr Ctl { $0 = 27; }
  : CO2 LPV Htr Ctl { $0 = 26; }
  : CO2 QCLI Reset { $0 = 25; }
  : CO2 Scroll Pump { $0 = 1; }
  : CO2 Laser TEC { $0 = 28; }
  : ISO Cell Htr Ctl { $0 = 3; }
  : ISO DPV Htr Ctl { $0 = 4; }
  : ISO LPV Ext TEC { $0 = 5; }
  : ISO QCLI Reset { $0 = 32; }
  : ISO Scroll Pump { $0 = 2; }
  : ISO Laser TEC { $0 = 6; }
  : Coolant Pump { $0 = 7; }
  : Inverter Arm { $0 = 8; }
  : Circuit3 { $0 = 12; }
  : MINI Cell Htr Ctl { $0 = 42; }
  : MINI DPV Htr Ctl { $0 = 43; }
  : MINI LPV Ext TEC { $0 = 45; }
  : MINI QCLI Reset { $0 = 41; }
  : MINI Scroll Pump { $0 = 0; }
  : MINI Laser TEC { $0 = 44; }
  : HK Sample Htr Ctl { $0 = 37; }
  : HK Space Htr Ctl { $0 = 38; }
  : Gas Deck Flow Controller Closed { $0 = 40; }
# : Gas Deck Flow Controller Open { $0 = 39; }
  ;
&dccc_cl_op <int>
  : CO2 Exhaust Valve { $0 = 31; }
  : CO2 Gas Valve { $0 = 30; }
  : ISO Exhaust Valve { $0 = 36; }
  : ISO Gas Valve { $0 = 35; }
  : MINI Exhaust Valve { $0 = 24; }
  : MINI Gas Valve { $0 = 47; }
  ;
&dccc_op_cl <int>
  : Gas Deck Valve { $0 = 33; }
  ;
&dccc_on_off <int>
  : CO2 Pressure Reg { $0 = 29; }
  : MINI Pressure Reg { $0 = 46; }
  : ISO Pressure Reg { $0 = 34; }
  ;
&dccc_set <int>
  : Coolant Divert { $0 = 100; }
  : BAT Purge { $0 = 101; }
  ;

