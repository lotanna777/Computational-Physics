clc; clear all;

syms x y                                        % Symbolic function
f(x,y) = (x^2)*exp(-x^2) + y^2 -1;
g(x,y) = (x^4)/(1+ (x^2) * y^2) -1;
fxprime(x,y) = diff(f,x);                       % diff f wrt x
fyprime(x,y) = diff(f,y);                       % diff f wrt y
gxprime(x,y) = diff(g,x);
gyprime(x,y) = diff(g,y);
sympref('FloatingPointOutput',true)             % Set results of sym to fp

tol = 10^-12;                                    % Tolerance
max_iter = 100;                                % Max no of ietrations

xi = 1;
yi = 1;

dx = 2;dy = 2;
niter=0;
while abs(f(xi,yi)^2) > tol &&   abs(g(xi,yi)^2) > tol
    xvec = [xi; yi] ;                           
    fxvec = [double(f(xi,yi)); double(g(xi,yi))] ;
    dmat = [double(fxprime(xi,yi)) double(gxprime(xi,yi));
            double(fyprime(xi,yi)) double(gyprime(xi,yi))]; % Jacobian matrix
   
   niter = niter + 1;                           % Counter
      
   if niter>max_iter                            % Convergence check
       disp("Convergence not achieved");
       break
   end
   xvec = xvec - dmat\fxvec;
   xi = xvec(1,1);
   yi = xvec(2,1);
   

end
disp("Solution is x = ");double(xi)                        % Display results
disp("and y = "); double(yi)

% Final result
% x = 1.1740, y = 0.8079