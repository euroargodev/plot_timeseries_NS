clear variables;close all

%% PREPARATION
% GSW toolbox
addpath(genpath('\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CodeProjects\matlab_toolboxes\GSW-Matlab-master\'))
% my toolbox
addpath '\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CodeProjects\imab'
% m_map
addpath '\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CodeProjects\matlab_toolboxes\m_map'

%% INPUT 1
%Desired pressure levels (interpolation)
ipres=800:10:2000;
ctdrdb_path='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\Datenbanken\Downloaded\IFREMER\CTD_for_DMQC_2021V01\';
%% Preparing data from reference database
%this step can be run once (it takes a while) and afterwards just call the
%matfiles
%plot_timeseries_prep(ipres,ctdrdb_path)

load interp_ctdrdb.mat
load interp_fh_NS

 % %% INPUT 2
% % WMO number
% float=6901909;
% % path for the netcdf file
% path_float='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CTD-RDB-DMQC\CTDRD_improved\argo\';
% 
% % read data
% nfile=[path_float '\' num2str(float) '_prof.nc'];
% data=read_argo(nfile);
% [data.itemp,data.isal]=interp_profile_ipres(data.pres,data.temp,data.sal,ipres);
% 
% % sort by time
% [B,I] = sort(data.daten);  
% data=selstrfields(data,I);
% % calculate f/h for classification
% data.f_h=interp_fh(data.long,data.lat);
% % classify in basins
% [gs,ip,lb,nb]=classbasinNS(data);
% 
% 
% % %% INPUTS2 for plot
% % preslevel=1000;
% % year=2010;
% % 
% % % select the basin
% % % change here for gs,ip,lb or nb (rhs)
% % basindata=ip_int;
% % floatdata=selstrfields(data,ip);
% % floatdata.ipres=ipres;
% % 
% % plot_timeseries(preslevel,year,basindata,floatdata)
