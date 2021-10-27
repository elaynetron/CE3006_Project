function errorRate = SNRToErrorRate(N,dBSNR)
% Call functions to perform phase 1
% calculate error rate based on given SNR
thresholdValue = 0;

% generate data and noise
data = gaussian(N);
noiseData = noise(N, dBSNR);

%add noise to signal
receivedSig = signalAdd(data, noiseData);

thresholdOut = threshold(receivedSig, thresholdValue);

errorRate = checkBitErrorRate(thresholdOut, data);
end

