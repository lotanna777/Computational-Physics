clc; clear all;close all;

% Initialization
r1 = [0.01,0];
r2 = [0,1];
r3 = [0,-1];
v1 = [0,0];
v2 = [1,0];
v3 = [-1,0];

ti = 0;
tf = 50;
dt = 0.001;
c = dt^2/2;
energy = [0 0 0 0];
r1_t = [0 0];
r2_t = [0 0];
r3_t = [0 0];
v1_t = [0 0];
v2_t = [0 0];
v3_t = [0 0];

% Verlet start up r(-1) = r(0) -dt*v(0) + (dt^2/2) * a(r0)
r1_0 = r1 - dt.*v1 + c.*((r2-r1)./(norm(r2-r1)^3) + (r3-r1)./(norm(r3-r1)^3));
r2_0 = r2 - dt.*v2 + c.*((r1-r2)./(norm(r1-r2)^3) + (r3-r2)./(norm(r3-r2)^3));
r3_0 = r3 - dt.*v3 + c.*((r1-r3)./(norm(r1-r3)^3) + (r2-r3)./(norm(r2-r3)^3));

for i = ti:dt:tf
% Position Verlet r(n+1) = 2r(n) -r(n-1) + dt^2*a(n)
r1p1 = 2.*r1 - r1_0 + 2*c.*((r2-r1)./(norm(r2-r1)^3) + (r3-r1)./(norm(r3-r1)^3));
r2p1 = 2.*r2 - r2_0 + 2*c.*((r1-r2)./(norm(r1-r2)^3) + (r3-r2)./(norm(r3-r2)^3));
r3p1 = 2.*r3 - r3_0 + 2*c.*((r1-r3)./(norm(r1-r3)^3) + (r2-r3)./(norm(r2-r3)^3));

% Velocity Verlet v(n) = (r(n+1) - r(n-1))/2*dt
v1p1 = (r1p1 - r1)/(2*dt);
v2p1 = (r2p1 - r2)/(2*dt);
v3p1 = (r3p1 - r3)/(2*dt);

% Potential energy, GM=1
PE = -(1/norm(r1p1-r2p1) + 1/norm(r1p1-r3p1) + 1/norm(r2p1-r3p1));

% Kinetic energy 0.5Mv^2, M=1
KE = 0.5*(norm(v1p1)^2 + norm(v2p1)^2 + norm(v3p1)^2);

% Total energy , dim-less
TE = PE + KE;

% reset r and v
r1_0 = r1;
r2_0 = r2;
r3_0 = r3;
r1 = r1p1;
r2 = r2p1;
r3 = r3p1;
v1 = v1p1;
v2 = v2p1;
v3 = v3p1;

% save
r1_t = [r1_t; r1p1];
r2_t = [r2_t; r2p1];
r3_t = [r3_t; r3p1];

v1_t = [v1_t; v1p1];
v2_t = [v2_t; v2p1];
v3_t = [v3_t; v3p1];

energy = [energy; [i KE PE TE]];
end

figure(1)
plot(energy(:,1),energy(:,2))
hold on
plot(energy(:,1),energy(:,3))
hold on
plot(energy(:,1),energy(:,4))
title('KE, PE, TE')
xlabel('Time') 
ylabel('Energy') 
legend('KE','PE','TE') 
hold off

figure(2)
plot(r1_t(2:end,1),r1_t(2:end,2))
hold on
plot(r2_t(2:end,1),r2_t(2:end,2))
hold on
plot(r3_t(2:end,1),r3_t(2:end,2))
title('Trajectory')
xlabel('Time') 
legend('r1','r2','r3') 
hold off