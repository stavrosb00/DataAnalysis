%Analysh dedomenwn 2021-22 : zhthma 3
%Omada29 Stavros Vasileios Bouliopoulos 9671


%eody data
function [date ,newCases ,pcrT,rapidT,eodyWeek,eodyDay] =  Group29Exe3Fun1()
opts = detectImportOptions('FullEodyData.xlsx');
data = readtable('FullEodyData.xlsx',opts);
%head(data,69)
date = data.Date;
newCases = data.NewCases;
pcrT = data.PCR_Tests;
rapidT = data.Rapid_Tests;
eodyWeek = data.Week;
eodyDay = data.Day;
clear opts data
end
