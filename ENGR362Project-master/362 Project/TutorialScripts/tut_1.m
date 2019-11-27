clear;
close all;
clc;

n = (-100:1:100)';
yn = 0.8.^abs(n);
zn = 0.6.^abs(n);

%%%%%%%%%%%%%%%%%%%%%%%%%%% problem 2 point 1 and 2
Y = [yn,zn];
stem(n,Y);
xlabel('n'); ylabel('y(n)-red and z(n)-blue') % label axis
title('Stem of 0.8^{|n|} and 0.6^{|n|}'); % title plot
legend('y(n)', 'z(n)');

%%%%%%%%%%%%%%%%%%%%%%%%%% point 3
rn = yn+zn;
figure;
stem(n,rn, 'm', 'filled');
xlabel('n'); ylabel(' r(n)') % label axis
title('Stem of 0.8^{|n|} + 0.6^{|n|}'); % title plot
legend('r(n)');

%%%%%%%%%%%%%%%%%%%%%%%%%% point 4
sn = yn.*zn;
figure;
stem(n,sn, 'g', 'filled');
xlabel('n'); ylabel(' r(n)') % label axis
title('Stem of 0.8^{|n|} * 0.6^{|n|}'); % title plot
legend('s(n)');