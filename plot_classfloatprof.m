function plot_classfloatprof(data,gs,ip,lb,nb)
% plot 
plot_background_NS
hold on
if isfield(data,'Flat')
   m_plot(data.Flong,data.Flat,'.k')
   m_plot(data.long,data.lat,'.r')
   title('In black deleted cycles')
   plot_background_NS
   m_plot(data.Flong,data.Flat,'.k')
   m_plot(data.long,data.lat,'.r')
   hold on
end
m_plot(data.long,data.lat,'.r')

hold on
if isempty(gs)==0;m_plot(data.long(gs),data.lat(gs),'*k');end
if isempty(ip)==0;m_plot(data.long(ip),data.lat(ip),'*b');end
if isempty(lb)==0;m_plot(data.long(lb),data.lat(lb),'*g');end
if isempty(nb)==0;m_plot(data.long(nb),data.lat(nb),'*m');end
title('Classified profiles')
