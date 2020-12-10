clear all
clf;
a = 0;
g = 0;
rng(1,'twister')

rand_number = zeros(100000,1);
for i=1:10
    a = a+1/i;
end

b = 1/a;
for i = 1:10
    c(i,1) = b*1/i*100000;
end

div = .1;
% n = 100000;
fe = 0.5*rand(1,floor(c(1,1)))+1;
rand_number(1:floor(c(1,1)),1) = fe;
for i= 2:9
    fe = rand(1,floor(c(i,1)))+i-0.5;
de = tabulate(fe);
g = g + floor(c(i-1,1));
rand_number((g+1):g+floor(c(i,1)),1) = fe;
end

fe = 0.5*rand(1,floor(c(10,1)))+9;
de = tabulate(fe);
g = g + floor(c(9,1));
rand_number((g+1):g+floor(c(10,1)),1) = fe;

for i = 1:100000
    x(i,1) = i;
end
figure(1)
scatter(x,rand_number(:,1))

figure(2)
plot(c)