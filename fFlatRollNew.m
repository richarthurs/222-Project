function [ trackData, forceData ] = fFlatRollNew(trackData, forceData, distance)
%FFLATROLL Summary of this function goes here
%   Detailed explanation goes here

global g;   % Gravity
global R;   % Radius of Ball
global m;   % Mass of Ball
global t_inc; % Time increment
t_inc = 0.001;


matrixHeight = size(trackData,1);

vi = trackData(matrixHeight, 4);
wi = trackData(matrixHeight, 8);
xi = trackData(matrixHeight, 2);
yi = trackData(matrixHeight, 3);
t0 = trackData(matrixHeight, 1);

trackDataNew = zeros(1, 9);
forceDataNew = zeros(1,5);

i = 1;

totalTime = abs(distance / vi);

while(i*t_inc <= totalTime)
    trackDataNew(i, 2) = (vi * (t_inc*i)) + xi;   
    trackDataNew(i, 1) = (t_inc*i) + t0;     % time
    trackDataNew(i, 8) = wi;
    trackDataNew(i, 3) = yi;
    trackDataNew(i, 4) = vi;
    
    forceDataNew(i, 1) = (t_inc*i) + t0;
    forceDataNew(i, 2) = m * g;
    
    i = i+1;
end

trackData = [trackData; trackDataNew];  % concatenate the intermediate matrix with the complete one
forceData = [forceData; forceDataNew];
end

