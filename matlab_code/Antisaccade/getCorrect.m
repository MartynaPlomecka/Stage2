function out = getCorrect(in)
k=1;
for i=1:size(in,2)
    if in(i).correct
        out(k,:) = in(i);
        k=k+1;
    end
end
end
