%Analysh dedomenwn 2021-22 : zhthma 4
%Omada29 Stavros Vasileios Bouliopoulos 9671


%gia na brw katallhlh katanomh gia parametriko elegxo basei MSE
function suitableFitDist =  Group29Exe4Fun1(arr,someDists)
    %arr: 1x9-> arr' : 9x1
    %arr = arr(1,:)
    %arr = cell2mat(arr);
    %someDists = cell2mat(someDists);
    arr = arr';
    ndis = length(someDists);
    narr = length(arr);
    mse = zeros(ndis,1);
    %observed/empeirikh pdf apo deigma
    pdfO = arr./sum(arr);
    bins = linspace(1,narr,narr)';
    
    for j = 1:ndis
        FIT1 = fitdist(arr,someDists{j});
        %qqplot(arr2020,FIT1)
        %estimated/8ewrhtikh pdf basei ths antistoixhs katanomhs
        pdfE = pdf(FIT1,bins);
        %https://en.wikipedia.org/wiki/Mean_squared_error#Predictor
        mse(j) = 1 / (narr*(sum(pdfO-pdfE)));
        %mse2020(j) = 1/(nct*(sum(pdfO2020-pdfE2020)));
    end
    %sygkrinontas ta mean square errors ,thelw to mikrotero wste na eimai konta
    %sto mhden
    [mseVal, mseIdx] = min(mse);
    %basei tou index briskw thn idanikh katanomh
    suitableFitDist = someDists(mseIdx);
    %fprintf('%s \n',suitableFitDist{1});
    fprintf('%s/%1.5f     ',suitableFitDist{1},mseVal);
end


