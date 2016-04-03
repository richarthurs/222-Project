function [ data ] = testCurve( radius, tstart, tend )
%TESTCURVE Summary of this function goes here
%   Detailed explanation goes here

xi = .02;
yi = -0.02;

n = 0;
i = 0;
while(tstart+n < tend)

    data(i+1, 1) = xi + radius*cos(tstart + n);
    data(i+1, 2) = -radius  + yi + radius*sin(tstart + n);
    n = n+0.1;  
    i = i+1;
end

rows = size(data, 1);

plot(data(1:rows, 1), data(1:rows, 2));

end

