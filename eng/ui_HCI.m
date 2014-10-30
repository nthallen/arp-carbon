function ui_HCI
f = ne_dialg('Harvard Carbon Isotopes',1);
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'newtab', 'CO2');
f = ne_dialg(f, 'add', 0, 1, 'gHCIcococ', 'CO2 Cell' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcococp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcococt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcococt_ctrl', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcococs', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIcococlpv', 'CO2 CLPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcococlpvp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcococlpvt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcococlpvt_ctrl', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcococlpvrh', 'RH' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIcocol', 'CO2 Laser' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocolc', 'Current' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocolt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocolt_ctrl', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocols', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocolp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocolrh', 'RH' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIcocod', 'CO2 Detector' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocodt', 'Temp' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIcocop', 'CO2 Pump' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocopt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocops', 'Status' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIcocoqcli', 'CO2 QCLI' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocoqcliw', 'Wave' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocoqclififo', 'FIFO' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocoqclis', 'Stale' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIco2_co2_qcli_status', 'CO2 QCLI Status' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIco2_co2_qcli_statuss', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIcocossp', 'CO2 SSP' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocosspo', 'Overflow' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocosspf', 'Files' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocossps', 'Scans' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocosspskipped', 'Skipped' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocosspw', 'Wave' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocosspstatus', 'Status' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIcocot', 'CO2 Temps' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocotssp', 'SSP' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocotr', 'Roving' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocots', 'Sample' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIcocotskin', 'Skin' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'newtab', 'MINI');
f = ne_dialg(f, 'add', 0, 1, 'gHCIminiminic', 'MINI Cell' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminicp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminict', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminict_ctrl', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminics', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIminiminid', 'MINI Detector' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminidt', 'Temp' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIminiminimdpv', 'MINI MDPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimdpvt', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimdpvtemp', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimdpvp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimdpvrh', 'RH' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimdpvs', 'Status' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIminiminimlpv', 'MINI MLPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimlpvt', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimlpvtemp', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimlpvp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimlpvrh', 'RH' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminimlpvs', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIminiminil', 'MINI Laser' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminilc', 'Current' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminilt', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminiltemp', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminilp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminilrh', 'RH' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminils', 'Status' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIminiminip', 'MINI Pump' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminipt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminips', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIminiminiqcli', 'MINI QCLI' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminiqcliw', 'Wave' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminiqclififo', 'FIFO' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminiqclis', 'Stale' );
f = ne_dialg(f, 'add', 0, 1, 'gHCImini_mini_qcli_status', 'MINI QCLI Status' );
f = ne_dialg(f, 'add', 1, 0, 'pHCImini_mini_qcli_statuss', 'Status' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIminiminissp', 'MINI SSP' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminisspo', 'Overflow' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminisspf', 'Files' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminissps', 'Scans' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminisspskipped', 'Skipped' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminisspw', 'Wave' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminisspstatus', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIminiminit', 'MINI Temps' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminitsspt', 'SSP Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminitr', 'Roving' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminits', 'Sample' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIminiminitskin', 'Skin' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'newtab', 'HK');
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkgd', 'GD' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkgdp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkgdt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkgdf', 'Flow' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkgds', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkdacs', 'DACS' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkdacsp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkdacst', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkdacsrh', 'RH' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkdacss', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkhk', 'HK' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkhkcpu', 'CPU' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkhkd', 'Disk' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkhkm', 'Memory' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkhksws', 'SW Stat' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkp', 'Power' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkpv', 'Voltage' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkpc', 'Current' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkps', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkptrh', 'PTRH' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkptrhclpv', 'CLPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkptrhcqcl', 'CQCL' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkptrhdacs', 'DACS' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkptrhidpv', 'IDPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkptrhilpv', 'ILPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkptrhiqcl', 'IQCL' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkptrhmdpv', 'MDPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkptrhmlpv', 'MLPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkptrhmqcl', 'MQCL' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIhksh', 'Sample Ht' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhksht', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkshs', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhk_spaceht', 'Space Ht' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhk_spacehtt', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhk_spacehts', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhk_spacehtc', 'Camera' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkt', 'Throttle' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkts', 'Step' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhktp', 'Pot' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhktscan', 'Scan' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhktstatus', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkc', 'Cal' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkcs', 'Solenoids' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkl', 'Lab' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkls', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhk_coolant', 'Coolant' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhk_coolantt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhk_coolantp', 'Pressure' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhk_coolants', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhki', 'Inverter' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkiv', 'Vin' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkil', 'Load' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkis', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkiq', 'Qury' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkistale', 'Stale' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkpp', 'Pilot Panel' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkpps', 'Status' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkspare', 'SPARE' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkspareai', 'AI' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkh', 'Hart' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkhr', 'R' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkhs', 'Stale' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIhkb', 'Bubbler' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkbt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkbp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIhkbf', 'Flow' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'newtab', 'ISO');
f = ne_dialg(f, 'add', 0, 1, 'gHCIisoisoc', 'ISO Cell' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisocp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoct', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoctemp', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisocs', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIisoisod', 'ISO Detector' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisodt', 'Temp' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIisoisodpv', 'ISO DPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisodpvt', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisodpvtemp', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisodpvp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisodpvrh', 'RH' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisodpvs', 'Status' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIisoisoilpv', 'ISO ILPV' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoilpvt', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoilpvtemp', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoilpvp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoilpvrh', 'RH' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoilpvs', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIisoisol', 'ISO Laser' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisolc', 'Current' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisolt', 'T ctrl' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoltemp', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisolp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisolrh', 'RH' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisols', 'Status' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIisoisoqcli', 'ISO QCLI' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoqclififo', 'FIFO' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoqcliw', 'Wave' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoqclis', 'Stale' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisoqclistatus', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIisoisossp', 'ISO SSP' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisosspt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisosspf', 'Files' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisosspo', 'Overflow' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisossps', 'Scans' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisosspskipped', 'Skipped' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisosspstatus', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisoisosspstale', 'Stale' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIisot', 'Temps' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisotr', 'Roving' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIisots', 'Sample' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'newtab', 'BAT SPAN');
f = ne_dialg(f, 'add', 0, 1, 'gHCIbatspanspan', 'SPAN' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanl', 'Lat' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanlon', 'Lon' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanh', 'Ht' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspannv', 'N Vel' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanev', 'E Vel' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanuv', 'Up Vel' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspana', 'Attitude' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIbatspanspanhk', 'SPAN HK' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanhkmsecs', 'msecs' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanhkweek', 'week' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanhksecs', 'secs' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanhkinss', 'INS Status' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanhknr', 'N Recs' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanhkstale', 'stale' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanhki', 'Idle' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanspanhkts', 'T Stat' );
f = ne_dialg(f, 'add', 0, 1, 'gHCIbatspanbat', 'BAT' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbatp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbata', 'A' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbatt', 'T' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbatpump', 'Pump' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbatpower', 'Power' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIbatspanbp', 'Best Pos' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbprxs', 'RX Stat' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbpss', 'Soln Stat' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbppt', 'Pos Type' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbpdid', 'Datum ID' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbpundulation', 'undulation' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbpls', 'Lat Std' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbplonstd', 'Lon Std' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbphs', 'Ht Std' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbpa', 'Age' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbpn', 'N' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbpess', 'ES Stat' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanbpsm', 'Sig Mask' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gHCIbatspana', 'Altimeter' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanah', 'Ht' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanas', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pHCIbatspanastale', 'Stale' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'newtab', 'Runs');
f = ne_listdirs(f, 'HCI_Data_Dir', 11);
f = ne_dialg(f, 'newcol');
ne_dialg(f, 'resize');
