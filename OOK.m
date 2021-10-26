function signal = OOK(data)
%OOK Summary of this function goes here
%   Detailed explanation goes here
carrierFreq = 10000;
carrierSignal = cos(2*pi*carrierFreq);
signal = data * carrierSignal;

end

