function dataStream = stretchData(data, numSample, dataRate, fs)
% Extend original data by 160 to correctly reflect values
% represent total number of intervals (163840) correctly\

    dataStream = zeros(1, numSample);
    for k = 1: numSample
        dataStream(k) = data(ceil(k*dataRate/fs));
    end
end

