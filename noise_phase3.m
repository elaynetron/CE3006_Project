function noiseData = noise_phase3(N, dBSNR)
% Generate noise with zero mean and required SNR variance
% Phase 3
    S = 1; %Signal Value

    SNR = 10^(dBSNR/10); % dBSNR = 10log10(SNR)
    noiseVariance = S/SNR; % SNR = S/N

    noiseData = randn(1,N*7/4) * sqrt(noiseVariance);

end

