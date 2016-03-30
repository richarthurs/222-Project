function [ Master_Array ] = After_Hammer( Master_Array, Max_Theta, Circle_radius )

%Analysis of curve after hammer impact

%Define Global variables
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball
global t_inc; %increment of t

%Grabbing data from last row of the master array
row = size(Master_Array,1);
StartPx = Master_Array(row, 2);
StartPy = Master_Array(row, 3);
Start_AngVel = Master_Array(row, 5);
Start_t = Master_Array(row, 1);
t = Start_t + t_inc;   %The first time value to be evaluated

%Establishes what the theta value is after one time increment, as we have
%all the data for the initial theta of 0
theta = 
time_range = int(vpa(sqrt((I+m*R^2)/((I+m*R^2)*Start_AngVel^2+2*m*g(Circle_radius-R)*(1-cos(theta))))), theta, 0, Max_Theta);
time_range = real(time_range);
iteration_count = (time_range/t_inc);
theta_increment = round(Max_Theta/iteration_count);

for Cur_theta=theta_increment:theta_increment:Max_Theta
    %Use energy analysis to determine ang velocity from the initial, under
    %no slip condition
    Cur_AngVel = sqrt(((I+m*R^2)*Start_AngVel^2-2*m*g(Circle_radius-R)*(1-cos(Cur_theta)))/(I+m*R^2));
    CurPx = StartPx + (Circle_radius-R)*sin(Cur_theta);
    CurPy = StartPy + (Circle_radius-(Circle_radius-R)*cos(Cur_theta));
    Vx = Cur_AngVel*R*cos(Cur_theta);
    Vy = Cur_AngVel*R*sin(Cur_theta);
    
    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    Cur_AngAcc = -m*g*R*cos(Cur_theta)/(I+m*R^2);
    ax = -Cur_AngAcc*R*cos(Cur_theta)+(Cur_AngVel^2)*R*sin(Cur_theta);
    ay = -Cur_AngAcc*R*sin(Cur_theta)-(Cur_AngVel^2)*R*cos(Cur_theta);
    Norm_Force = -m*ax/sin(Cur_theta);
    
    %Add to master array
    New_Data = [t, CurPx, CurPy, Vx, Vy, Cur_AngVel, ax, ay, Cur_AngAcc, Norm_Force];
    Master_Array = [Master_Array; New_Data];
    
    t = t+t_inc;
end
end

