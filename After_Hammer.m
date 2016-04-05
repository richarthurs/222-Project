function [ Master_Array, force_Array ] = After_Hammer( Master_Array, force_Array, Max_Theta, Circle_radius )
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
row = size(Master_Array,1);
StartPx = Master_Array(row, 2);
StartPy = Master_Array(row, 3)-R; % need to shift down by the radius
Start_AngVel = Master_Array(row, 8);
Start_t = Master_Array(row, 1);
t = Start_t + t_inc;   %The first time value to be evaluated

%Establishes what the theta value is after one time increment, as we have
%all the data for the initial theta of 0
syms theta;



%time_range = int(sqrt((I+m*R^2)/((I+m*R^2)*Start_AngVel^2+2*m*g*(Circle_radius-R)*(1-cos(theta)))), theta, 0, Max_Theta);
%time_range = vpa(time_range);

%time_range = real(time_range);
%disp(time_range)

%NUMERICAL INTEGRATION OF TIME_RANGE
k = (I+m*R^2);  % breaking the big nasty scalar bits up to make it easier to read
e = (I+m*R^2)*Start_AngVel^2+2*m*g* (Circle_radius-R);
thingy = @(theta) (k/e*(1-cos(theta))).^0.5;    % note the element-wise exponent (instead of sqrt)
time_range = integral(thingy, 0, Max_Theta);
time_range = real(time_range);
disp(time_range)


iteration_count = (time_range/t_inc);
display(iteration_count)
theta_increment = Max_Theta/iteration_count;
display(theta_increment)

%for Cur_theta=theta_increment:theta_increment:Max_Theta

prevTheta = 0;


for i = 1:(1/t_inc) % do 100 time steps
    time = time_range*(i*t_inc);
    
    New_Data(i, 1) = t + time;
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
    CurPx = StartPx + (Circle_radius-R)*sin(Cur_theta);
    CurPy = StartPy + (Circle_radius-(Circle_radius-R)*cos(Cur_theta));
    Vx = Cur_AngVel*R*cos(Cur_theta);
    Vy = -Cur_AngVel*R*sin(Cur_theta);
    
    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    Cur_AngAcc = -m*g*R*cos(Cur_theta)/(I+m*R^2);
    ax = -Cur_AngAcc*R*cos(Cur_theta)+(Cur_AngVel^2)*R*sin(Cur_theta);
    ay = -Cur_AngAcc*R*sin(Cur_theta)-(Cur_AngVel^2)*R*cos(Cur_theta);
    Norm_Force = -m*ax/sin(Cur_theta);
    centripetalForce = m * Circle_radius * Cur_AngVel^2;
    
    %Add to master array
    New_Data = [t, CurPx, CurPy, Vx, Vy, ax, ay, Cur_AngVel, Cur_AngAcc];
    newForce = [t, Norm_Force, 0,centripetalForce,0];  % getting the normal force for the force matrix
    Master_Array = [Master_Array; New_Data];
    force_Array = [force_Array; newForce];
    t = t+t_inc;
    
end
end

