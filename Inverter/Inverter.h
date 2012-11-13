#ifndef INVERTER_H_INCLUDED
#define INVERTER_H_INCLUDED

typedef struct __attribute__((__packed__)) {
  unsigned char QURY[8];
  unsigned char Status;
} Inverter_t;

/* Inverter Status Bits:
   0: Power On
   1: Fresh Data
*/
#define INV_STAT_POWER 1
#define INV_STAT_FRESH 2

extern const char *inverter_port;

#ifdef __cplusplus

#include <vector>
#include "SerSelector.h"

Class InvTM public TM_Selectee {
  public:
    InvTM();
    ~InvTM();
    void init(Inverter_t *data);
    int ProcessData(int flag);
  private:
    Inverter_t *TMdata;
};

Class InvRequest {
  public:
    InvRequest(const char *cmd, unsigned char *res);
    const char *cmdtxt;
    int cmdlen;
    unsigned char *result;
  private:
};

Class Cmd_Sel : public Cmd_Selectee {
  public:
    Cmd_Sel();
    ~Cmd_Sel();
    inline void init(InvDriver *top_in) { top = top_in; }
    int Process_Data(int flag);
  private:
    InvDriver *top;
    std::vector<InvRequest> Cmds;
    unsigned char PwrStat;
};

Class Inverter public Ser_Sel {
  public:
    Inverter();
    ~Inverter();
    void init(const char *port, Inverter_t *data);
    void InverterPower(InvRequest *cmd);
    int ProcessData(int flag);
  private:
    void next_request();
    Inverter_t *TMdata;
    bool TM_reported;
    InvRequest *CmdReq; // Command stored here when queued
    InvRequest *CurReq; // Then moved here...
    std::vector<InvRequest> Reqs;
    std::vector<InvRequest>::const_iterator Req;
};

Class InvDriver public Selector {
  public:
    InvDriver(const char *serial_port);
    ~InvDriver();
    void InverterPower(InvRequest *cmd);
  private:
    Inverter_t TMdata;
    InvTM ITM;
    Cmd_Sel ICmd;
    Inverter Inv;
};

#endif
#endif
