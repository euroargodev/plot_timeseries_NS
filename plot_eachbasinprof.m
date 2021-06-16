function plot_eachbasinprof(preslevel,year,ipres,data,gs,ip,lb,nb)
if isempty(gs)&&isempty(ip)&&isempty(lb)&&isempty(nb)
   disp('Nothing to plot, all profiles for this float are outside the deep basins')
else
    if isempty(gs)==0
        floatdata=selstrfields(data,gs);
        floatdata.ipres=ipres;
        load interp_ctdrdb_NS.mat gs_int
        plot_timeseries(preslevel,year,gs_int,floatdata,'GS')
        title(['GS basin (' num2str(preslevel)  ' db) - N cycles = ' num2str(numel(gs))])
    end
    if isempty(ip)==0
        floatdata=selstrfields(data,ip);
        floatdata.ipres=ipres;
        load interp_ctdrdb_NS.mat ip_int
        plot_timeseries(preslevel,year,ip_int,floatdata,'IP')
        title(['IP basin (' num2str(preslevel)  ' db) - N cycles = ' num2str(numel(ip))])
    end
    if isempty(lb)==0
        floatdata=selstrfields(data,lb);
        floatdata.ipres=ipres;
        load interp_ctdrdb_NS.mat lb_int
        plot_timeseries(preslevel,year,lb_int,floatdata,'LB')
        title(['LB basin (' num2str(preslevel)  ' db) - N cycles = ' num2str(numel(lb))])
    end
    if isempty(nb)==0
        floatdata=selstrfields(data,nb);
        floatdata.ipres=ipres;
        load interp_ctdrdb_NS.mat nb_int
        plot_timeseries(preslevel,year,nb_int,floatdata,'NB')
        title(['NB basin (' num2str(preslevel)  ' db) - N cycles = ' num2str(numel(nb))])
    end
end