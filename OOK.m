function signal = OOK(dataStream, carrier)
%OOK Summary of this function goes here
%   Detailed explanation goes here

signal = dataStream .* carrier;
end

