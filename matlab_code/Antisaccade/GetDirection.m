function [Events, dir] = GetDirection(sacc)
if sacc.data(2,4)<sacc.data(2,6)
    dir = 1;
elseif sacc.data(2,4)>sacc.data(2,6)
    dir = 0;
else  % added by NL (if the same value, then error)
    dir = nan;
end
Events = sacc.data(1,2);
end