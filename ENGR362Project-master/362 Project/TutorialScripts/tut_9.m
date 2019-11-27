%Tutorial 8 Code
clear;
close all;
clc;

%%%% Simulation Parameters
L = 40;    
M = L/2;   
Z = 2*M+1;  
Fs = 8000;
fc = 1000;
n = 0:1:Z-1;
N = 2048;   

h_d_LPF = 2*fc/Fs*sinc(2*fc/Fs*(n-M));

figure;
subplot(3,1,1)
plot(n,h_d_LPF,'r');
xlabel('n')
ylabel('sinc(n)')
title('Impulse Response of Basic Sinc LPF')

H = fft(h_d_LPF,N);
fre = [-(N-2)/2:1:N/2]*8000/N; % Note that I have done this to plot both +ve (0 to fs/2)  side and -ve (-fs/2 to 0) side properly

%figure
subplot(3,1,2)
plot(fre,fftshift(10*log10(abs(H))),'g');
xlabel('Frequency (Hz)')
ylabel('Magnitude response in dB')
title('Frequency Response of Basic Sinc LPF')

%figure
subplot(3,1,3)
plot(fre,angle(H),'r');
xlabel('Frequency(Hz)')
ylabel('Phase')
title('Phase as a function of Frequency for Basic Sinc LPF')

%part 3 and 4
w = 1/2*(1-cos(2*pi*(n)/(Z-1))); % Hann window
figure;
subplot(2,1,1)
plot(n,w,'b');
xlabel('n');
ylabel('w(n)')
title('Impulse Response of Hann Window')


%part 5
h_d_windowed_LPF=h_d_LPF.*w;


%part 6
H = fft(h_d_windowed_LPF,N);
%figure;
subplot(2,1,2)
plot(fre,fftshift(10*log10(abs(H))), 'c');
xlabel('Frequency (Hz)');
title('Frequency Response of Windowed Filter')
ylabel('Magnitude respone in dB')
legend('Hann Window')


%%%%%% filtering your speech signal
load 466-2.mat
%playObj = audioplayer(myRecording,Fs,Nbits,outputdev);
%play(playObj);

x = myRecording;
X_org = fft(x,N);  %% 3
X_mag = abs(X_org)/N; %% 4
l = 0:1:N-1;
f = Fs/N.*l;
fre = linspace(-Fs/2, Fs/2, N);
figure;
subplot(3,1,1)
%plot(f(1:round(N/2)),X_mag(1:round(N/2)))
plot(f(1:round(N/4)),X_mag(1:round(N/4))) % to show only low frequency

xlabel('frequency (f)')
ylabel('|X(f)|')
title('Original Frequency Spectrum of Voice Signal')

x_noisy = x'+0.1*randn(1,length(x));
X_noisy = fft(x_noisy,N);
X_mag_noisy = abs(X_noisy)/N; %% 4

%figure;
subplot(2,1,2)
plot(fre,fftshift(abs(X_noisy)),'b')


A = h_d_windowed_LPF;
y = conv(A,x_noisy);
% y=filter(A,1,x_noisy);

Y_fil=fft(y,N);

hold on;
plot(fre,fftshift(abs(Y_fil)),'r')

xlabel('frequency (f)')
ylabel('|X_{mag-noisy}| and |X_{mag-filtered}|')
legend('Unfiltered','Filtered')
title('Filtered and Unfiltered Voice Signals')

%pause
%playObj1 = audioplayer(x_noisy,Fs,16);
%play(playObj1);


%pause
%playObj = audioplayer(y,Fs,16);
%play(playObj);

disp('done')