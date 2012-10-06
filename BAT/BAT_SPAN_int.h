#ifndef BAT_SPAN_INT_H_INCLUDED
#define BAT_SPAN_INT_H_INCLUDED

#include "BAT_SPAN.h"

#ifdef __cplusplus

#include "SerSelector.h"

/** This struct definition is not quite right because the
 * data ordering is BigEndian, so each multibyte field needs
 * byte-swapping before use.
 */
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

extern unsigned long ulong_unpack(unsigned char *s);
extern long long_unpack(unsigned char *s);
extern unsigned short ushort_swap(unsigned char *s);
extern unsigned short ushort_unpack(unsigned char *s);
extern double double_unpack(unsigned char *s);

class BSDataRecord;

class BAT : public Ser_Sel {
  public:
    BAT( const char *path, BSDataRecord *data_in );
    int ProcessData(int flag);
    static const int nb_rec = 35;
  private:
    BSDataRecord *BSData;
};

class SPAN : public Ser_Sel {
  public:
    SPAN( const char *path, BSDataRecord *data_in );
    int ProcessData(int flag);
    static const int nb_rec = 104;
  private:
    static const unsigned long CRC32_POLYNOMIAL = 0xEDB88320;
    unsigned long CRC32Value(int i);
    unsigned long CalculateBlockCRC32( unsigned long ulCount,
        unsigned char *ucBuffer );
    BSDataRecord *BSData;
};

class BScmd : public Ser_Sel {
  public:
    BScmd( BSDataRecord *data_in );
    int ProcessData(int flag);
  private:
    BSDataRecord *BSData;
};

class BSTM : public TM_Selectee {
  public:
    BSTM(BAT_SPAN_t *tmdata_in);
    int ProcessData(int flag);
  private:
    BAT_SPAN_t *BAT_SPAN;
};

class BSlogger : public Selectee {
  public:
    BSlogger();
    ~BSlogger();
    int ProcessData(int flag);
    void BAT_data(unsigned char *data); // could be more precise
    void SPAN_data(unsigned char *data); // could be more precise
    void Flush_data();
  private:
    static const unsigned int n_records = 100;
    static const unsigned int rec_size = SPAN::nb_rec + BAT::nb_rec;
    unsigned char BSq[n_records][rec_size];
    unsigned head, tail, offset;
    unsigned long overflow;
};

class BSDataRecord {
  public:
    BSDataRecord();
    ~BSDataRecord();
    void init(Selector &S);
    void BAT_data(unsigned char *data); // could be more precise
    void SPAN_data(unsigned char *data); // could be more precise
    void Flush_data();
    void Logging(bool on);
  private:
    BAT_SPAN_t BAT_SPAN;
    SPAN *SPANport;
    BAT *BATport;
    BScmd *BScmdport;
    BSTM *BSTMport;
    BSlogger *BSloggerport;
    bool LogEnbl;
};

#endif

#endif
