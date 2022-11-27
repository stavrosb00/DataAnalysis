%Analysh dedomenwn 2021-22 : zhthma 1
%Omada29 Stavros Vasileios Bouliopoulos 9671
%email: smpoulio@ece.auth.gr

clear
close all
clc;

%%%%%%%%PROKARTAKTIKA%%%%%
%Paradidw 6 zhtoumena : 1,3,4,5,6,7. Ta programmata trexoun apla prosoxh me
%to baros sthn mnhmh giati trexw se kapoia shmeia polla plots se for loops.
%Exw ekshghseis se sxolia mesa ston kwdika h se synarthseis kai telika
%symperasmata se ka8e main Prog sto telos tou arxeiou.

%aem 9671->me dia 25 exw ypoloipo 21->me +1 exw 22->Slovakia gia A xwra
xwraA = 'Slovakia';
%%%%%%%%%%%%%%%%%%%%%%%%%%

%% antlhsh dedomenwn

%gia xwres data fun1
[ct_indexes,countries] = Group29Exe1Fun1();
%CountryA = countries(22);

%gia ebdomades 7day data fun2
[pos_rate,country7,yweek,level] =  Group29Exe1Fun2();


%x = find(strcmp('2020-W42',yweek(:)) & strcmp(country7(:),xwraA))

%% 2)2020

%na brw to 45-50 ths slovakias kai to max autou 
starting = find(strcmp('2020-W45',yweek(:)) & strcmp(country7(:),xwraA));
ending = starting + 5;
slov = zeros(6,2); %sthn 2h to i gia na parw thn seira pou exw max
for i = starting:ending
    slov(i-starting+1,1) = pos_rate(i);
    slov(i-starting+1,2) = i;
end
[val ,idx] = maxk(slov(:,1),1);
rowID = slov(idx,2);
fprintf('\nWeek of interest for 2020 is %s\n',yweek{rowID}'); %max se week50
%syllogh dedomenwn gia thn ebdomada mas gia oles tis xwres
n = length(pos_rate);
nct = length(ct_indexes);
arr2020 = zeros(nct,1);
for j = 1:nct
    %ebgainan bugs gt den exei gia kapoies xwres timh sto week50 sto excel
    %apo to workspace kai to command line ,ebriska sta j pou exw error
    if j == 10 | j == 12 | j == 16 %gallia ,ouggaria,letonia pairnw apo week51
        arr2020(j) = pos_rate(find(strcmp(yweek(rowID+1),yweek(:)) & strcmp(country7(:),countries(j)) & strcmp(level(:),'national'))); 
    else
    arr2020(j) = pos_rate(find(strcmp(yweek(rowID),yweek(:)) & strcmp(country7(:),countries(j)) & strcmp(level(:),'national'))); 
    end
end

%% 1)2021

%na brw to 45-50 ths slovakias kai to max autou 
starting = find(strcmp('2021-W45',yweek(:)) & strcmp(country7(:),xwraA));
ending = starting + 5;
slov = zeros(6,2); %sthn 2h to i gia na parw thn seira pou exw max
for i = starting:ending
    slov(i-starting+1,1) = pos_rate(i);
    slov(i-starting+1,2) = i;
