% This script loops through a range of theta and puts x, y, omega and
% accelerations into a vector. 

xi = 0.07;
yi = 0.07;
g = -9.8;

thetaStart = 1.5*pi;
thetaEnd = 2*pi;
thetaRange = thetaEnd - thetaStart;

r = 0.07;   % Radius of track
R = 0.01;   % Radius of Ball

steps = 100;

% MATRIX LAYOUT: theta, xpos, ypos, ax, ay
thetaV = zeros(steps:3);    % makes a horizontal matrix 

% PROBABLY A GOOD CALL TO MAKE STEPS A GLOBAL VARIABLE FOR THE ENTIRE SIM
% SO THAT THE VECTORS ARE ALWAYS A CONSISTENT SIZE

for n = 0:steps-1;  % we want 
    theta = thetaStart + (thetaRange / steps) * n;  % chew through theta
    x = ((r-R) * cos(theta)) + xi;  % use r-R because we want position of COG
    y = ((r-R) * sin(theta)) + yi;
    ax = g * cos(theta);
    ay = g * sin(theta);
    thetaV(n+1, 1) = theta;    % matrices are one indexed :(
    thetaV(n+1, 2) = x;
    thetaV(n+1, 3) = y;
    thetaV(n+1, 4) = ax;
    thetaV(n+1, 5) = ay;
end

figure
plot(thetaV(1:steps, 2), thetaV(1:steps, 3));
axis([0 0.3048 0 0.3048]);
figure
plot(thetaV(1:steps, 1), thetaV(1:steps, 5));



%y = -sqrt(r^2 - x^2);  % equation of track from r^2 = x^2 + y^2, solved for y
