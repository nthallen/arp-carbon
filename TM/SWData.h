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
#define SWS_MQCL_SELECT 4
#define SWS_MQCL_START 5
#define SWS_MQCL_STOP 6
#define SWS_MT_START 7
#define SWS_MT_STOP 8
#define SWS_MCALIBRATE 9
#define SWS_MSTART 10
#define SWS_HCISTART 11
#define SWS_CQCL_SELECT 12
#define SWS_CQCL_START 13
#define SWS_CQCL_STOP 14
#define SWS_CT_START 15
#define SWS_CT_STOP 16
#define SWS_CCALIBRATE 17
#define SWS_CSTART 18
#define SWS_TIMEWARP 19

#endif
