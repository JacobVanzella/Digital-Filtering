# Project Title

Variable Bandpass Filter

In this project a tuning fork recording will have noise added to it,
and the noise should subsequently be cleaned through digitial
filtering. The main undertaking in this project is the filter design
process. The filter design consideration will be justified here
briefly, and the implementation can be seen below, and in the
accompanying functions.

By taking the Fourier transform of the tuning fork recording it can be
seen that the maximum frequency component Fm = 466 Hz, see the plot
generated by the analyzeAudio function call in 1.1. This 466 Hz
frequency is identical to the tuning for label. Knowing the frequency
that needs to be isolated, the design process can begin.

## Design Principles

The general steps of filter design are:
1.  Choosing a windowing function. In the project, a Kaiser window was
    chosen as it provides an effective way of tailoring the response of
    the filter by adjusting the alpha parameter and the low pass
    cut-off frequency.
2.  Chosing the filter parameter M, such that the transition band is
    less than or equal to the stop frequency minus the pass frequency
    (dF <= Fstop - Fpass).
3.  Choose a cut-off frequency Fc for the truncated impulse response
    such that Fc = (Fstop + Fpass)/2.
4.  Plot the frequecy magnitude to see resulting filter satisfies the
    desired criteria.
5.  Adjust Fc and M to meet desired response. M should be minimized as
    computationally heavy to have large values of M.

We are choosing a Kaiser window for easy filter tuning. The Kaiser
window is calculated in 1.2 through a function call to kaiserLPF. The
intent here is to use two Kaiser bandpass filters of different alpha
parameters to first maximize stopband attenuation, and then use a
narrow transition to clean up the signal. Then we will choose alpha1 =
7 for a large attenuation, and then alpha2 = 0, for a sharp transition.

For the filter parameter M should allow for the smallest possible
transition band. Since the ideal frequency is 466 Hz, and the intent is
to use a shifted low-pass filter, the cut-off frequency should be as
small as reasonably possible. However, the smaller Fc is chosen, the
greater the overattenuation of our desired signal occurs. We will start
with an Fc value of 10, and adjust it experimentally. Then lets select
parameter M for a 50 dB attenuation which is approximately 30.