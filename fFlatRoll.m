function [ flatRollKin, flatRollForce ] = fFlatRoll(distance)
%FFLATROLL Summary of this function goes here
%   Detailed explanation goes here

global g;   % Gravity
global R;   % Radius of Ball
global m;   % Mass of Ball
global t_inc; % Time increment

global trackData;
global forceData;

matrixHeight = size(trackData,1);

vi = trackData(matrixHeight, 4);
wi = trackData(matrixHeight, 8);
xi = trackData(matrixHeight, 2);
yi = trackData(matrixHeight, 3);
t0 = trackData(matrixHeight, 1);

flatRollKin = zeros(1, 8);
flatRollForce = zeros(1,3);

i = 0;

totalTime = distance / vi;

while(i*t_inc <= totalTime)
    flatRollKin(i+1, 2) = vi * (t_inc*i);
    flatRollKin(i+1, 1) = t_inc*i + t0;
    flatRollKin(i+1, 8) = wi;
    flatRollKin(i+1, 3) = yi;
    flatRollKin(i+1, 4) = vi;
    
    flatRollForce(i+1, 1) = t_inc*i + t0;
    flatRollForce(i+1, 2) = m * g;
    
    i = i+1;
end

end

