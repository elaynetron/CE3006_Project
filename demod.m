function data = demod(receivedSig, carrier)
% OOK Demodulation
    % sigA is the demodulated signal
    sigA = receivedSig .* 2 .* carrier;
    % pass through low pass filter - 6th order, 0.2 cutoff freq
    [b,a] = butter(6, 0.2);
    filteredSig = filtfilt(b, a, sigA);
    % generate output data to be compared, using threshold
    data = threshold(filteredSig, 0.5);
end

