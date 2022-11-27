%Analysh dedomenwn 2021-22 : zhthma 4
%Omada29 Stavros Vasileios Bouliopoulos 9671


%% Hypothesis testing for mean difference (opws shmeiwseis 3.4 kef)
%gia na sygkrinw ta 2 deigmata apo tis 2 diaforetikes xronies
function [hypoAllv2,dmx] =  Group29Exe4Fun3(X,Y)
    
    %X = arr2020(i,:)
    %Y = arr2021(i,:)
    X = X';
    Y = Y';
    %X Nx1 thelw
    
    B = 1000;
    n = length(X);
    m = length(Y);
    alpha = 0.05;

    xmV = mean(X);
    xsdV = std(X);
    ymV = mean(Y);
    ysdV = std(Y);
    pvals = NaN(1,3); %p-values gia 1->parametric test,2->bootstrap test,3->randomization test
    hypoAllv2 = NaN(1,3);

    %% Parametric hypothesis testing for mean difference
    dmx = xmV - ymV;
    figure;
    xoxo2 = [xmV ymV dmx];
    stem(xoxo2)
    hold on
    title('LEFT=mean of 2months at 2020 , MID=same for 2021 , RIGHT=mean difference')
    hold off
%     p1 = stem(xmV,':diamondr')
%     hold on
%     p2 = stem(ymV,':diamondr')
%     p3 = stem(dmx,'b')
    vardxt = (xsdV^2*(n-1)+ysdV^2*(m-1)) / (n+m-2);
    sddxt = sqrt(vardxt);
    tsample = dmx / (sddxt * sqrt(1/n+1/m));
    pvals(1) = 2*(1-tcdf(abs(tsample),n+m-2)); % p-value for two-sided test
    %% Bootstrap hypothesis testing for mean difference
    bootdmxV = NaN(B,1);
    for iB=1:B
        rV = unidrnd(n+m,n+m,1);
        xyV = [X(:); Y(:)];
        xbV = xyV(rV(1:n));
        ybV = xyV(rV(n+1:n+m));
        bootdmxV(iB) = mean(xbV)-mean(ybV);
    end
    alldmxV = [dmx; bootdmxV];
    [~,idmxV] = sort(alldmxV);
    rankdmx0 = find(idmxV == 1);
    % With the following, strange situations are handled, such as all
    % statistics (original and bootstrap) are identical or there are
    % bootstrap statistics identical to the original.
    multipledmxV = find(alldmxV==alldmxV(1));
    if length(multipledmxV)==B+1
        rankdmx0=round(n/2); % If all identical give rank in the middle
    elseif length(multipledmxV)>=2
        irand = unidrnd(length(multipledmxV));
        rankdmx0 = rankdmx0+irand-1; % If at least one bootstrap statistic 
               % identical to the original pick the rank of one of them at
               % random  
    end
    if rankdmx0 > 0.5*(B+1)
        pvals(2) = 2*(1-rankdmx0/(B+1));
    else
        pvals(2) = 2*rankdmx0/(B+1);
    end
    %% Randomization hypothesis testing for mean difference
    randdmxV = NaN(B,1);
    for iB=1:B
        rV = randperm(n+m);
        xyV = [X(:); Y(:)];
        xbV = xyV(rV(1:n));
        ybV = xyV(rV(n+1:n+m));
        randdmxV(iB) = mean(xbV)-mean(ybV);
    end
    alldmxV = [dmx; randdmxV];
    [~,idmxV] = sort(alldmxV);
    rankdmx0 = find(idmxV == 1);
    % With the following, strange situations are handled, such as all
    % statistics (original and randomized) are identical or there are
    % randomized statistics identical to the original.
    multipledmxV = find(alldmxV==alldmxV(1));
    if length(multipledmxV)==B+1
        rankdmx0=round(n/2); % If all identical give rank in the middle
    elseif length(multipledmxV)>=2
        irand = unidrnd(length(multipledmxV));
        rankdmx0 = rankdmx0+irand-1; % If at least one randstrap statistic 
               % identical to the original pick the rank of one of them at
               % random  
    end
    if rankdmx0 > 0.5*(B+1)
        pvals(3) = 2*(1-rankdmx0/(B+1));
    else
        pvals(3) = 2*rankdmx0/(B+1);
    end

    fprintf(' alpha=%1.3f, parametric p-val for rejection of equal mean =  %1.3f. ',alpha,pvals(1));
    if pvals(1)<alpha
        hypoAllv2(1) = 1;
        fprintf('[Null hypothesis rejected]A significant difference does exist between 2 means of samples.\n');
    else
        hypoAllv2(1) = 0;
        fprintf('[Null hypothesis not rejected]CANNOT ensure that a significant difference does exist between 2 means of samples.\n');
    end
    fprintf('alpha=%1.3f, bootstrap p-val for rejection of equal mean =  %1.3f. ',alpha,pvals(2)); 
    if pvals(2)<alpha
        hypoAllv2(2) = 1;
        fprintf('[Null hypothesis rejected]A significant difference does exist between 2 means of samples.\n');
    else
        hypoAllv2(2) = 0;
        fprintf('[Null hypothesis not rejected]CANNOT ensure that a significant difference does exist between 2 means of samples.\n');
    end
    fprintf('alpha=%1.3f, randomization p-val for rejection of equal mean =  %1.3f. ',alpha,pvals(3)); 
    if pvals(3)<alpha
        hypoAllv2(3) = 1;
        fprintf('[Null hypothesis rejected]A significant difference does exist between 2 means of samples.\n');
    else
        hypoAllv2(3) = 0;
        fprintf('[Null hypothesis not rejected]CANNOT ensure that a significant difference does exist between 2 means of samples.\n');
    end
end