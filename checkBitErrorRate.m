function errorRate = checkBitErrorRate(thresholdOut, data)
% Calculate error rate
N = length(data);

if( N ~= length(thresholdOut))
   disp("Data lengths do not match");
   return;
end
error = 0;
for i = 1:N
    if(data(i) > 0 && thresholdOut(i) == 0) || (data(i) <= 0 && thresholdOut(i) == 1)
        error = error + 1;
    end
end

errorRate = error/N;

end

