function f_h=interp_fh(ulong,ulat)

ulong=convertlon(ulong,180);

% Define region of interest
latlims=[63 79];
lonlims=[-20 10];
% get f/H field
m_proj('lambert','long',[-25 25],'lat',[60 90]);
[H,long_f,lat_f]=m_tbase([lonlims latlims]);
f=gsw_f(lat_f);
H(H>=-10)=nan;
H=-H;
fh=f./H*1e6;
% Interpolate f/H to data points
f_h=nan(size(ulong));
for k=1:length(ulong)
    %disp([num2str(k) '/' num2str(length(ulong))])
    f_h(k)=interp2(long_f,lat_f,fh,ulong(k),ulat(k));
end
