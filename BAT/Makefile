LDFLAGS=-Wl,-rpath -Wl,/usr/local/lib -L /usr/local/lib \
 -Wl,-rpath -Wl,/usr/pkg/lib -L /usr/pkg/lib
CPPFLAGS= -I /usr/local/include -I /usr/pkg/include
CFLAGS=-Wall -g
CXXFLAGS= -Wall -g
LIBS=-ltmpp -ltm -lnort
RECLIBS=-lnort

.PHONY : all clean
all : BAT_SPAN BSlogger BS2cdfext

BSOBJ = BAT_SPAN.o BAT_SPANoui.o
BAT_SPAN : $(BSOBJ)
	$(LINK.cc) -o BAT_SPAN $(BSOBJ) $(LIBS)
	usemsg BAT_SPAN BAT_SPANoui.c
BAT_SPANoui.c : BAT_SPAN.oui
	oui -o BAT_SPANoui.c BAT_SPAN.oui

BSLOBJ = BSlogger.o BSloggeroui.o
BSlogger : $(BSLOBJ)
	$(LINK.cc) -o BSlogger $(BSLOBJ) $(LIBS)
	usemsg BSlogger BSloggeroui.c
BSloggeroui.c : BSlogger.oui
	oui -o BSloggeroui.c BSlogger.oui

BSCOBJ = BS2cdf.o BS2cdfoui.o
BS2cdfext : $(BSCOBJ)
	$(LINK.cc) -o BS2cdfext $(BSCOBJ) $(LIBS) -lnetcdf
	usemsg BS2cdfext BS2cdfoui.c
BS2cdfoui.c : BS2cdf.oui
	oui -o BS2cdfoui.c BS2cdf.oui

BS_recovery : BS_recovery.o
	$(LINK.cc) -o BS_recovery BS_recovery.o $(RECLIBS)

BS_rewrite : BS_rewrite.o
	$(LINK.cc) -o BS_rewrite BS_rewrite.o $(RECLIBS)

clean :
	rm -f *.o BAT_SPANoui.c BAT_SPAN BSloggeroui.c BSlogger BS2cdfext BS2cdfoui.c
