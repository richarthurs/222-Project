function [forceData, springData] = initSpring(data_old,x)
% The required global variables are initialized in the fSystemInit function

springData = data_old;

global k;
global m;
global g;
global s;
global R;
global impact_time;

forceData = zeros(1, 5);
springData = zeros(1, 9);

syms v
v = vpasolve(v == (k^(1/2)*x)/m^(1/2),v);
springData(1,4) = v; % Updates the data matrix with the initial x velocity. Note that the y velocity remains zero.
springData(1,8) = v./R; % Updates the data matrix with the initial angular velocity. (Rolls without slipping)

syms F_normal

F_normal = m*g; % No acceleration in the y-direction, so the normal force is balanced by the weight.

%springData(1,10) = F_normal; % Adds the initial normal force into the normal force column of the master data matrix.

syms F_spring
F_spring = vpasolve(F_spring == (s/impact_time)*(5*k*m/7)^(1/2), F_spring);
 



forceData(1, 2) = F_normal; 
forceData(1, 3) = F_spring;
forceData(1, 1) = 0;    % this is the time for the force - initial = 0

% Assuming that the frictional force does not affect the acceleration of the ball, it moves at constant velocity.
% i.e. The linear and angular acceleration remain zero.

end
