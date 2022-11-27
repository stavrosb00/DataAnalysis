%Analysh dedomenwn 2021-22 : zhthma 5
%Omada29 Stavros Vasileios Bouliopoulos 9671

%gia mia xwra deiktes apo 38-50ebdomada 2021
function [arr2021] =  Group29Exe5Fun1(CountrySel,countries,pos_rate,country7,yweek,level)
    i = 12; %38me50W
    year = '2021';
    startingWeek = append(year,'-W38');
    %ellada exception
    if CountrySel == -1
        starting = find(strcmp(startingWeek,yweek(:)) & strcmp(country7(:),'Greece') & strcmp(level(:),'national'));
    else
        starting = find(strcmp(startingWeek,yweek(:)) & strcmp(country7(:),countries(CountrySel)) & strcmp(level(:),'national'));
    end
    ending = starting + i;
    
    arr2021 = zeros(1,i);
    for j = starting:ending
        arr2021(j-starting+1) = pos_rate(j);
    end
end