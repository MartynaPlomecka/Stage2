function out = CombineET(in)
curDat = nan(0,4);
curMsg = nan(1,0);
curEvent = nan(0,2);
curSacEye = nan(0,1);
curSacData = nan(0,9);
curSacCol = in(1).eyeevent.saccades.colheader;
curFixEye = nan(0,1);
curFixData = nan(0,6);
curFixCol = in(1).eyeevent.fixations.colheader;
curBlinkEye = nan(0,1);
curBlinkData = nan(0,3);
%curBlinkCol = in(1).eyeevent.blinks.colheader;
curBlinkCol = nan(0,3);
for current = 1:size(in,2)
    curDat = vertcat(curDat,in(current).data);
    curMsg = horzcat(curMsg,in(current).messages);
    curEvent = vertcat(curEvent,in(current).event);
    if isfield(in(current).eyeevent(1),'saccades')
    curSacEye = vertcat(curSacEye,in(current).eyeevent.saccades.eye);
    curSacData = vertcat(curSacData,in(current).eyeevent.saccades.data);
    end
    if isfield(in(current).eyeevent,'fixations')
    curFixEye = vertcat(curFixEye,in(current).eyeevent.fixations.eye);
    curFixData = vertcat(curFixData,in(current).eyeevent.fixations.data);
    end
    if isfield(in(current).eyeevent,'blinks')
    curBlinkEye = vertcat(curBlinkEye,in(current).eyeevent.blinks.eye);
    curBlinkData = vertcat(curBlinkData,in(current).eyeevent.blinks.data);
    end
end
out.data = curDat;
out.messages = curMsg;
out.event = curEvent;
out.eyeevent.saccades.eye = curSacEye;
out.eyeevent.saccades.data = curSacData;
out.eyeevent.saccades.colheader = curSacCol;
out.eyeevent.fixations.eye = curFixEye;
out.eyeevent.fixations.data = curFixData;
out.eyeevent.fixations.colheader = curFixCol;
out.eyeevent.blinks.eye = curBlinkEye;
out.eyeevent.blinks.data = curBlinkData;
out.eyeevent.blinks.colheader =curBlinkCol;
end
