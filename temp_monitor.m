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
results(index) = temperature;
timegraph(index) = 0; % Time = 0 at start
addpoints(graph, 0, temperature);
drawnow;

while true
    voltage = readVoltage(a, therm);
    temperature = (voltage - voltagezero) / temperaturecoefficient;
    currentTime = toc(startTime);
    results(index) = temperature;
    timegraph(index) = currentTime;
    index = index + 1;

    addpoints(graph, currentTime, temperature);
    drawnow limitrate;

if temperature >= 18 && temperature <= 24

    writeDigitalPin(a, red, 0);
    writeDigitalPin(a, yellow, 0);
    writeDigitalPin(a, green, 1);
    
elseif temperature > 24
    writeDigitalPin(a, green, 0);
    writeDigitalPin(a, yellow, 0);
    redblink = ~redblink;
    writeDigitalPin(a, red, redblink);

elseif temperature < 18
    writeDigitalPin(a, red, 0);
    writeDigitalPin(a, green, 0);
    yellowblink = ~yellowblink;
    writeDigitalPin(a, yellow, yellowblink);

else 
    writeDigitalPin(a, red, 0);
    writeDigitalPin(a, yellow, 0);
    writeDigitalPin(a, green, 0);
end

pause(1);


end

end