function data = generateData(N, dBSNR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
binaryData = gaussian(N);
noiseData = noise(N, dBSNR);

data = signalAdd(binaryData, noiseData);
end

