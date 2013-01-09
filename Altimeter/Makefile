LDFLAGS=-Wl,-rpath -Wl,/usr/local/lib -L /usr/local/lib
CPPFLAGS=-I /usr/local/include
CFLAGS=-Wall -g
CXXFLAGS=-Wall -g
LIBS=-ltmpp -ltm -lnort

.PHONY : all clean

OBJ=Altimeter.o Altimeteroui.o
Altimeter : $(OBJ)
	$(LINK.cc) -o Altimeter $(OBJ) $(LIBS)
	usemsg Altimeter Altimeteroui.c
Altimeteroui.c : Altimeter.oui
	oui -o Altimeteroui.c Altimeter.oui
