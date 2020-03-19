function [anti,pro] = Split(et,nrOfBlocks)
i=1; j=1;
for current = 1:nrOfBlocks
    if (et(current).event(2,2) == 30) || (et(current).event(1,2) == 30)%Antisaccade
        anti(i) = et(current);
        %antisacc.type = 0;
        i=i+1;
    elseif (et(current).event(2,2) == 20) || (et(current).event(1,2) == 20)%Prosaccade
        pro(j) = et(current);
        %prosacc.type = 1;
        j=j+1;
    end
end
end
