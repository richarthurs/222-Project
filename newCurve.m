function [ curveData ] = newCurve(Master_Array, r, thetaStart, thetaEnd )
%NEWCURVE Summary of this function goes here
%   Detailed explanation goes here

global data;
global t_inc;   % the number of steps to compute in iterative functions
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball

%Master_Array = zeros(10,6);

MasterHeight = size(Master_Array, 1);
vi = sqrt(Master_Array(MasterHeight, 4)^2 + Master_Array(MasterHeight, 5)^2);   % compute the initial velocity
wi = Master_Array(MasterHeight, 6); % grab the master height

rkei = 0.5 * I * wi^2;   % initial rotational KE
tkei = 0.5 * I * m * vi^2;  % initial translational KE
syms theta;
gpei = @(theta) m * g * (r-R) * sin(theta);  % gravitational potential Energy

timeFunction = int(vpa(sqrt((0.5 * I+ 0.5 * m * r^2)/(rkei + tkei + gpei(theta)))), theta, thetaStart, thetaEnd);
timeFunction = real(timeFunction);

disp(timeFunction);

syms thetax;
thetaIntegral = @(thetax) real(int(vpa(sqrt((0.5 * I+ 0.5 * m * r^2)/(rkei + tkei + gpei(theta)))), theta, thetaStart, thetax));

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
     %display(i, thetaVal)
     %display(thetaVal)
     plot(curveData(1:100, 1), curveData(1:100, 2))
end

% have the thetas and times, figure out position! 
% TODO: ADD INITIAL POSITION!
for i = 0:(1/t_inc)-1
   curveData(i+1, 3) = ((r-R) * cos(curveData(i+1, 2)));  % x position
   curveData(i+1, 4) = ((r-R) * sin(curveData(i+1, 2)));    % y position
   
   % w = dtheta/dt -- MEH DOESN'T WORK
   if i == 0
       w = wi;
   else 
       w = curveData(i, 2) - curveData(i+1, 2) / (curveData(i, 1) - curveData(i+1, 1));
   end
   curveData(i+1, 5) = w;
   
   % s = theta*r, know delta t
   
end
    



% all the calculated values are going to go into a temp matrix before being
% concatenated with the main matrix to avoid over writing data



end

