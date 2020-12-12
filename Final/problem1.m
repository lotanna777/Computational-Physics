% dftcs - Program to solve the diffusion equation 
% using the Forward Time Centered Space (FTCS) scheme.
clear; help dftcs;  % Clear memory and print header

%* Initialize parameters (time step, grid spacing, etc.).
tau = input('Enter time step: ');
N = input('Enter the number of grid points: ');
L = 1.;  % The system extends from x=-L/2 to x=L/2
h = L/(N-1);  % Grid size
kappa = 1.;   % Diffusion coefficient
f = 1;          % U = fx
eta = 1;        %
coeff = kappa*tau/h^2;
coeff1 = 1 + f*h/(2*eta*kappa);
coeff2 = 1 - f*h/(2*eta*kappa);

if( coeff < 0.5 )
  disp('Solution is expected to be stable');
else
  disp('WARNING: Solution is expected to be unstable');
end

%* Set initial and boundary conditions.
nn = zeros(N,1);          % Initialize particle prob density to zero at all points
nn(round(N/2)) = 1/h;     % Initial cond. is delta function in center
%% The boundary conditions are d(nn(1))/dt = d(nn(N))/dt = 0 (reflecting)

%* Set up loop and plot variables.
xplot = (0:N-1)*h - L/2;   % Record the x scale for plots
iplot = 1;                 % Counter used to count plots
nstep = 10000;               % Maximum number of iterations
npts = 100;               % Number of snapshots (plots) to take
plot_step = nstep/npts;  % Number of time steps between plots

%* Loop over the desired number of time steps.
for istep=1:nstep  %% MAIN LOOP %%

  %* Compute new part. prob. density using FTCS scheme.
  nn(2:(N-1)) = nn(2:(N-1)) + coeff*(coeff2*nn(3:N) + coeff1*nn(1:(N-2)) - 2*nn(2:(N-1)));
  
  % Apply BCs
nn(1) = nn(1) + coeff*(-2*nn(1) + 2*nn(2));
nn(N) = nn(N) + coeff*(-2*nn(N) + 2*nn(N-1));

  %* Periodically record particle prob density for plotting.
  if( rem(istep,plot_step) < 1 )   % Every plot_step steps
    nnplot(:,iplot) = nn(:);       % record nn(i) for plotting.
    nplot(iplot) = istep*tau;      % Record time for plots
    iplot = iplot+1;
  end
end

% Analytical solution for comparison
nsteady = (kappa*eta/f)*exp((f/(kappa*eta))*xplot);

%* Plot particle probability density versus x and t as wire-mesh and contour plots.
figure(1); clf;
mesh(nplot,xplot,nnplot);  % Wire-mesh surface plot
xlabel('Time');  ylabel('x');  zlabel('n(x,t)');
title('Diffusion of a delta spike');

figure (2);clf;
plot(xplot,nnplot(:,end));  % plot last iteration 
hold on

plot(xplot,nsteady);        % add steady state soluion to plot
xlabel('x');  ylabel('n');  
title('Comparison of analytical and numerical solutions');
hold off
legend('numerical','analytical')

figure(3); clf;       
contourLevels = 0:0.5:10;  contourLabels = 0:5;     
cs = contour(nplot,xplot,nnplot,contourLevels);  % Contour plot
clabel(cs,contourLabels);  % Add labels to selected contour levels
xlabel('Time'); ylabel('x');
title('Particle probability density contour plot');
