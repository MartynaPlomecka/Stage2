function out = Summary(in)
correct = getCorrect(in);
false = getFalse(in);
c_corrections = getCorrections(correct);

 f_corrections = getCorrections(false);
out.meanLatency = mean([in.sacLatency]);
out.meanPeakVelocity = mean([in.SacPeakVelocity]);
out.meanAmplitude = mean([in.amplitude]);
out.meanGain = mean([in.gain]);
out.cor_nrOfCorrect = size(correct,1);
out.cor_meanLatency = mean([correct.sacLatency]);
out.cor_meanPeakVelocity = mean([correct.SacPeakVelocity]);
out.cor_meanAmplitude = mean([correct.amplitude]);
out.cor_meanGain = mean([correct.gain]);
out.cor_nrOfCorretions= size(c_corrections,1);
if(size(c_corrections, 1)>0)
out.cor_corr_meanLatency = mean([c_corrections.sacLatency]);
out.cor_corr_meanPeakVelocity = mean([c_corrections.SacPeakVelocity]);
out.cor_corr_meanAmplitude = mean([c_corrections.amplitude]);
out.cor_corr_meanGain = mean([c_corrections.gain]);
end
out.fal_nrOfFalse = size(false,1);
if ~isempty(false)
out.fal_meanLatency = mean([false.sacLatency]);
out.fal_meanPeakVelocity = mean([false.SacPeakVelocity]);
out.fal_meanAmplitude = mean([false.amplitude]);
out.fal_meanGain = mean([false.gain]);
out.fal_nrOfCorretions= size(f_corrections,1);
else
    out.fal_meanLatency = nan;
out.fal_meanPeakVelocity = nan;
out.fal_meanAmplitude = nan;
out.fal_meanGain = nan;
out.fal_nrOfCorretions= size(f_corrections,1);
end
if(size(f_corrections, 1)>0)
out.fal_corr_meanLatency = mean([f_corrections.sacLatency]);
out.fal_corr_meanPeakVelocity = mean([f_corrections.SacPeakVelocity]);
out.fal_corr_meanAmplitude = mean([f_corrections.amplitude]);
out.fal_corr_meanGain = mean([f_corrections.gain]);
end
end
