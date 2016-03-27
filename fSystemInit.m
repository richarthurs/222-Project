function [  ] = SystemInit(  )
% This function initializes the global variables required for the
% simulation. Change ball parameters here. 

global g;
global R;   % Radius of Ball
global m;   % Mass of Ball
global I;   % Moment of inertia of ball
global steps;

g = -9.81;
R = 0.01;
m = 0.03;
I = 0.4 * m * R^2;
steps = 10;

end

