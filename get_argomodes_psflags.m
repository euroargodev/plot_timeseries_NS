function data=get_argomodes_psflags(nfile,flagsel)
% INPUT
% NFILE is the float nc file full path/name
% FLAGSEL is a vector containing the allowed flag values
% OUTPUT
% DATA is a structure containing the basic info from argo float
% - metadata (cycle,long,lat, date, modes (as letter *mode and number
% *modenum)
% - origina data (pres,pres_adj and pres_qc, pres_adj,pres_adj_qc, same
% for sal and temp)
% - "edited" data:
% dpres, dtemp and dsal are the profiles in delayed mode
% rpres, rtemp and rsal are the profiles in real or adjusted mode
% all profiles in another mode and all samples with other than the selected 
% flags (FLAGSEL) in pressure and salinity are marked as NaN 
% the combined flags are stored in dflag and rflag (pressure first digit and
% salinity second digit).

% temp flags are not evaluated at all for the edited modes

%%
if nargin<2
   flagsel=1:3;% 1 good data, 2 probably good data, 3 probably bad data
end

%nfile=[pwd '\6901909_prof.nc'];

% Open the Netcdf file:
ncid = netcdf.open(nfile,'NC_NOWRITE');

% Read the data modes
varid = netcdf.inqVarID(ncid,'DATA_MODE');
DATAMODE = netcdf.getVar(ncid,varid)';
% convert the variable in a cell array with the letters and a vector array
% with 2 for Delayed, 1 for Adjusted and 0 for Real time
w=numel(DATAMODE);
DMODE=cell(1,w);DMODE2=nan(1,w);
for i=1:w
    DMODE{1,i}=DATAMODE(i);
    if strcmp(DATAMODE(i),'D')
        DMODE2(1,i)=2;
    elseif strcmp(DATAMODE(i),'A')
        DMODE2(1,i)=1;
    elseif strcmp(DATAMODE(i),'R')
        DMODE2(1,i)=0;
    end
end

% Read profiles time:
% Get the time reference:
varid = netcdf.inqVarID(ncid,'REFERENCE_DATE_TIME');
REFERENCE_DATE_TIME = netcdf.getVar(ncid,varid)';
ref = datenum(str2double(REFERENCE_DATE_TIME(1:4)),...
    str2double(REFERENCE_DATE_TIME(5:6)),...
    str2double(REFERENCE_DATE_TIME(7:8)),...
    str2double(REFERENCE_DATE_TIME(9:10)),...
    str2double(REFERENCE_DATE_TIME(11:12)),...
    str2double(REFERENCE_DATE_TIME(13:14)));
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
varid    = netcdf.inqVarID(ncid,'PRES_ADJUSTED');
pres_adj = netcdf.getVar(ncid,varid,'double');
varid    = netcdf.inqVarID(ncid,'PRES_ADJUSTED_QC');
pres_adj_qc = netcdf.getVar(ncid,varid);


% Read profiles temperature:
varid    = netcdf.inqVarID(ncid,'TEMP');
temp = netcdf.getVar(ncid,varid,'double');
varid    = netcdf.inqVarID(ncid,'TEMP_QC');
temp_qc = netcdf.getVar(ncid,varid);
varid    = netcdf.inqVarID(ncid,'TEMP_ADJUSTED');
temp_adj = netcdf.getVar(ncid,varid,'double');
varid    = netcdf.inqVarID(ncid,'TEMP_ADJUSTED_QC');
temp_adj_qc = netcdf.getVar(ncid,varid);

% Read profiles salinity:
varid    = netcdf.inqVarID(ncid,'PSAL');
sal = netcdf.getVar(ncid,varid,'double');
varid    = netcdf.inqVarID(ncid,'PSAL_QC');
sal_qc = netcdf.getVar(ncid,varid);
varid    = netcdf.inqVarID(ncid,'PSAL_ADJUSTED');
sal_adj = netcdf.getVar(ncid,varid,'double');
varid    = netcdf.inqVarID(ncid,'PSAL_ADJUSTED_QC');
sal_adj_qc = netcdf.getVar(ncid,varid);

% Close the Netcdf file:
netcdf.close(ncid);

% Convert flags to numerical matrix
[h,w]=size(pres);
% preallocates qc flag matrices for unadjusted(1) and adjusted (2) variables
pres_qc1=nan(h,w);temp_qc1=nan(h,w);sal_qc1=nan(h,w);
pres_qc2=nan(h,w);temp_qc2=nan(h,w);sal_qc2=nan(h,w);
for i=1:h
    for j=1:w
        pres_qc1(i,j)=str2double(pres_qc(i,j));
        temp_qc1(i,j)=str2double(temp_qc(i,j));
        sal_qc1(i,j)=str2double(sal_qc(i,j));
        pres_qc2(i,j)=str2double(pres_adj_qc(i,j));
        temp_qc2(i,j)=str2double(temp_adj_qc(i,j));
        sal_qc2(i,j)=str2double(sal_adj_qc(i,j));
    end
end

% Evaluating pressure and salinity flags, which are the relevant ones for
% the interp. salinity timeseries plots
% preallocating
flag_1=zeros(size(pres));% "raw"
flag_2=zeros(size(pres));% adjusted
% find all combination of the flags in the pressure and salinity
for ii=flagsel
    for jj=flagsel
        % create a combined flag value
        fl=str2double([num2str(ii) num2str(jj)]);
        % find the samples w. that flag combination
        ff=find(pres_qc1==ii&sal_qc1==jj);
        if isempty(ff)==0
            flag_1(ff)=fl;%assign the value
        end
        % same for adjusted qflags
        ff=find(pres_qc2==ii&sal_qc2==jj);
        if isempty(ff)==0
        flag_2(ff)=fl;
        end
    end
end
% assign nan to the samples that are nan.
flag_1(isnan(pres_qc1)&isnan(sal_qc1))=NaN;
flag_2(isnan(pres_qc2)&isnan(sal_qc2))=NaN;

% assign nan to all the samples that do not satisfy the flag requirements
pres(flag_1==0)=NaN;pres(isnan(flag_1))=NaN;
temp(flag_1==0)=NaN;temp(isnan(flag_1))=NaN;
sal(flag_1==0)=NaN;sal(isnan(flag_1))=NaN;
% adjusted
pres_adj(flag_2==0)=NaN;pres_adj(isnan(flag_2))=NaN;
temp_adj(flag_2==0)=NaN;temp_adj(isnan(flag_2))=NaN;
sal_adj(flag_2==0)=NaN;sal_adj(isnan(flag_2))=NaN;


% Select data for each mode

% Delayed
dflag=flag_2; % select appropriate flags
d=find(DMODE2<2); % find profiles that are not delayed mode
%assign values and nans to those not corresponding to the data mode
dpres=pres_adj;dpres(:,d)=NaN;
dtemp=temp_adj;dtemp(:,d)=NaN;
dsal=sal_adj;dsal(:,d)=NaN;
% indices of valid profs in this mode
dind=dflag;dind(dflag==0)=NaN;dind=sum(isfinite(dind),1)>0;

% Real time & Adjusted
rflag=flag_1; % select appropriate flags
% assign values
rpres=pres;
rtemp=temp;
rsal=sal;
% replace data with adjusted for the A mode profiles
a=find(DMODE2==1);
rpres(:,a)=pres_adj(:,a);
rtemp(:,a)=temp_adj(:,a);
rsal(:,a)=sal_adj(:,a);
rflag(:,a)=flag_2(:,a);
% indices of valid profs in this mode
rind=rflag;rind(rflag==0)=NaN;rind=sum(isfinite(rind),1)>0;

% store
% metadata
data.cycle=cycle;
data.long=long;
data.lat=lat;
data.daten=daten;
% modes
data.mode=DMODE;
data.modenum=DMODE2;
% edited modes
data.rpres=rpres;data.dpres=dpres;
data.rtemp=rtemp;data.dtemp=dtemp;
data.rsal=rsal;data.dsal=dsal;
data.rflag=rflag;data.dflag=dflag;
% indices of each mode
data.dind=dind;
data.rind=rind;
% origina data
data.pres=pres;data.pres_adj=pres_adj;
data.temp=temp;data.temp_adj=temp_adj;
data.sal=sal;data.sal_adj=sal_adj;
%qc
data.pres_qc=pres_qc;data.pres_adj_qc=pres_adj_qc;
data.temp_qc=temp_qc;data.temp_adj_qc=temp_adj_qc;
data.sal_qc=sal_qc;data.sal_adj_qc=sal_adj_qc;
