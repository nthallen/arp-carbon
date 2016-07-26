function mat2nc(filename,BAT_filename)
%Program to turn final FOCAL data files (L2b) into netcdf format. 
%Usage: mat2nc('filename')
%eg. >> mat2nc('F130813.2.L2b.mat')

D=load(filename);

FS.Name='/';
FS.Format='netcdf4_classic';
FS.Dimensions(1).Name = 'time1Hz';
FS.Dimensions(1).Length = length(D.T1Hz_GPS_msec);
FS.Dimensions(1).Unlimited = false;
FS.Dimensions(2).Name = 'time10Hz';
FS.Dimensions(2).Length = length(D.T10Hz_GPS_msec);
FS.Dimensions(2).Unlimited = false;
%FS.Dimensions(3).Name = 'time50Hz';
%FS.Dimensions(3).Length = length(D.T10Hz_GPS_msec)*5;
FS.Attributes(1).Name = 'Flight Date (yymmdd)';
FS.Attributes(1).Value = D.date(1:6);
FS.Attributes(2).Name = 'Instrument_Name';
FS.Attributes(2).Value = 'FOCAL';
FS.Attributes(3).Name = 'FileCreationDate';
FS.Attributes(3).Value = datestr(today);
%var name, dimension, unit, scale, add_offset, long_name, size
var=[{'Time1Hz'},{1},{'seconds'},{1},{0},{'1 Hz time vector - NovAtel SPAN GPS/INS time (sec since midnight Sat GMT)'}
    {'Time10Hz'},{2},{'seconds'},{1},{0},{'10 Hz time vector - NovAtel SPAN GPS/INS time (sec since midnight Sat GMT)'}
%    {'Time50Hz'},{3},{'seconds'}
    {'d13CH4'},{1},{'permil'},{1},{0},{'delta C-13 methane ratio'}
    {'d13CO2'},{2},{'permil'},{1},{0},{'delta C-13 carbon dioxide ratio'}
    {'CH4'},{2},{'ppv'},{1},{0},{'Dry Methane mixing ratio'}
    {'CO2'},{2},{'ppv'},{1},{0},{'Dry Carbon Dioxide mixing ratio'}
    {'H2O'},{2},{'ppv'},{1},{0},{'Dry Water Vapor mixing ratio'}
    {'N2O'},{2},{'ppv'},{1},{0},{'Dry Nitrous Oxide mixing ratio'}
%    {'GPSLat'},{1},{'degrees'}
%    {'GPSLon'},{1},{'degrees'}
%    {'GPSHt'},{1},{'meters'}
    {'Altimeter'},{2},{'meters'},{1},{0},{'Radar Altimeter Height Above Ground'}
%    {'AirP'},{1},{'mb'}
%    {'AirT'},{1},{'K'}
%    {'u'},{3},{'m/s'}
%    {'v'},{3},{'m/s'}
%    {'w'},{3},{'m/s'}
    ];

for i=1:size(var,1)
    FS.Variables(i).Name = var{i,1};
    FS.Variables(i).Dimensions = FS.Dimensions(var{i,2});
    FS.Variables(i).Size = FS.Dimensions(var{i,2}).Length;
    FS.Variables(i).Datatype = 'double';
    FS.Variables(i).Attributes(1).Name = 'unit';
    FS.Variables(i).Attributes(1).Value = var{i,3};
    FS.Variables(i).Attributes(2).Name= 'scale_factor';
    FS.Variables(i).Attributes(2).Value = var{i,4};
    FS.Variables(i).Attributes(3).Name= 'add_offset';
    FS.Variables(i).Attributes(3).Value = var{i,5};
    FS.Variables(i).Attributes(4).Name= 'long_name';
    FS.Variables(i).Attributes(4).Value = var{i,6};
    FS.Variables(i).ChunkSize = [];
    FS.Variables(i).FillValue = -999;
    FS.Variables(i).DeflateLevel = [];
    FS.Variables(i).Shuffle = false;
end

FSDi=length(FS.Dimensions); % current number of dimensions
FSVi=length(FS.Variables); % current number of variables
if nargin==2 && ~isempty(BAT_filename)
    BAT=ncinfo(BAT_filename);
    for i=1:length(BAT.Dimensions)
        FS.Dimensions(FSDi+i).Name = BAT.Dimensions(i).Name;
        FS.Dimensions(FSDi+i).Length = BAT.Dimensions(i).Length;
        FS.Dimensions(FSDi+i).Unlimited = BAT.Dimensions(i).Unlimited;
    end
    for i=1:length(BAT.Variables)
        FS.Variables(FSVi+i)=BAT.Variables(i);
        %FS.Variables(FSVi+i).FillValue=-999;
    end
end

OFILE=[filename(1:end-3) 'nc'];
ncwriteschema(OFILE, FS);

ncwrite(OFILE,'Time1Hz',D.T1Hz_GPS_msec)
ncwrite(OFILE,'Time10Hz',D.T10Hz_GPS_msec)
try ncwrite(OFILE,'d13CH4',D.d13CH4); catch; end
try ncwrite(OFILE,'d13CO2',D.d13CH4); catch; end
ncwrite(OFILE,'CH4',D.TCH4dry)
try ncwrite(OFILE,'CO2',D.TCO2dry); catch; end
ncwrite(OFILE,'H2O',D.H2Odry)
try ncwrite(OFILE,'N2O',D.N2Odry); catch; end
% ncwrite(OFILE,'AirP',D.AirP)
% ncwrite(OFILE,'AirT',D.AirT)
ncwrite(OFILE,'Altimeter',D.Alt)
% ncwrite(OFILE,'GPSLat',D.Lat)
% ncwrite(OFILE,'GPSLon',D.Lon)
% ncwrite(OFILE,'GPSHt',D.Ht)
if nargin==2 && ~isempty(BAT_filename)
   for i = 1:length(BAT.Variables)
       vardata=ncread(BAT_filename,BAT.Variables(i).Name);
       ncwrite(OFILE,BAT.Variables(i).Name,vardata);
   end
end

