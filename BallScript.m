global mass;
global ballRadius;
global position;
global velocity;
global angular;
global I;

mass = 0.03;
ballRadius = 0.01;
I = momentOfInertia();

springStroke = 0.03;
springK = 30;

disp('Initial Velocity')
initSpring(springStroke, springK);

disp(velocity)