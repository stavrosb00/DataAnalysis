%Analysh dedomenwn 2021-22 : zhthma 3
%Omada29 Stavros Vasileios Bouliopoulos 9671


%diabazw 7 hmeres kai deikth 8etikothtas eurwpaikhs enwshs wste na bgalw
%sthn eksodo to shma gia thn diafora meshs timhs kai deikth 8etikothtas
%elladas
function [meanSignal,posRateGR] =  Group29Exe3Fun2(idDayRange,posRateEE,pcrT,rapidT,newCases)

%bootstrapCI = 0;
meanSignal = 0;
%% --rapid-AS kai PCR-AT dia new cases-B = hmerhsio deikth = SAMPLE
nd = length(idDayRange);
sample = zeros(nd,1);
for i = 1:nd
    %ta tests dinontai a8roistika opote briskw poso allazoun basei ths
    %prohgoumenhs hmeras kai ths twrinhs
    sample(i) = ( (pcrT(idDayRange(i)) - pcrT(idDayRange(i)-1)) + (rapidT(idDayRange(i)) - rapidT(idDayRange(i)-1)) ) / (newCases(idDayRange(i)));
end

%thelw meso oro twn 7 deiktwn 8etikothtas ka8e hmeras
posRateGR = sum(sample)/7;

%% 95% bootstrap CI tou twn hmerisiwn deiktwn 8etikothtas

rng default;
B = 1000;
alpha = 0.05; %thelw gia 95% D.E.
%% enallaktikos(IGNORE)
% btstrpCI = bootci(B,{@mean,sample},'alpha',alpha);
% if posRateEE<btstrpCI(2) && posRateEE>btstrpCI(1)
%     meanSignal = 1;%eimai mesa sto diasthma kai ara mporei na yparksei periptwsh mesh timh ellados = eurwphs
% else
%     meanSignal = 0;%den eimai mesa sto diasthma kai ara den mporei na yparksei periptwsh mesh timh ellados = eurwphs
% end
% fprintf('Lower bound    Upper bound     EE rate     MeanSignal\n');
% fprintf('%f     %f      %f     %.2f\n',btstrpCI(1),btstrpCI(2),posRateEE,meanSignal);
%% kyrios tropos
bootMean = bootstrp(B,@mean,sample);
lowerLim = (B+1)*alpha/2;
upperLim = B+1-lowerLim;
limits = [lowerLim upperLim]/B*100;
bootMeanCI = prctile(bootMean,limits);
%hypothesis testing gia eurwpaikhs enwshs deikth
% elegxo CI ws pros posRateEE
if posRateEE<bootMeanCI(2) && posRateEE>bootMeanCI(1)
    meanSignal = 1;%eimai mesa sto diasthma kai ara mporei na yparksei periptwsh mesh timh ellados = eurwphs
else
    meanSignal = 0;%den eimai mesa sto diasthma kai ara den mporei na yparksei periptwsh mesh timh ellados = eurwphs
end
%fprintf('Lower bound   Upper bound    EE rate      MeanSignal\n');
fprintf('%f     %f      %f     %.2f\n\n',bootMeanCI(1),bootMeanCI(2),posRateEE,meanSignal);
end
