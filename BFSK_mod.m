function signal = BFSK_mod(dataStream, carrier1, carrier2)
%BFSK_MOD Summary of this function goes here
%   Detailed explanation goes here
signal = zeros(1,length(dataStream),'double');

for i = 1:length(dataStream)
    if (dataStream(i))
        temp = carrier2;
    else
        temp = carrier1;
    end
    signal = temp;
end
end
