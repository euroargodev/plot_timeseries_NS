function plot_timeseries(preslevel,year,basin,float,basin_name)
year=10000000000*year;

basin.daten=dates2daten(basin.dates);
pr=find(basin.ipres==preslevel);
f=find(basin.dates>year);
%check number of points available
ni=isnan(basin.isal(pr,f));ni=find(ni==1);
if numel(ni)>0
    disp('')
    disp([ basin_name ' basin (from '...
        ' year ' num2str(year/10000000000) ' on):'])
    disp(['Total of ' num2str(numel(f)) ' CTD reference profiles in the basin.'])
    disp(['From those ' num2str(numel(ni)) ' are NaN for the selected presure level  (' num2str(preslevel) ')'])
end

figure('color','w','Position',[212   219   886   325])
plot(basin.daten(f),basin.isal(pr,f),'ok','MarkerSize',6,'MarkerFaceColor',[0.8 0.8 0.8])
hold on


float.dates=daten2dates(float.daten);

pr=find(float.ipres==preslevel);
f=find(float.dates>year);
plot(float.daten(f),float.isal(pr,f),'ok','MarkerSize',6,'MarkerFaceColor','k')

grid on
datetick('x','yyyy','keeplimits')
legend('Basin','Float','Location','northoutside','Orientation','horizontal')
xx=xlim;yy=ylim;
set(findall(gcf,'-property','FontSize'),'FontSize',12)