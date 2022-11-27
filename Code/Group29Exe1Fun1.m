%Analysh dedomenwn 2021-22 : zhthma 1
%Omada29 Stavros Vasileios Bouliopoulos 9671

%xwres
function [ct_indexes,countries] =  Group29Exe1Fun1()
opts = detectImportOptions('EuropeanCountries.xlsx');
data = readtable('EuropeanCountries.xlsx',opts);
ct_indexes = data.A_A;
countries = data.Country;
clear opts data
end
%logidx = strcmp(countries(22),'Slovakia') %<-----douleuei