function errorRate = checkBitErrorRate(thresholdOut, data)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
N = length(data);

if( N ~= length(thresholdOut))
   disp("Data lengths do not match");
   return;
end

error = 0;
for i = 1:N
    if(thresholdOut(i) ~= data(i))
        error = error + 1;
    end
    
end

errorRate = error/N;

end

