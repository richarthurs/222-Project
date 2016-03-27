% this function uses x and Y coordinates to determine the amount of time a
% ball took to fall down a ramp described by equation f
<<<<<<< Updated upstream
% https://ca.answers.yahoo.com/question/index?qid=20101229213823AAjuJJS
% It assumes no slipping!

r = 0.5;    % radius of track
R = 0.01;   % radius of ball
g = 9.81;    % gravity

syms x;
y = r^2 - x^2;  % equation of track

% t = int(sqrt(((10/7)*g*(f))/(1+diff(f)^2)),x,0, 0.3);


t = (sqrt((10/7)*g)) * int(sqrt((1 + diff(y)^2)/(y)),x,0, 0.3);
%                          int(sqrt((1 + diff(f)^2)/(f)),x,0, 0.3);
disp(vpa(t))


=======
% Equation explanation: https://ca.answers.yahoo.com/question/index?qid=20101229213823AAjuJJS
% It assumes no slipping. 

r = 0.07;    % radius of track
g = -9.81;    % gravity
R = 0.01;   % radius of ball
m = 0.03;   % mass of ball

vi = 0;
wi = 0;
I = 0.4 * m * R^2;

syms x;

f = -sqrt(r^2 - x^2);  % equation of track - a circle solved for y = f(x,r). Negative to agree with gravity. 

t = int(sqrt(m*(7/10)*(1 + diff(f)^2)/(m*g*f + 0.5*m*vi^2 + 0.5*I*wi^2)), x, 0, 0.0699);

%Old version:
%t = (1/sqrt((10/7)*g)) * int(sqrt((1 + diff(f)^2)/f), x, 0, 0.0699);    % You can't integrate up to the radius, but you can get close
t = vpa(t);

fprintf('Time to complete section: ');
disp(t);
>>>>>>> Stashed changes




