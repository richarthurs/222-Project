% this function uses x and Y coordinates to determine the amount of time a
% ball took to fall down a ramp described by equation f
% https://ca.answers.yahoo.com/question/index?qid=20101229213823AAjuJJS
% It assumes no slipping!

r = 0.07;    % radius of track
R = 0.01;   % radius of ball
g = -9.81;    % gravity
m = 0.03;   % mass of ball
I = (2/5)*m*R^2;
wo = 0;

syms theta;

%t = (1/sqrt((10/7)*g)) * int(sqrt((1 + diff(f)^2)/(f)),x,0, 0.068);
wf = sqrt((0.5*I+0.5*m*R^2)/(m*g*r*sin(theta)));
t = int(wf,theta,pi,1.5*pi);

disp(vpa(t))






