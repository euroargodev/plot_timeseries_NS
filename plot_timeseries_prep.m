function plot_timeseries_prep(ipres,ctdrdb_path)
% INPUTS 
% ipres: desired pressure levels (interpolation)
% ctdrdpath: path to the reference database
if nargin==0
    ipres=800:10:2000;
    ctdrdb_path='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\Datenbanken\Downloaded\IFREMER\CTD_for_DMQC_2021V01\';
end

% Interpolate the f_h parameter for the entire basin
% this uses the ETOPO2 database that must be installed (m_etopo2).
[data,gs,ip,lb,nb]= interp_fh_NS;
save interp_fh_NS.mat data gs ip lb nb

%% Read CTD-RDB and get interpolated values for each basin
%ctdrdb_path='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\Datenbanken\Downloaded\IFREMER\CTD_for_DMQC_2021V01\';
[gs_int,ip_int,lb_int,nb_int]=interp_basin_NS(ctdrdb_path,ipres);
save interp_ctdrdb_NS.mat gs_int ip_int lb_int nb_int

%% plot
latlims=[63 79];
lonlims=[-20 10];
m_proj('lambert','lat',latlims,'long',lonlims,'rect','on');
figure
m_plot(convertlon(ip_int.long,180),ip_int.lat,'.')
hold on
m_plot(convertlon(nb_int.long,180),nb_int.lat,'.')
m_plot(convertlon(lb_int.long,180),lb_int.lat,'.')
m_plot(convertlon(gs_int.long,180),gs_int.lat,'.')
m_etopo2('contour',[-6000:500:-500],'linecolor',5*[0.1 0.1 0.1]);
m_grid
m_gshhs_h('patch',[.7 .7 .7],'edgecolor','k');
%addpath '\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\CodeProjects\matlab_toolboxes\export_fig'
%export_fig -r300 ctd-rdb_prof_basins.png