end
[val2 ,idx2] = maxk(slov(:,1),1);
rowID2 = slov(idx2,2);
fprintf('\nWeek of interest for 2021 is %s\n',yweek{rowID2}'); %max se week50
%syllogh dedomenwn gia thn ebdomada mas gia oles tis xwres
arr2021 = zeros(nct,1);
for j = 1:nct
    %den eixa bugs ,eixa gia oles tis xwres info
    arr2021(j) = pos_rate(find(strcmp(yweek(rowID2),yweek(:)) & strcmp(country7(:),countries(j)) & strcmp(level(:),'national'))); 
end

%% analysh katanomwn kai sygkrish 2020 ,2021

%boh8eia apo fitdist https://www.mathworks.com/help/stats/fitdist.html
%apo to link phra kapoia onomata katanomwn

%gia mia prwth opsh twn dedomenwn pou exw
figure;
%hist(arr2020)
histfit(arr2020,nct)
title('2020 Week50')
ylabel('Positivity rate')
xlabel('Different countries')
figure;
%hist(arr2021)
histfit(arr2021,nct)
title('2021 Week46')
ylabel('Positivity rate')
xlabel('Different countries')
%prepei na dokimasw diafores katanomes kai na brw poia tairiazei,mia idea
%pairnw optika apo to "Distribution Fitter" app/tool tou matlab alla prepei
%na sygkrinw analytika diafores katanomes ws pros to MSE ths ka8e mias
someDists = {'Normal' 'Exponential' 'Poisson' 'Gamma' 'HalfNormal' 'InverseGaussian' 'Nakagami' 'Logistic' 'Rician' 'Rayleigh'};
ndis = length(someDists);
mse2020 = zeros(ndis,1);
mse2021 = zeros(ndis,1);
%observed/empeirikh pdf apo deigma
pdfO2020 = arr2020./sum(arr2020);
pdfO2021 = arr2021./sum(arr2021);

bins2020 = linspace(1,nct,nct)';
bins2021 = linspace(1,nct,nct)';

fprintf('Testing some distributions and calculating mean square errors...\n');
fprintf('MSE 2020         MSE 2021         Distributions\n');
for j = 1:ndis
    %gia 2020
    FIT1 = fitdist(arr2020,someDists{j});
    %qqplot(arr2020,FIT1)
    %estimated/8ewrhtikh pdf basei ths antistoixhs katanomhs
    pdfE2020 = pdf(FIT1,bins2020);
    %plot(bins1,pdfE2020)
    %https://en.wikipedia.org/wiki/Mean_squared_error#Predictor
    mse2020(j) = 1/(nct*(sum(pdfO2020-pdfE2020)));
    figure;
    bar(pdfO2020)
    hold on
    plot(bins2020,pdfE2020)
    %title(someDists{j})
    title(sprintf('2020 Week50 fitted for distribution: %s',someDists{j}))
    ylabel('PDF positivity rate')
    xlabel('Countries')
    
    %gia 2021
    FIT1 = fitdist(arr2021,someDists{j});
    %qqplot(arr2021,FIT1)
    %estimated/8ewrhtikh pdf basei ths antistoixhs katanomhs
    pdfE2021 = pdf(FIT1,bins2021);
    %plot(bins1,pdfE2020)
    %https://en.wikipedia.org/wiki/Mean_squared_error#Predictor
    mse2021(j) = 1/(nct*(sum(pdfO2021-pdfE2021)));
    figure;
    bar(pdfO2021)
    hold on
    plot(bins2021,pdfE2021)
    %title(someDists{j})
    title(sprintf('2021 Week46 fitted for distribution: %s',someDists{j}))
    ylabel('PDF positivity rate')
    xlabel('Countries')
    
    %pause
    fprintf('%1.6f          %1.6f         %s\n',mse2020(j),mse2021(j),someDists{j});
end
%close all

%sygkrinontas ta mean square errors ,thelw to mikrotero wste na eimai konta
%sto mhden
[mse2020val, mse2020idx] = min(mse2020);
[mse2021val, mse2021idx] = min(mse2021);
%basei tou index briskw thn idanikh katanomh
suitableFitDist2020 = someDists(mse2020idx);
suitableFitDist2021 = someDists(mse2021idx);
fprintf('Suitable distribution for positivity rate on 25 countries at 2020 Week50 : %s\n',suitableFitDist2020{1});
fprintf('Suitable distribution for positivity rate on 25 countries at 2021 Week46 : %s\n',suitableFitDist2021{1});



%% Telika symperasmata
%Arxika,brhka thn xwra mou A=Slovakia .diabasa online gia to excel kai to 
%logical indexing . antlhsa ta dedomena kai genika prospa8hsa na apofygw ta""
%douleuontas me cell kai strcmp() .Meta,brhka gia thn ka8e xronia se poia 
%ebdomada exei h slovakia megisto deikth 8etikothtas kai sylleksa ta analoga
%dedomena gia tis 25xwres. Ta stoixeia htan 25 gia thn ka8e seira dedomenwn 
%opote h analysh kai h kalyterh proseggish basei optikhs se plots den htan
%kseka8arh opote epeleksa na prosdiorisw thn pio katallhlh katanomh me thn
%boh8eia tou fitdist gia merikes katanomes wste na ypologisw analytika basei 
%ari8mwn. Sygkekrimena epeleksa thn katallhloterh epilogh katanomhs basei tou 
%kalyterou MeanSquareError. Telos,katelhksa gia 2020 Week50 kanonikh katanomh
%kai gia 2021 Week46 ek8etikh katanomh ,ara den prosdiorizontai me thn idia
%parametrikh katanomh h "xwro-kratikh" sxesh tou deikth 8etikothtas twn 25xwrwn.


