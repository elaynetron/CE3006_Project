% Same as phase 2 - but to generate images for report

N = 1024;
dBSNR = 5; %fixed SNR value

data = randi([0,1], [1,N]);

fc = 10000; %carrier freq
dataRate = 1000;
fs = fc * 16; %sampling freq
%to start at where sampling interval starts
t = 1/(2*fs):1/fs:N/dataRate; 
carrier = cos(2*pi*fc*t);
numSample = fs*N/dataRate;

dataStream = stretchData(data, numSample, dataRate, fs);
tiledlayout(6,2)
ax1 = nexttile([1,2]);
title(ax1,"Data Waveform")
plot(ax1, dataStream)
OOK_mod_signal = OOK(dataStream, carrier);
ax2 = nexttile;
title(ax2,"OOK Modulated Signal")
plot(ax2, OOK_mod_signal)
BPSK_mod_signal = BPSK(dataStream, carrier);
ax3 = nexttile;
title(ax3,"BPSK Modulated Signal")
plot(ax3, BPSK_mod_signal)

noiseData = noise(numSample,dBSNR);
ax4 = nexttile([1,2]);
title(ax4,"Noise")
plot(ax4, noiseData)
OOK_rx = signalAdd(OOK_mod_signal, noiseData);
ax5 = nexttile;
title(ax5,"Received OOK");
plot(ax5, OOK_rx);
BPSK_rx = signalAdd(BPSK_mod_signal, noiseData);
ax6 = nexttile;
title(ax6,"Received BPSK");
plot(ax6, BPSK_rx);
OOK_demod_data = demod(OOK_rx, carrier);
ax7 = nexttile;
title(ax7, "OOK decoded signal");
plot(ax7, OOK_demod_data);
BPSK_demod_data = demod(BPSK_rx, carrier);
ax8 = nexttile;
title(ax8, "BPSK decoded signal");
plot(ax8, BPSK_demod_data);
OOK_error = checkBitErrorRate(OOK_demod_data,dataStream);
BPSK_error = checkBitErrorRate(BPSK_demod_data,dataStream);

ax9 = nexttile([1,2]);
hold on
title(ax9, "SNR vs ErrorRate")
xlabel(ax9, "dBSNR")
ylabel(ax9, "errorRate")
semilogy(dBSNR, OOK_error)
semilogy(dBSNR, BPSK_error)
legend('OOK','BPSK')
hold off
