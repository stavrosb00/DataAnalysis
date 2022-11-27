%Analysh dedomenwn 2021-22 : zhthma 6
%Omada29 Stavros Vasileios Bouliopoulos 9671
%email: smpoulio@ece.auth.gr


close all
clc;
%synexizontas me idio workspace apo zhthma 5
%% antlhsh dedomenwn kai mia optikh idea se scatter plots

A = grec2021; %ellada
B = arr2021(Rid(1),:); %h prwth kalyterh xwra gia sysxetish me ellada(Slovakia)
C = arr2021(Rid(2),:); %h deuterh = Polwnia

% X = [A B]; %zeugari1
% Y = [A C]; %zeugari2

figure;
scatter(B,C);
refline;
hold on
title('Scatter plot[Positivity rate]')
ylabel(countries{CountrySel(Rid(2))})
xlabel(countries{CountrySel(Rid(1))})



%%%%%%%%%%%%%%%%%%%
%% elegxo gia isothta sysxetishs me bootstrap h me tyxaiopoihsh [ypo8esh H0: r_BmeA - r_CmeA = 0]

A = grec2021; %ellada
%B = arr2021(Rid(1),:); %h prwth kalyterh xwra gia sysxetish me ellada(Slovakia)
%C = arr2021(Rid(2),:); %h deuterh = Polwnia
B = B';
C = C';

% [A B] %zeugari1
% [A C] %zeugari2


%% prokartaktika gia elegxo ypo8eshs (Ellada-A koinh bash sygkrishs , B kai C na paizoun me bootstrap h me tyxaiopoihsh)

L = 1000; %deigmata epanalhpshs
alpha = 0.05;


Rb = corrcoef(B,A);
Rb = Rb(1,2);
Rc = corrcoef(C,A);
Rc = Rc(1,2);
dmx = Rb - Rc;

m = length(C);
n = length(B);

pvaldmxM = NaN(1,2); %prwta gia bootstrap ,deutera gia tyxaiopoihsh
bootdmxV = NaN(L,1);
%% bootstrap gia diafora sysxetisewn
for iB=1:L
    rV = unidrnd(n+m,n+m,1);
    xyV = [B(:); C(:)];
    xbV = xyV(rV(1:n));
    ybV = xyV(rV(n+1:n+m));
    
    RxbV = corrcoef(xbV,A);
    RxbV = RxbV(1,2);
    
    RybV = corrcoef(ybV,A);
    RybV = RybV(1,2);
    
    bootdmxV(iB) = RxbV - RybV;
end
alldmxV = [dmx; bootdmxV];
[~,idmxV] = sort(alldmxV);
rankdmx0 = find(idmxV == 1);
% With the following, strange situations are handled, such as all
% statistics (original and bootstrap) are identical or there are
% bootstrap statistics identical to the original.
multipledmxV = find(alldmxV==alldmxV(1));
if length(multipledmxV)==L+1
    rankdmx0=round(n/2); % If all identical give rank in the middle
elseif length(multipledmxV)>=2
    irand = unidrnd(length(multipledmxV));
    rankdmx0 = rankdmx0+irand-1; % If at least one bootstrap statistic 
           % identical to the original pick the rank of one of them at
           % random  
end
if rankdmx0 > 0.5*(L+1)
    pvaldmxM(1) = 2*(1-rankdmx0/(L+1));
else
    pvaldmxM(1) = 2*rankdmx0/(L+1);
end

%% tyxaiopoihsh gia diafora sysxetisewn
for iB=1:L
    rV = randperm(n+m);
    xyV = [B(:); C(:)];
    xbV = xyV(rV(1:n));
    ybV = xyV(rV(n+1:n+m));
    
    RxbV = corrcoef(xbV,A);
    RxbV = RxbV(1,2);
    
    RybV = corrcoef(ybV,A);
    RybV = RybV(1,2);
    
    bootdmxV(iB) = RxbV - RybV;
end
alldmxV = [dmx; bootdmxV];
[~,idmxV] = sort(alldmxV);
rankdmx0 = find(idmxV == 1);
% With the following, strange situations are handled, such as all
% statistics (original and bootstrap) are identical or there are
% bootstrap statistics identical to the original.
multipledmxV = find(alldmxV==alldmxV(1));
if length(multipledmxV)==L+1
    rankdmx0=round(n/2); % If all identical give rank in the middle
elseif length(multipledmxV)>=2
    irand = unidrnd(length(multipledmxV));
    rankdmx0 = rankdmx0+irand-1; % If at least one bootstrap statistic 
           % identical to the original pick the rank of one of them at
           % random  
end
if rankdmx0 > 0.5*(L+1)
    pvaldmxM(2) = 2*(1-rankdmx0/(L+1));
else
    pvaldmxM(2) = 2*rankdmx0/(L+1);
end

%% apotelesmata
fprintf('p-val of rejection of equal correlation at alpha=%1.3f, bootstrap = %1.3f \n',...
    alpha,pvaldmxM(1)); 
fprintf('p-val of rejection of equal correlation at alpha=%1.3f, randomization = %1.3f \n',...
    alpha,pvaldmxM(2)); 





