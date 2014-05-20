/* SWData.h */
#ifndef SWDATA_H_INCLUDED
#define SWDATA_H_INCLUDED

typedef struct __attribute__((__packed__)) {
  unsigned char SWStat;
} SWData_t;
extern SWData_t SWData;

#define SWS_SHUTDOWN 1
#define SWS_TAKE_DATA 2
#define SWS_LAND 3
#define SWS_MQCL_SELICOS 4
#define SWS_MQCL_SELRING 31
#define SWS_MQCL_START 5
#define SWS_MQCL_STOP 6
#define SWS_MQCL_DISABLE 23
#define SWS_MT_START 7
#define SWS_MT_STOP 8
#define SWS_MCALIBRATE 9
#define SWS_MSTART 10
#define SWS_SMPLHTRWTCH 11
#define SWS_CQCL_SELECT 12
#define SWS_CQCL_START 13
#define SWS_CQCL_STOP 14
#define SWS_CQCL_DISABLE 24
#define SWS_CT_START 15
#define SWS_CT_STOP 16
#define SWS_CCALIBRATE 17
#define SWS_CSTART 18
#define SWS_TIMEWARP 19
#define SWS_PUMP_START 20
#define SWS_COOL_START 21
#define SWS_READ_FILE 22
#define SWS_MQCL_IDLE 25
#define SWS_CQCL_IDLE 26
#define SWS_MQCL_RAMP 27
#define SWS_FILLMINI 28
#define SWS_FILLCO2 29
#define SWS_CQCL_RAMP 30
#define SWS_GROUND_PWR 32
#define SWS_AIRCRAFT_PWR 33
#define SWS_SHORTSHUT 34
#define SWS_IQCL_SELICOS 35
#define SWS_IQCL_SELRING 36
#define SWS_IQCL_START 37
#define SWS_IQCL_STOP 38
#define SWS_IQCL_IDLE 39
#define SWS_IQCL_DISABLE 44
#define SWS_IT_START 40
#define SWS_IT_STOP 41
#define SWS_ICALIBRATE 42
#define SWS_ISTART 43
#define SWS_SPANCHK_IDLE 45
#define SWS_GASDECK_PI 46
#define SWS_GASDECK_CLOSE 47
#define SWS_LAB_CALIBRATE 48

#endif
