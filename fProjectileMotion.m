function [data_new] = ProjectileMOtion(data_old)
% The required global variables are initialized in the fSystemInit function

global R; % Radius of ball
R = 0.001;

[p, q] = size(data_old);

x_i = data_old(p,2); % Get the initial x position
y_i = data_old(p,3); % Get the initial y position
vx_i = data_old(p,4); % Get the initial x velocity from the master array
vy_i = data_old(p,5); % Get the initial y velocity from the master array

data_current = data_old(p,:);

for t=t_inc:t_inc:2  % If we start at 0 instead of t_inc, then we'll duplicate the last layer of the master matrix
 
 x = vx_i*t;
 y = t*vy_i - .5*(9.81)*t^2;
 
 v_y = vy_i + (9.81)*t
 
 data_current(1,2) = x_i + x;
 data_current(1,3) = y_i + y;
 data_current(1,5) = v_y; % Update the y velocity of the ball
 
 
 data_new = [data_old; data_new]
 
 if x == 0.005 - R
  end
 
 end

end
