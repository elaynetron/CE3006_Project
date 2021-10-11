function errorRate = SNRToErrorRate(N,dBSNR)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
thresholdValue = 0;

data = gaussian(N);
noiseData = noise(N, dBSNR);

receivedSig = signalAdd(data, noiseData);

thresholdOut = threshold(receivedSig, thresholdValue);

errorRate = checkBitErrorRate(thresholdOut, data);
end

