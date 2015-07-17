function level2datacreate(config_file)
%function level2datacreate(config_file)
%function to process multiple ICOSout directories and do some simple flaging
%of 'bad' data.
%Usage: level2datacreate('level2config')
% Will use the configuration file level2config.m to make a .mat file.
% level2config.m should be stored in the local directory with the ICOSout
% files. 
% Format of level2config.m
%regions={'R1','R2','R3','R4'};
%suffix={'3p1e'};
%OFILE='F130828.1.L2a.mat';
%linen=[1,2];
%remove_OA='y';
%chilimit=1e-5;

eval(config_file);
cfg = load_ICOSfit_cfg;
flight=getrun(1);
D=ne_load('HCIeng_1','HCI_Data_Dir');
D10=ne_load('HCIeng_10','HCI_Data_Dir');
run('calcoeffs.m');
Axis=cfg.ScanDir(5);
SSP_Num=eval(['D.SSP_' Axis '_Num']);
SSP_SN=eval(['D.SSP_' Axis '_SN']);
if strcmp(Axis,'I')
    T1gps=D.THCIeng_1-10/20;
elseif strcmp(Axis,'M')
    T1gps=D.THCIeng_1-10/20;
elseif strcmp(Axis,'C')
    T1gps=D.THCIeng_1-13/20;
end
save(OFILE,'flight')
n=1;
if strcmp(Inst,'MM')
for s=1:length(suffix)
    data=[]; snum=[]; chisq=[]; caldata=[]; 
    for r=1:length(regions)
        base = ['ICOSout.' regions{r} '.' suffix{s}];
        disp(['Reading ' base ' ...']);
        ICOSsetup
        data=[data;Chi]; snum=[snum;scannum]; chisq=[chisq;chi2];
        snumst(r)=scannum(1); snumed(r)=scannum(end);
    end
    %Read in cal regions
     for r=1:length(calregions)
         base = ['ICOSout.' calregions{r} '.' suffix{s}];
         disp(['Reading ' base ' ...']);
         ICOSsetup
         caldata=[caldata;Chi];
     end
     %calculate means
     calmean=mean(caldata);
    %
    disp(['Processing Data ...']);
    if strcmp(remove_OA,'y')
        OFlag=bitand(D.SSP_I_Flags,64);
        iDataFlag=interp1(snum,1:size(data,1),SSP_Num(OFlag>0),'nearest');
        iDataFlag(isnan(iDataFlag)) = [];
        data(iDataFlag,:)=[];
        snum(iDataFlag)=[];
        chisq(iDataFlag)=[];
    end
    data(chisq>chilimit,:)=NaN;
    
        for j = 1:length(linen)
            name2=strtrim(isovals(iso(linen(j)),'text'));
            num=regexp(name2{1},'\d');
            if num(1)==1
                l=find(diff(num)>1);
                name2{1}=[name2{1}(l+1) name2{1}(1:l) name2{1}(l+2:end)];
            end
            name=name2{1};
            if length(find(iso==iso(linen(j))))~=1
                foundline='F';
                k=1;
                letter=char('a'-1);
                while (strcmp(foundline,'F'))
                    if iso(k)==iso(linen(j));
                        letter=char(letter+1);
                    end
                    if nu(k)==nu(linen(j))
                        foundline='T';
                    end
                    k=k+1;
                end
                name=[name2{1} letter];
            end
            ncal=find([cal_coeffs.line]==nu(linen(j)));
            eval([name '=data(:,linen(j)).*cal_coeffs(' num2str(ncal) ').s_m + cal_coeffs(' num2str(ncal) ').s_b/isovals(iso(linen(i)),''abundance'');']);
            eval([name '_cal=calmean(linen(j)).*cal_coeffs(' num2str(ncal) ').s_m + cal_coeffs(' num2str(ncal) ').s_b/isovals(iso(linen(i)),''abundance'');']);
            %save(OFILE,name,'-append')
            names{n}=name;
            n=n+1;
            lines_used(j)=struct('name',name,'nu',nu(linen(j)),'iso',iso(linen(j)));
        end
