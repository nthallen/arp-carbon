# Makefile Generated Tue Jun 05 12:07:49 EDT 2012
MNC=HCI
HOMEDIR=/home/hci/src/TM
SPECFILE=HCI.spec
SRC=pwrmon_conv.tmc idx64flag.tmc qcli_conv.tmc PTRH_conv.tmc
SRC+=types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc
SRC+=qcli.tmc PTRH.tmc SWData.tmc SWData.h QCLI_C.tmc QCLI_M.tmc
SRC+=QCLI_I.tmc idx64col.tmc PTRH_col.tmc qcli_col.tmc SWData_col.tmc
SRC+=AO.cmd dccc.cmd qclis.cmd idx64drv.cmd subbus.cmd address.h
SRC+=SWData.cmd QCLI_C.cmd QCLI_M.cmd QCLI_I.cmd digio_conv.tmc
SRC+=hk.tbl qcli.tbl Cells.tbl HCI.tma HCI.sws HCIeng.cdf HCI.doit
TOOL=HCI.spec Makefile
SCRIPT=idx64.idx64 interact dccc.dccc runfile.FF
OBJ=QCLI_C.cmd QCLI_C.out QCLI_C.tmc QCLI_C.m QCLI_C.log QCLI_M.cmd
OBJ+=QCLI_M.out QCLI_M.tmc QCLI_M.m QCLI_M.log QCLI_I.cmd QCLI_I.out
OBJ+=QCLI_I.tmc QCLI_I.m QCLI_I.log HCIcol.cc HCI.pcm tm.dac
OBJ+=HCIcoloui.c HCIcoloui.o HCIcol.o ptrhm.o ptrhm_col.o HCIcmd.cc
OBJ+=HCIcmd.dat HCIsrvr.o HCIsrvroui.c HCIsrvroui.o hktbl.tmc
OBJ+=qclitbl.tmc Cellstbl.tmc HCIdisp.cc HCIdispoui.c HCIdispoui.o
OBJ+=HCIdisp.o hktblnc.tmc qclitblnc.tmc Cellstblnc.tmc HCIdispnc.cc
OBJ+=HCIdispncoui.c HCIdispncoui.o HCIdispnc.o HCIsws.tma
OBJ+=HCIalgoa.tmc HCIalgo.cc HCIalgooui.c HCIalgooui.o HCIalgo.o
OBJ+=HCIengextcdf.oui HCIengext.tmc HCIengext.cc HCIengextoui.c
OBJ+=HCIengextoui.o HCIengext.o doit.dep HCIclt.o HCIcltoui.c
OBJ+=HCIcltoui.o HCIcltnc.o HCIcltncoui.c HCIcltncoui.o
TGT=HCIcol HCIsrvr HCIdisp HCIdispnc HCIalgo HCIengext doit HCIclt
TGT+=HCIcltnc
DISTRIB=QCLI_C.out QCLI_M.out QCLI_I.out HCI.pcm tm.dac
IDISTRIB=Experiment.config VERSION doit
SRCDIST=QCLI_C.m QCLI_M.m QCLI_I.m hk.tbl qcli.tbl Cells.tbl HCI.tma
SRCDIST+=/usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc
SRCDIST+=T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc
SRCDIST+=PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc
SRCDIST+=/usr/local/share/huarp/vl_temp.tmc
SRCDIST+=/usr/local/share/huarp/tmdf.tmc
SRCDIST+=/usr/local/share/huarp/ptrhm.cc
SRCDIST+=/usr/local/share/huarp/flttime.tmc SWData.tmc SWData.h
SRCDIST+=QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc
NONRCS=
TMCBASE=/usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc
TMCBASE+=T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc
TMCBASE+=PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc
TMCBASE+=/usr/local/share/huarp/vl_temp.tmc
TMCBASE+=/usr/local/share/huarp/tmdf.tmc
TMCBASE+=/usr/local/share/huarp/ptrhm.cc
TMCBASE+=/usr/local/share/huarp/flttime.tmc SWData.tmc SWData.h
TMCBASE+=QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc
CMDBASE=/usr/local/share/huarp/root.cmd
CMDBASE+=/usr/local/share/huarp/getcon.cmd
CMDBASE+=/usr/local/share/huarp/DACS_AI.cmd
CMDBASE+=/usr/local/share/huarp/idx64.cmd
CMDBASE+=/usr/local/share/huarp/qcli.cmd AO.cmd dccc.cmd qclis.cmd
CMDBASE+=idx64drv.cmd subbus.cmd address.h SWData.cmd QCLI_C.cmd
CMDBASE+=QCLI_M.cmd QCLI_I.cmd
COLBASE=idx64col.tmc PTRH_col.tmc qcli_col.tmc
COLBASE+=/usr/local/share/huarp/DACS_ID.tmc
COLBASE+=/usr/local/share/huarp/vl_temp_col.tmc
COLBASE+=/usr/local/share/huarp/tmdf_col.tmc
COLBASE+=/usr/local/share/huarp/ptrhm_col.cc
COLBASE+=/usr/local/share/huarp/cpu_usage_col.tmc
COLBASE+=/usr/local/share/huarp/freemem_col.tmc SWData_col.tmc
SWSBASE=HCI.sws
QCLIBASE=QCLI_C.qcli QCLI_M.qcli QCLI_I.qcli
PHTGT=hktbl.tmc qclitbl.tmc Cellstbl.tmc
RCS=$(SRC) $(TOOL) $(SCRIPT)
SOURCE=$(RCS) $(NONRCS)
OBJECT=$(OBJ) *.err
TARGET=$(TGT)
DSTRB=$(TGT) $(DISTRIB) $(SCRIPT)
TGTDIR= $(TGTNODE)/home/hci
include /usr/local/share/huarp/appgen.mk

