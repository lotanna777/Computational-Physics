clc; clear all;

% Read inputs from Excel
t = xlsread('data_1.xlsx','data_1','A1:A100','basic');
x = xlsread('data_1.xlsx','data_1','B1:B100','basic');

% ft specifies the fit type while defining respective coefficients
ft = fittype( 'A*exp(-t/tau1)','dependent',{'x'},'independent',{'t'},...
    'coefficients',{'A','tau1'})     

f = fit( t, x, ft, 'StartPoint', [1, 1] )     % Start point specifies init values

figure (2)
subplot(1,3,1)
plot( f,'k', t, x) 
hold on;

% Read inputs from Excel - data 2
t2 = xlsread('data_2.xlsx','data_2','A1:A100','basic');
x2 = xlsread('data_2.xlsx','data_2','B1:B100','basic');

% ft specifies the fit type while defining respective coefficients
ft2 = fittype( 'A2*exp(-t2/tau12)','dependent',{'x2'},'independent',{'t2'},...
    'coefficients',{'A2','tau12'})     

f2 = fit( t2, x2, ft2, 'StartPoint', [1, 1] )     % Start point specifies init values

subplot(1,3,2)
plot( f2,'k',t2, x2) 
hold on;

% Read inputs from Excel - data 2
t3 = xlsread('data_3.xlsx','data_3','A1:A100','basic');
x3 = xlsread('data_3.xlsx','data_3','B1:B100','basic');

% ft specifies the fit type while defining respective coefficients
ft3 = fittype( 'A3*exp(-t3/tau13)','dependent',{'x3'},'independent',{'t3'},...
    'coefficients',{'A3','tau13'})     

f3 = fit( t3, x3, ft3, 'StartPoint', [1, 1] )     % Start point specifies init values

subplot(1,3,3)
plot( f3,'k',t3, x3) 
hold off;
