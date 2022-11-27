%Analysh dedomenwn 2021-22 : zhthma 5
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


%% antlhsh dedomenwn gia ellada + gia Slovakia kai 4 geitonikes xwres
weeks = 13; %38me50
CountrySel = [20 21 22 23 24]; %polwnia-portogalia-SLOVAKIA-slovenia- s(pain)
nsel = length(CountrySel);
arr2021 = zeros(nsel,weeks);
%gia ka8e xwra apo tis 5
for i = 1:nsel
    %antlhsh positivity rates gia tis 5 xwres
    [arr2021(i,:)] =  Group29Exe5Fun1(CountrySel(i),countries,pos_rate,country7,yweek,level);
    %se ka8e epanalhpsh sxhmatizw thn poreia tou deikth 8etikothtas se ka8e
    %xwra apo autes tis 5
    txtCt = countries{CountrySel(i)};
    figure;
    subplot(2,1, 1);
    stem(arr2021(i,:))
    hold on
    title(sprintf('Positivity rate for %s 38-50weeks in 2021',txtCt)) 
    xlabel('Weeks 38->50')
    ylabel('Positivity rate')
    
    subplot(2,1, 2);
    boxplot(arr2021(i,:))
    hold on
    title(sprintf('Boxplot  for %s 38-50weeks in 2021',txtCt))
    hold off
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]); 
    set(gcf,'name','Boxplot positivity rates by Stavros :)','numbertitle','off')
end
%sxhmatizw kai tis 5 xwres se ena plot
figure(69);
p20 = plot(arr2021(1,:),'r');  %'g'  'b' 'c' 'm'
hold on
p21 = plot(arr2021(2,:),'g');
hold on
p22 = plot(arr2021(3,:),'b','LineWidth',2);
hold on
p23 = plot(arr2021(4,:),'c');
hold on
p24 = plot(arr2021(5,:),'m');
legend([p20 p21 p22 p23 p24],{countries{CountrySel(1)},countries{CountrySel(2)},countries{CountrySel(3)},countries{CountrySel(4)},countries{CountrySel(5)} }) 
title('Positivity rate for all 5 countries[38-50weeks in 2021]')
xlabel('Weeks 38->50')
ylabel('Positivity rate')
hold off

%gia ellada apo arxeio twn 7days testing kai oxi EODY 1-by-1 hmera
grec2021 = zeros(1,weeks);
[grec2021] =  Group29Exe5Fun1(-1,countries,pos_rate,country7,yweek,level);
figure;
subplot(2,1, 1);
stem(arr2021(i,:))
hold on
title(sprintf('Positivity rate for %s 38-50weeks in 2021','Greece')) 
xlabel('Weeks 38->50')
ylabel('Positivity rate')

subplot(2,1, 2);
boxplot(arr2021(i,:))
hold on
title(sprintf('Boxplot  for %s 38-50weeks in 2021','Greece'))
hold off
set(gcf, 'units','normalized','outerposition',[0 0 1 1]); 
set(gcf,'name','Boxplot positivity rates by Stavros :)','numbertitle','off')


