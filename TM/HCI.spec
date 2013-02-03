tmcbase = /usr/local/share/huarp/freemem.tmc
tmcbase = cpu_usage.tmc
tmcbase = /usr/local/share/huarp/vl_temp.tmc

# Pick one of these two:
tmcbase = /usr/local/share/huarp/ebx11_temp.tmc
# tmcbase = /usr/local/share/huarp/ebx37f_temp.tmc

tmcbase = /usr/local/share/huarp/tmdf.tmc
tmcbase = /usr/local/share/huarp/ptrhm.cc
tmcbase = /usr/local/share/huarp/flttime.tmc
tmcbase = types.tmc
tmcbase = AIO.tmc
tmcbase = Altimeter.tmc
tmcbase = BAT_SPAN.tmc
tmcbase = Inverter.tmc
tmcbase = T30K75KU.tmc
tmcbase = T1M250KU.tmc
tmcbase = VigoT.tmc
tmcbase = digio.tmc
tmcbase = idx64.tmc
tmcbase = Pilot.tmc
tmcbase = pwrmon.tmc
tmcbase = qcli.tmc
tmcbase = PTRH.tmc

cmdbase = /usr/local/share/huarp/root.cmd
cmdbase = /usr/local/share/huarp/getcon.cmd
cmdbase = /usr/local/share/huarp/DACS_AI.cmd
cmdbase = /usr/local/share/huarp/idx64.cmd
cmdbase = /usr/local/share/huarp/qcli.cmd
cmdbase = /usr/local/share/huarp/phrtg.cmd
cmdbase = AO.cmd
cmdbase = BAT_SPAN.cmd
cmdbase = Inverter.cmd
cmdbase = dccc.cmd
cmdbase = qclis.cmd
cmdbase = idx64drv.cmd
cmdbase = subbus.cmd
cmdbase = panel.cmd
cmdbase = address.h

colbase = Altimeter_col.tmc
colbase = AI_col.tmc
colbase = BAT_SPAN_col.tmc
colbase = Inverter_col.tmc
colbase = idx64col.tmc
colbase = PTRH_col.tmc
colbase = qcli_col.tmc
colbase = /usr/local/share/huarp/DACS_ID.tmc

# Pick one of these two:
colbase = /usr/local/share/huarp/vl_temp_col.tmc
# colbase = /usr/local/share/huarp/ebx37f_temp_col.tmc

colbase = /usr/local/share/huarp/tmdf_col.tmc
colbase = /usr/local/share/huarp/ptrhm_col.cc
colbase = cpu_usage_col.tmc
colbase = /usr/local/share/huarp/freemem_col.tmc

swsbase = HCI.sws

qclibase = QCLI_C.qcli QCLI_M.qcli QCLI_I.qcli

TGTDIR = $(TGTNODE)/home/hci
SRC = pwrmon_conv.tmc idx64flag.tmc qcli_conv.tmc
SRC = PTRH_conv.tmc
SCRIPT = idx64.idx64 interact dccc.dccc
SCRIPT = runfile.FF
DISTRIB = ../BAT/BAT_SPAN ../BAT/BS2cdfext ../BAT/BSlogger
DISTRIB = ../Inverter/Inverter
DISTRIB = ../Altimeter/Altimeter
SRCDIST = HCI.sws $(qclibase) Thermistors.txt
SRCDIST = ../BAT/N51AU.txt

HCIcol : -lsubbus
HCIsrvr : -lsubbus
HCIdisp : PTRH_conv.tmc pwrmon_conv.tmc digio_conv.tmc idx64flag.tmc qcli_conv.tmc P_conv.tmc Inverter_conv.tmc hk.tbl qcli.tbl Cells.tbl SSPrtg.tmc /usr/local/share/oui/cic.oui
BSdisp : Pilot_conv.tmc digio_conv.tmc qcli_conv.tmc Inverter_conv.tmc BAT_SPAN.tbl Altimeter_conv.tmc hk2.tbl
HCIalgo : P_conv.tmc qcli_conv.tmc digio_conv.tmc Inverter_conv.tmc Pilot_conv.tmc HCI.tma HCI.sws
HCIengext : qcli_conv.tmc PTRH_conv.tmc P_conv.tmc Altimeter_conv.tmc HCIeng.cdf
doit : HCI.doit

%%

CPPFLAGS += -I ../BAT -I ../Inverter
COLFLAGS = -H address.h
address.h : HCIcol.cc
HCIeng.cdf : genui.txt
	genui -d ../eng -c genui.txt
../BAT/BAT_SPAN ../BAT/BS2cdfext ../BAT/BSlogger :
	cd ../BAT && make
../Inverter/Inverter :
	cd ../Inverter && make
../Altimeter/Altimeter :
	cd ../Altimeter && make
