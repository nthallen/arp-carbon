#ifndef BAT_SPAN_H_INCLUDED
#define BAT_SPAN_H_INCLUDED
// Defines structure of shared data
extern const char *bat_path;
extern const char *span_path;

typedef struct __attribute__((__packed__)) {
  long GPS_msecs;
  unsigned long GPS_weekl;
  double GPS_secs;
  double Latitude;
  double Longitude;
  double Ellipsoidal_Ht;
  double N_Velocity;
  double E_Velocity;
  double Up_Velocity;
  double Roll;
  double Pitch;
  double Azimuth;
  unsigned short GPS_week; // here for alignment optimization.
  unsigned short BAT_Px; // 0
  unsigned short BAT_Py; // 1
  unsigned short BAT_Pz; // 2
  unsigned short BAT_Ps; // 3
  unsigned short BAT_Ax; // 4
  unsigned short BAT_Ay; // 5
  unsigned short BAT_Az; // 6
  unsigned short BAT_Tp1; // 7
  unsigned short BAT_Tp2; // 8
  unsigned short BAT_Tbar1; // 9
  unsigned short BAT_Tbar2; // 10
  unsigned short BAT_Net; // 11
  unsigned short BAT_Q1; // 12
  unsigned short BAT_Q2; // 13
  unsigned short BAT_Aux1; // 14
  unsigned short BAT_Aux2; // 15
  unsigned char INS_Status;
  unsigned char n_span_records;
  unsigned char n_bat_records;
} BAT_SPAN;

#endif
