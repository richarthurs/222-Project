function [ Master_Array ] = Rod_Rotation( Master_Array, Length_of_Rod, L, small_length, mass_rod, mass_weight, initial_theta, final_theta )

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
Start_AngVel = 0;
Start_t = Master_Array(row, 1);
t = Start_t + t_inc;   %The first time value to be evaluated

Rod_Array = [t, 0, 0, 0, 0, 0, 0];

%Finding constant Angular Acceleration
Ang_Acc = (m*(-g)*L-mass_weight*(-g)*small_length+mass_rod*(-g)*(0.5*Length_of_Rod-small_length))/(((1/12)*mass_rod*Length_of_Rod^2)+mass_rod*(0.5*Length_of_Rod-small_length)^2);

%Find d after first t_inc
current_theta = abs(Ang_Acc)*0.5*t_inc^2+initial_theta;
total_theta = final_theta-initial_theta;

while current_theta < total_theta
    %Use energy analysis to determine ang velocity from the initial, under
    %no slip condition
    Cur_AngVel = (-m*(-g)*L*(t-Start_t)-mass_weight*(-g)*small_length*(t-Start_t)-mass_rod*(-g)*(t-Start_t)*(0.5*Length_of_Rod-small_length))/(((1/12)*mass_rod*Length_of_Rod^2)+mass_rod*(0.5*Length_of_Rod-small_length)^2);
    
    CurPx = StartPx + L*(cos(initial_theta)-cos(current_theta));
    if current_theta < 0
        CurPy = StartPy+L*(-sin(abs(current_theta))+sin(abs(initial_theta)));
    else
        CurPy = StartPy+L*(sin(abs(initial_theta))+sin(current_theta));
    end
    Vy = -Cur_AngVel*L*cos(current_theta);
    Vx = -Cur_AngVel*L*sin(current_theta);
    
    %Used force analysis with no friction to find ang acc and then
    %tangential and normal acceleration
    
    ax = -Ang_Acc*L*sin(current_theta)+(Cur_AngVel^2)*L*cos(current_theta);
    ay = -Ang_Acc*L*cos(current_theta)-(Cur_AngVel^2)*L*sin(current_theta);
    
    %ax = -Ang_Acc*L*sin(current_theta);
    %ay = -Ang_Acc*L*cos(current_theta);
    Norm_Force = m*ay+m*(-g)*cos(current_theta);
    
    %Add to master array
    New_Data = [t, CurPx, CurPy, Vx, Vy, 0, ax, ay, 0, Norm_Force];
    Master_Array = [Master_Array; New_Data];
    
    %Rod Data
    Rod_vgy = -Cur_AngVel*(0.5*Length_of_Rod-small_length)*cos(current_theta);
    Rod_vgx = -Cur_AngVel*(0.5*Length_of_Rod-small_length)*sin(current_theta);
    Rod_agx = -Ang_Acc*(0.5*Length_of_Rod-small_length)*sin(current_theta)+(Cur_AngVel^2)*(0.5*Length_of_Rod-small_length)*cos(current_theta);
    Rod_agy = -Ang_Acc*(0.5*Length_of_Rod-small_length)*cos(current_theta)-(Cur_AngVel^2)*(0.5*Length_of_Rod-small_length)*sin(current_theta);
    
    Rod_Data = [t, Rod_vgx, Rod_vgy, Cur_AngVel, Rod_agx, Rod_agy, Ang_Acc];
    Rod_Array = [Rod_Array; Rod_Data];
    t = t+t_inc;
    current_theta = 0.5*abs(Ang_Acc)*(t-Start_t)^2 + initial_theta;
end
Last_Data = [t, CurPx, CurPy, 0, 0, 0, 0, 0, 0, m*(-g)*cos(final_theta)];
Master_Array = [Master_Array; Last_Data];
disp(Rod_Array)
end
