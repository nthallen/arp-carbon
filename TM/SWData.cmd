%{
  #include "SWData.h"
  #ifdef SERVER
    SWData_t SWData;
  #endif
%}

%INTERFACE <SWData:DG/data>

&command
  : &SWTM * { if_SWData.Turf(); }
  ;
&SWTM
  : SWStat &SWStat { SWData.SWStat = $2; }
  ;
&SWStat <unsigned char>
  : Shutdown { $0 = SWS_SHUTDOWN; }
  : Set %d { $0 = $2; }
  : Flight Take Data { $0 = SWS_TAKE_DATA; }
  : Flight Land { $0 = SWS_LAND; }
  : MINI Laser Select ICOS and Run { $0 = SWS_MQCL_SELICOS; }
  : MINI Laser Select Ring and Run { $0 = SWS_MQCL_SELRING; }
  : MINI Laser Start { $0 = SWS_MQCL_START; }
  : MINI Laser Stop { $0 = SWS_MQCL_STOP; }
  : MINI Laser Disable { $0 = SWS_MQCL_DISABLE; }
  : MINI Temperature Ctrl Start { $0 = SWS_MT_START; }
  : MINI Temperature Ctrl Stop { $0 = SWS_MT_STOP; }
  : MINI Calibrate { $0 = SWS_MCALIBRATE; }
  : MINI Start { $0 = SWS_MSTART; }
  : HCI Start { $0 = SWS_SMPLHTRWTCH; }
  : CO2 Laser Select ICOS and Run { $0 = SWS_CQCL_SELECT; }
  : CO2 Laser Start { $0 = SWS_CQCL_START; }
  : CO2 Laser Stop { $0 = SWS_CQCL_STOP; }
  : CO2 Laser Disable { $0 = SWS_CQCL_DISABLE; }
  : CO2 Temperature Ctrl Start { $0 = SWS_CT_START; }
  : CO2 Temperature Ctrl Stop { $0 = SWS_CT_STOP; }
  : CO2 Calibrate { $0 = SWS_CCALIBRATE; }
  : CO2 Start { $0 = SWS_CSTART; }
  : Time Warp { $0 = SWS_TIMEWARP; }
  : Pump Start { $0 = SWS_PUMP_START; }
  : Pump Cool Start { $0 = SWS_COOL_START; }
  : Read File { $0 = SWS_READ_FILE; }
  : MINI Laser Idle { $0 = SWS_MQCL_IDLE; }
  : CO2 Laser Idle { $0 = SWS_CQCL_IDLE; }
  : MINI Laser TEC Ramp { $0 = SWS_MQCL_RAMP; }
  : MINI Fill Cell { $0 = SWS_FILLMINI; }
  : CO2 Fill Cell { $0 = SWS_FILLCO2; }
  : CO2 Laser TEC Ramp { $0 = SWS_CQCL_RAMP; }
  : Ground Power On { $0 = SWS_GROUND_PWR; }
  : Ground Power Off { $0 = SWS_AIRCRAFT_PWR; }
  : Shortcircuit Shutdown { $0 = SWS_SHORTSHUT; }
  : ISO Laser Select ICOS and Run { $0 = SWS_IQCL_SELICOS; }
  : ISO Laser Select Ring and Run { $0 = SWS_IQCL_SELRING; }
  : ISO Laser Start { $0 = SWS_IQCL_START; }
  : ISO Laser Stop { $0 = SWS_IQCL_STOP; }
  : ISO Laser Disable { $0 = SWS_IQCL_DISABLE; }
  : ISO Temperature Ctrl Start { $0 = SWS_IT_START; }
  : ISO Temperature Ctrl Stop { $0 = SWS_IT_STOP; }
  : ISO Calibrate { $0 = SWS_ICALIBRATE; }
  : ISO Start { $0 = SWS_ISTART; }
  ;
