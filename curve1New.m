function [ trackArray, forceArray ] = curve1New( trackArray, forceArray, thetaStart, thetaEnd, r )
% first curve

% Get required globals
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball
global t_inc; %increment of t
t_inc = 0.01;
% Get initial values from the master array 
row = size(trackArray,1);
xi = trackArray(row, 2);    % initial x position
yi = trackArray(row, 3);    % initial y
wi = trackArray(row, 8);    % angular velocity
vi = (trackArray(row, 4)^2 + trackArray(row, 5)^2)^0.5; % need tangential velocity
startingTime = trackArray(row, 1);   % starting time
t = startingTime + t_inc;   %The first time value to be evaluated

% Initial energies
syms theta;
rkei = 0.5 * I * wi^2;   % initial rotational KE
tkei = 0.5 * m * vi^2;  % initial translational KE
gpei = @(theta) m * g * (r-R) * sin(theta);  % gravitational potential Energy


%NUMERICAL INTEGRATION OF TIME_RANGE
% breaking the big nasty scalar bits up to make it easier to read
k = (I+m*R^2);  
e = (I+m*R^2)*wi^2+2*m*g* (r-R);
thetaIntegral = @(theta) (k/e*(1-cos(theta))).^0.5;    % note the element-wise exponent (instead of sqrt)
time_range = integral(thetaIntegral, thetaStart, thetaEnd); 
time_range = real(time_range);  % get the time it takes to complete the curve and keep it real
disp(time_range)

prevTheta = thetaStart; % keeping track of previous theta through the iterations

for i = 1:(1/t_inc) % do 100 time steps (at t_inc = 0.01)
    time = time_range*(i*t_inc);
    
    % Assume no slipping, use energy analysis
    n = 0.01;  % this is a counter to increment theta, the integration limit
    while time > integral(thetaIntegral, thetaStart, prevTheta + n) % compute time through integration until it's the iteration time
        n = n + 0.01;
    end    
    thetaVal = prevTheta + n;  % get the final theta at that time
    display(thetaVal)
    prevTheta = thetaVal;  % update the previous theta for speed. Nice!
                
    % Positions
    x = xi + (r-R) * cos(thetaEnd - thetaVal);  
    y = yi -(r-R) + (r-R) * sin(thetaEnd - thetaVal);
   
    % Velocities
    w = real(sqrt((rkei + tkei + m*g*(r-R)*y)/(0.5*I + 0.5*m*(R)^2)));    
    v = w*R;
    vx = v * sin(thetaEnd - thetaVal);  
    vy = -v * cos(thetaEnd - thetaVal); 

    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    alpha = -m*g*R*cos(thetaEnd - thetaVal)/(I+m*R^2);
    ax = -alpha*R*sin(thetaEnd - thetaVal)+(w^2)*R*sin(thetaEnd - thetaVal);
    ay = -alpha*R*cos(thetaEnd - thetaVal)-(w^2)*R*cos(thetaEnd - thetaVal);
    
    % Find the forces
    normalForce = -m*ax/sin(thetaEnd - thetaVal);
    centripetalForce = m * r * w^2;
    
    %Add to master array
    New_Data = [t+time, x, y, vx, vy, ax, ay, -w, alpha];
    newForce = [t+time, normalForce, 0,centripetalForce,0];  % getting the normal force for the force matrix
    trackArray = [trackArray; New_Data];
    forceArray = [forceArray; newForce];
    
end
end

