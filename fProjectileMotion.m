function [data_new] = ProjectileMotion(data_old)
% The required global variables are initialized in the fSystemInit function

global R; % Radius of ball
global t_inc;
t_inc = 0.01;
R = 0.01;

[p, q] = size(data_old);

x_i = data_old(p,2); % Get the initial x position
y_i = data_old(p,3); % Get the initial y position
vx_i = data_old(p,4); % Get the initial x velocity from the master array
vy_i = data_old(p,5); % Get the initial y velocity from the master array

data_current = data_old(p,:);
data_new = data_old;

for t=t_inc:t_inc:1  % If we start at 0 instead of t_inc, then we'll duplicate the last layer of the master matrix
 
    
 if x < (0.05 - R)
 % We want to keep incrementing the x values.
    x = vx_i*t; % Current x position relative to starting position 
 elseif x >= (0.05 - R)
     x = 0;
 elseif y == -0.0633 % When the ball has fallen enough that it has reached the curved landing
     break
 end
 

     
    

 y = t*vy_i - .5*(9.81)*t^2; % Current y position relative to starting position
 
 v_y = vy_i - (9.81)*t; % Current y velocity
 
 data_current(1,1) = data_current(1,1) + t_inc; % Increment the time by t_inc
 data_current(1,2) = x_i + x; % Update master matrix with absolute x position of the ball
 data_current(1,3) = y_i + y; % Update master matrix with absolute y position of the ball
 data_current(1,5) = v_y; % Update the y velocity of the ball, x velocity remains constant

 data_new = [data_new; data_current];
 
 if x >= (0.05 - R)
  % If this if-statement executes, we know the ball has hit the wall.
  % Then, we will consider the ball falling straight vertically downwards,
  % x position remains constant.
  x = 0;
  break
 end
 
end

 figure
plot(data_new(:,2),data_new(:,3)); % Plot x vs y
figure
plot(data_new(:,1),data_new(:,5));
end