%%  sysxetish elladas me ka8e xwra apo tis 5=>syntelesth Pearson kai elegxo shmantikothtas syntelesth syxetishs me parametric kai tyxaiopoihsh
R = zeros(nsel,1);
P = zeros(nsel,1); %a=0.05
P2 = zeros(nsel,1); %0.01
paramHypo = zeros(nsel,1); 
param2Hypo = zeros(nsel,1);
randomHypo = zeros(nsel,1);
random2Hypo = zeros(nsel,1);
L = 100;
a1 = 0.05;
a2 = 0.01;
fprintf('H0 = 1[Rejected,we may have significant correlation]  H0 = 0[Not rejected,there is no way of having significant correlation]\n');
fprintf('                                                                 Parametric(%0.2f) Parametric(%0.2f) Randomization(%0.2f) Randomization(%0.2f),\n',a1,a2,a1,a2);
for i = 1:nsel
    %Pearson syntelestes kai pamaetrikoi elegxoi
    [Rtemp,Ptemp,~,~] = corrcoef(grec2021,arr2021(i,:)); %1o gia syntelesth pearson sthn 8esh (1,2),2o p-value,3o lower bound,4o upper bound
    R(i) = Rtemp(1,2); %pearson
    P(i) = Ptemp(1,2);%p-value gia default alpha=0.05
    if( P(i) < a1 )
        paramHypo(i) = 1;
    end
    [~,Ptemp,~,~] = corrcoef(grec2021,arr2021(i,:),'Alpha',a2);
    P2(i)=Ptemp(1,2);
    if( P2(i) < a2 )
        param2Hypo(i) = 1;
    end
    
    %elegxo ypo8eshs me tyxaiopoihsh
    t0 = R(i)*sqrt((weeks-2)/(1-R(i)^2));
    t = zeros(L,1);
    for j = 1:L
        %deigma apo tyxaiopoihsh
        tmpPerm = arr2021(i,:);
        tmpPerm = tmpPerm(randperm(weeks));
        %ypologizw to t
        Rrand = corrcoef(tmpPerm,grec2021);
        t(j) = Rrand(1,2)*sqrt( (weeks-2)/(1-Rrand(1,2)^2) );
    end
    t = sort(t);
    %ypologismo diasthmatos empistosynhs
    alpha = a1*100;
    percentiles = [alpha/2 (100-alpha)/2];
    alpha2 = a2*100;
    percentiles2 = [alpha2/2 (100-alpha2)/2];
    
    CI = prctile(t,percentiles);
    CI2 = prctile(t,percentiles2);
    
    if( t0 < CI(1) || t0 > CI(2) )
        randomHypo(i) = 1;
    end
    if( t0 < CI2(1) || t0 > CI2(2) )
        random2Hypo(i) = 1;
    end

    fprintf('Hypothesis testing for zero correlation between Greece and %s: %0.9f     %0.9f       %0.9f       %0.9f\n',countries{CountrySel(i)}, paramHypo(i), param2Hypo(i),randomHypo(i),random2Hypo(i));

    %scatter plot gia Ellada me thn ka8e xwra
    figure;
    scatter(arr2021(i,:),grec2021);
    refline;
    hold on
    title('Scatter plot[Positivity rate]')
    ylabel('Greece')
    xlabel(countries{CountrySel(i)}) %eksarthmenh metablhth
    %legend(sprintf('r = %0.5f',R(i)),'Location','northwest')
    annotation('textbox', [0.169, 0.8, 0.1, 0.1], 'String',sprintf('r = %0.5f',R(i))) 
    hold off
end
disp(P);
disp(P2);
%^^statistika shmantikoterh sysxetish Ellada me Slovakia
[Rval,Rid] = maxk(R,2); %thn kalyterh sysxetish ws pros Pearson syntelesth
fprintf('\nGreece has the best Pearson correlation(r = %0.5f) and statistical correlation(p-values) with %s!\n',Rval(1),countries{CountrySel(Rid(1))});

%% Telika symperasmata
%(Antlhsh dedomenwn omoiws me zhthma 4 gia tis 5 xwres. Phra kai gia Ellada 
%apo to 7days testing arxeio tis 38->50ebdomades pou h8ela. Sxediasa kapoia
%stem kai boxplots gia thn ka8e xwra kai ena eniaio plot gia tis 5 xwres 
%opou fainontai olwn h klimakwsh.)
%H Ellada se sxesh me thn Ispania kai thn Slovenia exei thn mikroterh
%sysxetish kati to opoio einai fanero apo diagrammata kai apo syntelesth
%Pearson. Analytikotera auto fainetai apo tous elegxous ypo8eshs mhdenikhs 
%sysxetishs ka8ws H0 = 0 gia Ispania(kai gia tis 2 shmantikothtes) kai 
%Slovenia(gia shmantikothta a=0.01). Telika, h Ellada exei thn megalyterh 
%sysxetish stous deiktes 8etikothtas me thn Slovakia, to opoio fainetai sta
%diagrammata,sto megisto syntelesth Pearson kai sta statistika apo elegxous
%ypo8eshs. Epomenh,megalyterh sysxetish exei me thn Polwnia pou tha mas
%xreiastei kai sto zhthma 6.(Slovakia-Polwnia synoreuoun kiolas pragmatika)
