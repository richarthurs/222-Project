function [data_new] = ProjectileMOtion(data_old)
% The required global variables are initialized in the fSystemInit function

[p, q] = size(data_old);

vx_i = data_old(p,2); % Get the initial x velocity from the master array
vy_i = data_old(p,3); % Get the initial y velocity from the master array

for t=0:t_inc:2
 
 x = vx_i*t;
 y = t*vy_i - .5*(9.81)*t^2;
 
 if x == 0.005 - R
  end
 else if y == 0 && x == 
 
 end

end
