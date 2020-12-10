clc; clear all;close all;


n = [10 20 50 100 200 500 1000 2000];
% tol = 1e-3;                             % Convergence criterion                    
kmax = 100;
%% Loop
results = [0 0];

for i = 1: length(n)
I = eye(n(i),n(i));                     % Identity matrix   
A = (1 + I)/(n(i)+1);                   % Create matrix A
logA = zeros(n(i),n(i));

tic                                     % Start counter
for k = 1:kmax
    % Limit to 100 runs because higher n values took too long
%    k = k + 1;                           % iter counter
   deltalogA = -((I - A)^k)/k;
   
%    if all(abs(deltalogA)> tol)         % Stop/convergence
   logA = logA + deltalogA ;
%    end
end
t = toc;                                % Save runtime to t

%% Print to file
% Save logA matrix result to txt file
% save('logA Matrix.txt', 'logA', '-ascii', '-double', '-tabs') 
results = [results; [n(i) t]];              % Append n,t,k to results matrix
n(i)
end

cplx = 0.5*k*(k+1).*results(:,1).^2 + 0.5*k*(k-1).*results(:,1).^3;   % Complexity - no of ops

% Plot of n vs t
loglog(results(:,1),results(:,2));
% title('Time vs n')
xlabel('n') 
hold on
% Plot of complexity vs n
loglog(results(:,1),cplx);
% title('No of operations vs n')
xlabel('n') 
legend('Time','Complexity')
hold off

% Save n,t,k to text file

fileID = fopen('problem4d ntk.txt','w');
fprintf(fileID,'%6s %12s\r\n','n','t');
fprintf(fileID,'%6.2f %12.8f\r\n',results);
fclose(fileID);
