%% Discussion Week 1 - EBS 130 
% Nikhitha Ravi
% Juanruay 9th, 2026

%T = readtable("Run1");
%U = readtable(Run2);
%V = readtable(Run3);

% Automatically makes a matrix based off the table 
Hour1 = Run1.("Hour");
GEMMale1 = Run1.("GEM Male");
GEMFemale1 = Run1.("GEM Female");
WTFemale1 = Run1.("WT Female");
WTMale1 = Run1.("WT Male");

Hour2 = Run2.("Hour");
GEMMale2 = Run2.("GEM Male");
GEMFemale2 = Run2.("GEM Female");
WTFemale2 = Run2.("WT Female");
WTMale2 = Run2.("WT Male");

Hour3 = Run3.("Hour");
GEMMale3 = Run3.("GEM Male");
GEMFemale3 = Run3.("GEM Female");
WTFemale3 = Run3.("WT Female");
WTMale3 = Run3.("WT Male");

%% Plot the Temperatures 

subplot(2, 2, 1)
figure(1)
plot(Hour1, WTMale1, 'g', Hour1, WTFemale1, 'c', Hour1, GEMMale1, 'k', Hour1, GEMFemale1, 'r')
title('Number of Movements Per Mosquito Per Hour - Trial 1, Day 5')
legend('WT Male', 'WT Female', 'GEM Male', 'GEM Female')
xlabel('Time (in hours)')
ylabel('Average Movements Per Hour Per Mosquito')

%for subplots, you need to have rows, columns & position of the
%subplot (x, y, z) = (row, column, position)


subplot(2, 2, 2)
figure(1)
plot(Hour2, WTMale2, 'g', Hour2, WTFemale2, 'c', Hour2, GEMMale2, 'k', Hour2, GEMFemale2, 'r')
title('Number of Movements Per Mosquito Per Hour - Trial 2, Day 5')
legend('WT Male', 'WT Female', 'GEM Male', 'GEM Female')
xlabel('Time (in hours)')
ylabel('Average Movements Per Hour Per Mosquito')

subplot(2, 2, 3)
figure(1)
plot(Hour3, WTMale3, 'g', Hour3, WTFemale3, 'c', Hour3, GEMMale3, 'k', Hour2, GEMFemale2, 'r')
title('Number of Movements Per Mosquito Per Hour - Trial 3, Day 5')
legend('WT Male', 'WT Female', 'GEM Male', 'GEM Female')
xlabel('Time (in hours)')
ylabel('Average Movements Per Hour Per Mosquito')
