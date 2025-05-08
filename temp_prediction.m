function temp_prediction(a)

therm = 'A0'
red = 'D4'
yellow = 'D3'
green = 'D2'


duration = 180
voltagezero = 0.5
temperaturecoefficient = 0.01
datapoints = 10 

voltagearray = zeros(1, duration)
temparray = zeros(1,duration)
timearray = zeros(1, duration)

for time = 1:duration
voltage = readVoltage(a,therm);
temperature = (voltage-voltagezero)/temperaturecoefficient;




