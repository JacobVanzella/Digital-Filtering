% Analyze Audio, accepts parameters myRecording - an audio file, Fs - the
% sampling frequency (Hz), N - number of samples.
% This function plots the audio files amplitude, takes the discrete fourier
% transform (DFT), plots the dB scale of the DFT, and the phase plot of the
% DFT, then returns the DFT of the signal.

function DFT = analyzeAudio(myRecording, Fs, N)
    %% Discrete Fourier Transform
    % Creates x-axis for plotting DFT, takes DFT, shifts DFT to be centered
    % on 0, then takes absolute value of the transform.
    frequency = linspace(-Fs/2,Fs/2,N);
    DFT = fft(myRecording);
    DFT_Shift = fftshift(DFT);
    DFT_AbsShift = abs(DFT_Shift);
    
    %% Plot original recording.
    figure
    subplot(3,1,1)
    plot(linspace(0,N-1,N),myRecording)
    xlabel('Number of Samples');
    ylabel('Signal Amplitude')
    
    %% Plot dB scale amplitude of DFT.
    subplot(3,1,2)
    plot(frequency, 10*log10(DFT_AbsShift))
    xlabel('Frequency (Hz)')
    ylabel('Frequency Amplitude (dB)')
    
    %%  Downsamples DFT to simplify phase angle plot.
    downsampledFs = Fs/4;
    downsampledN = 80000 / downsampledFs;
    DFT_Shift = downsample(DFT_Shift, downsampledN);
    frequency = downsample(frequency, downsampledN);
    
    %% Plot downsampled DFT phase angle.
    subplot(3,1,3)
    plot(frequency, angle(DFT_Shift))
    xlabel('Frequency (Hz)')
    ylabel('Phase Angle (radians)')
end