function plot_background_NS
load interp_fh_NS.mat basins data

%% plot
latlims=[63 79];
lonlims=[-20 10];
m_proj('lambert','lat',latlims,'long',lonlims,'rect','on');
figure('color','w')
m_gshhs_i('patch',[.7 .7 .7],'edgecolor','k');
hold on
m_contourf(convertlon(data.long,180),data.lat,basins)
m_etopo2('contour',[-6000:500:-500],'linecolor',5*[0.1 0.1 0.1]);
m_grid('xtick',[-10:10:20],'ytick',[60:5:80])
caxis([0 4]);colormap(jet(5))
%savefig background_basins.fig