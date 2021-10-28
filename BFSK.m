clc;
clear all;
close all;

N = 1024;
dBSNR = 5;
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

noiseData = noise(numSample, dBSNR);
BFSK_rx = signalAdd(BFSK_mod_signal, noiseData);
% data = BFSK_demod(BFSK_rx, carrier1, carrier2, t);
signal1 = BFSK_rx .* carrier1;
signal2 = BFSK_rx .* carrier2;

for i = 1:length(dataStream)
    integral1 = trapz(t,signal1);
    integral2 = trapz(t,signal2);

    demod_signal = integral2 - integral1;
    data(i) = threshold(demod_signal, 0);
end
