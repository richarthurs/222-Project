% this function uses x and Y coordinates to determine the amount of time a
% ball took to fall down a ramp described by equation f
% https://ca.answers.yahoo.com/question/index?qid=20101229213823AAjuJJS
% It assumes slipping!

r = 0.07;    % radius of track
g = -9.8;
syms x;
y = -sqrt(r^2 - x^2);  % equation of track from r^2 = x^2 + y^2, solved for y

%t = (1/sqrt(2*g))* int(sqrt((1 + (diff(f))^2)/(f)),x,0, 0.0699);
t = (1/sqrt(2*g))* int(sqrt((1 + (diff(y))^2)/(y)),x,0, 0.0699);

disp(vpa(t))






