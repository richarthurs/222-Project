function [ Master_Array ] = After_Hammer( Master_Array, Max_Theta, Circle_radius )

%Analysis of curve after hammer impact
%Need to relate time to theta, need to get data and add data to the master
%Array

%Variables that need to be grabbed from array
%t from array
%Start_AngVel grab from array
%Cur_theta = initial value from array
%StartPx from array
%StartPy from array

%Entered data from measurements
%Max_Theta

global steps;   % the number of steps to compute in iterative functions
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball

%Pull data from master array

%Need to relate t to theta in some fashion
while(Cur_theta <= Max_Theta)
    %Use energy analysis to determine ang velocity from the initial, under
    %no slip condition
    Cur_AngVel = sqrt(((I+mR^2)*Start_AngVel^2-2*m*g(Circle_radius-R)(1-cos(Cur_Theta)))/(I+m*R^2));
    CurPx = StartPx + (Circle_radius-R)*sin(Cur_Theta);
    CurPy = StartPy + (Circle_radius-(Circle_radius-R)*cos(Cur_theta));
    Vx = Cur_AngVel*R*cos(Cur_theta);
    Vy = Cur_AngVel*R*sin(Cur_theta);
    
    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    Cur_AngAcc = m*g*R*cos(Cur_theta)/(I+m*R^2);
    ax = -Cur_AngAcc*R*cos(Cur_theta)+(Cur_AngVel^2)*R*sin(Cur_theta);
    ay = -Cur_AngAcc*R*sin(Cur_theta)-(Cur_AngVel^2)*R*cos(Cur_theta);
    Norm_Force = -m*ax/sin(Cur_theta);
    
    %Add to master array
    %Relate theta increase to time 
end

    
end

