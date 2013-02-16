#include <errno.h>
#include <sys/uio.h>
#include <string.h>
#include "BAT_SPAN_int.h"
#include "nortlib.h"
#include "oui.h"

const char *bat_path = "/dev/ser4";
const char *span_path = "/dev/ser3";
const char *mlf_config;

BSDataRecord::BSDataRecord() {
  SPANport = 0;
  BATport = 0;
  BScmdport = 0;
  BSTMport = 0;
  BSloggerport = 0;
  memset(&BAT_SPAN, 0, sizeof(BAT_SPAN));
  LogEnbl = false;
}

BSDataRecord::~BSDataRecord() {
  if (BSloggerport) delete BSloggerport;
  if (BSTMport) delete BSTMport;
  if (BScmdport) delete BScmdport;
  if (SPANport) delete SPANport;
}

void BSDataRecord::init(Selector &S) {
  SPANport = new SPAN(span_path, this);
  BATport = new BAT(bat_path, this);
  BScmdport = new BScmd(this);
  BSTMport = new BSTM(&BAT_SPAN);
  BSloggerport = new BSlogger();
  S.add_child(SPANport);
  S.add_child(BATport);
  S.add_child(BScmdport);
  S.add_child(BSTMport);
  S.add_child(BSloggerport);
  LogEnbl = true;
}

void BSDataRecord::BAT_data(unsigned char *data) {
  if (LogEnbl) BSloggerport->BAT_data(data);
  BAT_SPAN.BAT_Px = ushort_swap(&data[3]) - 32768; // 0
  BAT_SPAN.BAT_Py = ushort_swap(&data[5]) - 32768; // 1
  BAT_SPAN.BAT_Pz = ushort_swap(&data[7]) - 32768; // 2
  BAT_SPAN.BAT_Ps = ushort_swap(&data[9]) - 32768; // 3
  BAT_SPAN.BAT_Ax = ushort_swap(&data[11]) - 32768; // 4
  BAT_SPAN.BAT_Ay = ushort_swap(&data[13]) - 32768; // 5
  BAT_SPAN.BAT_Az = ushort_swap(&data[15]) - 32768; // 6
  BAT_SPAN.BAT_FOTemp = ushort_swap(&data[25]) - 32768; // 11
  BAT_SPAN.BAT_Pump = ushort_swap(&data[27]) - 32768; // 12
  BAT_SPAN.BAT_Axb = ushort_swap(&data[29]) - 32768; // 13
  BAT_SPAN.BAT_Ayb = ushort_swap(&data[31]) - 32768; // 14
  BAT_SPAN.BAT_Azb = ushort_swap(&data[33]) - 32768; // 15
  ++BAT_SPAN.n_bat_records;
}


void BSDataRecord::SPAN_data(unsigned char *data, unsigned max_nc) {
  if (LogEnbl) BSloggerport->SPAN_data(data);
  // Also send data to TM processing?
  BAT_SPAN.GPS_week = ushort_unpack(&data[6]);
  BAT_SPAN.GPS_msecs = long_unpack(&data[8]);
  BAT_SPAN.GPS_weekl = ulong_unpack(&data[12]);
  BAT_SPAN.GPS_secs = double_unpack(&data[16]);
  BAT_SPAN.Latitude = double_unpack(&data[24]);
  BAT_SPAN.Longitude = double_unpack(&data[32]);
  BAT_SPAN.Ellipsoidal_Ht = double_unpack(&data[40]);
  BAT_SPAN.N_Velocity = double_unpack(&data[48]);
  BAT_SPAN.E_Velocity = double_unpack(&data[56]);
  BAT_SPAN.Up_Velocity = double_unpack(&data[64]);
  BAT_SPAN.Roll = double_unpack(&data[72]);
  BAT_SPAN.Pitch = double_unpack(&data[80]);
  BAT_SPAN.Azimuth = double_unpack(&data[88]);
  BAT_SPAN.INS_Status = ulong_unpack(&data[96]);
  if (max_nc > BAT_SPAN.max_span_nc)
    BAT_SPAN.max_span_nc = max_nc;
  ++BAT_SPAN.n_span_records;
}

