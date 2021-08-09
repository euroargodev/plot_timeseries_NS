function  [gs_int,ip_int,lb_int,nb_int]=interp_basin_NS(indir,ipres)
% interpolates the reference profiles for DMQC in the Nordic Seas, 
% which are contained in the following WMO  boxes 
wmo=[1600   1601    1700	1701		1800	1801	1802	7600 ...	
     7601    7602   7700    7701        7800    7801   ];%1702 7702 7802
%INPUTS
% The matfiles for those wmo boxes are located in the INDIR directory
% and the date is interpolated into the IPRES pressure levels 
% OUTPUTS
% data structures named BASIN_int (gs_int,ip_int,lb_int,nb_int, see
% function interp_fh_NS)
% that contained the reference profiles in that basin iterpolated to the
% IPRES levels and sorted chronologically
% contents: data.itemp, data.isal, data.ipres, data.dates, data.long and data.lat
% 
%%
% fix pressure to column vector
if size(ipres,1)==1
   ipres=ipres';
end

disp('Sorting profiles of each WMO box into the corresponding basin')
for j=1:numel(wmo)
    disp([ 'WMO box ' num2str(j)])
    
    %filename
    fname=[indir 'ctd_' num2str(wmo(j)) '.mat'];
    load(fname,'lat','long')
    data.lat=lat;data.long=long;
    data.f_h=interp_fh(data.long,data.lat);
   
    [gs{j},ip{j},lb{j},nb{j}]=classbasinNS(data);
end
% 
clear data
basins={'gs','ip','lb','nb'};
for i=1:numel(basins)
    disp('interpolating')
    disp(num2str(i))
    
    eval(['prof=' basins{i} ';'])
    itemp=[];isal=[];dates=[];long=[];lat=[];
     for j=1:numel(wmo)
       fname=[indir 'ctd_' num2str(wmo(j))];       
       if isempty(prof{j})==0
          tmp=extr_prof(fname,prof{j});
          [temp,sal]=interp_ipres(tmp.pres,tmp.temp,tmp.sal,ipres);
          long=[long tmp.long];
          lat=[lat tmp.lat];
          dates=[dates tmp.dates];
          itemp=[itemp temp];
          isal=[isal sal];
       end
     end    
     data.itemp=itemp;
     data.isal=isal;
     data.ipres=ipres;
     data.dates=dates;
     data.long=long;
     data.lat=lat;
         
     [~,I] = sort(data.dates);  
     data=selstrfields(data,I);
     
     eval([ basins{i} '_int=data;'])    
end