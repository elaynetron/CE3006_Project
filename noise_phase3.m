function noiseData = noise_phase3(N,fs,datarate, dBSNR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
S = 1; %Signal Value

SNR = 10^(dBSNR/10); % 10dB is 10S/N
noiseVariance = S/SNR;

noiseData = randn(1,N*7/4) * sqrt(noiseVariance);

end

