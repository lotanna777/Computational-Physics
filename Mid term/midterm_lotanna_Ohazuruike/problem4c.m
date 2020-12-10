clc; clear all;


n = 10;
tol = 1e-6;                             % Convergence criterion
I = eye(n,n);                           % Identity matrix                       

A = (1 + I)/(n+1);

%% Loop
k = 0;
logA = 0;
results = [0 0];
tic
while true
   k = k + 1;
   deltalogA = -((I - A)^k)/k;
   logA = logA + deltalogA ;

    if all(abs(deltalogA)< tol)         % Stop
        break
    end
end
t = toc;

%% Print to file
% Save logA matrix result to txt file
save('logA Matrix.txt', 'logA', '-ascii', '-double', '-tabs') 

% Save n,t,k to text file
% results = [results n t k];
% fileID = fopen('problem4c ntk.txt','w');
% fprintf(fileID,'%6s %12s\r\n','n','t','k');
% fprintf(fileID,'%6.2f %12.8f\r\n',results);
% fclose(fileID);
