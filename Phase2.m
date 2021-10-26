N = 1024;
dBSNR = 5; %fixed SNR value
% SNR = 10.^(dBSNR/10);
% data = generateData(N,dBSNR);
data = randi([0,1], [1,N]);

fc = 10000; %carrier freq
dataRate = 1000;

OOK_mod_signal = OOK(data, fc, dataRate, N);
% numSample = fs*N/dataRate + 1; %WHY PLUS 1?
% [b,a] = butter(6, 0.2); %6th order, 0.2 cutoff freq, lowpassfilter
% freqz(b,a);
% 
plot(OOK_mod_signal);
xlim([0,1800]);

% dataOut = filtfilt(b,a,data);
