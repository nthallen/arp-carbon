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
  : MINI Laser Select Waveform and Run { $0 = SWS_MQCL_SELECT; }
  : MINI Laser Start { $0 = SWS_MQCL_START; }
  : MINI Laser Stop { $0 = SWS_MQCL_STOP; }
  : MINI Temperature Ctrl Start { $0 = SWS_MT_START; }
  : MINI Temperature Ctrl Stop { $0 = SWS_MT_STOP; }
  : MINI Calibrate { $0 = SWS_MCALIBRATE; }
  : MINI Start { $0 = SWS_MSTART; }
  : HCI Start { $0 = SWS_HCISTART; }
  : CO2 Laser Select Waveform and Run { $0 = SWS_CQCL_SELECT; }
  : CO2 Laser Start { $0 = SWS_CQCL_START; }
  : CO2 Laser Stop { $0 = SWS_CQCL_STOP; }
  : CO2 Temperature Ctrl Start { $0 = SWS_CT_START; }
  : CO2 Temperature Ctrl Stop { $0 = SWS_CT_STOP; }
  : CO2 Calibrate { $0 = SWS_CCALIBRATE; }
  : CO2 Start { $0 = SWS_CSTART; }
  ;
