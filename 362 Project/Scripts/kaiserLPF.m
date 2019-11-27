% Kaiser Windowed Low Pass Filter Impulse Response This function accepts
% parameters: M - filter order, N - number of samples, Fs - sampling
% frequency (Hz), Fc - cuttoff frequency (Hz), alpha - Kaiser window shape
% parameter This function plots and returns the real time impulse response
% of a Kaiser windowed low pass filter.

function hKaiserLPF = kaiserLPF(M, N, Fs, Fc, alpha)
    %% 3.1: Window parameters
    L = 2*M;
    Z = 2*M+1;
    n = linspace(0,L,Z)';
    
    %% 3.2: Filter Calculation
    
    % Truncated low pass filter impulse response
    hIdealLPF = 2*(Fc/Fs)*sinc(2*Fc/Fs*(n-M));
    
    % Calculation of Kaiser window
    beta = alpha*sqrt(n.*(2*M-n))/M;
    kaiserWin = besseli(0,beta)./besseli(0,alpha);
    
    % Application of Kaiser window to low pass filter
    hKaiserLPF = hIdealLPF.*kaiserWin;
    
    % Freq response calculation and plotting in dB
    HKaiserLPF = fft(hKaiserLPF,N);
    HZeroKaiserLPF = fftshift(HKaiserLPF);
    frequency = linspace(-Fs/2,Fs/2,N)';
    
    %% 3.3: Kaiser Low-Pass Filter Plots
    
    % Plot of time domain Kaiser LPF
    figure;
    subplot(2,1,1);
    plot(n,hKaiserLPF);
    xlabel('n');
    ylabel ('h(n)');
    title('Kaiser Windowed LPF Time Response');
    
    % Plot of frequency domain Kaiser LPF
    subplot(2,1,2);
    plot(frequency,real(20*log10(HZeroKaiserLPF)));
    xlabel('Frequency');
    ylabel('H(f) (dB)');
    title('Kaiser Windowed LPF Frequency Response');
    ylim([-inf,10]);
end