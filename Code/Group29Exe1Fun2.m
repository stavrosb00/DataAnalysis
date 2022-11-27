%Analysh dedomenwn 2021-22 : zhthma 1
%Omada29 Stavros Vasileios Bouliopoulos 9671

%ebdomades
function [pos_rate,country7,yweek,level] =  Group29Exe1Fun2()
opts = detectImportOptions('ECDC-7Days-Testing.xlsx');
data = readtable('ECDC-7Days-Testing.xlsx',opts);
%head(data,69)
pos_rate = data.positivity_rate;
country7 = data.country;
yweek = data.year_week;
level = data.level;
clear opts data
end



