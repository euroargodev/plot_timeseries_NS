function prep_interp_data(ctdrdb_path,ipres,pl)
% This function is a preparation step for the generation of the plots that
% uses the functions interp_fh_NS and interp_basin_NS
% A zip file with the outputs of this function is provided in the
% repository (using the CTD-RDB v2021 and ETOPO2 bathymetry) but the user 
% should repeat this step if they wish to define the basins using another
% reference database (see function interp_basin_NS)or another
% bathymetry database (see function interp_fh_NS).

% INPUTS 
% IPRES: desired pressure levels for interpolation of the reference 
% database profiles interpolation
% CTDRDB_PATH: path to the CTD reference database for argo dmqc
% PL (optional): write 1 if you want to save the plot (as png) showing the classification
% of the reference profiles into the basins 

% OUTPUT
% It saves the following mat files
% interp_fh_NS.mat with the outputs of the function interp_fh_NS
% interp_ctdrdb_NS.mat with the ouputs of interp_basin_NS that interpolates
% the profiles in the CTD reference database for DMQC 
% and optionally a figure (ctd-rdb_prof_basins.png)
%%
if nargin==0    
    ctdrdb_path=input('Please provide the full path for the CTD-RDB for Argo DMQC =');
    ipres=800:50:2000;
    disp('Using the default pressure levels from 800 to 2000db with 50db resolution') 
    pl=1;
elseif nargin==1
    ipres=800:50:2000;
    disp('Using the default pressure levels from 800 to 2000db with 50db resolution')
    pl=1;
elseif nargin==2
    pl=1;
end

% Interpolate the f_h parameter for the entire basin
% this uses the ETOPO2 database that must be installed (m_etopo2).
[data,gs,ip,lb,nb,basins]= interp_fh_NS;
save interp_fh_NS.mat data gs ip lb nb basins

%% Read CTD-RDB and get interpolated values for each basin
[gs_int,ip_int,lb_int,nb_int]=interp_basin_NS(ctdrdb_path,ipres);
save interp_ctdrdb_NS.mat gs_int ip_int lb_int nb_int

%% plot
latlims=[63 79];
lonlims=[-20 10];
m_proj('lambert','lat',latlims,'long',lonlims,'rect','on');
figure('color','w')
m_plot(convertlon(ip_int.long,180),ip_int.lat,'.')
hold on
m_plot(convertlon(nb_int.long,180),nb_int.lat,'.')
m_plot(convertlon(lb_int.long,180),lb_int.lat,'.')
m_plot(convertlon(gs_int.long,180),gs_int.lat,'.')
m_etopo2('contour',-6000:500:-500,'linecolor',5*[0.1 0.1 0.1]);
m_grid
m_gshhs_h('patch',[.7 .7 .7],'edgecolor','k');
if pl==1       
    exportgraphics(gcf,'ctd-rdb_prof_basins.png','Resolution',300)
end
