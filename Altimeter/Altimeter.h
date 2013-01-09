/* Altimeter.h */
#ifndef ALTIMETER_H_INCLUDED
#define ALTIMETER_H_INCLUDED

extern unsigned short MRA_Altitude;
extern const char *MRA_port;

#ifdef __cplusplus
#include <termios.h>

class MRA_Serial : public Ser_Sel {
  public:
    MRA_Serial();
    ~MRA_Serial();
    void init(const char *port);
    int ProcessData(int flag);
  private:
    unsigned char *MRA_Altitude;
    unsigned char reverse[128];
    unsigned char reverse(unsigned char);
    termios termios_m;
};

class MRA_Driver : public Selector {
  public:
    MRA_Driver(const char *port);
    ~MRA_Driver();
  private:
    unsigned short MRA_Altitude;
    TM_Selectee MRA_TM;
    Cmd_Selectee MRA_Cmd;
    MRA_Serial MRA;
};

#endif
#endif
