/* Inverter.cc */
#include <termios.h>
#include "Inverter.h"
#include "nl_assert.h"
#include "oui.h"

const char *inverter_port = "/dev/ser1";

InvRequest::InvRequest(const char *cmd, unsigned char *res) {
  cmdtxt = cmd;
  result = res;
  cmdlen = strlen(cmdtxt);
}

InvTM::InvTM() : TM_Selectee() {
  TMdata = 0;
}

void InvTM::init(Inverter_t *data) {
  TM_Selectee::init("Inverter", data, sizeof(Inverter_t));
  TMdata = data;
  TMdata->Status &= ~(INV_STAT_FRESH|INV_STAT_SYNERR);
}

InvTM::~InvTM() {}

int InvTM::ProcessData(int flag) {
  int rv = TM_Selectee::ProcessData(flag);
  TMdata->Status &= ~INV_STAT_FRESH;
  return rv;
}

Cmd_Sel::Cmd_Sel() : Cmd_Selectee("cmd/Inverter", 20) {
  top = 0;
  Cmds.push_back(InvRequest("POWER 0\r\n", 0));
  Cmds.push_back(InvRequest("POWER 2\r\n", 0));
}

Cmd_Sel::~Cmd_Sel() {}

int Cmd_Sel::ProcessData(int flag) {
  nl_assert(top != 0);
  if (flag == Selector::Sel_Read) {
    cp = 0;
    if (fillbuf()) return 1;
    switch (buf[cp]) {
      case 'P':
        switch (buf[++cp]) {
          case '0': top->InverterPower(&Cmds[0]); break;
          case '1': top->InverterPower(&Cmds[1]); break;
          default: report_err("Invalid Power Option"); break;
        }
        break;
      case 'Q': return 1;
      default: report_err("Invalid Command"); break;
    }
    consume(nc);
  }
  return 0;
}

Inverter::Inverter() : Ser_Sel() {
  TMdata = 0;
  TM_reported = false;
  CmdReq = 0;
  CurReq = 0;
  Req = Reqs.end();
}

Inverter::~Inverter() {}

void Inverter::init(const char *port, Inverter_t *data) {
  struct termios tio;
  TMdata = data;
  Ser_Sel::init(port, O_RDWR | O_NONBLOCK, 50);
  setup( 4800, 8, 'n', 1, 1, 1 );
  tcgetattr(fd, &tio);
  tio.c_cc[VFWD] = '>';
  tcsetattr(fd, TCSANOW, &tio);
  Reqs.push_back(InvRequest("QURY 0\r\n", &TMdata->QURY[0]));
  Reqs.push_back(InvRequest("QURY 1\r\n", &TMdata->QURY[1]));
  Reqs.push_back(InvRequest("QURY 2\r\n", &TMdata->QURY[2]));
  Reqs.push_back(InvRequest("QURY 3\r\n", &TMdata->QURY[3]));
  Reqs.push_back(InvRequest("QURY 4\r\n", &TMdata->QURY[4]));
  Reqs.push_back(InvRequest("QURY 5\r\n", &TMdata->QURY[5]));
  Reqs.push_back(InvRequest("QURY 6\r\n", &TMdata->QURY[6]));
  Reqs.push_back(InvRequest("QURY 7\r\n", &TMdata->QURY[7]));
  Reqs.push_back(InvRequest("POWER 3\r\n", &TMdata->Power));
  Req = Reqs.end();
  flags = Stor->Sel_Read | Stor->gflag(0) | Stor->gflag(1) |
    Stor->Sel_Timeout;
}

void Inverter::InverterPower(InvRequest *cmd) {
  CmdReq = cmd;
}

Timeout *Inverter::GetTimeout() {
  return &TO;
}

int Inverter::ProcessData(int flag) {
  if (flag & Stor->Sel_Read) {
    unsigned char val = 0;
    bool saw_digit = false;
    cp = 0;
    if (fillbuf()) return 1;
    while (cp < nc && isspace(buf[cp])) ++cp;
    if (CurReq == 0) {
      if (cp < nc)
        report_err("Unexpected input:");
      consume(nc);
    } else {
      while (cp < nc && isxdigit(buf[cp])) {
        unsigned char c = tolower(buf[cp]);
        val = val*16 + isdigit(c) ? (c - '0') : (c - 'a' + 10);
        ++cp;
        saw_digit = true;
      }
      while (cp < nc && isspace(buf[cp])) ++cp;
      if (cp < nc) {
        if (buf[cp] == '!') {
          TMdata->Status |= INV_STAT_SYNERR;
          consume(nc);
        } else { 
          if (not_str("=>")) {
            if (cp < nc) consume(nc);
          } else {
            if (CurReq->result)
              *(CurReq->result) = val;
            CurReq = 0;
            consume(nc);
            report_ok();
            next_request();
          }
        }
      }
    }
  }
  if (flag & Stor->gflag(0)) { // TM reported
    TM_reported = true;
    if (CurReq == 0)
      next_request();
  }
  if (flag & Stor->gflag(1)) { // command received
    if (CurReq == 0)
      next_request();
  }
  if (flag & Stor->Sel_Timeout) {
    report_err("Timeout on query: '%s'", ascii_escape(CurReq->cmdtxt));
    CurReq = 0;
    next_request();
  }
  return 0;
}

void Inverter::next_request() {
  if (CurReq == 0) {
    if (CmdReq != 0) {
      CurReq = CmdReq;
      CmdReq = 0;
    } else {
      if (Req == Reqs.end() && TM_reported) {
        Req = Reqs.begin();
        TM_reported = false;
      }
      if (Req == Reqs.end()) {
        TMdata->Status |= INV_STAT_FRESH;
        TO.Clear();
      } else {
        CurReq = &(*Req);
        ++Req;
      }
    }
    if (CurReq != 0) {
      write(fd, CurReq->cmdtxt, CurReq->cmdlen); //### Check?
      TO.Set(0, 100); // 100 msecs
    }
  }
}

InvDriver::InvDriver(const char *serial_port) : Selector() {
  int i;
  for (i = 0; i < 8; ++i) TMdata.QURY[i] = 0;
  TMdata.Status = 0;
  ITM.init(&TMdata);
  ICmd.init(this);
  Inv.init(serial_port, &TMdata);
  add_child(&ITM);
  add_child(&ICmd);
  add_child(&Inv);
}

InvDriver::~InvDriver() {}

void InvDriver::InverterPower(InvRequest *cmd) {
  Inv.InverterPower(cmd);
  set_gflag(1);
}

int main(int argc, char **argv) {
  oui_init_options(argc, argv);
  nl_error(0, "Driver Starting");
  { InvDriver ID(inverter_port);
    ID.event_loop();
  }
  nl_error(0, "Driver Shutting Down");
  return 0;
}
