function thresholdOut = threshold(receivedSig, thresholdValue)
% generate threshold output vector/array

thresholdOut(receivedSig >= thresholdValue) = 1;
thresholdOut(receivedSig < thresholdValue) = 0;

end

