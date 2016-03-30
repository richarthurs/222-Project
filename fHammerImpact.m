function [data_new] = HammerImpact(data_old)
% The required global variables are initialized in the fSystemInit function

global mass_hammer;
global mass_ball;
global g;
g = 9.81; % Global gravity value in fSystemInit is negative...

h_1 = 0.11; % In metres, the diistance the centre of gravity travels from top to point of impact.
h_2 = 0.05; % In metres, the height the centre of gravity of the hammer travels after impact.
d = 0.055; % In metres, the distance from the centre of gravity of the hammer to the point of rotation.
r = 0.01; % In metres, the radius of the cylindrical hammer head.

[p, q] = size(data_old);
data_new = data_old(p,:);

syms v
v = vpasolve(v == (mass_hammer/mass_ball)*(sqrt(2*g*h_2)-d*sqrt((2*g*h_1)/(.5(r^2) + d^2))),v);
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
