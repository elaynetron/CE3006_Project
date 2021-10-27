function noiseData = noise(N, dBSNR)
% Generate noise with zero mean and required SNR variance
% Phase 1, 2
    S = 1; %Signal Value

    SNR = 10^(dBSNR/10); % dBSNR = 10log10(SNR)
    noiseVariance = S/SNR; % SNR = S/N

    noiseData = randn(1,N) * sqrt(noiseVariance);

end

