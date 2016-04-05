function [ Master_Array, forceArray ] = curve5( Master_Array, forceArray, Length )

% Pull in global variables
global I;   % moment of inertia of ball
global m;   % mass of ball
global g;   % acceleration due to gravity
global R;   % Radius of Ball
global t_inc; %increment of t

% Get initial conditions from master array
row = size(Master_Array,1);
StartPx = Master_Array(row, 2);
StartPy = Master_Array(row, 3);
Start_AngVel = Master_Array(row, 8);
Start_t = Master_Array(row, 1);
t = Start_t + t_inc;   %The first time value to be evaluated

%Angular acceleration is 0

%Find d after first t_inc
dist_travelled = -Start_AngVel*R*t_inc;

while dist_travelled < Length
    %Use energy analysis to determine ang velocity from the initial, under
    %no slip condition
    Cur_AngVel = Start_AngVel;
    CurPx = StartPx + dist_travelled;
    CurPy = StartPy;
    Vx = -Cur_AngVel*R;

    
    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    
   
    Norm_Force = m*(-g);
    
    %Add to master array
    New_Data = [t, CurPx, CurPy, Vx, 0, 0, 0, Cur_AngVel, 0];
    newForce = [t, Norm_Force, 0, 0, 0];
    Master_Array = [Master_Array; New_Data];
    forceArray = [forceArray; newForce];
    
    %Update time travelled and distane travelled
    t = t+t_inc;
    dist_travelled = -Start_AngVel*R*(t-Start_t);
end
%Add to the array the data of the ball after the collision with the end,
%resulting in the ball being at rest.
Last_Data = [t, CurPx, CurPy, 0, 0, 0, 0, 0, 0];
lastForce = [t, m*(-g), 0, 0, 0];
Master_Array = [Master_Array; Last_Data];
forceArray = [forceArray; lastForce];
end

