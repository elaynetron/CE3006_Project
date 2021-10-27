function data = gaussian(N)
% Generate binary data - phase 1
    data = randi([0,1], [1,N]);
    
    data(data==0) = [-1];

end

