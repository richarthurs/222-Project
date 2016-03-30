function [  ] = SystemInit(  )
function [  ] = fSystemInit(  )
% This function initializes the global variables required for the
% simulation. Change ball parameters here. 

global g;   % Gravity
global R;   % Radius of Ball
global m;   % Mass of Ball
global I;   % Moment of inertia of ball
global steps;
global k;   % Spring constant of the ball

g = -9.81;
R = 0.01;
m = 0.03;
I = 0.4 * m * R^2;
I = 0.4 * m * R^2;  
steps = 10;
k = 100;

end

