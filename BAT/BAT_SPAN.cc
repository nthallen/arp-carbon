#include <errno.h>
#include "BAT_SPAN_int.h"
#include "nortlib.h"
#include "oui.h"

const char *bat_path = "/dev/ser4";
const char *span_path = "/dev/ser3";

BSDataRecord::BSDataRecord() {
  SPANport = 0;
  BATport = 0;
  BScmdport = 0;
  BSTMport = 0;
  BSloggerport = 0;
  LogEnbl = false;
};

void BSDataRecord::init(Selector &S) {
  SPANport = new SPAN(span_path, this);
  BATport = new BAT(bat_path, this);
  BScmdport = new BScmd(this);
  BSTMport = new BSTM(this);
  BSloggerport = new BSlogger();
  S.add_child(&SPANport);
  S.add_child(&BATport);
  S.add_child(&BScmdport);
  S.add_child(&BSTMport);
  S.add_child(&BSloggerport);
  LogEnbl = true;
}

bool BSDataRecord::Get_TM_Data(BAT_SPAN &bs) {
  return false;
}

void BSDataRecord::BAT_data(unsigned char *data) {
  if (LogEnbl) BSloggerport->BAT_data(data);
}


void BSDataRecord::SPAN_data(unsigned char *data) {
  if (LogEnbl) BSloggerport->SPAN_data(data);
}


void BSDataRecord::Flush_data() {
  if (LogEnbl) BSloggerport->Flush_data();
}


void BSDataRecord::Logging(bool on) {
  LogEnbl = on;
  if (!LogEnbl) BSloggerport->Flush_data();
}



int main(int argc, char **argv) {
  oui_init_options(argc, argv);
  
  { Selector S;
    BSDataRecord BSData;
    BSData.init(S);
    nl_error(0, "Driver Starting");
    S.event_loop();
  }
  nl_error( 0, "Terminating" );
}
