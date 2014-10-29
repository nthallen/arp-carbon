README.txt for Harvard Carbon Isotopes instrument

CPU Configuration:
  Versalogic Mamba VL-EBX-37F
    Manual says in order to use IRQs on the ISA bus, they must
    first be enabled in the BIOS setup, but there is no option
    to enable or disable IRQs in the BIOS setup.
    Only IRQs 3, 4, 5 and 10 go to ISA bus. We will use IRQ5,
    which is consistent with the Python config below.
    
    Apparently we have no need for the Firmbase support, so
    I have disabled it in the BIOS.
    
    [x] Check to see if CPU temp and board temp info is accessible
        in the same way as on Python: No it is not.
    [y] Test Xtreme/104 as RS-232
    
    BIOS: Configure eSATA connector to boot first, internal
    SATA second. Ubuntu config below.
  
  Versalogic Python VL-EBX-11
    BIOS requires PS/2 keyboard, not USB
      Actually, the VL-EBX-11 currently in /net/hci responds to USB keyboard.
      Probably smart to install the connector in case another board has to
      be swapped in at some point and does not respond to USB for some reason.
    Drive C: Secondary/Slave (for compact flash)
    PCI INT B => IRQ10 (instead of IRQ5)
    ISA IRQ 5 Enabled (for Xtreme/104 board)
    COM1 => IRQ4 (for use with inverter)
    COM2 => IRQ3 (default, for use with SPAN) (disable, move SPAN to Xtreme/104)
    COM3 => IRQ7 (for use with laser altimeter) (need to test this)
    COM4 => Disabled
  
  Xtreme/104:
    J1.3 Jumpered for IRQ Mode 2: 2 IRQs
    J1.6 Jumpered to select fast clock
    J1.* open for I/O address selection 0x300
    C5 Jumpered for IRQ5 (Mode 2, IRQ for ports 1, 3, 5, 7)
    D3 Jumpered for IRQ3 (Mode 2, IRQ for ports 2, 4, 6, 8)
    J5.P1.RX & .TX Jumpered for RS422 on Port 1
    
    /sbin/devc-ser8250 Driver needs to be invoked with -c option
    to note fast input clock:
      /sbin/devc-ser8250 -c 7372800/16 -u4 300,5 -u2 308,3

Need PS/2 keyboard Connector for BIOS, but not for QNX6. Or maybe not.

LK204:
  Write FIFO length is 64 characters.
  I2C Transmission rate is about 10 kbps or 1kBps
  
  Special characters for SEAS Shield:
    0: upper left:    \xfe\x4e\x00\x1f\x1f\x11\x11\x1f\x15\x10\x10
    1: upper middle:  \xfe\x4e\x01\x1f\x1f\x11\x11\x1f\x0a\x04\x0c
    2: upper right:   \xfe\x4e\x02\x1f\x1f\x11\x11\x1f\x15\x01\x01
    3: middle left:   \xfe\x4e\x03\x08\x0a\x0f\x09\x04\x04\x02\x01
    4: middle middle: \xfe\x4e\x04\x06\x14\x1f\x05\x0c\x04\x06\x0c
    5: middle right:  \xfe\x4e\x05\x02\x12\x1e\x0a\x04\x04\x08\x10
    6: bottom middle: \xfe\x4e\x06\x1f\x04\x00\x00\x00\x00\x00\x00
  
  It is not a good idea to write to the LK204 while the write buffer
  is draining. When sending a string, all but the last char is
  is marked to suspend draining of the write queue in order to
  ensure that complete escape sequences get delivered in a timely
  manner. The proper way to send large amounts of data like this is
  to send less than 64 characters, then enable output and wait for
  the output fifo to drain completely before writing any more.
  In this case, we could send the first five lines (55 chars), then
  drain. 55 characters should drain in about 55 msecs, so transmitting
  on the next second is pretty much guaranteed to be OK. If we had
  a dedicated driver, we could do it even faster, but since we don't
  do this that often, that really isn't necessary.

      > Panel display text \xfe\x4e\x00\x1f\x1f\x11\x11\x1f\x15\x10\x10\
      > Panel display text \xfe\x4e\x01\x1f\x1f\x11\x11\x1f\x0a\x04\x0c\
      > Panel display text \xfe\x4e\x02\x1f\x1f\x11\x11\x1f\x15\x01\x01\
      > Panel display text \xfe\x4e\x03\x08\x0a\x0f\x09\x04\x04\x02\x01\
      > Panel display text \xfe\x4e\x04\x06\x14\x1f\x05\x0c\x04\x06\x0c
   +1 > Panel display text \xfe\x4e\x05\x02\x12\x1e\x0a\x04\x04\x08\x10\
      > Panel display text \xfe\x4e\x06\x1f\x04\x00\x00\x00\x00\x00\x00\
      > Panel display text \xfe\x58\n \x00\x01\x02 AndersonGroup\n\
      > Panel display text  \x03\x04\x05 Harvard SEAS\n\
      > Panel display text   \x06
      
    12345678901234567890
   1     
   2 012 Anderson Group
   3 345 Harvard SEAS
   4  6  
   
                               R   G
  Top LED is controlled by GPO 1 & 2
  Middle LED               GPO 3 & 4
  Bottom LED               GPO 5 & 6
  The first GPO is the Red LED, the second is green
  
  Turn on GPO:  FE 57 n
  Turn off GPO: FE 56 n
  Set Startup:  FE C3 n s (where s=1 for on, s=0 for off)
  
  Want to initialize all of these LEDs to be off, so:
  > Panel display text \xfe\xc3\x01\x00
  > Panel display text \xfe\xc3\x02\x00
  > Panel display text \xfe\xc3\x03\x00
  > Panel display text \xfe\xc3\x04\x00
  > Panel display text \xfe\xc3\x05\x00
  > Panel display text \xfe\xc3\x06\x00

