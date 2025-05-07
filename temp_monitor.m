function temp_monitor(a)

therm = 'A0';
red = 'D2';
yellow = 'D3';
green = 'D4';

voltagezero = 0.5;       
temperaturecoefficient = 0.01; 

results = [];
timegraph = [];
index = 1;
redblink = 0;
yellowblink = 0;

figure;
graph = animatedline('Color','b','LineWidth',2);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Live Temperature Plot');
grid on;
startTime = tic;

voltage = readVoltage(a,therm);
temperature = (voltage-voltagezero)/temperaturecoefficient;
results(index) = temperature;
timegraph(index) = 0; % Time = 0 at start
addpoints(graph, 0, temperature);
drawnow;

while true

    delay = tic

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
   
    redblink = ~redblink;
    writeDigitalPin(a, red, redblink);
    writeDigitalPin(a, yellow, 0)
    writeDigitalPin(a, green, 0)

elseif temperature < 18

    yellowblink = ~yellowblink;
    writeDigitalPin(a, yellow, yellowblink);
    writeDigitalPin(a, red, 0)
    writeDigitalPin(a, green, 0)
end

elapse = toc(delay);
pause = (1 - elapse);


end

end