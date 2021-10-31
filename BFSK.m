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
dataStreamFSK = -1.*dataStream + 1; %bit flip 
%BFSK_mod_signal = BFSK_mod(dataStream, carrier1, carrier2);
BFSK_mod_signal = carrier2 .* dataStream + carrier1.*dataStreamFSK; % 1-- High F, 0 -- Low F

noiseData = noise(numSample, dBSNR);
BFSK_rx = signalAdd(BFSK_mod_signal, noiseData);
% plot(BFSK_rx);
% data = BFSK_demod(BFSK_rx, carrier1, carrier2, t);
% signal1 = BFSK_rx .* carrier1;
% signal2 = BFSK_rx .* carrier2;

%define 6th order LP butterworth filter with 0.2 normalized cutoff frequency
[b_low,a_low] = butter(6, 0.2);
%define 6th order HP butterworth filter with 0.2 normalized cutoff frequency
[b_high,a_high] = butter(6, 0.2, 'high');

%non coherent detection -- bandpass filters
ReceiveFSK_LOW = filtfilt(b_low,a_low,BFSK_rx);
ReceiveFSK_HIGH = filtfilt(b_high,a_high,BFSK_rx);
%Square Law
SquaredFSK_LOW = ReceiveFSK_LOW.*ReceiveFSK_LOW;
SquaredFSK_HIGH = ReceiveFSK_HIGH.*ReceiveFSK_HIGH;
SquaredFSK = SquaredFSK_HIGH - SquaredFSK_LOW;
%sample and decision device
samplingPeriod = fs / dataRate;
SampledFSK = sample(SquaredFSK, samplingPeriod, N);
resultFSK = decision_device(SampledFSK,N, 0.5);  
plot(resultFSK);
BFSK_error = checkBitErrorRate(resultFSK,data)

function sampled = sample(x,sampling_period,num_bit)
    sampled = zeros(1, num_bit);
    for n = 1: num_bit
        sampled(n) = x((2 * n - 1) * sampling_period / 2);
    end
end

function binary_out = decision_device(sampled,num_bit,threshold)
    binary_out = zeros(1,num_bit);
    for n = 1:num_bit
        if(sampled(n) > threshold)
            binary_out(n) = 1;
        else 
            binary_out(n) = 0;
        end
    end
end