Mamba CPU Die Temperature

Ubuntu on external drive
    On GSE, create /home/flight/.ssh/id_rsa*
    visudo to add
      (flight) /usr/local/bin/transfer
    to list of apps FLIGHT users can run.
    Copy transfer into /usr/local/bin
    [move transfer and remtransfer into tmutil]
    
  First Drive
    15 GB Boot partition ext3
    2 GB Swap partition
    Rest is /data ext3
    If install fails, regenerate the USB install stick
    Create account for me (nort) with QNX password
    Create account for flight with rooty password
      Copy relevant ssh keys into my account (cygwin, nortvm650a, *gse)
      Copy relevant ssh keys into flight account (*gse)
    Install sshd
    edit /etc/fstab to mount /qnx4
       /dev/sda1 /qnx4 qnx4 ro,nobootwait 0 0
    visudo to add
      Defaults editor=/usr/bin/vi
      flight ALL=(root) /sbin/shutdown
    edit /etc/default/grub
    sudo update-grub
    Copy remtransfer into /usr/local/bin and edit for instrument
    
    Copy configuration files to blast onto subsequent dists
    
  Subsequent Drives
    15 GB Boot partition ext3
    2 GB Swap partition
    Rest is /data ext3
    If install fails, regenerate the USB install stick
    Create account for me (nort) with QNX password
    Install sshd
    edit /etc/fstab to mount /qnx4
       /dev/sda1 /qnx4 qnx4 ro,nobootwait 0 0
    Copy configuration tar.gz and install
    
    sudo update-grub
    
    Fixed IP (so not dependent on lab network)
    ssh in to perform copy operation.
    Needs to work with ethernet jack J15 in order to use
      the onboard industrial switch
    [Ultimately would be great to use pilot panel...]
    
    Switching between graphical and text interface:
      Edit /etc/default/grub
      set GRUB_CMDLINE_LINUX_DEFAULT to "quiet splash" for GUI
      and "text" for text
      Run sudo update-grub to commit changes
      
    Run "sudo lightdm" from commandline to bring up graphical interface

Reduce procedure
  fixdisk /net/hci (before reduce)
  reduce
  Do dircksum after reduce so we can quickly get analysis data.
  Need analysis script to:
    Run BAT_SPAN extraction
    Copy engineering stuff
    Run dircksum on the flight computer (wrap dircksum in script to establish pwd)
      If all else fails, run a special script via flight.sh

Transfer procedure
  On GSE:
    transfer flight
      verify or wait for transfer to show up
      verify what data sets will be copied
      rsync src dest
      shutdown

7/1/13: Notes on external drive configuration. This info can be reintegrated
above.

  [123] Create user flight:flight on removable (adduser flight)
  [123] Transfer hcigse id_rsa.pub to authorized-keys
  [   ] Transfer scripts can go in /home/flight
  [123] Edit sudoers to allow flight to sudo shutdown -h now
      flight ALL=(root) NOPASSWD: /sbin/shutdown
  [123] Save ssh host key from one drive and duplicate on the others
  [x] Create /home/flight on gse and create /home/flight/.ssh/id_rsa*
  [ ] Edit sudoers to allow group flight to sudo -u flight transfer

Scripting
  My inclination is to tie database into reduce, not saverun, so ignore
  junk runs. If a junk run is subsequently reduced, it can be added to
  the database then.
  
  Perform dircksum for flight data, optionally for other types?
  
  Transfer:
    possible modes of operation
      a: just transfer all runs in the database that have not been
         copied to this drive
      b: list all runs in the database that have not been copied and
         ask for confirmation for some or all
         
      Both of these approaches would be decided on the gse, which has
      access to the database, but the transfer machine only knows what
      it sees on /qnx4/home/hci/raw and compares to /data/home/hci/raw.
      Perhaps should compare the two lists? Propose to copy anything
      except junk. Or could ask for that list, then have user use
      command line
    
    transfer
      transfer all runs in database that are on flight node and not
      on this drive
    transfer [flight|cal|data|junk]
      like transfer, but limit list to runs of the specified type
    transfer [(flight|cal|data|junk)/]run
      transfer the specified run. runtype is optional, since it should be
      easy to lookup the runtype in the database.
    transfer -a
      include runs that are not in the database
    transfer -c
      ask for confirmation of the list of runs to transfer before starting.
    transfer -d
      perform dircksum on tranferred runs
