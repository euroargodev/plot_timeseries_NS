function data=read_argo(nfile) 
%nfile=[pwd '\6901909_prof.nc'];

% Open the Netcdf file:
ncid = netcdf.open(nfile,'NC_NOWRITE');

% Read profiles time:
% Get the time reference:
varid = netcdf.inqVarID(ncid,'REFERENCE_DATE_TIME');
REFERENCE_DATE_TIME = netcdf.getVar(ncid,varid)';
ref = datenum(str2num(REFERENCE_DATE_TIME(1:4)),...
    str2num(REFERENCE_DATE_TIME(5:6)),...
    str2num(REFERENCE_DATE_TIME(7:8)),...
    str2num(REFERENCE_DATE_TIME(9:10)),...
    str2num(REFERENCE_DATE_TIME(11:12)),...
    str2num(REFERENCE_DATE_TIME(13:14)));
% then the relative time axis:
varid = netcdf.inqVarID(ncid,'JULD');
JULD  = netcdf.getVar(ncid,varid)';
% and finally the absolute time axis:
daten  = ref + JULD;

% Read profiles latitude:
varid    = netcdf.inqVarID(ncid,'LATITUDE');
lat = netcdf.getVar(ncid,varid,'double')';

% Read profiles longitude:
varid    = netcdf.inqVarID(ncid,'LONGITUDE');
long = netcdf.getVar(ncid,varid,'double')';

% Read profiles cycle:
varid    = netcdf.inqVarID(ncid,'CYCLE_NUMBER');
cycle = netcdf.getVar(ncid,varid,'double');

% Read profiles pressure:
varid    = netcdf.inqVarID(ncid,'PRES');
pres = netcdf.getVar(ncid,varid,'double');
varid    = netcdf.inqVarID(ncid,'PRES_QC');
pres_qc = netcdf.getVar(ncid,varid);

% Read profiles temperature:
varid    = netcdf.inqVarID(ncid,'TEMP');
temp = netcdf.getVar(ncid,varid,'double');
varid    = netcdf.inqVarID(ncid,'TEMP_QC');
temp_qc = netcdf.getVar(ncid,varid);

% Read profiles salinity:
varid    = netcdf.inqVarID(ncid,'PSAL');
sal = netcdf.getVar(ncid,varid,'double');
varid    = netcdf.inqVarID(ncid,'PSAL_QC');
sal_qc = netcdf.getVar(ncid,varid);

% Close the Netcdf file:
netcdf.close(ncid);

% Convert flags to matrix
[h,w]=size(pres);
for i=1:h
    for j=1:w
        pres_qc1(i,j)=str2double(pres_qc(i,j));
        temp_qc1(i,j)=str2double(temp_qc(i,j));
        sal_qc1(i,j)=str2double(sal_qc(i,j));
    end
end
flag=max(cat(3,pres_qc1,temp_qc1,sal_qc1),[],3)==1;
flag=flag==0;

pres(flag)=NaN;
temp(flag)=NaN;
sal(flag)=NaN;

%invalid profiles (bad quality)
f=find(min(flag,[],1)==1);
if isempty(f)==0
    disp([num2str(numel(f)) ' cycles will be excluded because do not satisfy'...
        ' the QF requirements (QF for pres, temp and/or sal for is lager than 1 in all samples ' ])
    % store full
    data.Fcycle=cycle;
    data.Flong=long;
    data.Flat=lat;
    data.Fdaten=daten;
    data.Fpres=pres;
    data.Ftemp=temp;
    data.Fsal=sal;
    % delete
    cycle(f)=[];
    long(f)=[];
    lat(f)=[];
    daten(f)=[];
    pres(:,f)=[];
    temp(:,f)=[];
    sal(:,f)=[];
end

data.cycle=cycle;
data.long=long;
data.lat=lat;
data.daten=daten;
data.pres=pres;
data.temp=temp;
data.sal=sal;