
%%  PARAMETERS

max_iterations=50;  % max number of iterations
numprint=50;        % how many numbers to print to the screen
r1=2.0;             % our choice of r
r2 = 2.99;
% INITIALIZATION
x1=0.01;            %our initial value
x2=0.01;
results = zeros(50,3);
%% ITERATIONS
for iter=1:max_iterations
    x1=logistic_calculate(r1,x1);
    x2=logistic_calculate(r2,x2);
    results(iter,1) = iter;
    results(iter,2) = x1;
    results(iter,3) = x2;
end  %end of iteration loop


%% Plotting
figure(1)
plot(results(:,1),results(:,2),'-o','MarkerSize',3,'color','red');
hold on
plot(results(:,1),results(:,3),'-+','MarkerSize',3,'color','blue');

title('question 5'); legend('r = 2','r = 2.99');
ax=gca; ax.FontSize=12;
xlabel('niter'); ylabel('x');

saveas(gcf,'logistic map Q5','epsc');
hold off

%% Functions
function x=logistic_calculate(r,x)
	x=r*x*(1-x);
end
