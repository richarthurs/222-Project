function v = initSpring(x,k)
%declare the global variables that are needed throughout 
global mass;
global velocity;

syms v
v = vpasolve(v == ((5k^(1/2))*x)/(7*mass^(1/2)),v);
velocity = [v, 0];
end
