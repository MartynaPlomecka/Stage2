function out = getCorrections(in)
k=1;
found = 0;
for i=1:size(in,1)
    if (~cellfun(@isempty,{in(i).corrData}))
        out(k,:) = in(i);
        k=k+1;
        found=1;
    end
end
if(~found)
    out=[];
end
end
