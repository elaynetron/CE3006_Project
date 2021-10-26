function signal = OOK(data, fc, dataRate, N)
%OOK Summary of this function goes here
%   Detailed explanation goes here

fs = fc * 16; %sampling freq
t = 0:1/fs:N/dataRate;
carrier = cos(2*pi*fc*t);
numSample = fs*N/dataRate + 1;
dataStream = zeros(1, numSample);
for k = 1: numSample - 1
    dataStream(k) = data(ceil(k*dataRate/fs));
end
dataStream(numSample) = dataStream(numSample - 1);
signal = dataStream .* carrier;
end

