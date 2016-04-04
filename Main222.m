% 222 Simulation 
% by Gabe Soares, Harrison Handley, Thomas Krammer and Richard Arthurs

% right top of board is 0,0, units are standard SI unless otherwise noted. 
clear all;
fSystemInit; % this sets up global variables like ball parameters

zeroData = zeros(1,9); % initial conditions - everything is zero
global springStroke;    % grab the initial displacement of the spring launcher

% Curve Test Matrix:
% t, x position, y position, vx, vy, ax, ay, omega, alpha

% Force Data Matrix:
% t, normal force, spring force, centripetal force, weight

[curveTestOut, curveTestForceOut] = initSpringNew(zeroData, springStroke);  % get initial velocity from spring launch
[curveTestOut, curveTestForceOut] = fFlatRollNew(curveTestOut, curveTestForceOut, 0.05);    % roll horizontally
[curveTestOut, curveTestForceOut] = curve1New(curveTestOut, curveTestForceOut, 0, pi/2, 0.03);  % first curve, right and down
[curveTestOut, curveTestForceOut] = curve2New(curveTestOut, curveTestForceOut, 1.5*pi, 2*pi, 0.03); % first curve, left and down
[curveTestOut, curveTestForceOut] = fFlatRollNew(curveTestOut, curveTestForceOut, 0.05);    % roll horizontally
[curveTestOut, curveTestForceOut] = curve3New(curveTestOut, curveTestForceOut, pi/2, pi, 0.03); % second curve, left and down
[curveTestOut, curveTestForceOut] = verticalDrop2(curveTestOut, curveTestForceOut, 0.05);   % fall vertically
[curveTestOut, curveTestForceOut] = curve4New(curveTestOut, curveTestForceOut, pi, 1.5*pi, 0.07);   % third curve, right and down
 
[curveTestOut, curveTestForceOut] = curve5(curveTestOut, curveTestForceOut, 0, 0.05);
[HammerData, HammerForce, curveTestOut, curveTestForceOut] = fHammerImpact(curveTestOut, curveTestForceOut);    % hit with hammer
[curveTestOut, curveTestForceOut] = After_Hammer(curveTestOut, curveTestForceOut, 1.4, 0.09);   % up curve after impact
[curveTestOut, curveTestForceOut] = fProjectileMotion(curveTestOut, curveTestForceOut); % projectile motion fall through chute
[curveTestOut, curveTestForceOut] = verticalDrop2(curveTestOut, curveTestForceOut, 0.05);   % continue falling through chute
[curveTestOut, curveTestForceOut] = curve6(curveTestOut, curveTestForceOut, 1.5*pi, 2*pi, 0.03);    % small left curve after chute
[curveTestOut, curveTestForceOut] = Slope_to_end(curveTestOut, curveTestForceOut, pi/5, 0.1);   % down teeter-totter ramp
[curveTestOut, curveTestForceOut, teeterData] = Rod_Rotation(curveTestOut, curveTestForceOut, 0.1, 0.1, 0.05, 0.05,0.1,-pi/5, pi/5);    % rotate teeter-totter 
[curveTestOut, curveTestForceOut] = Downhill_Slope_to_End(curveTestOut, curveTestForceOut, pi/5, 0.1);  % roll down teeter-totter

rows = size(curveTestOut, 1);
plot(curveTestOut(1:rows, 2), curveTestOut(1:rows, 3)); % grab a quick graph of position 