void BSDataRecord::BP_data(unsigned char *data) {
  static bool reported = false;
  BAT_SPAN.SPAN_IdleTime = data[12];
  BAT_SPAN.SPAN_TimeStatus = data[13];
  BAT_SPAN.BP_Week = ushort_unpack(&data[14]);
  BAT_SPAN.BP_msecs = ulong_unpack(&data[16]);
  BAT_SPAN.GPS_Rxvr_Status = ulong_unpack(&data[20]);
  BAT_SPAN.SolnStatus = ulong_unpack(&data[28+0]);
  BAT_SPAN.PosType = ulong_unpack(&data[28+4]);
  BAT_SPAN.BP_Lat = double_unpack(&data[28+8]);
  BAT_SPAN.BP_Lon = double_unpack(&data[28+16]);
  BAT_SPAN.BP_Ht = double_unpack(&data[28+24]);
  BAT_SPAN.BP_undulation = float_unpack(&data[28+32]);
  BAT_SPAN.BP_DatumID = ulong_unpack(&data[28+36]);
  BAT_SPAN.BP_LatStd = float_unpack(&data[28+40]);
  BAT_SPAN.BP_LonStd = float_unpack(&data[28+44]);
  BAT_SPAN.BP_HtStd = float_unpack(&data[28+48]);
  BAT_SPAN.BP_DiffAge = float_unpack(&data[28+56]);
  BAT_SPAN.BP_SolAge = float_unpack(&data[28+60]);
  BAT_SPAN.NSVs = data[28+64];
  BAT_SPAN.NSVsSol = data[28+65];
  BAT_SPAN.NGGL1 = data[28+66];
  BAT_SPAN.NGGL1L2 = data[28+67];
  BAT_SPAN.ExtSolnStatus = data[28+69];
  BAT_SPAN.SigMask = data[28+71];
  ++BAT_SPAN.n_bp_records;
  if (!reported) {
    nl_error(0, "BP Port: %d  SW Ver: %d", data[7],
          ushort_unpack(&data[26]));
    reported = true;
  }
}

void BSDataRecord::Flush_data() {
  if (LogEnbl) BSloggerport->Flush_data();
}


void BSDataRecord::Logging(bool on) {
  LogEnbl = on;
  if (!LogEnbl) BSloggerport->Flush_data();
}

BAT::BAT(const char *path, BSDataRecord *data_in) :
        Ser_Sel(path, O_RDONLY | O_NONBLOCK, nb_rec+1) {
  BSData = data_in;
  setup (460800, 8, 'n', 1, 35, 0);
  if (tcgetattr(fd, &termios_m)) {
    nl_error(2, "Error from tcgetattr: %s", strerror(errno));
  }
  flush_input();
}

int BAT::ProcessData(int flag) {
  unsigned min;
  if (flag & Selector::Sel_Read) {
    unsigned int start;
    if (fillbuf()) return 1;
    cp = 0;
    while (cp < nc) {
      if (not_found('\xF8')) break;
      start = cp-1;
      if (not_str("\x08\xF8", 2)) {
        if (cp == nc) {
          consume(start);
          break;
        } else continue;
      }
      // cp is now positioned past first 3 chars
      if (start + nb_rec > nc ) {
        consume(start);
        break;
      }
      BSData->BAT_data(&buf[start]);
      report_ok();
      consume(start+nb_rec);
    }
  }
  min = nb_rec - nc;
  if (min != termios_m.c_cc[VMIN]) {
    termios_m.c_cc[VMIN] = min;
    if (tcsetattr(fd, TCSANOW, &termios_m)) {
      nl_error(2, "Error from tcsetattr: %s", strerror(errno));
    }
  }
  return 0;
}

SPAN::SPAN( const char *path, BSDataRecord *data_in ) :
    Ser_Sel(path, O_RDONLY | O_NONBLOCK, nb_rec+1) {
  BSData = data_in;
  setup (115200, 8, 'n', 1, 104, 0);
  if (tcgetattr(fd, &termios_m)) {
    nl_error(2, "Error from tcgetattr: %s", strerror(errno));
  }
  max_nc = 0;
  flush_input();
}

SPAN::~SPAN() {
  nl_error(0, "SPAN: max_nc = %u", max_nc);
}

