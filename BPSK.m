function signal = BPSK(dataStream, carrier)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dataStream(dataStream==0) = [-1];
signal = dataStream .* carrier;
end

