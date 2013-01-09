/* Altimeter.cc */
#include "Altimeter.h"
#include "oui.h"
#include "nortlib.h"

const char *MRA_port = "/dev/ser1";

MRA_Serial::MRA_Serial() : Ser_Sel() {
  unsigned char i;
  for (i = 0; i < 128; ++i) {
    reverse[i] = reverse(i);
  }
}

MRA_Serial::~MRA_Serial() {}

MRA_Serial::init(const char *port, unsigned short *MRA_Alt) {
  init(port, O_RDONLY | O_NONBLOCK, 15);
  MRA_Altitude = MRA_Alt;
  *MRA_Altitude = 0xC000;
  setup(9600, 8, 'n', 1, 3, 0);
  if (tcgetattr(fd, &termios_m)) {
    nl_error(2, "Error from tcgetattr: %s", strerror(errno));
  }
  flush_input();
  flags |= Selector::gflag(0);
}

/**
 * MRA_Altitude is a 14-bit number representing altitude in 2 cm steps
 * I will use the top two bits to encode status data:
 *  Bit 14: Invalid data
 *  Bit 15: Stale data
 */
int MRA_Serial::ProcessData(flag) {
  if (flag & Selector::gflag(0)) {
    *MRA_Altitude |= 0x8000;
  }
  if (flag & Selector::Sel_Read) {
    unsigned short value = 0;
    unsigned min;
    if (fillbuf()) return 1;
    if (nc >= 3) {
      for (cp = nc; cp >= 3; --cp) {
        if (buf[cp-3]&1) {
          // evaluated record
          switch (buf[cp-3]) {
            case 1: break;
            default:
              report_err("Invalid header byte");
            case 0xFF:
              value = 0x4000;
              break;
          }
          if ((buf[cp-2]&1) || (buf[cp-1]&1)) {
            report_err("Invalid data byte");
            value = 0x4000;
          }
          value += (reverse[buf[cp-2]>>1] << 7) + reverse[buf[cp-1]>>1];
          *MRA_Altitude = value;
          consume(cp);
          break;
        }
      }
    }
    for (cp = 0; cp < nc && !(buf[cp]&1); ++cp);
    consume(cp);
    min = nb_rec - nc;
    if (min != termios_m.c_cc[VMIN]) {
      termios_m.c_cc[VMIN] = min;
      if (tcsetattr(fd, TCSANOW, &termios_m)) {
        nl_error(2, "Error from tcsetattr: %s", strerror(errno));
      }
    }
  }
  return 0;
}

MRA_Driver::MRA_Driver(const char *MRA_port) {
  MRA_TM.init("MRA_Altitude", &MRA_Altitude, sizeof(MRA_Altitude));
  MRA.init(MRA_port, &MRA_Altitude);
}

MRA_Driver::~MRA_Driver() {}

int main(int argc, char **argv) {
  out_init_options(argc, argv);
  nl_error(0, "Driver Starting Up");
  { MRA_Driver Drv(MRA_port);
    Drv.event_loop();
  }
  nl_error(0, "Driver Shutting Down");
}
