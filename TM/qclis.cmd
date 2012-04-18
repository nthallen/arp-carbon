%INTERFACE <SSP_C>
%INTERFACE <SSP_M>
%INTERFACE <SSP_I>
%INTERFACE <QCLI_C>
%INTERFACE <QCLI_M>
%INTERFACE <QCLI_I>

%{

#ifdef SERVER
  #include "hsatod.h"
  #define QCLI_ICOS \
      (HSAD_OPT_A|HSAD_OPT_B|HSAD_OPT_C|HSAD_TRIG_3|HSAD_TRIG_RISING)
  #define QCLI_C_ICOS QCLI_ICOS
  #define QCLI_M_ICOS QCLI_ICOS
  #define QCLI_I_ICOS QCLI_ICOS
  hsatod_setup_t SSP_C_setup;
  hsatod_setup_t SSP_M_setup;
  hsatod_setup_t SSP_I_setup;

  static struct sspqcli_s {
    hsatod_setup_t *setup;
    cmdif_rd *if_ssp;
  } sspqcli_bd[3] = {
    { &SSP_C_setup, &if_SSP_C },
    { &SSP_M_setup, &if_SSP_M },
    { &SSP_I_setup, &if_SSP_I },
  };

#endif

%}
# &SSP returns an index into sspqcli_bd[]
&SSP <int>
  : SSP_C { $0 = 0; }
  : SSP_M { $0 = 1; }
  : SSP_I { $0 = 2; }
  ;
# &QCLI returns an inteface
&QCLI <cmdif_rd *>
  : QCLI_C { $0 = &if_QCLI_C; }
  : QCLI_M { $0 = &if_QCLI_M; }
  : QCLI_I { $0 = &if_QCLI_I; }
  ;
&command
  : Select QCLI_C Waveform &QCLI_C_Wave * {
      *sspqcli_bd[0].setup = QCLI_C_Waves[$4];
      if_QCLI_C.Turf( "SW:%d\n", $4 );
    }
  : Select QCLI_M Waveform &QCLI_M_Wave * {
      *sspqcli_bd[1].setup = QCLI_M_Waves[$4];
      if_QCLI_M.Turf( "SW:%d\n", $4 );
    }
  : Select QCLI_I Waveform &QCLI_I_Wave * {
      *sspqcli_bd[2].setup = QCLI_I_Waves[$4];
      if_QCLI_I.Turf( "SW:%d\n", $4 );
    }
  ;
