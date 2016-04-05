% 222 Simulation 
% by Gabe Soares, Harrison Handley, Thomas Krammer and Richard Arthurs

% right top of board is 0,0, units are standard SI unless otherwise noted. 
clear all;
fSystemInit; % this sets up global variables like ball parameters

zeroData = [0,0,0.0145,0,0,0,0,0,0]; % initial conditions - everything is zero
global springStroke;    % grab the initial displacement of the spring launcher

% Curve Test Matrix:
% t, x position, y position, vx, vy, ax, ay, omega, alpha

% Force Data Matrix:
% t, normal force, spring force, centripetal force, weight

[curveTestOut, curveTestForceOut] = initSpringNew(zeroData, springStroke);  % get initial velocity from spring launch
[curveTestOut, curveTestForceOut] = fFlatRollNew(curveTestOut, curveTestForceOut, 0.0935);    % roll horizontally
[curveTestOut, curveTestForceOut] = curve1New(curveTestOut, curveTestForceOut, 0, pi/2, 0.03);  % first curve, right and down
[curveTestOut, curveTestForceOut] = curve2New(curveTestOut, curveTestForceOut, 1.5*pi, 2*pi, 0.03); % first curve, left and down
[curveTestOut, curveTestForceOut] = fFlatRollNew(curveTestOut, curveTestForceOut, 0.057);    % roll horizontally
[curveTestOut, curveTestForceOut] = curve3New(curveTestOut, curveTestForceOut, pi/2, pi, 0.03); % second curve, left and down
[curveTestOut, curveTestForceOut] = verticalDrop2(curveTestOut, curveTestForceOut, 0.046);   % fall vertically
[curveTestOut, curveTestForceOut] = curve4New(curveTestOut, curveTestForceOut, pi, 1.5*pi, 0.04);   % third curve, right and down
 
 [curveTestOut, curveTestForceOut] = curve5(curveTestOut, curveTestForceOut, 0, 0.13);
 [HammerData, HammerForce, curveTestOut, curveTestForceOut] = fHammerImpact(curveTestOut, curveTestForceOut);    % hit with hammer
 [curveTestOut, curveTestForceOut] = After_Hammer(curveTestOut, curveTestForceOut, (77*pi)/180, 0.07);   % up curve after impact
[curveTestOut, curveTestForceOut] = fProjectileMotion(curveTestOut, curveTestForceOut); % projectile motion fall through chute
[curveTestOut, curveTestForceOut] = verticalDrop2(curveTestOut, curveTestForceOut, 0.037);   % continue falling through chute
[curveTestOut, curveTestForceOut] = curve6(curveTestOut, curveTestForceOut, 1.5*pi, 5.89, 0.035);    % small left curve after chute
[curveTestOut, curveTestForceOut] = Slope_to_end(curveTestOut, curveTestForceOut, 0.3927, 0.25);   % down teeter-totter ramp
[curveTestOut, curveTestForceOut, teeterData] = Rod_Rotation(curveTestOut, curveTestForceOut, 0.25, 0.159, 0.091, 0.02,0.08,-0.3927, 0.3927);    % rotate teeter-totter 
[curveTestOut, curveTestForceOut] = Downhill_Slope_to_End(curveTestOut, curveTestForceOut, 0.3927, 0.25);  % roll down teeter-totter

cla;
rows = size(curveTestOut, 1);
plot(curveTestOut(1:rows, 2), curveTestOut(1:rows, 3)); % grab a quick graph of position 
axis([-0.05 0.3 -.35 0.05])
hold on
pause(5);
% plot(curveTestOut(1:rows, 1), curveTestOut(1:rows, 4)); % grab a quick graph of position 
% comet(curveTestOut(:,2),curveTestOut(:,3))
% 
for n = 1:1:rows-1
   plot(curveTestOut(n, 2), curveTestOut(n, 3), 'or'); 
   pause(curveTestOut(n, 1)/100);
end
