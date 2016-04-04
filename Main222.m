% Once functions for individual features are implemented, run them here. 
% right top of board is 0,0. 
%clear all;

fSystemInit; % this sets up globals

global g;   % Gravity
global R;   % Radius of Ball
global m;   % Mass of Ball
global I;   % Moment of inertia of ball
global steps;
global k;   % Spring constant of the ball
global impact_time; % Impact time between the spring and the ball
global s; % Distance compressed by the spring
global t_inc; % Time increment

%global trackData;
%global forceData;


% Master matrix of all the data needed
data = zeros(1,10); % time, pos_x, pos_y, v_x, v_y, omega, a_gx, a_gy, alpha, normal force

% UNCOMMENT STARTING HERE TO GET A FULL SIMULATION
springStroke = 0.02;
[curveTestOut, curveTestForceOut] = initSpringNew(data, springStroke);
[curveTestOut, curveTestForceOut] = fFlatRollNew(curveTestOut, curveTestForceOut, 0.05);
[curveTestOut, curveTestForceOut] = curve1New(curveTestOut, curveTestForceOut, 0, pi/2, 0.03);
[curveTestOut, curveTestForceOut] = curve2New(curveTestOut, curveTestForceOut, 1.5*pi, 2*pi, 0.03);
 [curveTestOut, curveTestForceOut] = fFlatRollNew(curveTestOut, curveTestForceOut, 0.05);
 [curveTestOut, curveTestForceOut] = curve3New(curveTestOut, curveTestForceOut, pi/2, pi, 0.03);
 [curveTestOut, curveTestForceOut] = verticalDrop2(curveTestOut, curveTestForceOut, 0.05);
 [curveTestOut, curveTestForceOut] = curve4New(curveTestOut, curveTestForceOut, pi, 1.5*pi, 0.07);
% 
% springStroke = 0.02;
% [sforceData, springData] = initSpring(data, springStroke); % Will update the data matrix with the initial velocity and angular velocity after it is launched from the spring
% trackData = [trackData; springData];
% forceData = [forceData; sforceData];
% clear springData;
% clear sforceData;
% 
% [flatData, flatForceData1] = fFlatRoll(0.05);
% trackData = [trackData; flatData];
% forceData = [forceData; flatForceData1];
% clear flatData;
% clear flatForceData;
% 
% % first part of first curve
% [curve1Data, curve1Force] = curve1(0.03, 0, pi/2);
% trackData = [trackData; curve1Data];
% forceData = [forceData; curve1Force];
% clear curve1Data;
% clear curve1Force;
% 
% % second part of first curve
% [curve2Data, curve2Force] = curve2(0.03, 1.5*pi, 2*pi);
% trackData = [trackData; curve2Data];
% forceData = [forceData; curve2Force];
% clear curve2Data;
% clear curve2Force;
% 
% % roll back underneath
% [flatData1, flatForceData1] = fFlatRoll(0.05);
% trackData = [trackData; flatData1];
% forceData = [forceData; flatForceData1];
% clear flatData;
% clear flatForceData;
% 
% [curve3Data, curve3Force] = curve3(0.03, pi/2, pi);
% trackData = [trackData; curve3Data];
% forceData = [forceData; curve3Force];
% clear curve3Data;
% clear curve3Force;
% 
% [dropData, dropForceData] = verticalDrop(0.05);
% trackData = [trackData; dropData];
% forceData = [forceData; dropForceData];
% clear dropData;
% clear dropForceData;
% 
% 
%  [curve4Data, curve4Force] = curve4(0.07, pi, 1.5*pi);
%  trackData = [trackData; curve4Data];
%  forceData = [forceData; curve4Force];
%  clear curve4Data;
%  clear curve4Force;
 
 [curveTestOut, curveTestForceOut] = curve5(curveTestOut, curveTestForceOut, 0, 0.05);
 [HammerData, HammerForce, curveTestOut, curveTestForceOut] = fHammerImpact(curveTestOut, curveTestForceOut);
 [curveTestOut, curveTestForceOut] = After_Hammer(curveTestOut, curveTestForceOut, 1.4, 0.09);
 [curveTestOut, curveTestForceOut] = fProjectileMotion(curveTestOut, curveTestForceOut);
 [curveTestOut, curveTestForceOut] = verticalDrop2(curveTestOut, curveTestForceOut, 0.05);
 [curveTestOut, curveTestForceOut] = curve6(curveTestOut, curveTestForceOut, 1.5*pi, 2*pi, 0.03);
 [curveTestOut, curveTestForceOut] = Slope_to_end(curveTestOut, curveTestForceOut, pi/5, 0.1);
 [curveTestOut, curveTestForceOut, teeterData] = Rod_Rotation(curveTestOut, curveTestForceOut, 0.1, 0.1, 0.05, 0.05,0.1,-pi/5, pi/5); 
 [curveTestOut, curveTestForceOut] = Downhill_Slope_to_End(curveTestOut, curveTestForceOut, pi/5, 0.1);

