clc; clear all;

%% Part a
% Read inputs as csv
x = (csvread('data.csv'))';        % Signal
t = (1:size(x))';                  % Time vector

% Fourier transformation
ftx = fft(x);                               % Compute DFT of x
mag = abs(ftx);                               % Magnitude
ph = unwrap(angle(ftx));                     % Phase

freq = (0:length(ftx)-1)*100/length(ftx);        % Frequency vector

% Power spectrum
figure(1)

subplot(3,2,1)
plot(t,x)
title('Signal')
xlabel('Time') 
ylabel('Signal') 

subplot(3,2,3)
plot(freq,mag)
title('Magnitude')
xlabel('Frequency') 
ylabel('Magnitude') 

subplot(3,2,5)
plot(freq,ph*180/pi)
title('Phase')
xlabel('Frequency') 
ylabel('Phase') 

%% Part b - new signal
y = zeros(1,length(ftx));

for i = 1:length(t)-1
   y(i) = (x(i) + x(i+1))/2;      % 2-point moving average
end
y(end) = y(1);                  % Periodic bc

% Fourier transformation
fty = fft(y);                               % Compute DFT of x
mag_y = abs(fty);                               % Magnitude
ph_y = unwrap(angle(fty));                     % Phase

freq_y = (0:length(fty)-1)*100/length(fty);        % Frequency vector

% Power spectrum
subplot(3,2,2)
plot(t,y)
title('Post-averaging Signal')
xlabel('Time') 
ylabel('Signal')

subplot(3,2,4)
plot(freq_y,mag_y)
title('Post-averaging Magnitude')
xlabel('Frequency') 
ylabel('Magnitude') 

subplot(3,2,6)
plot(freq_y,ph_y*180/pi)
title('Post-averaging Phase')
xlabel('Frequency') 
ylabel('Phase') 