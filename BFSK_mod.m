function signal = BFSK_mod(dataStream, carrier1, carrier2)
%BFSK_MOD Summary of this function goes here
%   Detailed explanation goes here
signal = zeros(1,length(dataStream),'double');

for i = 1:length(dataStream)
    if (dataStream(i))
        signal(i) = carrier2(i);
    else
        signal(i) = carrier1(i);
    end
end
end

