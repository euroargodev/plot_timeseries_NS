function data=selstrfields(data,I)
F=fields(data);
for i=1:numel(F)
    eval(['tmp=data.' F{i} ';'])
    if size(tmp,2)>1
        eval(['data.' F{i} '=data.' F{i} '(:,I);'])
    end
end