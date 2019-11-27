%%ENGR 362 Term Project
%%By Jacob Vanzella (49157654)

%% Initialization of Workspace

clear; close all; clc;

% Load given data into program.
load('466-2.mat');

% Declaration of variables.
M   = 30;   % Filter order
Fc  = 1;    % Filter cut-off frequency upper bound
n   = linspace(0,2*M,2*M+1)';    % Time domain of low pass filter
delay   = 466;  % Frequency delay for low pass filter in Hz
alpha1  = 1;    % Kaiser window shape parameter for filter 1
alpha2  = 7;    % Kaiser window shape parameter for filter 2

%% Analysis and Noise Addition of Signal

% Analyze given audio recording.
DFT_myRecording = analyzeAudio(myRecording, Fs, N);

% Add noise to audio recording.
myNoisyRec = myRecording + randn(N, 1);

% Analyze the noise added signal.
DFT_myNoisyRec = analyzeAudio(myNoisyRec, Fs, N);

%% Filter Calculation

% Calculate Kaiser low pass filters used as noiseFilter arguments.
kaiserLPF1 = ifft(fft(kaiserLPF(M,N,Fs,Fc,alpha1)));
kaiserLPF2 = kaiserLPF(M,N,Fs,Fc,alpha2);

% Shift Kaiser low pass filters to act as bandpass filter.
kaiserLPF1 = abs(kaiserLPF1.*exp(j*2*pi*delay*n));
kaiserLPF2 = abs(kaiserLPF2.*exp(j*2*pi*delay*n));
figure
subplot(2,1,1)
plot(1:length(kaiserLPF2),kaiserLPF2)
subplot(2,1,2)
plot(linspace(-Fs/2,Fs/2,N),10*log10(abs(fft(kaiserLPF2,N))));
ylim([-inf,0]);
title('debugging')

% % % Plot of the overlap of the shifted Kaiser filters.
% % frequency = linspace(-Fs/2 ,Fs/2,N)';
% % figure;
% % hold on;
% % plot(frequency, 10*log10(abs(fftshift(fft(kaiserLPF1,N)))));
% % plot(frequency, 10*log10(abs(fftshift(fft(kaiserLPF2,N)))));
% % xlabel('Frequency (Hz)');
% % ylabel('Frequency Amplitude (dB)');
% % title('Bandpass Overlap');
% % hold off;

%% Noise Filtration and Filtered Signal Analysis

% Clean noise added signal using Kaiser low pass filter.
%myCleanRec = noiseFilter(myNoisyRec, kaiserLPF1, kaiserLPF2);

% Analyze the cleaned signal.
%analyzeAudio(myCleanRec, Fs, N);