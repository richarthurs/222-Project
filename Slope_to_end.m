function [ Master_Array ] = Downhill_Slope_to_End( Master_Array, Incline_Angle, Length )
%Test
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

%Finding constant Angular Acceleration
Ang_Acc = m*(-g)*R*sin(Incline_Angle)/(I+m*R^2);

%Find d after first t_inc
dist_travelled = Start_AngVel*R*t_inc + 0.5*Ang_Acc*R*t_inc^2;

while dist_travelled < Length
    %Use energy analysis to determine ang velocity from the initial, under
    %no slip condition
    Cur_AngVel = sqrt(((I+m*R^2)*Start_AngVel^2-2*m*g*dist_travelled*sin(Incline_Angle))/(I+m*R^2));
    CurPx = StartPx - dist_travelled*cos(Incline_Angle);
    CurPy = StartPy - dist_travelled*sin(Incline_Angle);
    Vx = -Cur_AngVel*R*cos(Incline_Angle);
    Vy = -Cur_AngVel*R*sin(Incline_Angle);
    
    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    
    ax = -Ang_Acc*R*cos(Incline_Angle);
    ay = -Ang_Acc*R*sin(Incline_Angle);
    Norm_Force = -m*ax/sin(Incline_Angle);
    
    %Add to master array
    New_Data = [t, CurPx, CurPy, Vx, Vy, Cur_AngVel, ax, ay, Ang_Acc, Norm_Force];
    Master_Array = [Master_Array; New_Data];
    
    t = t+t_inc;
    dist_travelled = Start_AngVel*R*(t-Start_t) + 0.5*Ang_Acc*R*(t-Start_t)^2;
end
end

