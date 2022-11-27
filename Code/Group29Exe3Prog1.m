%Analysh dedomenwn 2021-22 : zhthma 3
%Omada29 Stavros Vasileios Bouliopoulos 9671
%email: smpoulio@ece.auth.gr

close all
clc;
clear
%% antlhsh dedomenwn
xwraA = 'Slovakia';

%gia xwres data fun1
[ct_indexes,countries] = Group29Exe1Fun1();
%CountryA = countries(22);

%gia ebdomades 7day data fun2
[pos_rate,country7,yweek,level] =  Group29Exe1Fun2();

%gia EODY
[date ,newCases ,pcrT,rapidT,eodyWeek,eodyDay] =  Group29Exe3Fun1();

%rapidT(isnan(rapidT)) = -1;
%newCases(isnan(newCases)) = -1;
%pcrT(isnan(pcrT)) = -1;

%% to peak ths slovakias

idSK = find(strcmp(country7(:),xwraA) & strcmp(level(:),'national'));
prSK = pos_rate(idSK);
figure;
plot(prSK)
figure;
%bar(prSK(find(~isnan(prSK))))
bar(prSK);
xlabel('Weeks')
ylabel('Positivity rate')
txt1 = yweek{idSK(1)};
txt2 = yweek{idSK(length(idSK))};
title(sprintf('Slovakia %s till %s',txt1,txt2))
%me to mati mporw na dw pou einai h teleutaia koryfwsh kai na pw gia 94h
%8esh tou idSK pinaka alla gia akriboterh analysh xrhsimopoiw synarthsh gia
%topika megista , boh8eia : findpeaks()
A=pos_rate(idSK);
[peaksSK,idPeaks] = findpeaks(A);
idPeaks = idPeaks + idSK(1);
recentPeak = idPeaks(length(idPeaks))-1;
recentWeek = yweek{recentPeak};
fprintf('Most recent peak for Slovakia had value %f and was at %s \n',pos_rate(recentPeak),recentWeek);

%% meleth 12ebdomadwn 

nct = length(countries);
%12 ebdomades prin
i = 12;
starting = recentPeak;
ending = recentPeak -i+1; %na parw 12 times kai oxi 13 . se autes tis 12 exw sthn 1h 8esh thn ebdomada koryfhs ths slovakias
%deiktes 8etikothtas gia eurwpaikh enwsh
posRateEEALL = zeros(i,nct);
posRateEE = zeros(i,1);

%pros ta pisw h seira twn deiktwn
for rowID = starting:-1:ending
    %fprintf('%d\n',rowID)
    for j = 1:nct
        %%%%idCT = find(strcmp(country7(:),countries(j)) & strcmp(level(:),'national'));
        %%%%prCT(find(~isnan(prCT)))
        posRateEEALL(starting-rowID+1,j) = pos_rate(find( strcmp(yweek(rowID),yweek(:)) & strcmp(country7(:),countries(j)) & strcmp(level(:),'national')));
    end
end
posRateEE = sum(posRateEEALL,2)/25; %meso oro twn eurwpaikwn deiktwn

%% kalesma synarthshs gia boostrap diasthma empistosynhs meshs timhs k positivity rate gia ellada

meanSignal = zeros(i,1);
posRateGR = zeros(i,1);
idDayRange = zeros(7,1);
fprintf('Computing confidence intervals for mean of daily Greek positivity rate according to EODY data and comparing to European Union weekly positivity rate!\n')
%pali me seira pros ta pisw to positivity rate GReece
fprintf('Lower bound   Upper bound    EE rate      MeanSignal\n');
for j = 1:i
    tempWeek = yweek(recentPeak-j+1);
    idDayRange = find(strcmp(tempWeek,eodyWeek));
    [meanSignal(j),posRateGR(j)] =  Group29Exe3Fun2(idDayRange,posRateEE(j),pcrT,rapidT,newCases);
end
%% diagramma meleths
%figure;
%bar(posRateGR - posRateEE,'y')
endWeek = yweek{recentPeak-11};
figure;
p1 = plot(posRateGR,'LineWidth',2.69);
hold on
p2 = plot(posRateEE,'LineWidth',2.69);
grid on
diffs = posRateGR - posRateEE; 
xCenter = 1:1:length(meanSignal);
yCenter = (posRateGR+posRateEE)/2;

for k = 1 : length(xCenter)
    if meanSignal == 0 %an einai shmantikh h diafora symfwna me thn analysh pou ekana prin tote emfanizw diafora kai kanw mark(mporw kai allous tropous gia annotation alla epeleksa autous tous 2)
        textLabel = sprintf('%.1f', diffs(k));
        text(xCenter(k), yCenter(k), textLabel, 'HorizontalAlignment', 'center')
        plot(k,posRateGR(k),'ro','markerfacecolor',[1 0 0])
        plot(k,posRateEE(k),'ro','markerfacecolor',[1 0 0])
    end
end
xlabel('Weeks')
ylabel('Positivity rate')
legend([p1 p2],{'Greece','European Union'},'FontSize',11.69,'TextColor','magenta','Location','northwest')
title(sprintf('Differences from week %s left to right week %s',recentWeek,endWeek))
grid off
hold off


%% Telika symperasmata
%To programma trexei apla mporei na arghsei logw pollwn import kai
%praksewn(B=1000)
%Se auto to zhtoumeno afou prwta ekana ereuna mesw commandline kai
%debugging wste na eksakribwsw oti parola kapoia kena ebdomadwn pou yphrxan
%ana xwra . Oi ebdomades pou mas endieferan basei ths teleutaias
%koryfwshs(topiko megisto) ths Slovakias eixan dedomena gia oles tis xwres
%opote den xreiasthke na ta kanw delete h fill basei prohgoumenou kai
%epomenou deikth ,alla ola ta dedomena yphrxan sto excel. Sthn
%synexeia, ypologisa ton meso oro deiktwn twn xwrwn ths eurwphs phra 
%deiktes 8etikothtas gia thn eurwpaikh enwsh kai tous deiktes gia thn
%ellada basei ta analytika hmerhsia dedomena apo ton EODY. Telos, brhka to
%95% diasthma empistosynhs me bootstrap gia to kathe deigma(sample) 7 
%hmerwn ana ebdomada kai sygkrina to diasthma auto me ton deikth
%8etikothtas ebdomadas apo EE,opou katelhksa oti kai stis 12 ebdomades eixa
%statistika shmantikh diafora metaksy twn deiktwn kai to emfanisa sto plot
%me noumera kai bullets an eblepe oti meanSignal=0. Ellada nikhse sthn 
%arrwstia... :(