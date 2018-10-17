%Mitchell's initial testing with getting plots of our data
%This one will be Australia's GDP vs Year
clear
clc
%initializations
load('D6ClimateData.mat');
AUS_GDP = [];
AUS_YEAR = [];
currentIndex = 1; %Because arrays start at 1 and not 0. For some reason.

%finding Australia in the data set
while (COUNTRY_TEXT(currentIndex) ~= "Australia")
    currentIndex = currentIndex + 1;
end
%currentIndex is now the start of Australia data

%now pull data and move it to local arrays AUS_GDP and AUS_YEAR
while (COUNTRY_TEXT(currentIndex) == "Australia")
    AUS_GDP = [AUS_GDP, GDP(currentIndex)];
    AUS_YEAR = [AUS_YEAR, YEAR(currentIndex)];
    currentIndex = currentIndex + 1;
end

%When in doubt, plot it out
semilogy(AUS_YEAR, AUS_GDP); % <-- Thats an exponential curve if I've ever seen one

%Time to plot line of best fit
fitConstants = polyfit(AUS_YEAR, log(AUS_GDP),1);
m = fitConstants(1);
b = exp(fitConstants(2));
bestFitY = b * exp(m*AUS_YEAR);
hold on
plot(AUS_YEAR, bestFitY);
xlabel ("Year");
ylabel("Population of Australia");
title("Population of Australia vs. Time");
disp ("Best fit in form y = b*e^(mx)
b
m
