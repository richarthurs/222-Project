function [ trackData, forceData ] = verticalDrop(trackData, forceData, distance)
%FFLATROLL Summary of this function goes here
%   Detailed explanation goes here

global g;   % Gravity
global R;   % Radius of Ball
global m;   % Mass of Ball
global t_inc; % Time increment
t_inc = 0.005;



matrixHeight = size(trackData,1);

vi = trackData(matrixHeight, 5);
wi = trackData(matrixHeight, 8);
xi = trackData(matrixHeight, 2);
yi = trackData(matrixHeight, 3);
t0 = trackData(matrixHeight, 1);

vDropKin = zeros(1, 9);
vDropForce = zeros(1,5);

i = 1;

syms t;
totalTime = vpasolve(0 == abs(vi)*t + 0.5*(-g)*t^2 - distance, t);
% need to only use the positive solution
if size(totalTime, 1) > 1
    if totalTime(1, 1) > totalTime(2, 1)
       finalTime = totalTime(1,1); 
    else
        finalTime = totalTime(2, 1);
    end
else
    finalTime = totalTime;
end

while(i*t_inc <= finalTime)
    vDropKin(i, 2) = xi;   
    vDropKin(i, 1) = (t_inc*i) + t0;     % time
    vDropKin(i, 8) = wi;
    vDropKin(i, 3) = yi + (vi * (t_inc*i) + 0.5*g*(t_inc*i)^2); % y height
    vDropKin(i, 5) = vi + (g*(i*t_inc));    % y velocity
    vDropKin(i, 4) = 0; % x velocity
    
    vDropForce(i, 1) = (t_inc*i) + t0;
    vDropForce(i, 2) = 0;
    vDropForce(i, 5) = m*g; % weight in freefall
    
    i = i+1;
end

trackData = [trackData; vDropKin];
forceData = [forceData; vDropForce];

end

