clear variables;close all
%% FOLLOWING TOOLBOXES ARE NECESSARY
% GSW 
% my toolbox (imab)
% m_map
%% INPUT 1
%Desired pressure levels (interpolation)
ipres=800:10:2000;
ctdrdb_path='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\Datenbanken\Downloaded\IFREMER\CTD_for_DMQC_2021V01\';

% Preparing data from reference database
% this step can be run once (it takes a while) and afterwards just call the
%  matfiles 
%  A zip file with the outputs of this function is provided in the
% repository (using the CTD-RDB v2021 and ETOPO2 bathymetry) but the user 
% should repeat this step if they wish to define the basins using another
% reference database (see function interp_basin_NS)or another
% bathymetry database (see function interp_fh_NS).
%prep_interp_data(ctdrdb_path,ipres,1)

load interp_ctdrdb_NS.mat
load interp_fh_NS

 %% INPUT 2
% WMO number
float=3901872 ;
% path for the netcdf file
path_float='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CTD-RDB-DMQC\CTDRD_improved\argo\';
disp(' ')
disp(['*Reading data from float WMO number ' num2str(float) '*'])

% read data
nfile=[path_float '\' num2str(float) '_prof.nc'];
data=get_argomodes_psflags(nfile,1:3);

% disp('...')
% disp(['*Interpolating float data to the desired pressure levels*'])
[data.isalr,data.isalr_flag,data.ipresr_flag]=interpsal_ipres_argo(data.rpres,data.rsal,data.rflag,ipres,data.cycle);
[data.isald,data.isald_flag,data.ipresd_flag]=interpsal_ipres_argo(data.dpres,data.dsal,data.dflag,ipres,data.cycle);
% 
% % sort by time
[B,I] = sort(data.daten);  
data=selstrfields(data,I);
% 
% calculate f/h for classification
data.f_h=interp_fh(data.long,data.lat);
% 
% classify in basins
[gs,ip,lb,nb]=classbasinNS(data);
% 
% plot floats 
figure('color','w','position',[103   42   1151    576])
plot_classfloatprof(data,gs,ip,lb,nb)
% 
%% INPUTS2 for plot
preslevel=1000;
% first year
year=2010;
% 
disp('...')
disp('*Plotting timeseries for each basin*')

% ploat each basin
plot_eachbasinprof(preslevel,year,ipres,data,'r',gs,ip,lb,nb)
plot_eachbasinprof(preslevel,year,ipres,data,'d',gs,ip,lb,nb)