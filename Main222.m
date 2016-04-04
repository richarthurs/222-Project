%222 Simulation by Gabe Soares, Harrison Handley, Thomas Krammer and
%Richard Arthurs

% right top of board is 0,0, units are standard SI unless otherwise noted. 
clear all;
fSystemInit; % this sets up global variables like

data = zeros(1,9); % initial conditions - everything is zero
global springStroke;    % grab the initial displacement of the spring launcher

[curveTestOut, curveTestForceOut] = initSpringNew(data, springStroke);
[curveTestOut, curveTestForceOut] = fFlatRollNew(curveTestOut, curveTestForceOut, 0.05);
[curveTestOut, curveTestForceOut] = curve1New(curveTestOut, curveTestForceOut, 0, pi/2, 0.03);
[curveTestOut, curveTestForceOut] = curve2New(curveTestOut, curveTestForceOut, 1.5*pi, 2*pi, 0.03);
[curveTestOut, curveTestForceOut] = fFlatRollNew(curveTestOut, curveTestForceOut, 0.05);
[curveTestOut, curveTestForceOut] = curve3New(curveTestOut, curveTestForceOut, pi/2, pi, 0.03);
[curveTestOut, curveTestForceOut] = verticalDrop2(curveTestOut, curveTestForceOut, 0.05);
[curveTestOut, curveTestForceOut] = curve4New(curveTestOut, curveTestForceOut, pi, 1.5*pi, 0.07);
 
[curveTestOut, curveTestForceOut] = curve5(curveTestOut, curveTestForceOut, 0, 0.05);
[HammerData, HammerForce, curveTestOut, curveTestForceOut] = fHammerImpact(curveTestOut, curveTestForceOut);
[curveTestOut, curveTestForceOut] = After_Hammer(curveTestOut, curveTestForceOut, 1.4, 0.09);
[curveTestOut, curveTestForceOut] = fProjectileMotion(curveTestOut, curveTestForceOut);
[curveTestOut, curveTestForceOut] = verticalDrop2(curveTestOut, curveTestForceOut, 0.05);
[curveTestOut, curveTestForceOut] = curve6(curveTestOut, curveTestForceOut, 1.5*pi, 2*pi, 0.03);
[curveTestOut, curveTestForceOut] = Slope_to_end(curveTestOut, curveTestForceOut, pi/5, 0.1);
[curveTestOut, curveTestForceOut, teeterData] = Rod_Rotation(curveTestOut, curveTestForceOut, 0.1, 0.1, 0.05, 0.05,0.1,-pi/5, pi/5); 
[curveTestOut, curveTestForceOut] = Downhill_Slope_to_End(curveTestOut, curveTestForceOut, pi/5, 0.1);

rows = size(curveTestOut, 1);
plot(curveTestOut(1:rows, 2), curveTestOut(1:rows, 3));
