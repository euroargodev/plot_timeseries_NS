function plot_eachbasinprof(preslevel,year,ipres,data,mode,gs,ip,lb,nb)
if isempty(gs)&&isempty(ip)&&isempty(lb)&&isempty(nb)
    disp('Nothing to plot, all profiles for this float are outside the deep basins')
else
    if isempty(gs)==0
        bname='GS';
        floatdata=selstrfields(data,gs);
        floatdata.ipres=ipres;
        load interp_ctdrdb_NS.mat gs_int
        nplot=plot_timeseries(preslevel,year,gs_int,floatdata,mode,bname);
        title({[bname ' basin (' num2str(preslevel)  ' db) - Mode ' upper(mode) ' - N cycles = ' num2str(nplot(1))];...
            ['N salinity flag 2 (+) =  ' num2str(nplot(2)) ' - N salinity flag 3 (*) =  ' num2str(nplot(3))]})
    end
    
    if isempty(ip)==0
        bname='IS';
        floatdata=selstrfields(data,ip);
        floatdata.ipres=ipres;
        load interp_ctdrdb_NS.mat ip_int
        nplot=plot_timeseries(preslevel,year,ip_int,floatdata,mode,'IP');
        title({[bname ' basin (' num2str(preslevel)  ' db) - Mode ' upper(mode) ' - N cycles = ' num2str(nplot(1))];...
            ['N salinity flag 2 (+) =  ' num2str(nplot(2)) ' - N salinity flag 3 (*) =  ' num2str(nplot(3))]})
    end
    if isempty(lb)==0
        bname='LB';
        floatdata=selstrfields(data,lb);
        floatdata.ipres=ipres;
        load interp_ctdrdb_NS.mat lb_int
        nplot=plot_timeseries(preslevel,year,lb_int,floatdata,mode,bname);
        title({[bname ' basin (' num2str(preslevel)  ' db) - Mode ' upper(mode) ' - N cycles = ' num2str(nplot(1))];...
            ['N salinity flag 2 (+) =  ' num2str(nplot(2)) ' - N salinity flag 3 (*) =  ' num2str(nplot(3))]})
    end
    if isempty(nb)==0
        bname='NB';
        floatdata=selstrfields(data,nb);
        floatdata.ipres=ipres;
        load interp_ctdrdb_NS.mat nb_int
        nplot=plot_timeseries(preslevel,year,nb_int,floatdata,mode,bname);
        title({[bname ' basin (' num2str(preslevel)  ' db) - Mode ' upper(mode) ' - N cycles = ' num2str(nplot(1))];...
            ['N salinity flag 2 (+) =  ' num2str(nplot(2)) ' - N salinity flag 3 (*) =  ' num2str(nplot(3))]})
    end
end