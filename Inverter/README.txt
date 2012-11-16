Inverter Driver

Interfaces:
  RS232 (/dev/ser1,4800,8,n,1)
  Command (/dev/huarp/HCI/cmd/Inverter)
  Telemetry (/dev/huarp/HCI/TM/DG/Inverter)

Commands:
  Inverter On (send "POWER 2\r\n")
  Inverter Off (send "POWER 0\r\n")

Data:
  QURY 0-7? No idea what most of these are, best guesses:
    QURY 0 1 = Failed (latched...)
    QURY 1 Input Voltage
    QURY 2 0 = OK 4 = Failed
    QURY 3 4 = commanded off 7 = commanded on
    QURY 4 Output Load (latched in failure mode)
    QURY 5 Bit Mapped
    QURY 6 Bit Mapped
    QURY 7 Bit Mapped
  POWER 3
    0: Off
    2: On
    empty response == 0
  Data can be polled at 1 Hz.

Parsing:
  Responses appear to be of the form:
    ^\s*[0-9A-F]{0,2}\s*=>
  \s of course includes \r,\n and ' '
  '=>' appears to be a prompt string, but I will probably use it
  as an end-of-transfer string.
  
  Commands and queries to the device will need to be queued.
  The commands take priority, of course. Will want to cycle
  through the queries once for each TM transaction.
  Will also need to timeout on no response, and presumably
  not report back to TM to increment the stale counter.
 
Architecture:
  Selector
    InvTm: TM_Selectee (synchronous)
      Col_send, and clear bit to indicate data not fresh
      Set global flag 0
    Cmd_Sel: Cmd_Selectee (now inheriting from Ser_Sel
      On receiving a command, set common command request and set
      global flag 1 to signal Ser_Selectee
    Inverter: Ser_Sel
      Monitor RS232 and global flags 1 and 0 for cmd and TM.
      save status to TM structure.
      Set bit to indicate data is fresh
      On global flag 0 (TM), initiate queries, send first if not waiting
      On global flag 1 (Cmd), issue command if not waiting
      On RS232 data, parse response, save to TM structure,
      issue next command or query.
