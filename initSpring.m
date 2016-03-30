function [F_spring, data_new] = initSpring(data_old)
% The required global variables are initialized in the fSystemInit function

data_new = data_old;

syms v
v = vpasolve(v == (k^(1/2)*x)/mass^(1/2),v);
data_new(1,4) = v; % Updates the data matrix with the initial x velocity. Note that the y velocity remains zero.
data_new(1,6) = v./R; % Updates the data matrix with the initial angular velocity. (Rolls without slipping)

syms F_normal

F_normal = m*g; % No acceleration in the y-direction, so the normal force is balanced by the weight.

data_new(1,10) = F_normal; % Adds the initial normal force into the normal force column of the master data matrix.

syms F_spring
F_spring = vpasolve(F_spring == (s/impact_time)*(5*k*mass/7)^(1/2), F_spring);
 
% Assuming that the frictional force does not affect the acceleration of the ball, it moves at constant velocity.
% i.e. The linear and angular acceleration remain zero.

end
