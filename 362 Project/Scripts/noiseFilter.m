% Noise filter accepts the the discrete fourier transform (DFT) of a
% signal and two filters. These filters are applied to the DFT, and the
% inverse DFT is returned.
function cleanRec = noiseFilter(DFT, filter1, filter2)
    DFT = DFT .* fftshift(filter1);
    DFT = DFT .* fftshift(filter2);
    cleanRec = abs(ifft(DFT));
end