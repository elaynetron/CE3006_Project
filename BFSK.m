clc;
clear all;
close all;

N = 1024;
dBSNR = 10;
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
figure(1)
plot(dataStream)
xlim([0 5000])

BFSK_mod_signal = BFSK_mod(dataStream, carrier1, carrier2);

noiseData = noise(numSample, dBSNR);
BFSK_rx = signalAdd(BFSK_mod_signal, noiseData);
% data = BFSK_demod(BFSK_rx, carrier1, carrier2, t);

[b1,a1] = butter(6, [0.10,0.15], 'bandpass');
[b0,a0] = butter(6, [0.05,0.08], 'bandpass');

filteredOnes = filtfilt(b1,a1,BFSK_rx);
filteredZeros = filtfilt(b0,a0,BFSK_rx);

[upperOnes, lowerOnes] = envelope(filteredOnes, 10, 'peak');
[upperZeros, lowerZeros] = envelope(filteredZeros, 10, 'peak');

filteredBFSK = upperOnes - upperZeros;
figure(2)
plot(filteredBFSK)
xlim([0 5000])
bitError = checkBitErrorRate(filteredBFSK, dataStream);
bitError
