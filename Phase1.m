N = 1024;

dBSNR = 10;
errorRate = SNRToErrorRate(N,dBSNR)

% plot(dBSNR, errorRate)
% title("plot of errorRate against dBSNR")
% xlabel("dBSNR");
% ylabel("errorRate");
% grid on