end
%Read in Tank Data
run('caltanks.m');
tank=eval(tanknum);
for i=1:length(linen)
    molec=cell2mat(strtrim(isovals(floor(iso(linen(i))/10)*10,'text')));
    if ~strcmp('H2O',molec)
    Rs2=isovals(floor(iso(linen(i))/10)*10+2,'abundance')/isovals(floor(iso(linen(i))/10)*10+1,'abundance');
    Rs3=isovals(floor(iso(linen(i))/10)*10+3,'abundance')/isovals(floor(iso(linen(i))/10)*10+1,'abundance');
    Tmr=tank.(molec)(1).value;
    DR2=(tank.(molec)(2).value/1000+1)*Rs2;
    DR3=(tank.(molec)(3).value/1000+1)*Rs3;
    if rem(iso(linen(i)),10)==1
        tankconc=Tmr/(1+DR2+DR3);
    elseif rem(iso(linen(i)),10)==2
        tankconc=Tmr*DR2/(1+DR2+DR3);
    elseif rem(iso(linen(i)),10)==3
        tankconc=Tmr*DR3/(1+DR2+DR3);
    else
        error('Invalid Isotopologue %s. Aborting.',isovals(iso(linen(i),'text')));
    end
    eval([names{i} '_cor_factor=tankconc/(' names{i} '_cal*isovals(iso(linen(i)),''abundance''));']);
    eval([names{i} '=' names{i} '*' names{i} '_cor_factor;']);
    end
end
elseif strcmp(Inst,'CO2')
   names={'CO2','C13O2'};
   CO2=CO2run(:,3);
   C13O2=CO2run(:,4);
   snum=CO2run(:,1);
end

%create evenly spaced 1Hz and 10Hz time vectors
if range(D.GPS_msecs)==0
    T1Hz_ftime=[D.THCIeng_1(100):1:D.THCIeng_1(end)]';
    T10Hz_ftime=[D.THCIeng_1(100):0.1:D.THCIeng_1(end)]';
else
    GPS_msecs=D.GPS_msecs(D.GPS_msecs~=0);
    T1Hz_GPS_msec=[min(GPS_msecs)/1000:1:max(GPS_msecs)/1000]';
    T10Hz_GPS_msec=[min(GPS_msecs)/1000:0.1:max(GPS_msecs)/1000]';
    T1Hz_GPS_week=interp1(GPS_msecs/1000,D.GPS_week(D.GPS_msecs~=0),T1Hz_GPS_msec,'nearest');
    T1Hz_ftime=interp1(GPS_msecs/1000,D.THCIeng_1(D.GPS_msecs~=0)+12/20,T1Hz_GPS_msec);
    T10Hz_ftime=interp1(GPS_msecs/1000,D.THCIeng_1(D.GPS_msecs~=0)+12/20,T10Hz_GPS_msec);
end
sspnum=snum;
disp(['Reading SSP file headers. This may take awhile... '])
hdrs=loadscanhdrs(sspnum);
%Do linear fit for time correction for each region segment
SN=[]; GPS=[];
for i=1:length(snumst)
    ind=find(SSP_Num>snumst(i) & SSP_Num<snumed(i));
    P=polyfit(time2d(T1gps(ind)),SSP_SN(ind),1);
    m=max(SSP_SN(ind)-polyval(P,time2d(T1gps(ind))));
    SNi=round(polyval(P,time2d(T1gps(ind(1)-2)))+m);
    SNii=SNi:56:SSP_SN(ind(end)+2);
    SN=[SN, SNii];
    GPS=[GPS, [0:1:length(SNii)-1]*.1+D.GPS_msecs(ind(1)-2)/1000-12/20];    
end
sntime=interp1(SN,GPS,[hdrs.SerialNum]);

%use correct rate time vector and correct for inlet to cell lag
if strcmp(Axis,'I')
        time=T1Hz_GPS_msec;
        t_offset=t_inlet.(FConfig).ISO;
elseif strcmp(Axis,'C')
        time=T10Hz_GPS_msec;
        t_offset=t_inlet.(FConfig).CO2;
elseif strcmp(Axis,'M')
        time=T10Hz_GPS_msec;
        t_offset=t_inlet.(FConfig).MINI;
end
index=interp1(time,[1:length(time)],sntime-t_offset,'nearest');
for k = 1:length(names)
    temp = time*NaN;
    eval(['temp(index) = ' names{k} ';']);
    eval([names{k} ' = temp;']);
    save(OFILE,names{k},'-append')
end
SSP_NUM=time*NaN;
SSP_NUM(index)=sspnum;
Lat=interp1(D.THCIeng_1-18/20,D.BP_Lat,T1Hz_ftime);
Lon=interp1(D.THCIeng_1-18/20,D.BP_Lon,T1Hz_ftime);
Ht=interp1(D.THCIeng_1-18/20,D.BP_Ht,T1Hz_ftime);
AirT=interp1(D.THCIeng_1-18/20,D.BAT_FOTemp,T1Hz_ftime);
AirP=interp1(D.THCIeng_1-18/20,D.BAT_Ps,T1Hz_ftime);
Alt=interp1(D10.THCIeng_10,D10.MRA_Alt_a,T10Hz_ftime);

save(OFILE,'SSP_NUM','T1Hz_*','T10Hz_*','Lat','Lon','Ht','Alt','AirT','AirP','lines_used','-append')
disp(['Writing ' OFILE ' ... Done!']);