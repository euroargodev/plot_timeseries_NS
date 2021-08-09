function [itemp,isal]=interp_ipres(pres,temp,sal,ipres,cycle)
% interp_ipres 
% Interpolates profile data (PRES,TEMP,SAL) to standard pressure levels given
% by ipres. The optional variable CYCLE (vector) is only used as an auxiliary 
% information when interpolating argo profiles (leave it empty otherwise)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
if nargin<5
    cycle=[];
end

% preallocate output
n=size(temp,2);
itemp=nan(numel(ipres),n);
isal=itemp;nan(numel(ipres),n);
% loop for profiles
for i=1:n    
    %finds valid pressure levels (for the Argo profiles)
    [~,ix1] = unique(pres(:,i));% unique pressure values
    ix2=find(isfinite(pres(:,i))); % valid data
    % selecting only valid data
    ix=intersect(ix1,ix2);
    % interpolating
    if isempty(ix)==0
        if numel(ix)==1 && isempty(cycle)==0
           disp(['Cycle number ' num2str(cycle(i)) ' has been skipped. Not enough interpolation points (only 1).'])
        else
            itemp(:,i)=interp1(pres(ix,i),temp(ix,i),ipres');
            isal(:,i)=interp1(pres(ix,i),sal(ix,i),ipres');
        end
    end
end