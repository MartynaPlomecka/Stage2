clear all;

addpath(genpath('~/Dropbox/AA_Neurometric/ANALYSES/functions/'))

pathAllSubjects = '/Volumes/methlab/Neurometric/Antisaccades/ALL/ET/'; %tutaj chce zeby byly nowe pliki
%pathAllSubjects = '/Users/mplome/Desktop/et/ET/';

allSubj = [];
allCorr = [];

%% ALLE Subjekte
all_names = dir([pathAllSubjects, 'A*' ])
all_names = [all_names; dir([pathAllSubjects, 'B*' ])]

PROTOCOL = [1, 0, 0, 0, 1];
nrOfBlocks = size(PROTOCOL, 2);

%nn = 35 nn = 48 not working
RANGE = 1:size(all_names,1);
for nn = RANGE
    clearvars all -except  all_names nn
subjectToProcess = {all_names(nn,1).name};
%subjectToProcess = {'mm2'};


for sub = 1:length(subjectToProcess)
try
    display(char(subjectToProcess(1,sub)))
    parFile = [pathAllSubjects '/' char(subjectToProcess(1,sub)) '/' char(subjectToProcess(1,sub)) '_ASA.mat'];
    load(parFile);

    clear et;
    for current = 1:nrOfBlocks
        etFile = [pathAllSubjects '/' char(subjectToProcess(1,sub)) '/' char(subjectToProcess(1,sub)) '_AS' char(num2str(current)) '_ET.mat'];
        tmp = load(etFile); % Load ET 
        et(current) = rmfield(tmp,'comments');
    end
catch
    display(char(subjectToProcess(1,sub)) + ": Missing AS files.");
    continue;
end

% [antisacc, prosacc] = Split(et,nrOfBlocks);
% prosacc = CombineET(prosacc);
% antisacc = CombineET(antisacc);
% [PEvents, Ptype]= FilterEvents(prosacc.event);
% [AEvents, Atype] = FilterEvents(antisacc.event);
% antiData = vertcat(antisacc.eyeevent.saccades.data, AEvents);
% antiData = sortrows(antiData);
% proData = vertcat(prosacc.eyeevent.saccades.data, PEvents);
% proData = sortrows(proData);
% 
% psaccades = SortBySaccade(proData);
% asaccades = SortBySaccade(antiData);
% asaccades = EvalAS(asaccades, Atype, par);
% psaccades = EvalAS(psaccades, Ptype, par);
% 
% prosaccades = Summary(psaccades);
% antisaccades = Summary(asaccades);
% result(sub) = struct('VP',subjectToProcess(sub),'ProSummary',prosaccades,'AntiSummary',antisaccades);

for blockNo = 1:nrOfBlocks
    saccBlock = et(blockNo);
    [events, type] = FilterEvents(saccBlock.event);
    saccData = vertcat(saccBlock.eyeevent.saccades.data, events);
    saccData = sortrows(saccData);
    saccades = SortBySaccade(saccData);
    saccadesBlocks(blockNo).block = EvalAS(saccades, type, par);
end
prosaccadesCombined = CombineSaccades(saccadesBlocks, PROTOCOL);
antisaccadesCombined = CombineSaccades(saccadesBlocks, ~PROTOCOL);

subj = PrepareSubject(saccadesBlocks, nn, subjectToProcess);
corr = PrepareCorrective(saccadesBlocks, nn, subjectToProcess);
allSubj = [allSubj;subj];
allCorr = [allCorr;corr];

data = ConvertData(CombineSaccades(saccadesBlocks, ones(1, nrOfBlocks)));
data.name = subjectToProcess;
%save(sprintf('/Users/mplome/data/sbj%02d.mat', nn), 'data');
all_data(nn) = data;
end

% for i=1:size(result,2)
%     latency(i) = result(i).Pro.meanLatency;
%     peakVelocity(i) = result(i).Pro.meanPeakVelocity;
%     amplitude(i) = result(i).Pro.meanAmplitude;
%     nrCorrect(i)= result(i).Pro.nrOfCorrect;
%     nrFalse(i)= result(i).Pro.fal_nrOfFalse;
%     a_latency(i) = result(i).Anti.meanLatency;
%     a_peakVelocity(i) = result(i).Anti.meanPeakVelocity;
%     a_amplitude(i) = result(i).Anti.meanAmplitude;
%     a_nrCorrect(i)= result(i).Anti.nrOfCorrect;
%     a_nrFalse(i)= result(i).Anti.fal_nrOfFalse;
% end
%     pro.latency=mean(latency);
%     pro.velocity=mean(peakVelocity);
%     pro.amplitude=mean(amplitude);
%     pro.nrCorrect=mean(nrCorrect);
%     pro.nrFalse=mean(nrFalse);
%     anti.latency=mean(a_latency);
%     anti.velocity=mean(a_peakVelocity);
%     anti.amplitude=mean(a_amplitude);
%     anti.nrCorrect=mean(a_nrCorrect);
%     anti.nrFalse=mean(a_nrFalse);  

% 
% %% Probit
% figure(4)
% % raw data
% rt = [psaccades.sacLatency];
% x = -1./sort((rt)); % multiply by -1 to mirror abscissa
% rtinv  = 1./rt; % inverse reaction time / promptness (ms-1)
% n = numel(rtinv); % number of data points
% y = pa_probit((1:n)./n); % cumulative probability for every data point converted to probit scale
% plot(x,y,'k.');
% hold on
%  
% % quantiles
% p    = [1 2 5 10:10:90 95 98 99]/100;
% probit  = pa_probit(p);
% q    = quantile(rt,p);
% q    = -1./q;
% xtick  = sort(-1./(150+[0 pa_oct2bw(50,-1:5)])); % some arbitrary xticks
%  
% plot(q,probit,'ko','Color','k','MarkerFaceColor','r','LineWidth',2);
% hold on
% set(gca,'XTick',xtick,'XTickLabel',-1./xtick);
% xlim([min(xtick) max(xtick)]);
% set(gca,'YTick',probit,'YTickLabel',p*100);
% ylim([pa_probit(0.1/100) pa_probit(99.9/100)]);
% axis square;
% box off
% xlabel('Reaction time (ms)');
% ylabel('Cumulative probability');
% title('Probit ordinate');
%  
% % this should be a straight line
% x = q;
% y = probit;
% b = regstats(y,x);
% h = pa_regline(b.beta,'k-');
% set(h,'Color','r','LineWidth',2);
%  

% cd([pathAllSubjects ,all_names(nn).name]) 
% save([all_names(nn).name ,'_antisaccade_results.mat'], 'result', '-v7.3');
% disp(all_names(nn).name)

end

data = all_data(RANGE)';  

save('/Users/mplome/data/et_full_data.mat', 'data');
writetable(allSubj, sprintf('/Users/mplome/data/et_full_data.csv'));
writetable(allCorr, sprintf('/Users/mplome/data/corrective_et_full_data.csv'));