%Analysh dedomenwn 2021-22 : zhthma 6
%Omada29 Stavros Vasileios Bouliopoulos 9671

%% IGNORE FUNCTION NOT USED IN THE END
function [xoxoxo] =  Group29Exe6Fun1(X,Y)
    %% analysh gia elegxo ypo8eshs diaforas meswn timwn me bootstrap kai tyxaiopoihsh
    xoxoxo=0;
    B = 1000;
    n = length(X);
    m = length(Y);
    a1 = 0.05;
    xmV = mean(X);
    xsdV = std(X);
    ymV = mean(Y);
    ysdV = std(Y);
    pvals = NaN(1,3); %p-values gia 1->parametric test,2->bootstrap test,3->randomization test

    dmx = xmV - ymV;
    % %% Parametric hypothesis testing for mean difference ,to pairnw kai auto thewrwntas kanonikh katanomh an thelw
    % dmx = xmV - ymV;
    % vardxt = (xsdV^2*(n-1)+ysdV^2*(m-1)) / (n+m-2);
    % sddxt = sqrt(vardxt);
    % tsample = dmx / (sddxt * sqrt(1/n+1/m));
    % pvals(1) = 2*(1-tcdf(abs(tsample),n+m-2)); % p-value for two-sided test
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

    %fprintf(' alpha=%1.3f, parametric p-val for rejection of equal mean =  %1.3f \n',alpha,pvals(1)); 
    fprintf('alpha=%1.3f, bootstrap p-val for rejection of equal mean   =  %1.3f \n',a1  ,pvals(2)); 
    fprintf('alpha=%1.3f, randomization p-val for rejection of equal mean =  %1.3f \n',a1,pvals(3)); 
    if pvals(2) < a1
        fprintf('bootstrap:[H0 Rejected]We may have equal means\n')
    else
        fprintf('bootstrap:[H0 Not rejected]There is no way of having significant equal means\n')  
    end

    if pvals(3) < a1
        fprintf('randomization:[H0 Rejected]We may have equal means\n')
    else
        fprintf('randomization:[H0 Not rejected]There is no way of having significant equal means\n')  
    end
end