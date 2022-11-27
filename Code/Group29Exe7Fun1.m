%Analysh dedomenwn 2021-22 : zhthma 7
%Omada29 Stavros Vasileios Bouliopoulos 9671

%gia na brei thn aplh grammikh palindromish basei beltisths ysterhshs
function xoxo = Group29Exe7Fun1(X,Y,period)
xoxo = 0;

    nx = length(X);
    ysterhsh = 5;
    allRMSE = zeros(nx-ysterhsh+1,1);
    allRsq = zeros(nx-ysterhsh+1,1);
    %na dokimasw montela gia ysterhsh ws kai 5 ebdomades prin
    for k = 0:(nx-ysterhsh)
        %problepsh
        Xyst = X(1:nx-k); %deikths 8etikothtas
        Yyst = Y(1+k:nx); %pososto thanatou
        tempLM = fitlm(Xyst,Yyst);
        eSt = tempLM.Residuals.Raw/tempLM.RMSE;
        allRMSE(k+1) = tempLM.RMSE;
        allRsq(k+1) = tempLM.Rsquared.Ordinary;

        figure;
        scatter(Yyst,eSt);
        annotation('textbox', [0.169, 0.8, 0.1, 0.1], 'String', "RMSE = " + allRMSE(k+1))
        annotation('textbox', [0.169, 0.7, 0.1, 0.1], 'String', "R^2 = " + allRsq(k+1))
        hold on;
        plot(xlim,[1.96 1.96]);
        hold on;
        plot(xlim,[0 0]);
        hold on;
        plot(xlim,[-1.96 -1.96]);
        title(sprintf('Diagnostic plot[Ysterhsh %d ebdomades prin]',nx-k));
        xlabel('y')
        ylabel('e*');
    end
    [bestRMSE,idRMSE] = mink(allRMSE,3);
    [bestRsq,idRsq] = maxk(allRsq,3);
    %disp(idRMSE)


    b = tempLM.Coefficients.Estimate;
    %% to montelo gia beltisth ysterhsh bghke gia idRMSE dhladh otan kseroume gia nx-(idRMSE(1)-1) ebdomades prin exoume kalyterh problepsh

    Xbest = X(1:nx-(idRMSE(1)-1))'; 
    Ybest = Y(1+(idRMSE(1)-1):nx)'; 
    bestLM = fitlm(Xyst,Yyst);
    b = bestLM.Coefficients.Estimate;
    Ytrained = [ones(length(Xbest),1) Xbest]*b;
    figure;
    subplot(2,1, 1)
    plot(1:nx,X);
    hold on
    plot(1+(idRMSE(1)-1):nx,Ytrained,'LineWidth',2.169,'Color','r');
    title(sprintf('%s',period))
    xlabel('Weeks')
    ylabel('Deaths per million')
    legend('Deaths per million','Best simple linear regression','Location','best')
    hold off
    
    r = corrcoef(Xbest,Ybest); 
    r = r(1,2);
    subplot(2,1, 2)
    scatter(Xbest,Ybest)
    hold on
    refline
    title(sprintf('Scatter plot[Ysterhsh %d ebdomades prin]',nx-(idRMSE(1)-1)))
    ylabel('Deaths per million')
    xlabel('Positivity rate') 
    annotation('textbox', [0.169, 0.3, 0.1, 0.1], 'String', "r = " + r)
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]); 
    set(gcf,'name','Predicted/trained VS Real on best simple linear regression :)','numbertitle','off')
end