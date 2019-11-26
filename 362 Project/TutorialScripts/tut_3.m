clear;
close all;
clc;

%%%%%%%%%%%%%% P1
A = 1;
fsin = 100;
t = -0.01:0.0001:0.01;
theta = pi/2;
x_t = A*sin(2*pi*fsin.*t+theta);
plot(t,x_t)
xlabel('t')
ylabel('x(t)')
title('Continous Signal X(t)')

%%%%%%%%%%%%%%% P2
n1 = -8:8;
x_n1 = A*sin(2*pi*1/8.*n1+theta);
figure
stem(n1,x_n1)
xlabel('n')
ylabel('x1(n)')
title('Sampled Version of Signal X(t) with F_s=8f_{sin}')

%%%%%%%%%%%%%%%
n2=-16:16;
x_n2 = A*sin(2*pi*1/16.*n2+theta);
figure
stem(n2,x_n2)
xlim([-16 16])
xlabel('n')
ylabel('x2(n)')
title('Sampled Version of Signal X(t) with F_s=16f_{sin}')

