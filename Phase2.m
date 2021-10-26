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
    OOK_noisy = signalAdd(OOK_mod_signal, noiseData);
    BPSK_noisy = signalAdd(BPSK_mod_signal, noiseData);
    OOK_received_data = demod(OOK_noisy, carrier);
    BPSK_received_data = demod(BPSK_noisy, carrier);
    OOK_error(i) = checkBitErrorRate(OOK_received_data,dataStream);
    BPSK_error(i) = checkBitErrorRate(BPSK_received_data,dataStream);
end

title("SNR vs ErrorRate")
xlabel("dBSNR");
ylabel("errorRate");
hold on
semilogy(dBSNR, OOK_error)
semilogy(dBSNR, BPSK_error)
hold off
legend('OOK','BPSK');
