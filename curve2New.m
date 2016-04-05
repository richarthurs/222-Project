function [ trackArray, forceArray ] = curve2New( trackArray, forceArray, thetaStart, thetaEnd, r )

% Pull in the required globals
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball
global t_inc; %increment of t
t_inc = 0.01;
% Get initial values from master array
row = size(trackArray,1);   % need this to count
xi = trackArray(row, 2);
yi = trackArray(row, 3);
wi = trackArray(row, 8);
vi = (trackArray(row, 4)^2 + trackArray(row, 5)^2)^0.5; % tangential velocity from XY
vix = trackArray(row, 4);
viy = trackArray(row, 5);
startTime = trackArray(row, 1);
t = startTime + t_inc;   %The first time value to be evaluated

% Calculate initial energies
syms theta;
rkei = 0.5 * I * wi^2;   % initial rotational KE
tkei = 0.5 * m * vi^2;  % initial translational KE
gpei = @(theta) m * g * (r-R) * sin(theta);  % gravitational potential Energy


%NUMERICAL INTEGRATION OF TIME_RANGE
 % breaking the big nasty scalar bits up to make it easier to read
k = (I+m*R^2); 
e = (I+m*R^2)*wi^2+2*m*g* (r-R);
thetaIntegral = @(theta) (k/e*(1-cos(theta))).^0.5;    % note the element-wise exponent (instead of sqrt)
time_range = integral(thetaIntegral, thetaStart, thetaEnd);    % get the time it takes to complete the curve section
time_range = real(time_range);
disp(time_range)

prevTheta = thetaStart; % keep track of theta through the iterations


for i = 1:(1/t_inc) % do 100 time steps (at t_inc = 0.01)
    time = time_range*(i*t_inc);
    display(time);
    
    % Assume no slip, use energy analysis
    
    n = 0.01;  % this is a counter to increment theta, the integration limit
    while time > integral(thetaIntegral, thetaStart, prevTheta + n)    % integrate until times match to get theta at that time
        n = n + 0.01;   % this is the theta increment
    end    
    
    thetaVal = prevTheta + n;  % get the final theta at that time
    display(thetaVal)
    prevTheta = thetaVal;  % update the previous theta for speed
              
    % Position
    x = xi -(r-R) + (r-R) * cos(1.5*pi - thetaVal);
    y = yi + (r-R) * sin(1.5*pi - thetaVal);
   
    % Velocities
    w = real(sqrt((rkei + tkei + m*g*(r-R)*y)/(0.5*I + 0.5*m*(R)^2)));    
    v = w*R;
    vx = vix - v * cos(thetaVal);  
    vy = -v * sin(thetaVal);  

    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    alpha = -m*g*R*cos(1.5*pi - thetaVal)/(I+m*R^2);
    ax = -alpha*R*cos(1.5*pi - thetaVal)+(w^2)*R*sin(1.5*pi - thetaVal);
    ay = -alpha*R*sin(1.5*pi - thetaVal)-(w^2)*R*cos(1.5*pi - thetaVal);
    
    % Find Forces
    normalForce = -m*ax/sin(1.5*pi - thetaVal);
    centripetalForce = m * r * w^2;
    
    %Add to master array
    New_Data = [t+time, x, y, vx, vy, ax, ay, -w, alpha];
    newForce = [t+time, normalForce, 0,centripetalForce,0];  % getting the normal force for the force matrix
    trackArray = [trackArray; New_Data];
    forceArray = [forceArray; newForce];
    
end
end

