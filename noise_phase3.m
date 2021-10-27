function noiseData = noise(N, dBSNR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
S = 1; %Signal Value

SNR = 10^(dBSNR/10); % 10dB is 10S/N
noiseVariance = S/SNR;

noiseData = randn(1,N) * sqrt(noiseVariance);

end

