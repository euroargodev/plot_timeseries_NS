function plot_background_NS(lonlims,latlims)
load interp_fh_NS.mat basins data
warning('off','MATLAB:handle_graphics:Patch:NumColorsNotEqualNumVertsOrNumFacesException')
%% colormap (from colorbrewer)
cm=[250,250,250;141,211,199;255,255,179;190,186,218;251,128,114];
cm=cm./255;
%% plot
m_proj('lambert','lat',latlims,'long',lonlims,'rect','on');
hold on
m_contourf(convertlon(data.long,180),data.lat,basins);shading flat
m_etopo2('contour',[-6000:500:-500],'linecolor',5*[0.1 0.1 0.1]);
xt=floor(lonlims(1)/10)*10:5:ceil(lonlims(2)/10)*10;
yt=floor(latlims(1)/10)*10:5:ceil(latlims(2)/10)*10;
m_grid('xtick',xt,'ytick',yt)
caxis([0 4]);colormap(cm);
m_gshhs_i('patch',[.7 .7 .7],'edgecolor','k');
%savefig background_basins.fig