%% (IGNORE)
%xoxoxo = Group29Exe6Fun1(X,Y);
% figure;
% scatter(X,Y);
% refline;
% hold on
% title('Scatter plot[Positivity rate]')
% ylabel('2nd combination')
% xlabel('1st combination')  
% hold off


% %% analysh gia elegxo syntelestwn sysxetishs isothtas twn 2 zeugariwn me bootstrap(unirnd) kai tyxaiopoihsh(randperm) 
% fprintf('We combined Greece with %s into one vector and with %s into other vector ,so we can make hypothesis testing(bootstrap and randomization) for zero \ncorrelation between these new 2 vectors. This will help us even more to find for which country is the best correlation of Greece.\n',countries{CountrySel(Rid(1))},countries{CountrySel(Rid(2))});
% 
% btstrp = 0; %a=0.05
% btstrp2 = 0; %a=0.01
% random = 0;
% random2 = 0;
% L = 100;
% comb = 2*weeks;
% a1 = 0.05;
% a2 = 0.01;
% 
% 
% [Rtemp,~,~,~] = corrcoef(X,Y); %1o gia syntelesth pearson sthn 8esh (1,2),2o p-value,3o lower bound,4o upper bound
% R = Rtemp(1,2); %pearson
% 
% t0 = R*sqrt((comb-2)/(1-R^2));
% 
% %% elegxo ypo8eshs me tyxaiopoihsh
% t = zeros(L,1);
% for j = 1:L
%     %deigma apo tyxaiopoihsh
%     tmpPerm = Y;
%     tmpPerm = tmpPerm(randperm(comb)); %n+m
%     %ypologizw to t
%     Rrand = corrcoef(tmpPerm,X);
%     t(j) = Rrand(1,2)*sqrt( (comb-2)/(1-Rrand(1,2)^2) );
% end
% t = sort(t);
% %ypologismo diasthmatos empistosynhs
% alpha = a1*100;
% percentiles = [alpha/2 (100-alpha)/2];
% alpha2 = a2*100;
% percentiles2 = [alpha2/2 (100-alpha2)/2];
% 
% CI = prctile(t,percentiles);
% CI2 = prctile(t,percentiles2);
% 
% if( t0 < CI(1) || t0 > CI(2) )
%     random = 1;
% end
% if( t0 < CI2(1) || t0 > CI2(2) )
%     random2 = 1;
% end
% 
% %% elegxo ypo8eshs me bootstrap
% t = zeros(L,1);
% for j = 1:L
%     %deigma apo bootstrap
%     tmpBoot = Y;
%     tmpBoot = tmpBoot(unidrnd(comb,comb,1)); %n+m
%     %ypologizw to t
%     Rboot = corrcoef(tmpBoot,X);
%     t(j) = Rboot(1,2)*sqrt( (comb-2)/(1-Rboot(1,2)^2) );
% end
% t = sort(t);
% 
% btCI = prctile(t,percentiles);
% btCI2 = prctile(t,percentiles2);
% 
% if( t0 < btCI(1) || t0 > btCI(2) )
%     btstrp = 1;
% end
% if( t0 < btCI2(1) || t0 > btCI2(2) )
%     btstrp2 = 1;
% end
% fprintf('                                                                 Bootstrap(%0.2f) Bootstrap(%0.2f)    Randomization(%0.2f) Randomization(%0.2f),\n',a1,a2,a1,a2);
% fprintf('Confidence intervals:                                       [%0.5f,%0.5f] [%0.5f,%0.5f] [%0.5f,%0.5f] [%0.5f,%0.5f] \n',CI(1),CI(2),CI2(1),CI2(2),btCI(1),btCI(2),btCI2(1),btCI2(2));
% fprintf('Hypothesis testing for zero correlation between 2 new vectors:  %0.9f     %0.9f         %0.9f         %0.9f\n', btstrp, btstrp2,random,random2);
% 
% 
% 
% fprintf('\n Now we can make hypothesis testing(bootstrap and randomization) for equal mean between these new 2 vectors. This will help us even more \nto find for which country is the best correlation of Greece.\n');
% 

%%%%%%%%%%%%%%%%%%%%%%%%IGNORE ABOVE SECTION%%%%%%%%%%%%%%%%%%%%%%%%


%% Telika symperasmata
%A=Ellada eixe thn megalyterh sysxetish kata Pearson me thn xwra B=Slovakia
%kai meta me thn xwra C=Polwnia. Exw ta zeugaria (A B) kai (A C) kai thelw
%na kanw thn ekshs mhdenikh ypo8esh H0 : sysxetish_AmeB - sysxetish_AmeC=0
%kai katalhgw oses fores etreksa to programma basei ths tyxaiothtas twn
%epandeigmatolhptoumenwn stoixeiwn na exw p-value na kymainetai 0.75me0.82
%to opoio einai poly megalytero alpha=0.05 ara DEN mporw na pw me
%bebaiothta (D.E.=95%) oti h ypo8esh aporriptetai. Dhladh exw mhdenikh
%ypo8esh H0 not rejected. Ara h sysxetish ths Elladas(A) einai ontws poly
%isxyroterh me thn Slovakia(B) ap'oti me thn Polwnia(C) kai den
%eksomoiwnontai.