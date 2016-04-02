function [data_new] = ProjectileMotion(data_old)
% The required global variables are initialized in the fSystemInit function

global R; % Radius of ball
global t_inc;
t_inc = 0.001;
R = 0.01;

[p, q] = size(data_old);

x_i = data_old(p,2); % Get the initial x position
y_i = data_old(p,3); % Get the initial y position
vx_i = data_old(p,4); % Get the initial x velocity from the master array
vy_i = data_old(p,5); % Get the initial y velocity from the master array

data_current = data_old(p,:);
data_new = data_old;

%% Constant parameters during the projectile motion

data_current(1,6) = 0; % Angular velocity is assumed to be zero
data_current(1,7) = 0; % x component of acceleration remains zero
data_current(1,8) = -9.81; % y component of acceleration remains g
data_current(1,9) = 0; % Angular acceleration is assumed to be zero

%% Changing position and velocity
x = 0; % Current x position relative to starting position
y = 0; % Current y position relative to starting position

for t=t_inc:t_inc:2  % If we start at 0 instead of t_inc, then we'll duplicate the last layer of the master matrix

 if x < (0.05 - R) && y > -0.0633
 % We want to keep incrementing the x values.
    x = vx_i*t; % Current x position relative to starting position 
 elseif x >= (0.05 - R) && y > -0.0633 % If the ball has hit the ball but still has space to fall downward:
     % Do nothing
 elseif x >= (0.05 - R) && y <= -0.0633
     break
 elseif x < (0.05 - R) && y <= -0.0633
     break
 end
 
 y = t*vy_i - .5*(9.81)*t^2; % Current y position relative to starting position
 
 v_y = vy_i - (9.81)*t; % Current y velocity
  
 data_current(1,1) = data_current(1,1) + t_inc; % Increment the time by t_inc
 data_current(1,2) = x_i + x; % Update master matrix with absolute x position of the ball
 data_current(1,3) = y_i + y; % Update master matrix with absolute y position of the ball
 data_current(1,5) = v_y; % Update the y velocity of the ball, x velocity remains constant

 data_new = [data_new; data_current];

end

 figure
plot(data_new(:,2),data_new(:,3)); % Plot x vs y
figure
plot(data_new(:,1),data_new(:,5));
end





