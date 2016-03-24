% this function uses x and Y coordinates to determine the amount of time a
% ball took to fall down a ramp described by equation f
% https://ca.answers.yahoo.com/question/index?qid=20101229213823AAjuJJS
% It assumes no slipping!

r = 0.5;    % radius of track
R = 0.01;   % radius of ball
g = 9.81;    % gravity

syms x;
f = r^2 - x^2;  % equation of track

% t = int(sqrt(((10/7)*g*(f))/(1+diff(f)^2)),x,0, 0.3);


t = (sqrt((10/7)*g)) * int(sqrt((1 + diff(f)^2)/(f)),x,0, 0.3);
%                          int(sqrt((1 + diff(f)^2)/(f)),x,0, 0.3);
disp(vpa(t))






