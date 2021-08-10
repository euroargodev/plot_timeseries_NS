function [isal,isal_flag,ipres_flag]=interpsal_ipres_argo(pres,sal,flag,ipres,cycle)
% % Interpolates profile data (PRES,SAL) to standard pressure levels given
% by ipres. The FLAG variable is expected to be a numeric array that combines 
% the pressure (first digit) and the salinity (second digit) flags (as in
% the output of get_argomodes_psflags)
% The optional variable CYCLE (vector) is only used as an auxiliary
% information to generate a warning when a profile is empty)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if nargin<5
    cycle=[];
end

[h,n]=size(sal);
fp=nan(h,n);fs=nan(h,n);
for i=1:h
    for j=1:n
        if isfinite(flag(i,j))
            tmp=num2str(flag(i,j));
            if numel(tmp)==2
            fp(i,j)=str2double(tmp(1));
            fs(i,j)=str2double(tmp(2));
            end
        end
    end
end

% preallocate output

isal=nan(numel(ipres),n);
isal_flag=nan(numel(ipres),n);
ipres_flag=nan(numel(ipres),n);
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
            isal(:,i)=interp1(pres(ix,i),sal(ix,i),ipres');
            isal_flag(:,i)=ceil(interp1(pres(ix,i),fs(ix,i),ipres'));
            ipres_flag(:,i)=ceil(interp1(pres(ix,i),fp(ix,i),ipres'));
        end
    end
end