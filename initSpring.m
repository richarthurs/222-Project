function v = initSpring(x,k)
%declare the global variables that are needed throughout 
global mass;
global velocity;

syms v
v = vpasolve(v == (k^(1/2)*x)/mass^(1/2),v);
velocity = [v, 0];
end