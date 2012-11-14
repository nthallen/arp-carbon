%INTERFACE <Inverter>
&command
  : Inverter Power &on_off * { if_Inverter.Turf("P%d\n", $3); }
  : Inverter Quit * { if_Inverter.Turf("Q\n"); }
  ;
