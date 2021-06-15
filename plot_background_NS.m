function plot_background_NS
load interp_fh_NS.mat basins data

%% plot
latlims=[63 79];
lonlims=[-20 10];
m_proj('lambert','lat',latlims,'long',lonlims,'rect','on');
figure
m_contourf(convertlon(data.long,180),data.lat,basins)
hold on
m_etopo2('contour',[-6000:500:-500],'linecolor',5*[0.1 0.1 0.1]);
m_grid
m_gshhs_i('patch',[.7 .7 .7],'edgecolor','k');
%savefig background_basins.fig