%INTERFACE <BAT_SPAN>
&command
  : BAT_SPAN &BAT_cmd * { if_BAT_SPAN.Turf("%s\n", $2); }
  ;
&BAT_cmd <const char *>
  : Logging Suspend { $0 = "N"; }
  : Logging Resume { $0 = "L"; }
  : Quit { $0 = "Q"; }
  ;

