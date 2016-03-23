% this function uses x and Y coordinates to determine the amount of time a
% ball took to fall down a ramp described by equation f
% https://ca.answers.yahoo.com/question/index?qid=20101229213823AAjuJJS
% It assumes slipping!

r = 0.5;    % radius of track
syms x;
f = r^2 - x^2;  % equation of track

t = int(sqrt((1 + (diff(f))^2)/(f)),x,0, 0.3);

disp(vpa(t))






