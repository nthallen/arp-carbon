LDFLAGS=-Wl,-rpath -Wl,/usr/local/lib -L /usr/local/lib
CPPFLAGS= -I /usr/local/include
CFLAGS=-Wall -g
CXXFLAGS= -Wall -g
LIBS=-ltmpp -ltm -lnort

.PHONY : all clean
all : BAT_SPAN

BSOBJ : BAT_SPAN.o BAT_SPANoui.o
BAT_SPAN : $(BSOBJ)
	$(LINK.cc) -o BAT_SPAN $(BSOBJ) $(LIBS)
	usemsg BAT_SPAN BAT_SPANoui.c
BAT_SPANoui.c : BAT_SPAN.oui
	oui -o BAT_SPANoui.c BAT_SPAN.oui

clean :
	rm -f *.o BAT_SPANoui.c BAT_SPAN
