

t = 2;

%% Main loop
for n=1:10                                  % run for different values of n
del_t = 10^-n;
x1 = x_t(t);                                % computes x at current time
x2 = x_t(t + del_t);                        % computes x at next time
xprime = x_t_prime(t);                      % computes exact value of differential x

del_dt = abs(xprime-(x2-x1)/del_t);         % difference between exact and numerical 

del_dt_mat(n) = del_dt;                     % save results to a vector

end

%% Plot results
figure (1)
loglog(del_dt_mat)
set(gca,'FontSize',14,'FontWeight','bold');
title('Difference between exact and numerical solution');
xlabel('n');ylabel('del dt')
saveas(gcf,'question 1_matlab','epsc');

%% Functions
function x = x_t(t)
	x=1/(1+9*exp(-t));
end

function xprime = x_t_prime(t)
	xprime=9*exp(-t)/(1+9*exp(-t))^2;
end

