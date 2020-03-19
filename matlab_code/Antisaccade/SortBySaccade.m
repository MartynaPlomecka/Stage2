function out = SortBySaccade(in)
k=1;j=0;take=false;
for i = 1:size(in,1) %TODO CHECK THAT FIRST IS FIXATION
    fixation = (in(i,2)==40);
    stimulus = (in(i,2)==10 || in(i,2)==11);
    if (fixation)
        take = false;
        k=1;
    end
    if (stimulus)
        take = true;
        j=j+1;
    end
    if(take)
        out(j).data(k,:)=in(i,:);
        k = k+1;
    end
end
end
