function thresholdOut = threshold(receivedSig, thresholdValue)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
N = length(receivedSig);

thresholdOut(receivedSig >= thresholdValue) = 1;
thresholdOut(receivedSig < thresholdValue) = 0;

end

