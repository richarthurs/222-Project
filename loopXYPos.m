% This script loops through a range of theta and puts x, y, omega and
% accelerations into a vector. 

xi = 0.07;
yi = 0.07;
vi = 0;
wi = 0;
thetaStart = pi;
thetaEnd = 1.5*pi;
r = 0.07;   % Radius of track

global steps;   % the number of steps to compute in iterative functions
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball

thetaRange = thetaEnd - thetaStart;

% MATRIX LAYOUT: theta, xpos, ypos, ax, ay
thetaV = zeros(steps:6);    % makes a matrix for the output

rkei = 0.5 * I * wi^2;  % initial rotational kinetic energy
tkei = 0.5 * m * vi^2;  % initial translational kinetic energy
gpei = m * g * sin(thetaStart);
syms thetax;
gpeft = m * g* sin(thetax);  % final gravitational potential energy for time function - needs symbolic variable

prevTime = 0;

for n = 0:steps-1;  % subtract one because of zero indexing
    theta = thetaStart + (thetaRange / steps) * n;  % chew through theta
    
    % determine position of COG
    x = ((r-R) * cos(theta)) + xi;  % use r-R because we want position of COG
    y = ((r-R) * sin(theta)) + yi;
    
    % determine acceleration (from gravity - need to add more here)
    ax = g * cos(theta);
    ay = g * sin(theta);
    
    thetaV(n+1, 1) = theta;    % matrices are one indexed :(
    
    % This is solved for wf (final angular velocity) but something is
    % wrong, the values are pretty off
    wf = sqrt((rkei + gpei - (m * g* abs(sin(theta))) + tkei)/(0.5 * I + 0.5 * m * R^2));
    wf = real(wf);
    
    % Similar to above, this attempts to solve for time. It gets the time
    % from the start of the curve to the current position, but the values
    % do not seem correct. 
    syms thetax;
   % t = int(sqrt((0.5 * I + 0.5 * m * R^2)/(rkei + gpei - gpeft + tkei)), thetax, thetaStart, theta);
   FxyBallNoSlip(vi,wi,cos(theta),r); 
   t = vpa(t);
    t = t - prevTime;
    prevTime = t;
    
    thetaV(n+1, 2) = x;
    thetaV(n+1, 3) = y;
    thetaV(n+1, 4) = ax;
    thetaV(n+1, 5) = ay;
    thetaV(n+1, 6) = real(t);
    thetaV(n+1, 7) = vpa(wf);
    
end

% These plots were used to verify the position function. 
%figure
%plot(thetaV(1:steps, 2), thetaV(1:steps, 3));
%axis([0 0.3048 0 0.3048]);
%figure
%plot(thetaV(1:steps, 1), thetaV(1:steps, 5));



