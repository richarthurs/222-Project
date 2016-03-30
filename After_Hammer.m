function [ Master_Array ] = After_Hammer( Master_Array, Max_Theta, Circle_radius )

%Variables
%t
%Vx
%Vy
%Start_theta
%Start_AngVel
%Cur_theta = Start_theta
%Cur_AngVel = From Array
%CurPx
%CurPy
%StartPx
%StartPy

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
    Cur_AngAcc = m*g*R*cos(Cur_theta)/(I+m*R^2);
    ax = -Cur_AngAcc*R*cos(Cur_theta)+(Cur_AngVel^2)*R*sin(Cur_theta);
    ay = -Cur_AngAcc*R*sin(Cur_theta)-(Cur_AngVel^2)*R*cos(Cur_theta);
    Norm_Force = -m*ax/sin(Cur_theta);
    
    %Add to master array
end

    
end

