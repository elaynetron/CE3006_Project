N = 1024;
% dBSNR = 5; %fixed SNR value
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
BPSK_mod_signal = BPSK(dataStream, carrier);


dBSNR = zeros(1,10,'double');
OOK_error = zeros(1,10,'double');
BPSK_error = zeros(1,10,'double');
for i = 1:10
    dBSNR(i) = (i-1)*5;
    noiseData = noise(numSample,dBSNR(i));
    OOK_rx = signalAdd(OOK_mod_signal, noiseData);
    BPSK_rx = signalAdd(BPSK_mod_signal, noiseData);
    OOK_demod_data = demod(OOK_rx, carrier);
    BPSK_demod_data = demod(BPSK_rx, carrier);
    OOK_error(i) = checkBitErrorRate(OOK_demod_data,dataStream);
    BPSK_error(i) = checkBitErrorRate(BPSK_demod_data,dataStream);
end
hold on
title("SNR vs ErrorRate")
xlabel("dBSNR");
ylabel("errorRate");
semilogy(dBSNR, OOK_error)
semilogy(dBSNR, BPSK_error)
hold off
legend('OOK','BPSK');
