N = 1024;
dBSNR = 5; %fixed SNR value
% SNR = 10.^(dBSNR/10);
% data = generateData(N,dBSNR);
data = randi([0,1], [1,N]);

fc = 10000; %carrier freq
dataRate = 1000;
fs = fc * 16; %sampling freq
t = 0:1/fs:N/dataRate;
carrier = cos(2*pi*fc*t);
numSample = fs*N/dataRate + 1;

dataStream = stretchData(data, numSample, dataRate, fs); 
OOK_mod_signal = OOK(dataStream, carrier);
noiseData = noise(numSample,dBSNR);
OOK_noisy = signalAdd(OOK_mod_signal, noiseData);
received_data = OOK_demod(OOK_noisy, carrier);
OOK_error = checkBitErrorRate(received_data,dataStream)

% plot(OOK_mod_signal);
% plot(data);
% xlim([0,1800]);
