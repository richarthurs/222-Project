function [ Master_Array, force_Array ] = curve6( Master_Array, force_Array, thetaMin, thetaMax, Circle_radius )

% Pull in global variables
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball
global t_inc; %increment of t
t_inc = 0.01;

% Get initial conditions from master array
row = size(Master_Array,1);
StartPx = Master_Array(row, 2);
StartPy = Master_Array(row, 3);
Start_AngVel = Master_Array(row, 8);
Start_t = Master_Array(row, 1);
t = Start_t + t_inc;   %The first time value to be evaluated

syms theta;

%NUMERICAL INTEGRATION OF TIME_RANGE
k = (I+m*R^2);  % breaking the big nasty scalar bits up to make it easier to read
e = (I+m*R^2)*Start_AngVel^2+2*m*g* (Circle_radius-R);
thingy = @(theta) (k/e*(1-cos(theta))).^0.5;    % note the element-wise exponent (instead of sqrt)
time_range = integral(thingy, thetaMin, thetaMax);  % find the time it takes for the curve section
time_range = real(time_range);
disp(time_range)

prevTheta = thetaMin;   % keep track of theta in iterations

% calculate values at a series of time increments
for i = 1:(1/t_inc) % do 100 time steps 
    time = time_range*(i*t_inc);
    
    %New_Data(i, 1) = t + time;
    %Use energy analysis to determine ang velocity from the initial, under
    %no slip condition
    
    n = 0.01;  % this is a counter to increment theta, the integration limit
    while time > integral(thingy, 0, prevTheta + n)
        n = n + 0.01;
    end    
    Cur_theta = prevTheta + n;  % get the final theta at that time
    display(Cur_theta)
    prevTheta = Cur_theta;  % update the previous theta for speed
    
    Cur_AngVel = (((I+m*R^2)*Start_AngVel^2-2*m*g*(Circle_radius-R)*(1-cos(Cur_theta)))/(I+m*R^2))^0.5;
    
    CurPx = StartPx -(Circle_radius-R) + (Circle_radius-R) * cos(1.5*pi - Cur_theta);
    CurPy =   StartPy + (Circle_radius-R) * sin(1.5*pi - Cur_theta);
    Vx = -Cur_AngVel*R*cos(Cur_theta);
    Vy = Cur_AngVel*R*sin(Cur_theta);
    
    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    Cur_AngAcc = -m*g*R*cos(Cur_theta)/(I+m*R^2);
    ax = -Cur_AngAcc*R*cos(Cur_theta)-(Cur_AngVel^2)*R*sin(Cur_theta);
    ay = Cur_AngAcc*R*sin(Cur_theta)-(Cur_AngVel^2)*R*cos(Cur_theta);
    Norm_Force = -m*ax/sin(Cur_theta);
    centripetalForce = m * Circle_radius * Cur_AngVel^2;
    
    %Add to master array
    New_Data = [t+time, CurPx, CurPy, Vx, Vy, ax, ay, Cur_AngVel, Cur_AngAcc];
    newForce = [t+time, Norm_Force, 0,centripetalForce,0];  % getting the normal force for the force matrix
    Master_Array = [Master_Array; New_Data];
    force_Array = [force_Array; newForce];
    %t = t+t_inc;
    
end
end

