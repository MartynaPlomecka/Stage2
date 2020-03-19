    
function asaccades = EvalAS(asaccades, type, par)
amplitude = par.amplitude;
screenWidth = par.screensize(1);

for i = 1:size(asaccades,2) %TODO if Emptysacc
    %1=prosac 0=antisac Second 0=left 1=right
    if (size(asaccades(i).data,1)<2)
        continue;
    end
    asaccades(i).type = type;    %First 
    asaccades(i).stimulusDirection = asaccades(i).data(1,2)-10;
    [~,asaccades(i).saccadeDirection] = GetDirection(asaccades(i));
    if (isnan(asaccades(i).saccadeDirection))
        continue;
    end
    
    if type==0
    asaccades(i).correct = xor(asaccades(i).stimulusDirection,asaccades(i).saccadeDirection);
    elseif type==1
    asaccades(i).correct = eq(asaccades(i).stimulusDirection,asaccades(i).saccadeDirection);
    end
    asaccades(i).sacLatency = asaccades(i).data(2,1)-asaccades(i).data(1,1);
    asaccades(i).SacPeakVelocity = asaccades(i).data(2,9);
    asaccades(i).amplitude = asaccades(i).data(2,8);
    asaccades(i).gain = asaccades(i).data(2,8)/amplitude;
    asaccades(i).data(1, :) = []; %Delete the Trigger Information from the Data (as it's now written in the Struct)
    
    asaccades(i).corrData = [];
    if size(asaccades(i).data,1)>1 %corrData Saccades
        k=1;
        for j = 2:size(asaccades(i).data,1)
            centerLineCross = (screenWidth/2)<abs(asaccades(i).data(j,4)-asaccades(i).data(j,6)); %Find wheter center was crossed        
            if centerLineCross
                asaccades(i).corrData(k,:) = asaccades(i).data(j,:);
                k=k+1;
            else
                asaccades(i).corrData = [];
            end
        end
    end  
end

for i=1:size(asaccades,2) %TODO MUltiple Correctionn Saccades
    asaccades(i).corrLatency = [];
    asaccades(i).corrVelocity = [];
    asaccades(i).corrAmplitude = [];
    asaccades(i).corrGain = [];
    if isfield(asaccades(i), 'corrData') && ~isempty(asaccades(i).corrData)
        idx = find(ismember(asaccades(i).data,asaccades(i).corrData,'rows'),1);
        if idx>0
          latency = asaccades(i).corrData(1, 1) - asaccades(i).data(1,2);
          asaccades(i).corrLatency = latency;
          asaccades(i).corrVelocity = asaccades(i).corrData(1, 9);
          asaccades(i).corrAmplitude = asaccades(i).corrData(1, 8);
          asaccades(i).corrGain = asaccades(i).corrData(1, 8)/amplitude;
        end
    end
end
end
