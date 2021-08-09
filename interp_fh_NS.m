function [data,gs,ip,lb,nb,basins]= interp_fh_NS
% This script obtains the gridded DATA structure containing
% longitude (data.long), latitude (data.lat), bottom depth(data.H) and f/h 
% (data.f_h) based on the etopo2 database (m_etopo2) and the f parameter 
% calculated from latitude using the GSW toolbox.
% Optional outputs are 
%         - the indices of the profiles corresponding to the
%         GS (Greenland Sea), IP (Island Sea), LF (Lofoten Basin),
%         NB (Norwegian Basin), as obtained using classbasinNS
%         - BASINS that is a grid of the same size as the matrices in DATA
%         on which each basin has a different number GS=1, IP=2, LB=3, NB=4
%% Nordic Seas region definition
latlims=[63 79];
lonlims=[-20 10];
% get f/H field
% Bottom depth
m_proj('lambert','long',[-25 25],'lat',[60 90]);
[H,long_f,lat_f]=m_etopo2([lonlims latlims]);
H(H>=-10)=nan;
H=-H;% convert to positive values
% f parameter
f=gsw_f(lat_f);
% f/H
fh=f./H*1e6;
% Storing in the data structure
data.long=long_f;data.lat=lat_f;data.f_h=fh;data.H=H;

% Classifies the grid points in the basins
[gs,ip,lb,nb]=classbasinNS(data);
% Creats a basin grid (good for plots)
basins=zeros(size(data.long));
basins(gs)=1;basins(ip)=2;basins(lb)=3;basins(nb)=4;