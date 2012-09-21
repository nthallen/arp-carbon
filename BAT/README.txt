SPAN Connection: RS232, 115200 Baud, 8 bits, no parity, 1 stop bit
SPAN Data Packet: INSPVASB Short Binary 50 Hz
  Total length: 104 bytes
  Header: 12 bytes
    0:  0xAA
    1:  0x44
    2:  0x13 (0x12 would be the long binary header)
    3:  UChar Message Length, not including header or CRC (88)
    4:  UShort Message ID Number (508: INSPVASB)
    6:  UShort GPS Week Number
    8:  long Milleseconds from beginning of the GPS week
  INSPVASB
    12: Week GPS Week Ulong 4 H
    16: Seconds Seconds from week start Double 8 H+4
    24: Latitude Latitude (WGS84) Double 8 H+12
    32: Longitude Longitude (WGS84) Double 8 H+20
    40: Height Ellipsoidal Height (WGS84) [m] Double 8 H+28
    48: North Velocity Velocity in a northerly direction (a -
        ve value implies a southerly direction)
        [m/s] Double 8 H+36
    56: East Velocity Velocity in an easterly direction (a -
        ve value implies a westerly direction)
        [m/s] Double 8 H+44
    64: Up Velocity Velocity in an up direction [m/s] Double 8 H+52
    72: Roll Right handed rotation from local
        level around y-axis in degrees
        Double 8 H+60
    80: Pitch Right handed rotation from local
        level around x-axis in degrees Double 8 H+68
    88: Azimuth Left handed rotation around z-axis
        Degrees clockwise from North Double 8 H+76
    96: Status INS Status, see Table 1 on page 39 Enum 4 H+84
   100: xxxx 32-bit CRC Hex 4 H+88
   
  CRC is calculated on bytes 0-100.

BAT Connection: RS422?
BAT Data Packet: 50 Hz, 35 bytes
     0: 0xF8
     1: 0x08
     2: 0xF8
     3: 16 x 2-byte integer values, msb first.
        Channels may or may not have a 32768 offset.
        0: Px  4: Ax   8: Tp2    12: Q1
        1: Py  5: Ay   9: Tbar1  13: Q2
        2: Pz  6: Az  10: Tbar2  14: Aux1
        3: Ps  7: Tp1 11: Net    15: Aux2

Strategy:
  Maintain global data record
    When GPS data arrives, flush record if non-empty
      Write GPS data into record
    When BAT data arrives, add to record if non-empty, flush
  Can report low rate data to TM

  Using the Selector pattern, I need:
    DataRecord
      Members:
        Ser_Sel on BAT interface Sends BAT data to DataRecord
        Ser_Sel on SPAN interface Sends SPAN data to DataRecord
        Selectee on Command interface (log, no log, quit)
        Selectee on Collection interface (report low-rate/averaged data)
          When writable, check for data. If none available, mask off and set 
        Selectee on Logger
          WriteRecord(...);
          By default, mask off flags, write non-block as soon as data arrives
          If blocking is indicated, set write flag and buffer the data.
      Methods:
        BAT_data(unsigned char *data);
        SPAN_data(unsigned char *data);
        Flush_data();
        Logging(bool on);
        Get_Averages(BAT_SPAN &bs);
        
  Logger app
    reads from stdin (binary) and writes to log files using MLF tools
    Must know the record size and check for framing chars. Find an
    efficient number of records near 5 seconds/file. Set a timeout
    to close an open file if no data arrives for 5 seconds.