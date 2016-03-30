function v = initSpring(x,k)
%declare the global variables that are needed throughout 
global mass;
global velocity;
global impact_time; % Impact time between the spring and the ball
global s; % Distance compressed by the spring
global r; % Radius of the ball
global k; % Spring constant of the ball

impact_time = 0.00141; % Time in seconds

syms v
v = vpasolve(v == ((5k^(1/2))*x)/(7*mass^(1/2)),v);
velocity = [v, 0];

syms F_spring
F_spring = vpasolve(F_spring == (s/impact_time)*(5*k*mass/7)^(1/2), F_spring);

% Assuming that the frictional force does not affect the acceleration of the ball, it moves at constant velocity
% Without any linear or angular acceleration. 

syms omega
omega = v*r;

end
