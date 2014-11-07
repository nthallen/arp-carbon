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
Axis=cfg.ScanDir(5);
SSP_Num=eval(['D.SSP_' Axis '_Num']);
SSP_SN=eval(['D.SSP_' Axis '_SN']);
if strcmp(Axis,'I')
    T1gps=D.THCIeng_1-18/20;
elseif strcmp(Axis,'M')
    T1gps=D.THCIeng_1-10/20;
elseif strcmp(Axis,'C')
    T1gps=D.THCIeng_1-13/20;
end
save(OFILE,'flight')
n=1;
for s=1:length(suffix)
    data=[]; snum=[]; chisq=[]; caldata=[]; 
    for r=1:length(regions)
        base = ['ICOSout.' regions{r} '.' suffix{s}];
        disp(['Reading ' base ' ...']);
        ICOSsetup
        data=[data;Chi]; snum=[snum;scannum]; chisq=[chisq;chi2];
    end
    %Read in cal regions
%     for r=1:length(calregions)
%         base = ['ICOSout.' calregions{r} '.' suffix{s}];
%         disp(['Reading ' base ' ...']);
%         ICOSsetup
%         caldata=[caldata;Chi];
%     end
%     %calculate means
%     calmeans=mean(caldata);
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
            if length(find(iso==iso(j)))~=1
                foundline='F';
                k=1;
                letter=char('a'-1);
                while (strcmp(foundline,'F'))
                    if iso(k)==iso(j);
                        letter=char(letter+1);
                    end
                    if nu(k)==nu(j)
                        foundline='T';
                    end
                    k=k+1;
                end
                name=[name2{1} letter];
            end
            eval([name '=data(:,linen(j));']);
            %eval([name '_cal=calmean(j);']);
            %save(OFILE,name,'-append')
            names{n}=name;
            n=n+1;
        end
end
%Read in Tank Data
run('../caltanks.m');
tank=eval(tanknum);
Rs=isovals(62,'abundance')/isovals(61,'abundance');
for i=1:length(linen)
    molec=cell2mat(strtrim(isovals(floor(iso(linen(1))/10)*10,'text')));
    if rem(iso(linen(i)),10)==1
        tankconc=tank.(molec)(1).value/(1+Rs*(tank.(molec)(2).value/1000+1));
    elseif rem(iso(linen(i)),10)==2
        tankconc=tank.(molec)(1).value/(1+Rs*(tank.(molec)(2).value/1000+1));
    elseif rem(iso(linen(i)),10)==3
        tankconc=tank.(molec)(1).value/(1+Rs*(tank.(molec)(2).value/1000+1));
    end
    eval([names{i} '_cor_factor'])=tankconc/(eval([names{i} '_cal'])*isovals(iso(linen(i)),abundance));
    eval([names{i} '=' names{i} '*' names{i} '_cor_factor;'])
end
sspnum=snum;
hdrs=loadscanhdrs(sspnum);
sn=reshape(struct2array(hdrs),9,size(hdrs,2));
lon=find(diff(SSP_SN)~=0 & SSP_Num(2:end) > min(sspnum) & SSP_Num(2:end) < max(sspnum));
sntime=csaps(SSP_SN(lon),T1gps(lon),.05,sn(6,:));
%create evenly spaced 1Hz and 10Hz time vectors
if range(D.GPS_msecs)==0
    T1Hz_ftime=[D.THCIeng_1(100):1:D.THCIeng_1(end)]';
    T10Hz_ftime=[D.THCIeng_1(100):0.1:D.THCIeng_1(end)]';
else
    GPS_msecs=D.GPS_msecs(D.GPS_msecs~=0);
    T1Hz_GPS_msec=[min(GPS_msecs)/1000:1:max(GPS_msecs)/1000]';
    T10Hz_GPS_msec=[min(GPS_msecs)/1000:0.1:max(GPS_msecs)/1000]';
    T1Hz_GPS_week=interp1(GPS_msecs/1000,D.GPS_week(D.GPS_msecs~=0),T1Hz_GPS_msec);
    T1Hz_ftime=interp1(GPS_msecs/1000,D.THCIeng_1(D.GPS_msecs~=0)-18/20,T1Hz_GPS_msec);
    T10Hz_ftime=interp1(GPS_msecs/1000,D.THCIeng_1(D.GPS_msecs~=0)-18/20,T10Hz_GPS_msec);
end
if strcmp(Axis,'I')
        time=T1Hz_ftime;
elseif strcmp(Axis,'C') || strcmp(Axis,'M')
        time=T10Hz_ftime;
end
index=interp1(time,[1:length(time)],sntime,'nearest');
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

save(OFILE,'SSP_NUM','T1Hz_*','T10Hz_*','Lat','Lon','Ht','Alt','AirT','AirP','-append')
disp(['Writing ' OFILE ' ... Done!']);