#ifndef BAT_SPAN_INT_H_INCLUDED
#define BAT_SPAN_INT_H_INCLUDED

#include "BAT_SPAN.h"

#ifdef __cplusplus

#include "SerSelector.h"

struct  __attribute__((__packed__)) INSPVASB {
  unsigned char synch[3];
  unsigned char msg_len;
  unsigned short msg_id;
  unsigned short GPS_week;
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
  long INS_Status;
  unsigned long CRC;
};

class BSDataRecord;

class BAT : public Ser_Sel {
  public:
    BAT( const char *path, BSDataRecord *data_in );
    int ProcessData(int flag);
  private:
    BSDataRecord *BSData;
};

class SPAN : public Ser_Sel {
  public:
    SPAN( const char *path, BSDataRecord *data_in );
    int ProcessData(int flag);
  private:
    BSDataRecord *BSData;
};

class BScmd : public Ser_Sel {
  public:
    BScmd( BSDataRecord *data_in );
    int ProcessData(int flag);
  private:
    BSDataRecord *BSData;
};

class BSTM : public Selectee {
  public:
    BSTM(BSDataRecord *data_in);
    int ProcessData(int flag);
    void Data_Ready();
  private:
    BSDataRecord *BSData;
};

class BSlogger : public Selectee {
  public:
    BSlogger();
    int ProcessData(int flag);
    void BAT_data(unsigned char *data); // could be more precise
    void SPAN_data(unsigned char *data); // could be more precise
    void Flush_data();
  private;
    void WriteRecords(...);
    circular buffer for several seconds of data
};

class BSDataRecord {
  public:
    BSDataRecord();
    void init(Selector &S);
    bool Get_TM_Data(BAT_SPAN &bs);
    void BAT_data(unsigned char *data); // could be more precise
    void SPAN_data(unsigned char *data); // could be more precise
    void Flush_data();
    void Logging(bool on);
  private:
    SPAN *SPANport;
    BAT *BATport;
    BScmd *BScmdport;
    BSTM *BSTMport;
    BSlogger *BSloggerport;
    bool LogEnbl;
};

#endif

#endif
