function [ trackArray, forceArray ] = curve2New( trackArray, forceArray, thetaStart, thetaEnd, r )
%Test
%Analysis of curve after hammer impact

%Define Global variables
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball
global t_inc; %increment of t
t_inc = 0.01;
%Grabbing data from last row of the master array
row = size(trackArray,1);
xi = trackArray(row, 2);
yi = trackArray(row, 3);
wi = trackArray(row, 8);
vi = (trackArray(row, 4)^2 + trackArray(row, 5)^2)^0.5;
vix = trackArray(row, 4);
viy = trackArray(row, 5);
Start_t = trackArray(row, 1);
t = Start_t + t_inc;   %The first time value to be evaluated

%Establishes what the theta value is after one time increment, as we have
%all the data for the initial theta of 0
syms theta;
rkei = 0.5 * I * wi^2;   % initial rotational KE
tkei = 0.5 * m * vi^2;  % initial translational KE
gpei = @(theta) m * g * (r-R) * sin(theta);  % gravitational potential Energy



%time_range = int(sqrt((I+m*R^2)/((I+m*R^2)*Start_AngVel^2+2*m*g*(Circle_radius-R)*(1-cos(theta)))), theta, 0, Max_Theta);
%time_range = vpa(time_range);

%time_range = real(time_range);
%disp(time_range)

%NUMERICAL INTEGRATION OF TIME_RANGE
k = (I+m*R^2);  % breaking the big nasty scalar bits up to make it easier to read
e = (I+m*R^2)*wi^2+2*m*g* (r-R);
thingy = @(theta) (k/e*(1-cos(theta))).^0.5;    % note the element-wise exponent (instead of sqrt)
time_range = integral(thingy, thetaStart, thetaEnd);
time_range = real(time_range);
disp(time_range)

prevTheta = thetaStart;


for i = 1:(1/t_inc) % do 100 time steps
    time = time_range*(i*t_inc);
    display(time);
    %Use energy analysis to determine ang velocity from the initial, under
    %no slip condition
    
    n = 0.01;  % this is a counter to increment theta, the integration limit
    while time > integral(thingy, thetaStart, prevTheta + n)
        n = n + 0.01;
    end    
    thetaVal = prevTheta + n;  % get the final theta at that time
    display(thetaVal)
    prevTheta = thetaVal;  % update the previous theta for speed
              
    x = xi -(r-R) + (r-R) * cos(1.5*pi - thetaVal);
    
    y = yi + (r-R) * sin(1.5*pi - thetaVal);
   
    w = real(sqrt((rkei + tkei + m*g*(r-R)*y)/(0.5*I + 0.5*m*(R)^2)));    
    v = w*R;
    vx = vix - v * cos(thetaVal);   % nmay need negative
    vy = -v * sin(thetaVal);   % note negative

    
    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    alpha = -m*g*R*cos(1.5*pi - thetaVal)/(I+m*R^2);
    ax = -alpha*R*cos(1.5*pi - thetaVal)+(w^2)*R*sin(1.5*pi - thetaVal);
    ay = -alpha*R*sin(1.5*pi - thetaVal)-(w^2)*R*cos(1.5*pi - thetaVal);
    Norm_Force = -m*ax/sin(1.5*pi - thetaVal);
    centripetalForce = m * r * w^2;
    
    %Add to master array
    New_Data = [t+time, x, y, vx, vy, ax, ay, -w, alpha];
    newForce = [t+time, Norm_Force, 0,centripetalForce,0];  % getting the normal force for the force matrix
    trackArray = [trackArray; New_Data];
    forceArray = [forceArray; newForce];
    
end
end

