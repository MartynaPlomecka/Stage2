function [out, type] = FilterEvents(in)
in(:,9) = 0; type=0;
j=1;
for i=1:size(in,1)
    if(in(i,2)==30); type=0; end;%Anti %TODO Verkehrt RUM!!!!
    if(in(i,2)==20); type=1; end;%Pro
end
for i=1:size(in,1)
    if(in(i,2)==10 || in(i,2)==11 || in(i,2)==40)
        out(j,:)=in(i,:);
        j=j+1;
    end
end
end
