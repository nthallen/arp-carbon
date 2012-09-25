#include <errno.h>
#include <sys/uio.h>
#include <string.h>
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
  // BATport = new BAT(bat_path, this);
  // BScmdport = new BScmd(this);
  BSTMport = new BSTM(this);
  BSloggerport = new BSlogger();
  S.add_child(SPANport);
  // S.add_child(BATport);
  // S.add_child(BScmdport);
  S.add_child(BSTMport);
  S.add_child(BSloggerport);
  LogEnbl = true;
}

//bool BSDataRecord::Get_TM_Data(BAT_SPAN &bs) {
//  return false;
//}

void BSDataRecord::BAT_data(unsigned char *data) {
  if (LogEnbl) BSloggerport->BAT_data(data);
  // Also send data to TM processing?
}


void BSDataRecord::SPAN_data(unsigned char *data) {
  if (LogEnbl) BSloggerport->SPAN_data(data);
  // Also send data to TM processing?
}


void BSDataRecord::Flush_data() {
  if (LogEnbl) BSloggerport->Flush_data();
}


void BSDataRecord::Logging(bool on) {
  LogEnbl = on;
  if (!LogEnbl) BSloggerport->Flush_data();
}

SPAN::SPAN( const char *path, BSDataRecord *data_in ) :
    Ser_Sel(path, O_RDONLY, 209) {
  BSData = data_in;
  setup (115200, 8, 'n', 1, 104, 0);
}

unsigned long SPAN::ulong_swap(unsigned char *s) {
  unsigned long sum = s[0];
  sum = (sum << 4) + s[1];
  sum = (sum << 4) + s[2];
  sum = (sum << 4) + s[3];
  return sum;
}

int SPAN::ProcessData(int flag) {
  if (flag & Selector::Sel_Read) {
    int start;
    if (fillbuf()) return 1;
    while (cp < nc) {
      unsigned long crc_calc, crc_rep;
      
      if (not_found('\xAA')) return 0;
      start = cp-1;
      if (not_str("\x44\x13\x58\x01\xFC", 5)) {
        if (cp == nc) {
          consume(start);
          return 0;
        } else continue;
      }
      // cp is now positioned past first 6 chars
      if (cp + 104 - 6 > nc ) {
        consume(start);
        return 0;
      }
      // Now check the CRC
      crc_calc = CalculateBlockCRC32(100, &buf[start]);
      crc_rep = ulong_swap(&buf[start+100]);
      if (crc_calc == crc_rep) {
        BSData->SPAN_data(&buf[start]);
        report_ok();
      } else {
        report_err("CRC Error");
      }
      consume(104);
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

BSlogger::BSlogger() : Selectee() {
  fd = open("BSdata.log", O_WRONLY | O_CREAT | O_NONBLOCK);
  if (fd == -1) nl_error(3, "Unable to write to BSdata.log");
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
  close(fd);
}

BSTM::BSTM(BAT_SPAN *tmdata_in) :
      TM_Selectee("BAT_SPAN", tmdata_in, sizeof(BAT_SPAN)) {
  TMdata = tmdata_in;
}

int BSTM::ProcessData(int flag) {
  Col_send(TMid);
  TMdata->n_span_records = 0;
  TMdata->n_bat_records = 0;
  return 0;
}

int BSlogger::ProcessData(int flag) {
  if (flag & Selector::Sel_Write) {
    if (head == tail) {
      flag = 0;
      return 0;
    } else {
      iov_t iov[2];
      int n_iov = 0;
      ssize_t nc;
      if (head < tail) {
        SETIOV(&iov[0], &BSq[head][offset], (n_records - head)*rec_size + rec_size - offset);
        n_iov = 1;
        if (tail > 0) {
          SETIOV(&iov[1], &BSq[0][0], tail*rec_size);
          n_iov = 2;
        }
      } else {
        SETIOV(&iov[0], &BSq[head][offset], (tail - head)*rec_size + rec_size - offset);
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
  if (BSq[tail][0] == 0 && BSq[tail][SPAN::nb_rec] == 0)
    return;
  if (nexttail >= n_records)
    nexttail = 0;
  if (nexttail == head)
    ++overflow;
  memset(&BSq[tail][0], 0, rec_size);
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
