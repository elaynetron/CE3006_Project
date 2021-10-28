N = 1024;

data = randi([0,1], [1,N]);

fc1 = 10000; %carrier freq
fc2 = 2 * fc1;
dataRate = 1000;
fs = fc2 * 16; %sampling freq
%to start at where sampling interval starts
t = 1/(2*fs):1/fs:N/dataRate; 
carrier1 = cos(2*pi*fc1*t);
carrier2 = cos(2*pi*fc2*t);
numSample = fs*N/dataRate;

dataStream = stretchData(data, numSample, dataRate, fs);
BFSK_mod_signal = BFSK_mod(dataStream, carrier1, carrier2);
plot(BFSK_mod_signal)
xlim([0,2000])