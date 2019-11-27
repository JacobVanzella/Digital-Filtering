% Noise filter accepts the the discrete fourier transform (DFT) of a
% signal and two filters. These filters are applied to the DFT, and the
% inverse DFT is returned.
function cleanRec = noiseFilter(signal, filter1, filter2)
    cleanRec = filtfilt(filter1,1,signal);
    cleanRec = filtfilt(filter2,1,cleanRec);
end