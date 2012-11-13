LDFLAGS=-Wl,-rpath -Wl,/usr/local/lib -L /usr/local/lib
CPPFAGS=-I /usr/local/include
CFLAGS=-Wall -g
CXXFLAGS=-Wall -g
LIBS=-ltmpp -ltm -lnort

.PHONY : all clean

OBJ=Inverter.o Inverteroui.o
Inverter : $(OBJ)
	$(LINK.cc) -o Inverter $(OBJ) $(LIBS)
	usemsg Inverter Inverteroui.c
Inverteroui.c : Inverter.oui
	oui -o Inverteroui.c Inverter.oui
