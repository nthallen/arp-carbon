tmcbase = types.tmc
tmcbase = AIO.tmc
tmcbase = digio.tmc
tmcbase = idx64.tmc
tmcbase = pwrmon.tmc
tmcbase = qcli.tmc
tmcbase = PTRH.tmc
tmcbase = /usr/local/share/huarp/vl_temp.tmc
tmcbase = /usr/local/share/huarp/tmdf.tmc

cmdbase = /usr/local/share/huarp/root.cmd
cmdbase = /usr/local/share/huarp/getcon.cmd
cmdbase = /usr/local/share/huarp/DACS_AI.cmd
cmdbase = /usr/local/share/huarp/idx64.cmd
cmdbase = idx64drv.cmd

colbase = idx64col.tmc
colbase = PTRH_col.tmc
colbase = /usr/local/share/huarp/DACS_ID.tmc
colbase = /usr/local/share/huarp/vl_temp_col.tmc
colbase = /usr/local/share/huarp/tmdf_col.tmc

swsbase = HCI.sws

qclibase = QCLI_C.qcli QCLI_M.qcli QCLI_I.qcli

SRC = pwrmon_conv.tmc idx64flag.tmc qcli_conv.tmc
SRC = PTRH_conv.tmc
SCRIPT = idx64.idx64

HCIcol : -lsubbus
HCIsrvr : -lsubbus
HCIalgo : HCI.tma HCI.sws
