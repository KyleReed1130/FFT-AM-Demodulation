%% AM Demod Password Decoder (robust)
% Loads Question_01.mat if present; otherwise calls gen_synth_am.m
% Then estimates Fc from FFT peaks, demodulates, filters, and plays audio.

clear; close all; clc;

matfile = "Question_01.mat";
if ~isfile(matfile)
    fprintf("'%s' not found. Generating a synthetic dataset...\n", matfile);
    run("gen_synth_am.m");
end
S = load(matfile);            % expects S.y and S.Fs
y = S.y; Fs = S.Fs;
fprintf("Loaded signal with %d samples at Fs=%d Hz\n", numel(y), Fs);

%% Time-domain
figure(1); clf;
subplot(2,1,1);
plot((0:numel(y)-1)/Fs, y);
xlabel("Time (s)"); ylabel("Amplitude"); title("Received AM Signal");

%% Frequency-domain (single-sided FFT)
N = numel(y);
Y = fft(y);
f = (0:N-1)*Fs/N;
halfN = ceil(N/2);
subplot(2,1,2);
plot(f(1:halfN), abs(Y(1:halfN)));
xlabel("Frequency (Hz)"); ylabel("|Y(f)|");
title("Single-Sided FFT Spectrum");

%% Estimate carrier frequency (Fc) by top two spectral peaks
[pks, locs] = findpeaks(abs(Y(1:halfN)), f(1:halfN), "SortStr","descend");
if numel(locs) < 2
    error("Not enough peaks to estimate carrier frequency.");
end
FcEstim = mean(locs(1:2));
fprintf("Estimated Fc ≈ %.1f Hz\n", FcEstim);

%% Demodulate and low-pass filter
x_bb = demod(y, FcEstim, Fs, "am");   % baseband
[b,a] = butter(5, min(0.99, 2*FcEstim/Fs));   % normalized cutoff (safety clamp)
x_filt = filtfilt(b,a,x_bb);

figure(2); clf;
freqz(b,a,[],Fs); title("Butterworth LPF");

%% Play recovered audio (blocking)
fprintf("Playing recovered audio...\n");
player = audioplayer(x_filt, Fs);
playblocking(player);
