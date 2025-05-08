%Lance Lopez
%efyll5@nottingham.ac.uk
clear
a = arduino()
red = 'D4';
yellow = 'D3';
green = 'D2';

writeDigitalPin(a, green, 0)
writeDigitalPin(a, yellow, 0)
writeDigitalPin(a, red, 0)
%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

 

clc
%----------ASSIGNING VARIABLE TO ARDUINO----------
%-----------------TURNING LED ON------------------

for i = 1:5
    writeDigitalPin(a, 'D2', 1);  % LED ON
    pause(0.5);
    writeDigitalPin(a, 'D2', 0);  % LED OFF
    pause(0.5);
end






%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

clc
%------- Setup Arduino and sensor -------
     
analoguechannel = 'A0';                    
duration = 600;                       
timeinterval = 1;                
totalrepeats = duration / timeinterval;
voltagezero = 0.5;       
temperaturecoefficient = 0.01;      
%------- Initialize data arrays -------
voltages = zeros(1, totalrepeats);
temperatures = zeros(1, totalrepeats);

%------- Data acquisition loop -------
for i = 1:totalrepeats
    voltages(i) = readVoltage(a, analoguechannel);
    temperatures(i) = (voltages(i) - voltagezero) / temperaturecoefficient;
    pause(timeinterval);  % Wait for the next reading
end

%------- Statistical calculations -------
minTemp = min(temperatures);
maxTemp = max(temperatures);
avgTemp = mean(temperatures);

%------- Display results -------
fprintf('\n--- Summary ---\n');
fprintf('Minimum Temperature: %.2f °C\n', minTemp);
fprintf('Maximum Temperature: %.2f °C\n', maxTemp);
fprintf('Average Temperature: %.2f °C\n', avgTemp);

%------- Create time array for plotting -------
time = 0:timeinterval:duration-timeinterval;  % Time from 0 to duration

%------- Plot temperature vs time -------
figure;  % Create new figure window
plot(time, temperatures, 'b', 'LineWidth', 1.5); % Plot with blue line and set line width
xlabel('Time (seconds)');      % x-axis label (time)
ylabel('Temperature (°C)');    % y-axis label (temperature)
title('Temperature vs Time');  % Title of the plot
grid on;                      % Enable grid for easier reading


% Number of minute intervals (600s / 60s = 10 readings)
numberofpoints = floor((duration - 1)/ 60);

% Preallocate array to hold temperatures every minute
minuteTemps = zeros(1, numberofpoints);

% Extract temperature at every 60-second interval
for i = 1:numberofpoints
    timepoint = i * 60;  % Time in seconds (60, 120, ..., 600)
    index = timepoint / timeinterval + 1;  % Convert to index
    minuteTemps(i) = temperatures(index);
end


% Optional: display result
disp('Temperatures at each minute:');
disp(minuteTemps);




%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

temp_monitor(a);

%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

temp_prediction(a);

%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.