%Analysh dedomenwn 2021-22 : zhthma 4
%Omada29 Stavros Vasileios Bouliopoulos 9671



%gia mia xwra deiktes apo 42-50ebdomada 2020 k 2021
function [arr2020,arr2021] =  Group29Exe4Fun2(CountrySel,countries,pos_rate,country7,yweek,level)
    i = 8;
    year1 = '2020';
    year2 = '2021';
    
    startingWeek1 = append(year1,'-W42');
    starting1 = find(strcmp(startingWeek1,yweek(:)) & strcmp(country7(:),countries(CountrySel)) & strcmp(level(:),'national'));
    ending1 = starting1 + i;
    
    startingWeek2 = append(year2,'-W42');
    starting2 = find(strcmp(startingWeek2,yweek(:)) & strcmp(country7(:),countries(CountrySel)) & strcmp(level(:),'national'));
    ending2 = starting2 + i;
    
    arr2020 = zeros(1,i);
    arr2021 = zeros(1,i);
    for j = starting1:ending1
        arr2020(j-starting1+1) = pos_rate(j);
    end
    for j = starting2:ending2
        arr2021(j-starting2+1) = pos_rate(j);
    end
end

