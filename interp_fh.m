function f_h=interp_fh(ulong,ulat)

ulong=convertlon(ulong,180);

% get f/H field
load interp_fh_NS.mat data
%%
% Interpolate f/H to data points
f_h=nan(size(ulong));
for k=1:length(ulong)
    %disp([num2str(k) '/' num2str(length(ulong))])
    f_h(k)=interp2(data.long,data.lat,data.f_h,ulong(k),ulat(k));
end
