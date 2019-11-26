%%ENGR 362 Term Project
%%By Jacob Vanzella (49157654)

%% Initialization of Workspace

clear
close all
clc

% Declaration of variables.
M = 30;     % Filter order
Fc = 5;     % Filter cut-off frequency upper bound
delay = 466;
alpha1 = 0; % Kaiser window shape parameter for filter 1
alpha2 = 7; % Kaiser window shape parameter for filter 2

% Load given data into program.
load('466-2.mat');

%% Analysis and Noise Addition of Signal

% Analyze given audio recording.
DFT_myRecording = analyzeAudio(myRecording, Fs, N);

% Add noise to audio recording.
myNoisyRec = myRecording + randn(N, 1);

% Analyze the noise added signal.
DFT_myNoisyRec = analyzeAudio(myNoisyRec, Fs, N);

%% Filter Calculation

% Calculate Kaiser low pass filters used as noiseFilter arguments.
kaiserLPF1 = kaiserLPF(M,N,Fs,Fc,alpha1);
kaiserLPF2 = kaiserLPF(M,N,Fs,Fc,alpha2);

% Shift Kaiser low pass filters to act as bandpass filter.
kaiserLPF1 = abs(ifft(exp(-j*2*pi*delay)*fftshift(fft(kaiserLPF1,N)))');
kaiserLPF2 = abs(ifft(exp(-j*2*pi*delay)*fftshift(fft(kaiserLPF2,N)))');

% Plot of the overlap of the shifted Kaiser filters.
figure;
hold on;
frequency = linspace(-Fs/2 ,Fs/2,N);
plot(frequency, 10*log10(abs(fftshift(fft(kaiserLPF1,N)))));
plot(frequency, 10*log10(abs(fftshift(fft(kaiserLPF2,N)))));
xlabel('Frequency (Hz)');
ylabel('Frequency Amplitude (dB)');
title('Bandpass Overlap');
hold off;
figure
plot(frequency, kaiserLPF1);

%% Noise Filtration and Filtered Signal Analysis

% Clean noise added signal using Kaiser low pass filter.
myCleanRec = noiseFilter(DFT_myNoisyRec, kaiserLPF1, kaiserLPF2);

% Analyze the cleaned signal.
analyzeAudio(myCleanRec, Fs, N);