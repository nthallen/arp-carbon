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
run=getrun(1);
D=ne_load('HCIeng_1','HCI_Data_Dir');
Axis=cfg.ScanDir(5);
SSP_Num=eval(['D.SSP_' Axis '_Num']);
save(OFILE,'run')
for s=1:length(suffix)
    data=[]; snum=[]; chisq=[];
    for r=1:length(regions)
        base = ['ICOSout.' regions{r} '.' suffix{s}];
        disp(['Reading ' base ' ...']);
        ICOSsetup
        data=[data;Chi]; snum=[snum;scannum]; chisq=[chisq;chi2];
    end
    disp(['Processing Data ...']);
    if strcmp(remove_OA,'y')
        OFlag=bitand(D.SSP_I_Flags,64);
        iDataFlag=interp1(snum,1:size(data,1),D.SSP_I_Num(OFlag>0),'nearest');
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
            save(OFILE,name,'-append')
        end
end
sspnum=snum;
ftime=interp1(SSP_Num(diff(SSP_Num)>0),D.THCIeng_1(diff(SSP_Num)>0),snum);
time=time2d(ftime);
Lat=interp1(time2d(D.THCIeng_1),D.BP_Lat,time);
Lon=interp1(time2d(D.THCIeng_1),D.BP_Lon,time);
Ht=interp1(time2d(D.THCIeng_1),D.BP_Ht,time);
AirT=interp1(time2d(D.THCIeng_1),D.BAT_FOTemp,time);
AirP=interp1(time2d(D.THCIeng_1),D.BAT_Ps,time);
save(OFILE,'sspnum','ftime','time','Lat','Lon','Ht','AirT','AirP','-append')
disp(['Writing ' OFILE ' ... Done!']);