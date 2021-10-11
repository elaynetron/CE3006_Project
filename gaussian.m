function data = gaussian(N)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
data = randi([0,1], [1,N]);

data(data==0) = [-1];

end

