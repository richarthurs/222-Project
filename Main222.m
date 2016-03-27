% Once functions for individual features are implemented, run them here. 
% Bottom left of board is 0,0. 

clear all;
fSystemInit; % this sets up globals

% demo: get the data for a quarter-circle 7cm loop at 7cm, 7cm. 
% Output MATRIX Columns: theta, xpos, ypos, ax, ay, time, w
% please note that the time and w are not correct, and ax and ay are also
% just based on angle/gravity (I'll fix it though)
Curve1 = fLoopXYPos(0.07,0.07,0,0,pi,1.5*pi,0.07);

% Normally you'd pass the appropriate parameters to the next function, like
% velocities and accelerations. 

% demo: get the data for a quarter-circle 5cm loop at 2cm, 7cm. 
Curve2 = fLoopXYPos(0.02,0.07,0,0,pi,1.5*pi,0.05);

Curve3 = [Curve1; Curve2];   % vertically concatente the matrices