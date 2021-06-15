%% PREPARATION
% GSW toolbox
addpath(genpath('\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CodeProjects\matlab_toolboxes\GSW-Matlab-master\'))
% my toolbox
addpath '\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CodeProjects\imab'
clear variables;close all

%% INPUTS 1
%Desired pressure levels (interpolation)
ipres=800:10:2000;
ctdrdb_path='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\Datenbanken\Downloaded\IFREMER\CTD_for_DMQC_2021V01\';
float=6901909;
path_float='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CTD-RDB-DMQC\CTDRD_improved\argo\';

%% Read CTD-RDB and get interpolated values for each basin
%ctdrdb_path='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\Datenbanken\Downloaded\IFREMER\CTD_for_DMQC_2021V01\';
[gs_int,ip_int,lb_int,nb_int]=interp_basin(ctdrdb_path,ipres);
save interp_ctdrdb.mat gs_int ip_int lb_int nb_int
% load interp_ctdrdb.mat

%% Read float 
%float=6901909;
% path for the netcdf file
%path_float='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CTD-RDB-DMQC\CTDRD_improved\argo\';

% read data
nfile=[path_float '\' num2str(float) '_prof.nc'];
data=read_argo(nfile);
[data.itemp,data.isal]=interp_profile_ipres(data.pres,data.temp,data.sal,ipres);

% sort by time
[B,I] = sort(data.daten);  
data=selstrfields(data,I);
% calculate f/h for classification
data.f_h=interp_fh(data.long,data.lat);
% classify in basins
[gs,ip,lb,nb]=classbasinNS(data);


%% INPUTS2 for plot
preslevel=1000;
year=2010;

% select the basin
% change here for gs,ip,lb or nb (rhs)
basindata=ip_int;
floatdata=selstrfields(data,ip);
floatdata.ipres=ipres;

plot_timeseries(preslevel,year,basindata,floatdata)
