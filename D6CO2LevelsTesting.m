%Mitchell's initial testing with getting plots of our data
%This will be population vs. CO2(emissions?) of Caribbean island nations
clear 
clc
load('D6ClimateData.mat');
%COUNTRIES = ["Bahamas", "Cuba", "Barbados", "Dominican Republic", "Jamaica", "Haiti", ...
    %"Trinidad & Tobago", "Saint Kitts & Nevis", "Antigua & Barbuda", "Grenada"];
%COUNTRIES = ["United Kingdom", "Australia", "Japan", "Iceland", "New Zealand", "Greenland", "Cuba"];
%COUNTRIES = ["United States", "China", "Japan", "Germany", "United Kingdom", "France", "India", "Italy", "Brazil", "Canada"];
COUNTRIES = ["Germany", "United Kingdom", "Italy", "Spain", "Poland", "Sweden", "Norway", "Iceland", "Portugal"];
LOC_POPULATIONS = [];
CO2 = [];
currentIndex = 1;
while (currentIndex < length(POPULATION))
    %Use year as initial condition, because year will trigger the fewest
    %calls, and therefore save time
    if(YEAR(currentIndex) == 2000) 
        %Counter is temp variable just for looking through the list of countries we care about
        counter = 1; 
        while (counter <= length(COUNTRIES)) 
            %Is the country one in our list?
            if(COUNTRY_TEXT(currentIndex) == COUNTRIES(counter))
                %If so, grab its data
                LOC_POPULATIONS = [LOC_POPULATIONS, POPULATION(currentIndex)];
                CO2 = [CO2, CARBON_DIOXIDE(currentIndex)];
            end
            counter = counter + 1;
        end
    end
    currentIndex = currentIndex + 1;
end
disp ("Unsorted Pop: ");
disp (LOC_POPULATIONS);
disp ("Unsorted CO2: ");
disp (CO2);
%Now we have Population and CO2 data for our desired countries
%Population is our Independant variable, so we want to sort its dataset
%We'll sort it lowest to highest
%We need to make sure indicies between it and CO2 still match

DATA_ARRAY = zeros (2, length(LOC_POPULATIONS)); %R1 will be population R2 will be CO2

%For those keeping track at home, I'll be using a selection sort for this.
solutionIndex = 1;
while (solutionIndex <= length(DATA_ARRAY(1,:)))
    targetIndex = 1;
    removeMe = 1;
    DATA_ARRAY(1, solutionIndex) = LOC_POPULATIONS(1);%Set to the first, compare and replace to that
    DATA_ARRAY(2, solutionIndex) = CO2(1);
    while (targetIndex <= length(LOC_POPULATIONS))
        if(LOC_POPULATIONS(targetIndex) < DATA_ARRAY(1, solutionIndex)) %Finding the minimum
            DATA_ARRAY(1, solutionIndex) = LOC_POPULATIONS(targetIndex);
            DATA_ARRAY(2, solutionIndex) = CO2(targetIndex);
            removeMe = targetIndex;%The index of the minimum
        end
        targetIndex = targetIndex + 1;%Go to next index so we can see if its a new minimum
    end
    LOC_POPULATIONS(removeMe) = []; %Remove whats already been sorted out
    CO2(removeMe) = [];%By the end, CO2 and LOC_POPULATIONS will be empty
    solutionIndex = solutionIndex + 1;
end
disp ("Sorted Pop: ");
disp (DATA_ARRAY(1,:));
disp ("Sorted CO2: ");
disp (DATA_ARRAY(2,:));

plot(DATA_ARRAY(1,:),DATA_ARRAY(2,:))
xlabel("Gross Domestic Product");
ylabel("CO2 Emissions");