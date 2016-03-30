function [F_spring, data_new] = initSpring(data_old)
%declare the global variables that are needed throughout 
global mass;
global velocity;
global impact_time; % Impact time between the spring and the ball
global s;           % Distance compressed by the spring
global R;           % Radius of the ball

syms v
v = vpasolve(v == (k^(1/2)*x)/mass^(1/2),v);
data_new(1,4) = v; % Updates the data matrix with the initial x velocity. Note that the y velocity remains zero.
data_new(1,6) = v*R; % Updates the data matrix with the initial angular velocity. (Rolls without slipping)


+syms F_spring
 +F_spring = vpasolve(F_spring == (s/impact_time)*(5*k*mass/7)^(1/2), F_spring);
 +
 +% Assuming that the frictional force does not affect the acceleration of the ball, it moves at constant velocity.
 +% i.e. The linear and angular acceleration remain zero.

end
