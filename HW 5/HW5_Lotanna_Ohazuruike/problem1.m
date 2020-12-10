clc;clear all;

%% 1st Region - about 9
x1 = 8;                                         % Choose ome bound
x2 = 10;                                        % Choose 2nd bound

tol = 10^-6;                                    % Tolerance
max_iter = 1000;                                % Max no of ietrations

syms x                                          % Symbolic function
f(x) = exp(x) - x^4;
sympref('FloatingPointOutput',true)             % Set results of sym to fp

% Determine which bound value is top (xup) and which is bottom (xlow)
if f(x1)>0 
    xup = x1; 
else
    xlow = x1;  
end

if f(x2)>0 
    xup = x2; 
else
    xlow = x2;  
end

x_init = 10;
x_fin = 7;
niter=0;
while abs(x_init-x_fin)>tol
   x_init = x_fin;

   x_fin = 0.5*(xup + xlow);                        % Bisect bound values

   if f(xup) * f(x_fin) >0
       xup = x_fin;
   else
       xlow = x_fin;
   end
   niter = niter + 1;                               % Counter
      
   if niter>max_iter                                % Convergence check
       disp("Failed to converge for 1st region. Change range");
       break
   end
end
disp("1st root is = ");x_fin                        % Display results

Roots = x_fin;                                      % Append to roots vector
%% Second region about 1
x2 = 0;

tol = 10^-6;

syms x
f(x) = exp(x) - x^4;
sympref('FloatingPointOutput',true);

if f(x1)>0 
    xup = x1; 
else
    xlow = x1;  
end

if f(x2)>0 
    xup = x2; 
else
    xlow = x2;  
end

x_init = 10;
x_fin = 7;
niter=0;
while abs(x_init-x_fin)>tol
   x_init = x_fin;

   x_fin = 0.5*(xup + xlow);

   if f(xup) * f(x_fin) >0
       xup = x_fin;
   else
       xlow = x_fin;
   end
   niter = niter + 1;
      
   if niter>max_iter
       disp("Failed to converge for 2nd region. Change range");
       break
   end
end
disp("2nd root is = ");x_fin
Roots =[Roots x_fin];

%% Third Region - about -1
x1 = -3;
x2 = 0;

tol = 10^-6;

syms x
f(x) = exp(x) - x^4;
sympref('FloatingPointOutput',true);

if f(x1)>0 
    xup = x1; 
else
    xlow = x1;  
end

if f(x2)>0 
    xup = x2; 
else
    xlow = x2;  
end

x_init = 10;
x_fin = 7;
niter=0;
while abs(x_init-x_fin)>tol
   x_init = x_fin;

   x_fin = 0.5*(xup + xlow);

   if f(xup) * f(x_fin) >0
       xup = x_fin;
   else
       xlow = x_fin;
   end
   niter = niter + 1;
   
   if niter>max_iter
       disp("Failed to converge for 3rd region. Change range");
       break
   end
end
disp("3rd root is = ");x_fin

Roots = [Roots x_fin]



