function [ trackArray, forceArray ] = Curve_After_Hammer( trackArray, forceArray, thetaStart, thetaEnd, r )

% Pull in required global variables
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball
global t_inc; %increment of t
t_inc = 0.01;

% Get initial conditions from master matrix
row = size(trackArray,1);
xi = trackArray(row, 2);
yi = trackArray(row, 3);
wi = trackArray(row, 8);
vi = (trackArray(row, 4)^2 + trackArray(row, 5)^2)^0.5;
vix = trackArray(row, 4);
viy = trackArray(row, 5);
Start_t = trackArray(row, 1);
t = Start_t + t_inc;   %The first time value to be evaluated

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
time_range = integral(thetaIntegral, thetaStart, thetaEnd);
time_range = real(time_range);  % Get the total time for the curve section and keep it real
disp(time_range)

prevTheta = thetaStart; % keep track of previous theta through the iterations

% calculate values at time increments
for i = 1:(1/t_inc) % do 100 time steps (at t_inc = 0.01)
    time = time_range*(i*t_inc);
    display(time);

% Assume no slip, do energy analysis    
    n = 0.01;  % this is a counter to increment theta, the integration limit
    while time > integral(thetaIntegral, thetaStart, prevTheta + n) % integrate until times match, find theta there
        n = n + 0.01;   % the theta incremeter
    end    
    thetaVal = prevTheta + n;  % get the final theta at that time
    display(thetaVal)
    prevTheta = thetaVal;  % update the previous theta for speed
    
    % Position
    x = xi + (r-R) * cos(thetaVal);
    y = yi + (r-R) * (1 + sin(thetaVal));
   
    % Velocity
    %w = real(sqrt((rkei + tkei + m*g*(r-R)*y)/(0.5*I + 0.5*m*(R)^2)));    
    %v = w*R;
    %vx = v * sin(thetaVal);   
    %vy = -v * cos(thetaVal);   

    % Use force analysis to get accelerations
    %alpha = -m*g*R*cos(thetaVal)/(I+m*R^2);
    %ax = -alpha*R*cos(thetaVal)+(w^2)*R*sin(thetaEnd - thetaVal);
    %ay = -alpha*R*sin(thetaVal)-(w^2)*R*cos(thetaEnd - thetaVal);
    
    %Attempted fix
    % Velocity
    w = -real(sqrt((rkei + tkei + m*g*(r-R)*y)/(0.5*I + 0.5*m*(R)^2)));    
    v = w*R;
    vx = v * sin(thetaVal);   
    vy = -v * cos(thetaVal);
    
    alpha = m*g*R*cos(thetaVal)/(I+m*R^2);
    ax = alpha*R*sin(thetaVal)+(w^2)*R*cos(thetaVal); %alpha neg, sin() neg, cos() neg
    ay = -alpha*R*cos(thetaVal)+(w^2)*R*sin(thetaVal); %Harrison
  
    
    % Find forces
    normalForce = -m * r* w^2 + m*g*cos(thetaVal);
    centripetalForce = m * r * w^2;
    
    %Add to master array
    New_Data = [t+time, x, y, vx, vy, ax, ay, w, alpha];
    newForce = [t+time, normalForce, 0,centripetalForce,0];  % getting the normal force for the force matrix
    trackArray = [trackArray; New_Data];
    forceArray = [forceArray; newForce];
    
end
end

