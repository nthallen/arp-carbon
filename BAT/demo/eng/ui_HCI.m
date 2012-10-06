function ui_HCI;
f = ne_dialg('Harvard Carbon Isotopes');
f = ne_dialg(f, 'add', 0, 1, 'gHCIspan', 'SPAN' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIspannc', 'NC' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIspann', 'N' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIspancpu', 'CPU' );
f = ne_listdirs(f, 'HCI_Data_Dir', 18);
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'resize');
