%Lance Lopez
%efyll5@nottingham.ac.uk

%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

 clear %clears all variables 
a = arduino() %allows matlab to save the arduino as a variable
clc %clears the command windiow


%-----------------TURNING LED ON AND OFF------------------

for repeat = 1:5 % starts a loop that repeats 5 times
    writeDigitalPin(a, 'D2', 1);  % turns the LED on , D2 is the connection to the input
    pause(0.5); % waits 0.5 seconds
    writeDigitalPin(a, 'D2', 0);  % turns the LED off
    pause(0.5); % wats 0.5 seconds
end


%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

clear % clears all variables 
a = arduino() % allows matlab to save the arduino as a variable
clc % clears the command windiow


%-------CREATING VARIABLES-------
     
analoguechannel = 'A0'; % sets the analogue input channel a variable                   
duration = 600; % total time saved as a variable duration                      
timeinterval = 1; %saved as a variable
totalrepeats = duration / timeinterval; % equation divides the two variables to find the total repeats
voltagezero = 0.5; % it is the voltage at 0 degrees
temperaturecoefficient = 0.01; %0.01 means 10mv per degree


%-------CREATING THE ARRAYS -------

voltages = zeros(1, totalrepeats); % creates an array that stores the voltage
temperatures = zeros(1, totalrepeats);% crea tes an array that stores the temperature


%-------CREATING THE DATA AQUISITION LOOP-------
for i = 1:totalrepeats % starts a loop that repeats depending on the number of repeats
    voltages(i) = readVoltage(a, analoguechannel); %this allows matalb to read the voltage from the sensor
    temperatures(i) = (voltages(i) - voltagezero) / temperaturecoefficient; %this converts the voltage into temperature
    pause(timeinterval);  % Wait for the next reading
end


%-------SHOWING RESULTS-------
minTemp = min(temperatures); %shows the minimum temperature
maxTemp = max(temperatures); %shows the maximum temperature
avgTemp = mean(temperatures);%shows the mean temperature

fprintf('Minimum Temperature: %.2f °C\n', minTemp);
fprintf('Maximum Temperature: %.2f °C\n', maxTemp);
fprintf('Average Temperature: %.2f °C\n', avgTemp);


%-------PLOTTING TIME AGAINST TEMPERATURE-------

time = 0:timeinterval:duration-timeinterval;  % this gives the time up to the duration
figure;  % this will create a new window
plot(time, temperatures, 'b', 'LineWidth', 1.5); % plots the temperature against the time
xlabel('Time (seconds)');      % labels the x axis (time)
ylabel('Temperature (°C)');    % labels the y axis(temperature)
title('Temperature vs Time');  % labels the title of the graph
grid on;                      % creates a grid in the background


%----------CREATING A WAY TO PLACE TABLE----------

numberofpoints = floor((duration - 1)/ 60); %floor enables you to take a number of values but to the nearest integer 
temppermin = zeros(1, numberofpoints);
for i = 1:numberofpoints
    timepoint = i * 60;  % Time in seconds (60, 120, ..., 600)
    index = timepoint / timeinterval + 1;  % Convert to index
    temppermin(i) = temperatures(index);
end





%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
clear
a = arduino()
clc
temp_monitor(a);

%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]
clear
a = arduino()
clc
temp_prediction(a);

%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.