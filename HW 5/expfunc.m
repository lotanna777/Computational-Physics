
function x = expfunc(t,A,B,tau1,tau2)

x = zeros(size(t));

for i = 1:length(t)
    x(i) = A*exp(-t/tau1) + B*exp(-t/tau2);
end

end
