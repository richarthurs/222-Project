function [Hammer_Data, F_hammer, data_new, force_new] = HammerImpact(data_old, force_old)
% The required global variables are initialized in the fSystemInit function

global t_inc;

global R; % 0.01 metres
g = 9.81; % Global gravity value in fSystemInit is negative...
global mass_hammer; % 92 grams
global mass_ball; % 16 grams

global h; % In metres, the height the centre of gravity of the hammer travels after impact.
global d; % In metres, the distance from the centre of gravity of the hammer to the point of rotation.
r = 0.01; % In metres, the radius of the cylindrical hammer head.

% Note that we are approximating the hammer as a slender rod with no mass with a cylinder on the end.
% We assumed that the mass of the rod was negligible in comparison to the hammer head and would thus only slightly affect the centre of gravity
% Therefore the centre of gravity lies at the centre of gravity of the cylinder shape on the end of the rod.
% We can then approximate the moment of inertia as that of a cylinder, 0.5mr^2


[p, q] = size(data_old);
data_new = data_old(p,:);

syms v_ball
v_ball = vpasolve(v_ball == (mass_hammer/mass_ball)*d*sqrt(2*9.81/(.5*r^2+d^2))*(sqrt(2*d)-sqrt(h)));
data_new(1,4) = v_ball; % Updates the data matrix with the x velocity. Note that the y velocity remains zero.
data_new(1,8) = v_ball./R; % Updates the data matrix with the angular velocity. (Rolls without slipping)

syms F_normal

F_normal = mass_ball*g; % No acceleration in the y-direction, so the normal force is balanced by the weight.

force_new = zeros(1,5);
force_new(1,2) = F_normal; % Adds the initial normal force into the normal force column of the force matrix
force_new = [force_old; force_new]; % add the old force data into the output force matrix
% Time taken for the hammer to fall from top to bottom is approximately 0.5 seconds
% Time taken from hammer to go from bottom position to top after hitting the ball is approximately 0.34 seconds

syms F_hammer
F_hammer = vpasolve(F_hammer == (mass_ball*v_ball/0.00141), F_hammer); % 0.00141 is the estimated impact time in seconds.

wi_hammer = sqrt((4*9.81*d)/(.5*r^2+d^2)); % Angular velocity of the hammer right before impact with the ball
w_int_hammer = sqrt((2*9.81*h)/(0.5*r^2+d^2)); % Intermediate angular velocity, right after impact with the ball
wf_hammer = 0; % Angular velocity of the hammer as it rises and comes to rest before falling down again.

% Using the kinematic formulas and assuming constant acceleration, the linear and angular accelerations can be found
% The time intervals have been measured experimentally

% Assuming constant linear and angular acceleration
alpha_1_hammer = (wi_hammer)/0.5; % Angular acceleration of hammer from top to bottom
alpha_2_hammer = (wf_hammer - w_int_hammer)/0.34; % Angular acceleration of hammer from after impact to top as it follows through

a_1 = alpha_1_hammer*d;
a_2 = alpha_2_hammer*d;

data_new = [data_old; data_new];

Hammer_Data = zeros(1,5); % time, velocity, angular velocity, acceleration, angular acceleration

%% First part of the hammer swing, until impact

for t = t_inc:t_inc:0.5

 Current_Data = zeros(1,5);
 Current_Data(1,1) = t + data_old(p,1); % The current time we're at starting from when the ball hits the bottom of the hammer.
 Current_Data(1,2) = alpha_1_hammer*t*d; % Current velocity of the hammer centre of gravity
 Current_Data(1,3) = alpha_1_hammer*t; % Current angular velocity of the hammer
 Current_Data(1,4) = a_1; % Constant linear acceleration of the hammer centre of gravity
 Current_Data(1,5) = alpha_1_hammer; % Constant angular acceleration of the hammer
 
 Hammer_Data = [Hammer_Data; Current_Data];
end

%% Second part of the hammer swing, after impact till it reaches maximum height

for i = t_inc:t_inc:0.34

 Current = zeros(1,5);
 Current(1,1) = i + 0.5 + data_old(p,1); % Current time
 Current(1,2) = w_int_hammer*d + a_2*i; % Current velocity of the hammer centre of gravity
 Current(1,3) = w_int_hammer + alpha_2_hammer*i; % Current angular velocity of the hammer
 Current(1,4) = a_2; % Constant linear acceleration of the hammer centre of gravity
 Current(1,5) = alpha_2_hammer; % Constant angular acceleration of the hammer
 
 Hammer_Data = [Hammer_Data; Current];
end

 
% Assuming that the frictional force does not affect the acceleration of the ball, it moves at constant velocity.
% i.e. The linear and angular acceleration remain zero.

end
