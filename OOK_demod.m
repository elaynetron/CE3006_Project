function data = OOK_demod(receivedSig, carrier)
%OOK_DEMOD Summary of this function goes here
%   Detailed explanation goes here
% sigA is the signal after being multiplied with twice of carrier
    sigA = receivedSig .* 2 .* carrier;
    [b,a] = butter(6, 0.2); %6th order, 0.2 cutoff freq, lowpassfilter
    filteredSig = filtfilt(b, a, sigA);
    data = threshold(filteredSig, 0.5);
end

