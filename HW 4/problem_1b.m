
addpath('C:\Users\olota\OneDrive\Documents\Education\Computational Physics\NM4P-master\Matlab');

a = 1;
r = 1;
theta = 0.1*pi;
t = 0;
T = 30;

dt = 0.1;
nstep = T/dt;

params = [];
x = [0,0];
sampleTimes=(1:(nstep+1))*dt;
rk4Results = [];

x(1) = r;
x(2) = theta;
for iter = 1:nstep
    x = rk4(x,t,dt,'deriv_hw4',params);
    rk4Results = [rk4Results x(1) x(2)];
    t = t + dt;
end


figure
hold on
plot(sampleTimes,rk4Results,'k'); 
xlabel('t');
ylabel('theta');


