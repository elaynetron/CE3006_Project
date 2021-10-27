function signal = BPSK(dataStream, carrier)
% BPSK Modulation
% Convert 0s to -1, 1s remains as 1s
dataStream(dataStream==0) = [-1];
signal = dataStream .* carrier;
end

