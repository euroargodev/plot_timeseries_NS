%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iboxes 
% Interpolates v2 boxes data to standard pressure levels using the function
% interp_ipres% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  [gs_int,ip_int,lb_int,nb_int]=interp_basin_NS(indir,ipres)
wmo=[1600   1601    1700	1701		1800	1801	1802	7600 ...	
     7601    7602   7700    7701        7800    7801   ];%1702 7702 7802
%indir='\\win.bsh.de\root$\Standard\Hamburg\Homes\Homes00\bm2286\Datenbanken\Downloaded\IFREMER\CTD_for_DMQC_2021V01\';
 % Pressure levels for DMQC
%ipres=800:10:2000;
if size(ipres,1)==1
   ipres=ipres';
end
%%
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