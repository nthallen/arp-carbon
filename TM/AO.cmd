%{
  #ifdef SERVER
    #include "subbus.h"
    #include "address.h"
    
    /* scale is in volts/unit */
    unsigned short ao_scale(double val, double scale, double maxv) {
      double N;
      unsigned short bits;
      if (val > maxv) val = maxv;
      N = val * scale * 6553.6;
      if ( N >= 65535. ) bits = 65535U;
      else if ( N < 0 ) bits = 0;
      else bits = (unsigned short)N;
      return bits;
    }

    void reprogram_dacs() {
      unsigned i;
      for (i = 0; i < 16; ++i) {
        unsigned short addr = 0x420 + 2*i;
        unsigned short value = sbrwa(addr);
        if (!sbwr(addr, value)) {
          nl_error(2, "No acknowledge writing to DAC (0x%04X, 0x%04X)",
            addr, value);
        }
      }
    }
  #endif
%}
&Command
  : &AO_volts %f (Enter 0-10 Volts) * { sbwr( $1, ao_scale($2, 1.0, 10.0) ); }
  : &AO_5volts %f (Enter 0-5 Volts) * { sbwr( $1, ao_scale($2, 1.0, 5.0) ); }
  : &AO_pset %f (Enter 0-100 Torr) * { sbwr( $1, ao_scale($2, 1/30., 130.0) ); }
  : Reprogram CB2 DACs * { reprogram_dacs(); }
  ;
&AO_5volts <unsigned short>
  : Gas Deck Set Gas Flow Setpoint { $0 = GsFlSt_Address; }
  ;
&AO_volts <unsigned short>
  : CO2 Set Cell Temp Setpoint { $0 = CCelTSt_Address; }
  : CO2 Set Laser TEC Temp Setpoint { $0 = CLTETSt_Address; }
  : CO2 Set LPV Temp Setpoint { $0 = CLPVTSt_Address; }
  : HK Set Sample Heater Temp Setpoint { $0 = SHTSt_Address; }
  : HK Set Space Heater Temp Setpoint { $0 = SpHtTSt_Address; }
  : ISO Set Cell Temp Setpoint { $0 = ICelTSt_Address; }
  : ISO Set DPV Temp Setpoint { $0 = IDPVTSt_Address; }
  : ISO Set LPV External TEC Setpoint { $0 = ILPVTSt_Address; }
  : ISO Set Laser TEC Temp Setpoint { $0 = ILTETSt_Address; }
  : MINI Set Cell Temp Setpoint { $0 = MCelTSt_Address; }
  : MINI Set DPV Temp Setpoint { $0 = MDPVTSt_Address; }
  : MINI Set Laser TEC Temp Setpoint { $0 = MLTETSt_Address; }
  : MINI Set LPV External TEC Setpoint { $0 = MLPVTSt_Address; }
  ;
&AO_pset <unsigned short>
  : CO2 Set Cell Pressure Setpoint { $0 = CCelPSt_Address; }
# : ISO Set Cell Pressure Setpoint { $0 = ICelPSt_Address; }
  : MINI Set Cell Pressure Setpoint { $0 = MCelPSt_Address; }
  ;
