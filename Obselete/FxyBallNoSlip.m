function [ t ] = FxyBallNoSlip( vi, wi, Xin, r)
%FXYBALLNOSLIP Summary of this function goes here
%   Detailed explanation goes here


% this function uses x and Y coordinates to determine the amount of time a
% ball took to fall down a ramp described by equation f
% Equation explanation: https://ca.answers.yahoo.com/question/index?qid=20101229213823AAjuJJS
% It assumes no slipping. 


global g;    % gravity
global R;   % radius of ball
global m;   % mass of ball
global I;

% These variables are typically presented as arguments to the function. 
% r = 0.07;    % radius of track
% vi = 0;   % Initial Velocity
% wi = 0;   % Initial angular velocity

syms x;

f = -sqrt(r^2 - x^2);  % equation of track - a circle solved for y = f(x,r). Negative to agree with gravity. 

t = int(sqrt(m*(7/10)*(1 + diff(f)^2)/(m*g*f + 0.5*m*vi^2 + 0.5*I*wi^2)), x, 0, Xin);

%Old version:
%t = (1/sqrt((10/7)*g)) * int(sqrt((1 + diff(f)^2)/f), x, 0, 0.0699);    % You can't integrate up to the radius, but you can get close
t = vpa(t);

%fprintf('Time to complete section: ');
%disp(t);

end

