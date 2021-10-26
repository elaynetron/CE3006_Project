function signal = OOK(data, carrier, numSample, fs, dataRate)
%OOK Summary of this function goes here
%   Detailed explanation goes here

dataStream = zeros(1, numSample);
for k = 1: numSample - 1
    dataStream(k) = data(ceil(k*dataRate/fs));
end
dataStream(numSample) = dataStream(numSample - 1);
signal = dataStream .* carrier;
end

