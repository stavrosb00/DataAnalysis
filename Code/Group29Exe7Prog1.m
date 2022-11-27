%Analysh dedomenwn 2021-22 : zhthma 7
%Omada29 Stavros Vasileios Bouliopoulos 9671
%email: smpoulio@ece.auth.gr

clear
close all
clc;

%%  antlhsh dedomenwn
%(y)ebdomadiaio ari8mo 8anatwn(ana ekatommyrio) ws pros positivity rate(x)
%aplh grammikh palindromhsh=> 2 montela basei 2 4mhnwn
%kalyterh akribeia an 1 h 2 h 3 h 4 h 5 ysterhsh ebdomadas

xwraA = 'Slovakia';

%gia xwres data fun1
[ct_indexes,countries] = Group29Exe1Fun1();
%CountryA = countries(22);

%gia ebdomades 7day data fun2
[pos_rate,country7,yweek,level] =  Group29Exe1Fun2();

%https://www.covidstats.gr/testing.html (gia nekroi ebdomadas ana 1ekat.)
%2 periodous 16ebdomadwn
%1o 4mhno:19/12/21 kai prin ,dhladh W50 kai prin=> W35-50 tou 21
i = 15; %16ebdomades euros
startingWeek = '2021-W35';
starting = find(strcmp(startingWeek,yweek(:)) & strcmp(country7(:),xwraA) & strcmp(level(:),'national'));
ending = starting + i;
PRtrim1 = zeros(1,i+1);
for j = starting:ending
    PRtrim1(j-starting+1) = pos_rate(j);
end

death1 = [6 13 10 27 29 31 27 33 34 76 48 118 89 95 99 118]';
%scatter plot 1o 4mhno
r = corrcoef(PRtrim1,death1); 
r = r(1,2);
figure;
scatter(PRtrim1,death1);
refline;
hold on
title('Scatter plot[Slovakia 2021-W35->W50]')
ylabel('Deaths per million')
xlabel('Positivity rate')  
annotation('textbox', [0.169, 0.8, 0.1, 0.1], 'String', "r = " + r)
hold off

%2o 4mhno:18/10/20 mexri 31/1/21=> W42 tou 20 mexri W04 tou 21
startingWeek = '2020-W42';
starting = find(strcmp(startingWeek,yweek(:)) & strcmp(country7(:),xwraA) & strcmp(level(:),'national'));
ending = starting + i;
PRtrim2 = zeros(1,i+1);
for j = starting:ending
    PRtrim2(j-starting+1) = pos_rate(j);
end

death2 = [1 2 2 4 15 11 22 12 23 41 60 59 77 102 94 120]';
%scatter plot 2o 4mhno
r = corrcoef(PRtrim2,death2); 
r = r(1,2);
figure;
scatter(PRtrim2,death2);
refline;
hold on
title('Scatter plot[Slovakia 2020-W42->2021-W04]')
ylabel('Deaths per million')
xlabel('Positivity rate')  
annotation('textbox', [0.169, 0.8, 0.1, 0.1], 'String', "r = " + r)
hold off
%% analysh gia montela me aplh grammikh palindromhsh gia beltisth ebdomadiakh ysterhsh palindromhshs

period1 = 'Slovakia 2021-W35->W50';
period2 = 'Slovakia 2020-W42->2021-W04';
xoxo1 = Group29Exe7Fun1(PRtrim1,death1,period1);
xoxo2 = Group29Exe7Fun1(PRtrim2,death2,period2);


%% Telika symperasmata
%(Antlhsa ta dedomena apo ta excel kai gia tous 8anatous apo thn istoselida
%kai ekana mia prwth optikopoihsh. 8ewrhsa ysterhsh apo 16 ews kai 5
%ebdomades prin gia na brw to kalytero montelo problepshs kai to apotypwsa 
%sthn synarthsh Group29Exe7Fun1() seira13-16 an katalava swsta to
%zhtoumeno. Apeikonisa kai ta diagnwstika diagrammata gia na doume an 
%ta sfalmata ypakououn sthn tyxaiothta h se kapoio koino protypo)
%Ypologisa thn beltisth ysterhsh palindromhshs basei RMSE gia to ka8e 4mhno
%(1o: 2021-W35->W50 kai 2o: 2020-W42->2021-W04 opou sto site htan emfanhs h
%klimakwsh 8anatwn se autes tis 2 periodous). Ystera,katelhksa oti mporw na 
%problepsw tis entones koryfwseis 8anatwn apo ton deikth 8etikothtas kai 
%pio sygkekrimena gia to 1o 4mhno brhka beltisth ysterhsh gia 14 ebdomades,
%enw sto 2o 12 ebdomades kai syntelestes montelou na akolou8oun omoiothtes.
%Ara, symfwnoun ta apotelesmata kai apo tis 2 periodous.