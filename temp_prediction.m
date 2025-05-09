 function temp_prediction(a)

therm = 'A0';
red = 'D4';
yellow = 'D3';
green = 'D2';


duration = 180;
voltagezero = 0.5;
temperaturecoefficient = 0.01;
datapoints = 10;

voltagearray = zeros(1, duration);
temparray = zeros(1,duration);
timearray = zeros(1, duration);

for time = 1:duration
voltage = readVoltage(a,therm);
temperature = (voltage-voltagezero)/temperaturecoefficient;

voltagearray(time) = voltage;
temparray(time) = temperature;
timearray(time) = time;

if time >= datapoints
    averagetemp = mean(temparray(time - datapoints +1:time));

    dy = temparray(time) - temparray(time - datapoints + 1);
    dx = timearray(time) - timearray(time - datapoints + 1);
    rateofchange = dy/dx;

    tempprediction = rateofchange * 300 + temperature;

     fprintf('Time: %3ds | Temp: %.2f°C | Rate: %.4f°C/s | Predicted in 5 min: %.2f°C\n', time, averagetemp, rateofchange, tempprediction);

        % Alert if rate too fast (> 4°C/min = 0.0667°C/s)
   if rateofchange > 0.0667
            % Rapid increase → red
            writeDigitalPin(a, red, 1);
            writeDigitalPin(a, yellow, 0);
            writeDigitalPin(a, green, 0);
        elseif rateofchange < -0.0667
            % Rapid decrease → yellow
            writeDigitalPin(a, red, 0);
            writeDigitalPin(a, yellow, 1);
            writeDigitalPin(a, green, 0);

        else
            % Outside comfort but not rapidly changing
            writeDigitalPin(a, red, 0);
            writeDigitalPin(a, yellow, 0);
            writeDigitalPin(a, green, 1);
        end
    else
        fprintf('Time: %3ds | Temp: %.2f°C\n', time, temperature);
    end

    pause(1);  % Wait 1 second
end
