function temp_monitor(a)


therm = 'A0';   %
red = 'D4';     %saves each analogue adn digital pin as a variable
yellow = 'D3';  %
green = 'D2';   %

voltagezero = 0.5; % it is the voltage at 0 degrees
temperaturecoefficient = 0.01; % 0.01 means 10mv per degree

timegraph = []; %creates an array to hold all values
index = 1; % index that stores the results
redblink = 0; %variable that starts red as zero
yellowblink = 0; %variable that starts yellow at zero

figure; % creates a new window
graph = animatedline('Color','b','LineWidth',2); % makes an animated line thats live
xlabel('Time (s)'); % lables the x aaxis
ylabel('Temperature (°C)'); %labels the y axis
title('Live Temperature Plot'); % labels the tittle of the graph
grid on; % creats a grid in the background
startTime = tic; % used in order to measure elapsed time

voltage = readVoltage(a,therm); % reads the voltage from sensor
temperature = (voltage-voltagezero)/temperaturecoefficient; %converts voltage into temp
results(index) = temperature; % stores the temperature
timegraph(index) = 0; % Time = 0 at start
addpoints(graph, 0, temperature); % plots the points while live
drawnow; %updates the figure to allow continuous plotting

while true %while loop that allows sensor to keep running as long as conditions below are true
    voltage = readVoltage(a, therm); %reads the voltage
    temperature = (voltage - voltagezero) / temperaturecoefficient; %converts voltage to temp
    currentTime = toc(startTime); % gives the elapsed time
    results(index) = temperature; %stores the temperature into an array
    timegraph(index) = currentTime; % stores the time into an arrayu
    index = index + 1; %

    addpoints(graph, currentTime, temperature); % adds a point to the live graph
    drawnow limitrate; % updates the graph. limitrate allows teh graph to plot at an appropriate amount

if temperature >= 18 && temperature <= 24 % runs the code uunderneath if conditions met

    writeDigitalPin(a, red, 0);   %red off
    writeDigitalPin(a, yellow, 0);%yellow off
    writeDigitalPin(a, green, 1);%green on
    
elseif temperature > 24 % runs code underneath if conditions met
    writeDigitalPin(a, green, 0); %green opff
    writeDigitalPin(a, yellow, 0);%yellow off
    redblink = ~redblink; %this allows the red LED to be toggled on an off
    writeDigitalPin(a, red, redblink); % this causes the red led to blink 

elseif temperature < 18 % runs code underneath if conditions met
    writeDigitalPin(a, red, 0);% red off
    writeDigitalPin(a, green, 0);% rgreen  off
    yellowblink = ~yellowblink; %this allows the yellow LED to be toggled on an off
    writeDigitalPin(a, yellow, yellowblink); % this causes the yellow led to blink 

else %turns off all LED
    writeDigitalPin(a, red, 0);
    writeDigitalPin(a, yellow, 0);
    writeDigitalPin(a, green, 0);
end

pause(1); % waits one second


end

end