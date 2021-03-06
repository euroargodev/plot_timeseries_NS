function nplot=plot_timeseries(preslevel,year,basin,float,mode,basin_name)
year=10000000000*year;

cm=lines(2);

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

if strcmp(mode,'r')
    plot(float.daten(f),float.isalr(pr,f),'ok','MarkerSize',6,'MarkerFaceColor',cm(2,:))
    f2=intersect(f,find(float.isalr_flag(pr,:)==2));% flag 2
    plot(float.daten(f2),float.isalr(pr,f2),'+w','MarkerSize',3)
    f3=intersect(f,find(float.isalr_flag(pr,:)==3));% flag 3
    plot(float.daten(f3),float.isalr(pr,f3),'*w','MarkerSize',3)
    nplot=[sum(isfinite(float.isalr(pr,f))) sum(isfinite(float.isalr(pr,f2))) sum(isfinite(float.isalr(pr,f3)))];
elseif strcmp(mode,'d')
    plot(float.daten(f),float.isald(pr,f),'ok','MarkerSize',6,'MarkerFaceColor',cm(1,:))
    f2=intersect(f,find(float.isald_flag(pr,:)==2));% flag 2
    plot(float.daten(f2),float.isald(pr,f2),'+w','MarkerSize',3)
    f3=intersect(f,find(float.isald_flag(pr,:)==3));% flag 3
    plot(float.daten(f3),float.isald(pr,f3),'*w','MarkerSize',3)
    nplot=[sum(isfinite(float.isald(pr,f))) sum(isfinite(float.isald(pr,f2))) sum(isfinite(float.isald(pr,f3)))];
    
    if isempty(find(abs(float.isalr(pr,f)-float.isald(pr,f))>0, 1))==0
        plot(float.daten(f),float.isalr(pr,f),'ok','MarkerSize',6,'MarkerFaceColor',cm(2,:))
        f2=intersect(f,find(float.isalr_flag(pr,:)==2));% flag 2
        plot(float.daten(f2),float.isalr(pr,f2),'+w','MarkerSize',3)
        f3=intersect(f,find(float.isalr_flag(pr,:)==3));% flag 3
        plot(float.daten(f3),float.isalr(pr,f3),'*w','MarkerSize',3)
    end
end

grid on
datetick('x','yyyy','keeplimits')
if isempty(find(abs(float.isalr(pr,f)-float.isald(pr,f))>0, 1))==0
    legend('Basin','Float in D mode ','Float in R/A mode','Location','northoutside','Orientation','horizontal')
else
    if strcmp(mode,'d')
        legend('Basin','Float in D mode','Location','northoutside','Orientation','horizontal')
    elseif strcmp(mode,'r')
        legend('Basin','Float in R/A mode','Location','northoutside','Orientation','horizontal')
    end        
end
xx=xlim;yy=ylim;
set(findall(gcf,'-property','FontSize'),'FontSize',12)