function errorRate = SNRToErrorRate(N,dBSNR)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
thresholdValue = 0;

receivedSig = generateData(N, dBSNR);

thresholdOut = threshold(receivedSig, thresholdValue);

errorRate = checkBitErrorRate(thresholdOut, data);
end

