function plot_classfloatprof(data,gs,ip,lb,nb)
% plot 
plot_background_NS
hold on
if isfield(data,'Flat')
   m_plot(data.Flong,data.Flat,'ob','MarkerFaceColor','b','MarkerSize',2)
   m_plot(data.long,data.lat,'ok','MarkerFaceColor','k','MarkerSize',2)
   title('In blue deleted cycles')
   plot_background_NS
   m_plot(data.Flong,data.Flat,'ob','MarkerFaceColor','b','MarkerSize',2)
   m_plot(data.long,data.lat,'ok','MarkerFaceColor','k','MarkerSize',2)
   hold on
end
m_plot(data.long,data.lat,'.k')

hold on
if isempty(gs)==0;m_plot(data.long(gs),data.lat(gs),'ok');end
if isempty(ip)==0;m_plot(data.long(ip),data.lat(ip),'ok');end
if isempty(lb)==0;m_plot(data.long(lb),data.lat(lb),'ok');end
if isempty(nb)==0;m_plot(data.long(nb),data.lat(nb),'ok');end
title({'Classified profiles (encircled) - Deleted in blue ';[' GS (cyan): ' num2str(numel(gs)) ' IS (green): ' num2str(numel(ip)) ...
    ' LB (yellow): ' num2str(numel(lb)) ' NB (orange): ' num2str(numel(nb))]})
