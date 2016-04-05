function [ flatRollKin, flatRollForce ] = fFlatRoll(distance)
%FFLATROLL Summary of this function goes here
%   Detailed explanation goes here

global g;   % Gravity
global R;   % Radius of Ball
global m;   % Mass of Ball
global t_inc; % Time increment
t_inc = 0.005;

global trackData;
global forceData;

matrixHeight = size(trackData,1);

vi = trackData(matrixHeight, 4);
wi = trackData(matrixHeight, 8);
xi = trackData(matrixHeight, 2);
yi = trackData(matrixHeight, 3);
t0 = trackData(matrixHeight, 1);

flatRollKin = zeros(1, 9);
flatRollForce = zeros(1,5);

i = 1;

totalTime = abs(distance / vi);

while(i*t_inc <= totalTime)
    flatRollKin(i, 2) = (vi * (t_inc*i)) + xi;   
    flatRollKin(i, 1) = (t_inc*i) + t0;     % time
    flatRollKin(i, 8) = wi;
    flatRollKin(i, 3) = yi;
    flatRollKin(i, 4) = vi;
    
    flatRollForce(i, 1) = (t_inc*i) + t0;
    flatRollForce(i, 2) = m * g;
    
    i = i+1;
end

end

