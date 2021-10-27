function dataStream = stretchData(data, numSample, dataRate, fs)
%STRETCHDATA Summary of this function goes here
%   Detailed explanation goes here
dataStream = zeros(1, numSample);
for k = 1: numSample
    dataStream(k) = data(ceil(k*dataRate/fs));
end
%dataStream(numSample) = dataStream(numSample - 1);
end

