tmcbase = types.tmc
tmcbase = /usr/local/share/huarp/tmdf.tmc
tmcbase = /usr/local/share/huarp/cpu_usage.tmc
tmcbase = /usr/local/share/huarp/freemem.tmc
tmcbase = /usr/local/share/huarp/flttime.tmc
tmcbase = base.tmc
tmcbase = BAT_SPAN.tmc

cmdbase = /usr/local/share/huarp/root.cmd
cmdbase = /usr/local/share/huarp/getcon.cmd
cmdbase = BAT_SPAN.cmd

colbase = /usr/local/share/huarp/tmdf_col.tmc
colbase = /usr/local/share/huarp/cpu_usage_col.tmc
colbase = /usr/local/share/huarp/freemem_col.tmc

swsbase = demo.sws

SCRIPT = interact
TGTDIR = $(TGTNODE)/home/BATdemo
OBJ = SWData.cmd SWData.h SWData.tmc SWData_col.tmc
DISTRIB = ../BAT_SPAN ../BSlogger ../BS2cdfext

demodisp : demo.tbl
demoalgo : demo.tma demo.sws
BATdemoengext : BATdemoeng.cdf
doit : demo.doit
%%
CPPFLAGS += -I ..
BATdemoeng.cdf : genui.txt
	genui -d eng -c genui.txt