.PHONY : all extdistribution distribution clean check_photon

all : Makefile check_photon $(TGT) .cvsignore
Makefile : HCI.spec
	appgen HCI.spec
VERSION=`cat VERSION`
extdistribution : $(DSTRB) $(SRCDIST) VERSION
	@[ -d $(TGTDIR)/bin ] || mkdir $(TGTDIR)/bin
	@[ -d $(TGTDIR)/bin/$(VERSION) ] || mkdir $(TGTDIR)/bin/$(VERSION)
	@[ -d  $(TGTDIR)/bin/$(VERSION)/Base ] || mkdir $(TGTDIR)/bin/$(VERSION)/Base
	@distribute $(FORCE) $(TGTDIR)/bin/$(VERSION) $(DSTRB)
	@distribute $(FORCE) $(TGTDIR)/bin/$(VERSION)/Base $(SRCDIST)
distribution : extdistribution
	@distribute $(FORCE) $(TGTDIR) $(IDISTRIB)
check_photon :
ifeq ($(WPHOTON),YES)
	@for tgt in $(PHTGT); do \
	  cmp -s $$tgt /usr/local/share/huarp/nulltbl.tmc && echo Remaking $$tgt && rm -f $$tgt; \
	done; true
endif
HCIcol : HCIcol.o ptrhm.o ptrhm_col.o HCIcoloui.o
	$(LINK.privCXX) HCIcol.o ptrhm.o ptrhm_col.o HCIcoloui.o -lsubbus -ltmpp -ltm -lnort
	$(OUIUSE) HCIcoloui.c
	$(PROMOTE) HCIcol
HCIsrvr : HCIsrvr.o HCIsrvroui.o
	$(LINK.privCXX) HCIsrvr.o HCIsrvroui.o -lsubbus -ltmpp -ltm -lnort
	$(OUIUSE) HCIsrvroui.c
	$(PROMOTE) HCIsrvr
HCIdisp : HCIdisp.o ptrhm.o HCIdispoui.o
	$(LINK.normCXX) HCIdisp.o ptrhm.o HCIdispoui.o -ldisp -ltmph -lph -ltmpp -ltm -lnort
	$(OUIUSE) HCIdispoui.c
HCIdispnc : HCIdispnc.o ptrhm.o HCIdispncoui.o
	$(LINK.normCXX) HCIdispnc.o ptrhm.o HCIdispncoui.o -ldispnc -ltmnc -lncurses -ltmpp -ltm -lnort
	$(OUIUSE) HCIdispncoui.c
HCIalgo : HCIalgo.o ptrhm.o HCIalgooui.o
	$(LINK.normCXX) HCIalgo.o ptrhm.o HCIalgooui.o -ltmpp -ltm -lnort
	$(OUIUSE) HCIalgooui.c
HCIengext : HCIengext.o ptrhm.o HCIengextoui.o
	$(LINK.normCXX) HCIengext.o ptrhm.o HCIengextoui.o -ltmpp -ltm -lnort
	$(OUIUSE) HCIengextoui.c
doit : HCI.doit
	mkdoit3 -o doit  HCI.doit
