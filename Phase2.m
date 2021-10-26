N = 1024;
dBSNR = 5; %fixed SNR value
% SNR = 10.^(dBSNR/10);
% data = generateData(N,dBSNR);
data = randi([0,1], [1,N]);

fc = 10000; %carrier freq
fs = fc * 16; %sampling freq
dataRate = 1000;

signalTime = fs*N/dataRate + 1; %WHY PLUS 1?
[b,a] = butter(6, 0.2); %6th order, 0.2 cutoff freq, lowpassfilter
freqz(b,a);

t = 0:1/fs:N/dataRate; 
carrier = cos(2*pi*fc*t); %amplitude = 5?
plot(carrier);


dataStream = zeros(1, signalTime);
for k = 1: signalTime - 1
    dataStream(k) = data(ceil(k*dataRate/fs));
end
dataStream(signalTime) = dataStream(signalTime - 1);

modSignal_OOK = dataStream .* carrier;
plot(modSignal_OOK);
xlim([0,100]);

% dataOut = filtfilt(b,a,data);
