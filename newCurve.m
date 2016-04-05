function [ curveOut ] = newCurve(r, thetaStart, thetaEnd )
%NEWCURVE Summary of this function goes here
%   Detailed explanation goes here

global trackData;
global t_inc;   % the number of steps to compute in iterative functions
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball

%Master_Array = zeros(10,6);

global trackData;
global forceData;

% TODO: Get the initial position out of the array 
xi = 0;
yi = 0;

vi = 0;   % compute the initial velocity
wi = 0; % grab the master height
alphai = 0; % Initial alpha 
ai = 0; % initial acceleration

rkei = 0.5 * I * wi^2;   % initial rotational KE
tkei = 0.5 * I * m * vi^2;  % initial translational KE
syms theta;
gpei = @(theta) m * g * (r-R) * sin(theta);  % gravitational potential Energy

timeFunction = int(vpa(sqrt((0.5 * I+ 0.5 * m * (r-R)^2)/(rkei + tkei + gpei(theta)))), theta, thetaStart, thetaEnd);
timeFunction = real(timeFunction);

disp(timeFunction);

syms thetax;
thetaIntegral = @(thetax) real(int(vpa(sqrt((0.5 * I+ 0.5 * m * (r-R)^2)/(rkei + tkei + gpei(theta)))), theta, thetaStart, thetax));

curveData = zeros(1/t_inc, 6);  % Pre-allocate space in the curveData array to hold our values

prevTheta = thetaStart;     % Keep track of the previous calculated theta to speed up the iteration

for i = 0:(1/t_inc)-1   % starting at zero, go up to 99 (t_inc = 0.01) steps
    time = (timeFunction*t_inc)*i;  % get the time for this iteration
    curveData(i+1, 1) = time;  % add one to i because matrices are 1-indexed and fn is zero-indexed
    n = 0;  % n is a counter to increment the theta (upper integral limit) guess
     while time > thetaIntegral(prevTheta + n)  % integrate until it equals the time ish
         n = n + 0.01;
       
     end  
     thetaVal = prevTheta + n;  % get the final theta at that time
     prevTheta = thetaVal;  % update the previous theta for speed
     curveData(i+1, 2) = thetaVal;
     %display(thetaVal)
     %plot(curveData(1:100, 1), curveData(1:100, 2))
end

% have the thetas and times, figure out position! 
for i = 0:(1/t_inc)-1
   curveData(i+1, 3) = (xi + (r-R) * cos(curveData(i+1, 2)));  % x position
   curveData(i+1, 4) = (yi + (r-R) * sin(curveData(i+1, 2)));    % y position
   
% find everything    
    w = real(sqrt((rkei + tkei + m*g*(r-R)*curveData(i+1, 4))/(0.5*I + 0.5*m*(R)^2)));
    curveData(i+1, 5) = w;
    v = w*R;
    vx = -v * sin(curveData(i+1, 2));   % note negative sign
    vy = v * cos(curveData(i+1, 2));
  
    curveData(i+1, 6) = vx;     % vx
    curveData(i+1, 7) = vy;     % vy
    curveData(i+1, 10) = v; 

% find alpha
% this makes sense but has approximation errors at the start of the curve
    if i == 0
        alpha = alphai;
    else
    alpha = alphai + (curveData(i+1,5)-curveData(i,5)/curveData(i+1,1)-curveData(i,1));
    end
    curveData(i+1, 8) = alpha;
    
    % Find Acceleration
    if i == 0
        a = ai;
    else
    a = ai + (curveData(i+1,10)-curveData(i,10)/(curveData(i+1,1)-curveData(i,1)));
    curveData(i+1, 9) = a;
    end

    % The data in the CurveData intermediate matrix is in weird columns,
    % easiest to sort it out at the end

end
    
    curveOut = zeros(100,6);
    for outCount = 1:100
        curveOut(outCount, 1) = curveData(outCount, 1);
        curveOut(outCount, 2) = curveData(outCount, 3);
        curveOut(outCount, 3) = curveData(outCount, 4);
        curveOut(outCount, 4) = curveData(outCount, 6);
        curveOut(outCount, 5) = curveData(outCount, 7);
        curveOut(outCount, 6) = curveData(outCount, 9);
        curveOut(outCount, 7) = curveData(outCount, 5);
        curveOut(outCount, 7) = curveData(outCount, 8);
    end
    

end