HCIclt : HCIclt.o HCIcltoui.o
	$(LINK.normCXX) HCIclt.o HCIcltoui.o -ltmph -lph -ltmpp -ltm -lnort
	$(OUIUSE) HCIcltoui.c
HCIcltnc : HCIcltnc.o HCIcltncoui.o
	$(LINK.normCXX) HCIcltnc.o HCIcltncoui.o -ltmnc -lncurses -ltmpp -ltm -lnort
	$(OUIUSE) HCIcltncoui.c
HCIcol.cc : /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc idx64col.tmc PTRH_col.tmc qcli_col.tmc /usr/local/share/huarp/DACS_ID.tmc /usr/local/share/huarp/vl_temp_col.tmc /usr/local/share/huarp/tmdf_col.tmc /usr/local/share/huarp/cpu_usage_col.tmc /usr/local/share/huarp/freemem_col.tmc SWData_col.tmc
	$(TMC.col) /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc idx64col.tmc PTRH_col.tmc qcli_col.tmc /usr/local/share/huarp/DACS_ID.tmc /usr/local/share/huarp/vl_temp_col.tmc /usr/local/share/huarp/tmdf_col.tmc /usr/local/share/huarp/cpu_usage_col.tmc /usr/local/share/huarp/freemem_col.tmc SWData_col.tmc
HCIcoloui.c : $(OUIDIR)/collect.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/collect.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
HCIcoloui.o : HCIcoloui.c SWData.h
HCIcol.o : HCIcol.cc SWData.h
ptrhm.o : /usr/local/share/huarp/ptrhm.cc SWData.h
	$(COMPILE.cc) /usr/local/share/huarp/ptrhm.cc
ptrhm_col.o : /usr/local/share/huarp/ptrhm_col.cc SWData.h
	$(COMPILE.cc) /usr/local/share/huarp/ptrhm_col.cc
HCIcmd.cc : /usr/local/share/huarp/root.cmd /usr/local/share/huarp/getcon.cmd /usr/local/share/huarp/DACS_AI.cmd /usr/local/share/huarp/idx64.cmd /usr/local/share/huarp/qcli.cmd AO.cmd dccc.cmd qclis.cmd idx64drv.cmd subbus.cmd SWData.cmd QCLI_C.cmd QCLI_M.cmd QCLI_I.cmd
	$(CMDGEN) -d HCIcmd.dat /usr/local/share/huarp/root.cmd /usr/local/share/huarp/getcon.cmd /usr/local/share/huarp/DACS_AI.cmd /usr/local/share/huarp/idx64.cmd /usr/local/share/huarp/qcli.cmd AO.cmd dccc.cmd qclis.cmd idx64drv.cmd subbus.cmd SWData.cmd QCLI_C.cmd QCLI_M.cmd QCLI_I.cmd
HCIsrvr.o : HCIcmd.cc
	$(COMPILE.srvr) HCIcmd.cc
HCIsrvroui.c : $(OUIDIR)/cis.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/cis.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
HCIsrvroui.o : HCIsrvroui.c address.h
hktbl.tmc : hk.tbl
qclitbl.tmc : qcli.tbl
Cellstbl.tmc : Cells.tbl
HCIdisp.cc : /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc PTRH_conv.tmc pwrmon_conv.tmc digio_conv.tmc idx64flag.tmc qcli_conv.tmc hktbl.tmc qclitbl.tmc Cellstbl.tmc
	$(TMC) /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc PTRH_conv.tmc pwrmon_conv.tmc digio_conv.tmc idx64flag.tmc qcli_conv.tmc hktbl.tmc qclitbl.tmc Cellstbl.tmc
HCIdispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
HCIdispoui.o : HCIdispoui.c SWData.h
HCIdisp.o : HCIdisp.cc SWData.h
hktblnc.tmc : hk.tbl
qclitblnc.tmc : qcli.tbl
Cellstblnc.tmc : Cells.tbl
HCIdispnc.cc : /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc PTRH_conv.tmc pwrmon_conv.tmc digio_conv.tmc idx64flag.tmc qcli_conv.tmc hktblnc.tmc qclitblnc.tmc Cellstblnc.tmc
	$(TMC) /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc PTRH_conv.tmc pwrmon_conv.tmc digio_conv.tmc idx64flag.tmc qcli_conv.tmc hktblnc.tmc qclitblnc.tmc Cellstblnc.tmc
HCIdispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
HCIdispncoui.o : HCIdispncoui.c SWData.h
HCIdispnc.o : HCIdispnc.cc SWData.h
HCIsws.tma : HCI.sws
	$(COMPILE.sws) HCI.sws
HCIalgoa.tmc : HCI.tma HCIsws.tma HCIsrvr
	$(SERVER) ./HCIsrvr
	$(TMCALGO) -V "`./HCIsrvr -R`" HCI.tma HCIsws.tma
HCIalgo.cc : /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc HCIalgoa.tmc
	$(TMC) /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc HCIalgoa.tmc
HCIalgooui.c : $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
HCIalgooui.o : HCIalgooui.c SWData.h
HCIalgo.o : HCIalgo.cc SWData.h
HCIengextcdf.oui : HCIeng.cdf
	$(EDF2OUI) HCIeng.cdf
HCIengext.tmc : HCIeng.cdf
	$(EDF2EXT) HCIeng.cdf
HCIengext.cc : /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc qcli_conv.tmc PTRH_conv.tmc HCIengext.tmc
	$(TMC) /usr/local/share/huarp/freemem.tmc types.tmc AIO.tmc T30K75KU.tmc digio.tmc idx64.tmc pwrmon.tmc qcli.tmc PTRH.tmc /usr/local/share/huarp/cpu_usage.tmc /usr/local/share/huarp/vl_temp.tmc /usr/local/share/huarp/tmdf.tmc /usr/local/share/huarp/flttime.tmc SWData.tmc QCLI_C.tmc QCLI_M.tmc QCLI_I.tmc qcli_conv.tmc PTRH_conv.tmc HCIengext.tmc
HCIengextoui.c : HCIengextcdf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) HCIengextcdf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
HCIengextoui.o : HCIengextoui.c SWData.h
HCIengext.o : HCIengext.cc SWData.h
doit.dep : HCI.doit
	mkdoit3 -M -o doit  HCI.doit
-include doit.dep
HCIclt.o : HCIcmd.cc
	$(COMPILE.clt) HCIcmd.cc
HCIcltoui.c : $(OUIDIR)/kbdclt.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/kbdclt.oui $(OUIDIR)/msg.oui
HCIcltoui.o : HCIcltoui.c address.h
HCIcltnc.o : HCIcmd.cc
	$(COMPILE.cltnc) HCIcmd.cc
HCIcltncoui.c : $(OUIDIR)/kbdclt.oui $(OUIDIR)/nctable.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/kbdclt.oui $(OUIDIR)/nctable.oui $(OUIDIR)/msg.oui
HCIcltncoui.o : HCIcltncoui.c address.h
SWData.h SWData.tmc SWData_col.tmc SWData.cmd :  HCI.sws
	swscomp -o SWData  HCI.sws
QCLI_C.cmd QCLI_C.out QCLI_C.tmc QCLI_C.m : QCLI_C.qcli
	qclicomp -o QCLI_C.out -c QCLI_C.cmd -d QCLI_C.tmc \
	  -v QCLI_C.log -m QCLI_C.m QCLI_C.qcli || \
	  ( rm -f QCLI_C.out QCLI_C.cmd QCLI_C.tmc QCLI_C.log QCLI_C.m; false )
QCLI_M.cmd QCLI_M.out QCLI_M.tmc QCLI_M.m : QCLI_M.qcli
	qclicomp -o QCLI_M.out -c QCLI_M.cmd -d QCLI_M.tmc \
	  -v QCLI_M.log -m QCLI_M.m QCLI_M.qcli || \
	  ( rm -f QCLI_M.out QCLI_M.cmd QCLI_M.tmc QCLI_M.log QCLI_M.m; false )
QCLI_I.cmd QCLI_I.out QCLI_I.tmc QCLI_I.m : QCLI_I.qcli
	qclicomp -o QCLI_I.out -c QCLI_I.cmd -d QCLI_I.tmc \
	  -v QCLI_I.log -m QCLI_I.m QCLI_I.qcli || \
	  ( rm -f QCLI_I.out QCLI_I.cmd QCLI_I.tmc QCLI_I.log QCLI_I.m; false )

tidy :
	rm -f $(OBJECT)
clean : tidy
	rm -f $(TARGET)
.cvsignore : Makefile
	@for i in $(OBJECT) $(TARGET); do echo "$$i"; done >.cvsignore

COLFLAGS = -H address.h
address.h : HCIcol.cc
HCIeng.cdf : genui.txt
	genui -d ../eng -c genui.txt
