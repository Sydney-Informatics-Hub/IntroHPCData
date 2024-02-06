% A demo Matlab script to read a csv file and perform data manipulation.

filePath= "airline2008.csv";
T = readtable(filePath);
T(1:10,1:10);

%  Converting variables to their correct data types lets you perform
% efficient computations and comparisons that improves memory usage

data = T(:,{'Year','Month','DayofMonth','UniqueCarrier','ArrDelay'});
data.Date = datetime(data.Year,data.Month,data.DayofMonth);
data.UniqueCarrier = categorical(data.UniqueCarrier);
data.ArrDelay = minutes(data.ArrDelay);

% Find the day of the year with the longest delay, and then display the date.

ind = find(data.ArrDelay == max(data.ArrDelay));
disp('The day of the year with the longest flight delay is:')
data.Date(ind)
