function data = demod_phase3(receivedSig, encoded_bits, fs, dataRate, carrier)
% Demodulation - for phase 3
    % sigA is the demodulated signal
    sigA = receivedSig .* 2 .* carrier;
    % pass through low pass filter - 6th order, 0.2 cutoff freq
    [b,a] = butter(6, 0.2);
    filteredSig = filtfilt(b, a, sigA);
    % generate output data to be compared, using threshold
    data = zeros(1, encoded_bits);
    for i = 1:encoded_bits
        thresholdOut = filteredSig(1 /2 * fs/dataRate + (i - 1) * fs/dataRate);
        if thresholdOut > 0.5
            data(i) = 1;
        else
            data(i) = 0;        
        end
    end
end

