function plot_classfloatprof(data,gs,ip,lb,nb)
% plot all NS
subplot(1,2,1)
latlims=[63 79];
lonlims=[-20 10];
plot_background_NS(lonlims,latlims)
hold on
% plot all
m_plot(data.long,data.lat,'.-k')
% plot mode
m_plot(data.long(data.modenum==2),data.lat(data.modenum==2),'o',...
    'MarkerFaceColor',[0 0.45 0.74],'MarkerEdgeColor',[0 0.45 0.74],'MarkerSize',2)% dmode blue
m_plot(data.long(data.modenum<2),data.lat(data.modenum<2),'o',...
    'MarkerFaceColor',[0.85 0.33 0.10],'MarkerEdgeColor',[0.85 0.33 0.10],'MarkerSize',2) % rmode red

title({'Prof. modes: red - available only in R or A mode';...
    'blue - available in D mode. Prof. in each basin: ';...
['GS (green)-' num2str(numel(gs)) ' IS (yellow)-' num2str(numel(ip)) ...
     ' LB (lillac)-' num2str(numel(lb)) ' NB (orange)-' num2str(numel(nb))]})

 
subplot(1,2,2)
lonlims=[min(data.long)-0.5 max(data.long)+0.5];
latlims=[min(data.lat)-0.5 max(data.lat)+0.5];
plot_background_NS(lonlims,latlims)
% plot prof avaliability (flag)
% plot rmode 
m_plot(data.long(data.rind),data.lat(data.rind),'o',...
    'MarkerFaceColor',[0.85 0.33 0.10],'MarkerEdgeColor','k','MarkerSize',4) % rmode red
% plot dmode
m_plot(data.long(data.dind),data.lat(data.dind),'o',...
    'MarkerFaceColor',[0 0.45 0.74],'MarkerEdgeColor','k','MarkerSize',4)% dmode blue

hold on
if isempty(gs)==0;m_plot(data.long(gs),data.lat(gs),'.k','MarkerSize',4);end
if isempty(ip)==0;m_plot(data.long(ip),data.lat(ip),'.k','MarkerSize',4);end
if isempty(lb)==0;m_plot(data.long(lb),data.lat(lb),'.k','MarkerSize',4);end
if isempty(nb)==0;m_plot(data.long(nb),data.lat(nb),'.k','MarkerSize',4);end

title({'Prof. availability with selected flags: red - only in R or A mode';...
    'blue - in D mode. Prof. inside a basin: dot inside';})



