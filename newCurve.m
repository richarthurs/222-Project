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

thetaIntegral = @(theta) real(int(vpa(sqrt((0.5 * I+ 0.5 * m * r^2)/(rkei + tkei + gpei(theta)))), theta, thetaStart, thetaEnd));

thetaGuess = thetaStart;
counter = 1;
% for t = 0:(timeFunction/t_inc):timeFunction
%     syms theta
%     timeSyncTheta = vpasolve(t == thetaIntegral, theta, thetaGuess);
%     curveData(counter, 1) = t;
%     curveData(counter, 2) = timeSyncTheta;
%     counter = counter + 1;
%     thetaGuess = timeSyncTheta;
% end
    
% all the calculated values are going to go into a temp matrix before being
% concatenated with the main matrix to avoid over writing data



end

