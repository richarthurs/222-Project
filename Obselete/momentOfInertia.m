function [moment] = momentOfInertia( input_args )
%MOMENTOFINERTIA Summary of this function goes here
%   This function calculates the moment of inertia of the ball
global mass;
global ballRadius;

moment = (2/5)*mass*ballRadius^2;

end

