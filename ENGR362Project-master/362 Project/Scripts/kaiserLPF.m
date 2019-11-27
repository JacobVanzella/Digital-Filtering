% Kaiser Windowed Low Pass Filter Impulse Response This function accepts
% parameters: M - filter order, N - number of samples, Fs - sampling
% frequency (Hz), Fc - cuttoff frequency (Hz), alpha - Kaiser window shape
% parameter This function plots and returns the real time impulse response
% of a Kaiser windowed low pass filter.

function kaiserLPF = kaiserLPF(M, N, Fs, Fc, alpha)
    %% Window parameters
    L = 2*M;
    Z = 2*M+1;
    
    %% Truncated low pass filter impulse response
    n = linspace(0,L,Z);
    truncatedLPFImpulse = 2*(Fc/Fs)*sinc(2*Fc/Fs*(n-M));
    
    %% Calculation of Kaiser window
    B = (alpha*sqrt(n.*(2*M-n) ))/M;
    w_KaiserOr = besseli(0,B)./besseli(0,alpha);
    
    %% Application of Kaiser window to low pass filter
    kaiserLPF = (truncatedLPFImpulse.*w_KaiserOr)';
    
    %% Freq response calculation and plotting in dB  
    frequency = linspace(-Fs/2,Fs/2,N)';
    DFT_KaiserLPF = fft(kaiserLPF,N);
    
    %% Plot of time domain Kaiser LPF
    figure;
    subplot(2,1,1)
    plot(n,kaiserLPF,'g')
    xlabel('n')
    ylabel ('Kaiser Window function')
    
    %% Plot of frequency domain Kaiser LPF
    subplot(2,1,2)
    plot(frequency,fftshift(10*log10(abs(DFT_KaiserLPF))),'g');
    xlabel('Frequency')
    ylabel('Response Amplitude (dB)')
    ylim([-inf,0]);
end