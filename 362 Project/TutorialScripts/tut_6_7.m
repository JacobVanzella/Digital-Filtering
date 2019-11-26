clear;
close all;
clc;

L = 1000; % number of samples
n = 0:L-1; t=0:0.01:2;
T = 0.2; % sampling period
f_s = 5; % sampling rate
N = 1024; % DFT point
x_t = 1+0.5*sin(2*pi.*t)+0.25*sin(4*pi.*t);
plot(t,x_t);
x_n = 1+0.5*sin(2*pi.*n*T)+0.25*sin(4*pi.*n*T);

figure;
stem(n,x_n);  %% part 2
xlabel('n');
ylabel('x(nTs)');

%%%%%%%%%%%%%%%%%%%%%%%%
X = fft(x_n,N);  %% part 3
X_omg = abs(X)/N; %% 
l = 0:1:N-1;
%l=-(N-2)/2:1:N/2;
f = f_s/N.*l;
figure;

plot(f,X_omg) % part 4
%plot(f,fftshift(X_omg))
xlabel('f')
ylabel('|X_l(f)|')

%%%%%
figure;
plot(f,X_omg); % part 5
xlim([0 2.5]);
xlabel('f')
ylabel('|X_l(f)|')