int SPAN::ProcessData(int flag) {
  unsigned min;
  if (flag & Selector::Sel_Read) {
    int start;
    if (fillbuf()) return 1;
    if (nc > max_nc) max_nc = nc;
    cp = 0;
    while (cp < nc) {
      unsigned long crc_calc, crc_rep;
      
      if (not_found('\xAA')) break;
      start = cp-1;
      if (not_str("\x44", 1)) {
        if (cp == nc) {
          consume(start);
          break;
        } else continue;
      }
      // cp is now positioned past first 2 chars
      // coincidentally, the two messages we are interested in have the
      // exact same length
      if (cp + 104 - 2 > nc ) {
        consume(start);
        break;
      }
      // Now check the CRC
      crc_calc = CalculateBlockCRC32(100, &buf[start]);
      crc_rep = ulong_unpack(&buf[start+100]);
      if (crc_calc == crc_rep) {
        if (buf[cp] == 0x13 && buf[cp+1] == 0x58 &&
            buf[cp+2] == 0xFC && buf[cp+3] == 0x01) {
          BSData->SPAN_data(&buf[start], nc);
          report_ok();
        } else if (buf[cp] == 0x12 && buf[cp+1] == 0x1C &&
            buf[cp+2] == 0x2A) {
          BSData->BP_data(&buf[start]);
          report_ok();
        }
        consume(start+104);
      } else {
        // report_err("CRC Error: calc: %X reported: %X", crc_calc, crc_rep);
        consume(start+50);
      }
    }
  }
  min = nb_rec - nc;
  if (min != termios_m.c_cc[VMIN]) {
    termios_m.c_cc[VMIN] = min;
    if (tcsetattr(fd, TCSANOW, &termios_m)) {
      nl_error(2, "Error from tcsetattr: %s", strerror(errno));
    }
  }
  return 0;
}

unsigned long SPAN::CRC32Value(int i) {
  int j;
  unsigned long ulCRC;
  ulCRC = i;
  for ( j = 8 ; j > 0; j-- ) {
    if ( ulCRC & 1 )
      ulCRC = ( ulCRC >> 1 ) ^ CRC32_POLYNOMIAL;
    else
      ulCRC >>= 1;
  }
  return ulCRC;
}

/**
 * Calculates the CRC-32 of a block of data all at once
 * @param ulCount Number of bytes in the data block
 * @param ucBuffer Data block
 */
unsigned long SPAN::CalculateBlockCRC32( unsigned long ulCount,
    unsigned char *ucBuffer ) {
  unsigned long ulTemp1;
  unsigned long ulTemp2;
  unsigned long ulCRC = 0;
  while ( ulCount-- != 0 ) {
    ulTemp1 = ( ulCRC >> 8 ) & 0x00FFFFFFL;
    ulTemp2 = CRC32Value( ((int) ulCRC ^ *ucBuffer++ ) & 0xff );
    ulCRC = ulTemp1 ^ ulTemp2;
  }
  return( ulCRC );
}

BSTM::BSTM(BAT_SPAN_t *tmdata_in) :
      TM_Selectee("BAT_SPAN", tmdata_in, sizeof(BAT_SPAN_t)) {
  BAT_SPAN = tmdata_in;
}

int BSTM::ProcessData(int flag) {
  Col_send(TMid);
  BAT_SPAN->n_span_records = 0;
  BAT_SPAN->max_span_nc = 0;
  BAT_SPAN->n_bat_records = 0;
  BAT_SPAN->n_bp_records = 0;
  return 0;
}

BScmd::BScmd(BSDataRecord *data_in) : Ser_Sel(NULL, 0, 20) {
  BSData = data_in;
  fd = tm_open_name( tm_dev_name("cmd/BAT_SPAN"), NULL, O_RDONLY );
  flags = Selector::Sel_Read;
}

int BScmd::ProcessData(int flag) {
  // Will ultimately handle logging enable/disable commands
  // BSData->Logging(bool on);
  if (flag & Selector::Sel_Read) {
    if (fillbuf()) return 1;
    if (nc == 0) return 1;
    switch (buf[cp]) {
      case 'Q': return 1;
      case 'L': BSData->Logging(true); break;
      case 'N': BSData->Logging(false); break;
      default: report_err("Invalid command"); return 0;
    }
    consume(nc);
    report_ok();
  }
  return 0;
}

