function [data,gs,ip,lb,nb]= interp_fh_NS
% basic interpolation 
% Define region of interest
latlims=[63 79];
lonlims=[-20 10];
% get f/H field
m_proj('lambert','long',[-25 25],'lat',[60 90]);
[H,long_f,lat_f]=m_etopo2([lonlims latlims]);
f=gsw_f(lat_f);
H(H>=-10)=nan;
H=-H;
fh=f./H*1e6;
data.long=long_f;data.lat=lat_f;data.f_h=fh;data.H=H;
[gs,ip,lb,nb]=classbasinNS(data);