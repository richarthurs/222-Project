function [F_hammer, data_new] = HammerImpact(data_old)
% The required global variables are initialized in the fSystemInit function

R = 0.01; % 0.01 metres
g = 9.81; % Global gravity value in fSystemInit is negative...
mass_hammer = 0.2; %200 grams
mass_ball = 0.03; %30 grams

h_1 = 0.11; % In metres, the diistance the centre of gravity travels from top to point of impact.
h_2 = 0.05; % In metres, the height the centre of gravity of the hammer travels after impact.
d = 0.055; % In metres, the distance from the centre of gravity of the hammer to the point of rotation.
r = 0.01; % In metres, the radius of the cylindrical hammer head.

% Note that we are approximating the hammer as a slender rod with no mass with a cylinder on the end.
% We assumed that the mass of the rod was negligible in comparison to the hammer head and would thus only slightly affect the centre of gravity
% Therefore the centre of gravity lies at the centre of gravity of the cylinder shape on the end of the rod.
% We can then approximate the moment of inertia as that of a cylinder, 0.5mr^2


[p, q] = size(data_old);
data_new = data_old(p,:);

syms v_ball
v_ball = vpasolve(v_ball == (mass_hammer/mass_ball)*(d*sqrt((2*g*h_1)/(.5*r^2 + d^2))-sqrt(2*g*h_2)),v_ball);
data_new(1,4) = v_ball; % Updates the data matrix with the x velocity. Note that the y velocity remains zero.
data_new(1,6) = v_ball./R; % Updates the data matrix with the angular velocity. (Rolls without slipping)

syms F_normal

F_normal = mass_ball*g; % No acceleration in the y-direction, so the normal force is balanced by the weight.

data_new(1,10) = F_normal; % Adds the initial normal force into the normal force column of the master data matrix.

% Time taken for the hammer to fall from top to bottom is approximately 0.5 seconds
% Time taken from hammer to go from bottom position to top after hitting the ball is approximately 0.34 seconds

syms F_hammer
F_hammer = vpasolve(F_hammer == (mass_ball*v_ball/0.00141), F_hammer); % 0.00141 is the estimated impact time in seconds.

wi_hammer = sqrt((2*g*h_1)/(.5r^2+d^2)); % Angular velocity of the hammer right before impact with the ball
w_int_hammer = sqrt(2*g*h_2); % Intermediate angular velocity, right after impact with the ball
wf_hammer = 0; % Angular velocity of the hammer as it rises and comes to rest before falling down again.

% Using the kinematic formulas and assuming constant acceleration, the linear and angular accelerations can be found
% The time intervals have been measured experimentally

% Assuming constant linear and angular acceleration
alpha_1_hammer = (wi_hammer)/0.5; % Angular acceleration of hammer from top to bottom
alpha_2_hammer = (wf_hammer - w_int_hammer)/0.34; % Angular acceleration of hammer from after impact to top as it follows through

a_1

data_new = [data_old; data_new];
 
% Assuming that the frictional force does not affect the acceleration of the ball, it moves at constant velocity.
% i.e. The linear and angular acceleration remain zero.

end
