tmcbase = /usr/local/share/huarp/freemem.tmc
tmcbase = types.tmc
tmcbase = AIO.tmc
tmcbase = T30K75KU.tmc
tmcbase = digio.tmc
tmcbase = idx64.tmc
tmcbase = pwrmon.tmc
tmcbase = qcli.tmc
tmcbase = PTRH.tmc
tmcbase = /usr/local/share/huarp/cpu_usage.tmc
tmcbase = /usr/local/share/huarp/vl_temp.tmc
tmcbase = /usr/local/share/huarp/tmdf.tmc
tmcbase = /usr/local/share/huarp/ptrhm.cc
tmcbase = /usr/local/share/huarp/flttime.tmc

cmdbase = /usr/local/share/huarp/root.cmd
cmdbase = /usr/local/share/huarp/getcon.cmd
cmdbase = /usr/local/share/huarp/DACS_AI.cmd
cmdbase = /usr/local/share/huarp/idx64.cmd
cmdbase = /usr/local/share/huarp/qcli.cmd
cmdbase = /usr/local/share/huarp/phrtg.cmd
cmdbase = AO.cmd
cmdbase = dccc.cmd
cmdbase = qclis.cmd
cmdbase = idx64drv.cmd
cmdbase = subbus.cmd
cmdbase = address.h

colbase = idx64col.tmc
colbase = PTRH_col.tmc
colbase = qcli_col.tmc
colbase = /usr/local/share/huarp/DACS_ID.tmc
colbase = /usr/local/share/huarp/vl_temp_col.tmc
colbase = /usr/local/share/huarp/tmdf_col.tmc
colbase = /usr/local/share/huarp/ptrhm_col.cc
colbase = /usr/local/share/huarp/cpu_usage_col.tmc
colbase = /usr/local/share/huarp/freemem_col.tmc

swsbase = HCI.sws

qclibase = QCLI_C.qcli QCLI_M.qcli QCLI_I.qcli

TGTDIR = $(TGTNODE)/home/hci
SRC = pwrmon_conv.tmc idx64flag.tmc qcli_conv.tmc
SRC = PTRH_conv.tmc
SCRIPT = idx64.idx64 interact dccc.dccc
SCRIPT = runfile.FF

HCIcol : -lsubbus
HCIsrvr : -lsubbus
HCIdisp : PTRH_conv.tmc pwrmon_conv.tmc digio_conv.tmc idx64flag.tmc qcli_conv.tmc hk.tbl qcli.tbl Cells.tbl SSPrtg.tmc /usr/local/share/oui/cic.oui
HCIalgo : HCI.tma HCI.sws
HCIengext : qcli_conv.tmc PTRH_conv.tmc HCIeng.cdf
doit : HCI.doit

%%

COLFLAGS = -H address.h
address.h : HCIcol.cc
HCIeng.cdf : genui.txt
	genui -d ../eng -c genui.txt
