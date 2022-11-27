%Analysh dedomenwn 2021-22 : zhthma 4
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

%% antlhsh dedomenwn gia Slovakia kai 4 geitonikes xwres=> analysh/sygkrish : 2020 vs 2021
weeks = 9; %42me50
CountrySel = [20 21 22 23 24]; %polwnia-portogalia-SLOVAKIA-slovenia- s(pain)
nsel = length(CountrySel);
arr2020 = zeros(nsel,weeks);
arr2021 = zeros(nsel,weeks);
%gia ka8e xwra apo tis 5
for i = 1:nsel
    %antlhsh positivity rates gia tis 5 xwres
    [arr2020(i,:),arr2021(i,:)] =  Group29Exe4Fun2(CountrySel(i),countries,pos_rate,country7,yweek,level);
    %prwth epafh me ta dedomena mhpws entwpisoume optika an akolou8oun
    %kanonikh katanomh basei boxplots
    txtCt = countries{CountrySel(i)};
    figure;
    subplot(2,2,1);
    stem(arr2020(i,:))
    hold on
    title(sprintf('Positivity rate for %s 42-50weeks in 2020',txtCt))
    xlabel('Weeks 42->50')
    ylabel('Positivity rate')
    
    subplot(2,2,2);
    stem(arr2021(i,:))
    hold on
    title(sprintf('Positivity rate for %s 42-50weeks in 2021',txtCt)) 
    xlabel('Weeks 42->50')
    ylabel('Positivity rate')
    
    subplot(2,2, 3);
    boxplot(arr2020(i,:))
    hold on
    title(sprintf('Boxplot  for %s 42-50weeks in 2020',txtCt))
    
    subplot(2,2, 4);
    boxplot(arr2021(i,:))
    hold on
    title(sprintf('Boxplot  for %s 42-50weeks in 2021',txtCt))
    hold off
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]); 
    set(gcf,'name','Boxplot positivity rates by Stavros :)','numbertitle','off')
end
%euresh katallhlhs katanomhs basei MSE paromoia me zhthma 1

someDists = {'Normal' 'Exponential' 'Poisson' 'Gamma' 'HalfNormal' 'InverseGaussian' 'Nakagami' 'Logistic' 'Rician' 'Rayleigh'};
suitableFitDist2020 = cell(nsel,1);
suitableFitDist2021 = cell(nsel,1);
% finalFitDist = cell(nsel,1);
% mse2020 = zeros(nsel,1);
% mse2021 = zeros(nsel,1);
areSame = zeros(nsel,1);
fprintf('Testing some distributions and calculating mean square errors for each country and year(42-50weeks) sample...\n');
fprintf('2020           vs          2021     for suitable distribution/lowest MSE\n');
for i = 1:nsel
    suitableFitDist2020(i,1) =  Group29Exe4Fun1(arr2020(i,:),someDists);
    suitableFitDist2021(i,1) =  Group29Exe4Fun1(arr2021(i,:),someDists);
    fprintf('\n')
    areSame(i) = strcmp(suitableFitDist2020(i,1),suitableFitDist2021(i,1));
end



%% analysh deigmatwn me parametriko elegxo(8ewrw kanonikh katanomh an kai se kanena dimhno den brhka oti tairiazei kalytera h 'Normal') kai bootstrap kai tyxaiopoihsh(randomization) gia thn diafora meswn timwn 2020 VS 2021 gia kathe xwra
fprintf('\n$$$$Hypothesis testing for mean difference so we can compare 2020 endings to 2021 endings$$$$\n')
hypoAll = zeros(nsel,3); %krataw kai tous 3 tropous elegxou ypo8eshs 
hypoSure = zeros(nsel,1); %apo8hkeuw edw, an kai oi 3 tropoi elegxou mesh timhs bgaloun idia timh H(0 h 1)
meanDifferenceAll = zeros(nsel,1);
for i = 1:nsel
    [hypoAll(i,:),meanDifferenceAll(i)] =  Group29Exe4Fun3(arr2020(i,:),arr2021(i,:)); %gia na sygkrinw ta 2 deigmata apo tis 2 diaforetikes xronies
    hypoSure(i) = (hypoAll(i,1) == hypoAll(i,2) == hypoAll(i,3));
end

figure;
X = linspace(0,nsel,nsel)';
stem(X,meanDifferenceAll,':diamondr')
hold on
title('Difference of sample means for all five countries : 2020 VS 2021')
xlabel('Country')
ylabel('Positivity rate')
hold off

for i = 1:nsel
    fprintf('-----FOR COUNTRY: %s -----\n',countries{CountrySel(i)});
    if hypoSure(i) == 1
        fprintf('A significant difference does exist between means of 2020 2month sample and 2021 2month sample.\n');
    else
        fprintf('CANNOT ensure that a significant difference does exist between 2 means of 2020 2month sample and 2021 2month sample.\n');
    end
    
end



%% Telika symperasmata
%(Ekana thn antlhsh dedomenwn pou h8ela,meta ekana kapoia proxeira plots 
%kai boxplots gia prwth eikona twn 2mhnwn gia ka8e xwra kai mia analysh san
%to prwto zhthma ths ergasias gia na brw thn katallhloterh katanomh gia thn
%kathe season xronias kai xwras kai apo ekei hdh kiolas entopisa megales
%diagrammatikes kai ari8mhtikes diafores metaksy twn deigmatwn mou)
%Nai yparxoun shmantikes diafores sto deikth 8etikothtas se ka8e xwra pou
%ypologisa (Polwnia-Portogalia-SLOVAKIA-Slovenia-Ispania) kai mporw na
%symperanw oti yparxei symfwnia sta apotelesmata autwn twn xwrwn,giati kai
%stis 5 xwres exei meiw8ei h mesh timh tou deikth 8etikothtas apo to 2020
%mexri to 2021.Analytikotera, oi elegxoi ypo8eshs gia diafora meshs timhs
%pou ekana me parametriko elegxo,me bootstrap kai tyxaiopoihsh me odhghsan
%sthn euresh twn p-values gia tis 3 methodous kai sthn synexeia gia
%alpha=0.05 epibebaiwsa gia KA8E me8odo sthn KA8E xwra oti exw shmantikh
%diafora twn meswn timwn. (deigmata bootstrap B=1000)