SPAN Connection: RS232, 115200 Baud, 8 bits, no parity, 1 stop bit
SPAN Data Packet: INSPVASB Short Binary 50 Hz
  Total length: 104 bytes
  Header: 12 bytes
    0:  0xAA
    1:  0x44
    2:  0x13 (0x12 would be the long binary header)
    3:  UChar Message Length, not including header or CRC (88) x58
    4:  UShort Message ID Number (508: INSPVASB) x01 xFC
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
    96: Status INS Status, see Table 1 on page 39 Enum 4 H+84 (vals 0-7)
   100: xxxx 32-bit CRC Hex 4 H+88
   
  CRC is calculated on bytes 0-100.

SPAN Long Header Data (for BESTPOSB Message)
    0: xAA
    1: x44
    2: x12 (long header)
    3: x1C Header Length (presumably x1C, 28 bytes)
    4: x2A UShort, Msg ID, 42 for BESTPOS x2A
    6: UCHAR Message type 0x80 == Response, maybe 0x00 (maybe report on first message?)
    7: UCHAR Port address (probably useless)
    8: USHORT Message length (not including header or CRC 72 = x48)
   10: USHORT Sequence (probably 0)
   12: UCHAR Idle Time (0-200 = 0-100%)
   13: UCHAR Time Status
   14: USHORT GPS_Week
   16: ULONG GPS_msec
   20: ULONG Rxvr_Status
   24: USHORT Reserved
   26: USHORT Rxvr_SW_Ver (report on first message)
  
BETSPOSB Message
    0: ULONG SolnStatus
    4: ULONG PosType
    8: double BP_Lat
   16: double BP_Lon
   24: double BP_Ht (above MSL)
   32: float BP_undulation
   36: ULONG BP_DatumID
   40: float BP_LatStd
   44: float BP_LonStd
   48: float BP_HtStd
   52: char[4] StnID (probably ignore)
   56: float BP_DiffAge
   60: float BP_SolAge
   64: UCHAR NSVs
   65: UCHAR NSVsSol
   66: UCHAR NGGL1
   67: UCHAR NGGL1L2
   68: reserved
   69: UCHAR ExtSolnStatus
   70: reserved
   71: UCHAR SigMask
   72: ULONG CRC
  
BAT Connector, RS422
Pin 1: Tx-(A) [NC]
Pin 2: Tx+(B) [NC]
Pin 3: Rx+(B)
Pin 4: Rx-(A)
Pin 5: GND
Pin 6: RTS-(A) [NC]
Pin 7: RTS+(B) [NC]
Pin 8: CTS+(B) [NC]
Pin 9: CTS-(A) [NC]

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
    
  Extraction app
    Will read the standard BAT configuration file
    BAT Channels will be designated as usual
    SPAN Channels will use the following channel numbering:
      0: Header Week Number (UShort)
      1: Header Seconds (long msecs)
      2: INSPVAS Week Number (Ulong)
      3-12: Doubles as listed in INSPVAS Pg 122
      13: INS Status (Ulong values 0-7)
