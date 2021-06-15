function plot_timeseries(preslevel,year,basin,float)
year=10000000000*year;

basin.daten=dates2daten(basin.dates);
pr=find(basin.ipres==preslevel);
f=find(basin.dates>year);
figure
plot(basin.daten(f),basin.isal(pr,f),'.','MarkerSize',14)
hold on


float.dates=daten2dates(float.daten);

pr=find(float.ipres==preslevel);
f=find(float.dates>year);
plot(float.daten(f),float.isal(pr,f),'.','MarkerSize',14)

grid on
datetick('x','yyyy','keeplimits')
legend('Basin','Float','Location','northoutside','Orientation','horizontal')	
xx=xlim;yy=ylim;
set(findall(gcf,'-property','FontSize'),'FontSize',12)