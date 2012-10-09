#ifndef BAT_SPAN_H_INCLUDED
#define BAT_SPAN_H_INCLUDED
// Defines structure of shared data

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
  short BAT_Px; // 0
  short BAT_Py; // 1
  short BAT_Pz; // 2
  short BAT_Ps; // 3
  short BAT_Ax; // 4
  short BAT_Ay; // 5
  short BAT_Az; // 6
  short BAT_FUST; // 8
  short BAT_Tbar; // 10
  short BAT_Pump; // 12
  short BAT_Axb; // 13
  short BAT_Ayb; // 14
  short BAT_Azb; // 15
  unsigned char INS_Status;
  unsigned char n_span_records;
  unsigned char n_bat_records;
  unsigned short max_span_nc;
} BAT_SPAN_t;

#endif
