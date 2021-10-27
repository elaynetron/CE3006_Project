function signal = OOK(dataStream, carrier)
%OOK Modulation

    signal = dataStream .* carrier;
end

