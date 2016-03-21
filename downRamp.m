function vout = downRamp(h)
%declare the global variables that are needed throughout 
global mass;
global ballRadius;
global position;
global velocity;
global angular;
global I;

% use the vf array to contain velocity
syms vout;
syms omegaOut;

vout = vpasolve(mass*0.5*vout^2 == (.5 * mass * velocity(1)^2 + mass*9.81*h), vout);


%Y = vpasolve(mass*0.5*vout^2 + .5*I*omegaOut^2 == (.5 * mass * velocity(1)^2 + mass*9.81*h + .5*I*angular^2), vout, omegaOut);

%http://www.mathworks.com/help/symbolic/solve.html

disp(vout);
end