BSlogger::BSlogger() : Selectee() {
  // fd = open("BSdata.log", O_WRONLY | O_CREAT | O_NONBLOCK, 0664);
  // if (fd == -1) nl_error(3, "Unable to write to BSdata.log");
  
  /* Note: when building the commandline here, I should really pass
     all of the msg options on to BSlogger. I am assuming I won't
     actually need any, so I can get away without. */
  char cmd[160];
  if (mlf_config)
    snprintf(cmd, 159, "BSlogger -N %s", mlf_config);
  else snprintf(cmd, 159, "BSlogger");
  fp = popen(cmd, "w");
  if (fp == NULL) nl_error(3, "Unable to open pipe to BSlogger");
  fd = fileno(fp);
  flags = 0;
  head = tail = offset = 0;
  overflow = 0;
}

BSlogger::~BSlogger() {
  if (flags) {
    fcntl(fd, F_SETFL, 0); // remove O_NONBLOCK
    while (flags != 0 &&
           ProcessData(Selector::Sel_Write) == 0);
  }
  // close(fd);
  fclose(fp);
  nl_error(0, "Overflow = %lu", overflow);
}

int BSlogger::ProcessData(int flag) {
  if (flag & Selector::Sel_Write) {
    if (head == tail) {
      flags = 0;
      return 0;
    } else {
      iov_t iov[2];
      int n_iov = 0;
      ssize_t nc;
      if (head > tail) {
        SETIOV(&iov[0], &BSq[head][offset],
          (n_records - head)*rec_size - offset);
        n_iov = 1;
        if (tail > 0) {
          SETIOV(&iov[1], &BSq[0][0], tail*rec_size);
          n_iov = 2;
        }
      } else {
        SETIOV(&iov[0], &BSq[head][offset],
          (tail - head)*rec_size - offset);
        n_iov = 1;
      }
      nc = writev(fd, &iov[0], n_iov);
      if (nc < 0) {
        switch (errno) {
          case EAGAIN: break;
          case EINTR: break;
          default:
            nl_error(2, "Write error in BSlogger::ProcessData: %s", strerror(errno));
            return 1;
        }
      } else if (nc > 0) {
        offset += nc;
        head += offset/rec_size;
        offset = offset%rec_size;
        if (head >= n_records)
          head -= n_records;
        if (head == tail)
          flags = 0;
      }
    }
  }
  return 0;
}


void BSlogger::BAT_data(unsigned char *data) {
  memcpy(&BSq[tail][SPAN::nb_rec], data, BAT::nb_rec);
  Flush_data();
}


void BSlogger::SPAN_data(unsigned char *data) {
  if (BSq[tail][0])
    Flush_data();
  memcpy(&BSq[tail][0], data, SPAN::nb_rec);
}

void BSlogger::Flush_data() {
  unsigned nexttail = tail+1;
  flags = Selector::Sel_Write;
  if (BSq[tail][0] == 0 && BSq[tail][SPAN::nb_rec] == 0)
    return;
  if (nexttail >= n_records)
    nexttail = 0;
  if (nexttail == head) {
    ++overflow;
  } else {
    tail = nexttail;
  }
  memset(&BSq[tail][0], 0, rec_size);
}

unsigned long ulong_unpack(unsigned char *s) {
  unsigned long sum;
  memcpy((unsigned char *)&sum, s, 4);
  return sum;
}

long long_unpack(unsigned char *s) {
  long sum;
  memcpy((unsigned char *)&sum, s, 4);
  return sum;
}

unsigned short ushort_swap(unsigned char *s) {
  unsigned short sum = s[0];
  sum = (sum << 8) + s[1];
  return sum;
}

unsigned short ushort_unpack(unsigned char *s) {
  unsigned short sum = (s[1]<<8) + s[0];
  return sum;
}

double double_unpack(unsigned char *s) {
  double sum;
  memcpy((unsigned char*)&sum, s, sizeof(double));
  return sum;
}

float float_unpack(unsigned char *s) {
  float sum;
  memcpy((unsigned char*)&sum, s, sizeof(float));
  return sum;
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
