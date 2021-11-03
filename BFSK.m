function BFSK_error = BFSK()
    N = 1024;
    %dBSNR = 5;
    data = randi([0,1], [1,N]);

    fc1 = 10000; %carrier freq
    fc2 = 2 * fc1;
    dataRate = 1000;
    fs = fc1 * 16; %sampling freq
    %to start at where sampling interval starts
    t = 1/(2*fs):1/fs:N/dataRate; 
    carrier1 = cos(2*pi*fc1*t);
    carrier2 = cos(2*pi*fc2*t);
    numSample = fs*N/dataRate;

    dataStream = stretchData(data, numSample, dataRate, fs);
    BFSK_mod_signal = BFSK_mod(dataStream, carrier1, carrier2);

    % pass through low pass filter - 6th order, 0.2 cutoff freq
    [b,a] = butter(6, 0.2);
    [bhigh, ahigh] = butter(6, 0.2, "high");

    dBSNR = zeros(1,10,'double');
    BFSK_error = zeros(1,10,'double');
    for i = 1:11
        dBSNR(i) = (i-1)*5;
        noiseData = noise(numSample, dBSNR(i));
        BFSK_rx = signalAdd(BFSK_mod_signal, noiseData);

        % Demodulation
        % LPF
        BFSK_lowfilt = filtfilt(b, a, BFSK_rx);
        BFSK_highfilt = filtfilt(bhigh, ahigh, BFSK_rx);
        % Square-Law Device
        BFSK_lowsl = BFSK_lowfilt .^ 2;
        BFSK_highsl = BFSK_highfilt .^ 2;
        BFSK_sl = BFSK_highsl - BFSK_lowsl;
        BFSK_demod = threshold(BFSK_sl, 0);
        BFSK_error(i) = checkBitErrorRate(BFSK_demod, dataStream);
    end
    hold on
    title("SNR vs ErrorRate")
    xlabel("dBSNR");
    ylabel("errorRate");
    semilogy(dBSNR, BFSK_error, 'DisplayName', 'BFSK')
    hold off
end
