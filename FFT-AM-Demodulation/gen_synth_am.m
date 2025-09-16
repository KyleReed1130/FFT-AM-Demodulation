%% gen_synth_am.m
% Generate a synthetic AM dataset that says the password "BRAZIL" as tones.
% Saves y (AM signal) and Fs into Question_01.mat (gitignored).

clear; clc;

% Parameters
Fs  = 16000;               % sample rate (Hz)
Fc  = 4000;                % carrier (Hz)
dur = 0.25;                % tone duration per letter (s)
gap = 0.05;                % silence between letters (s)
letters = 'BRAZIL';

% Map letters to distinct baseband tones (Hz)
tone_map = containers.Map;
tone_map('A') = 440;
tone_map('B') = 494;
tone_map('C') = 523;
tone_map('D') = 587;
tone_map('E') = 659;
tone_map('F') = 698;
tone_map('G') = 784;
tone_map('I') = 880;
tone_map('L') = 988;
tone_map('R') = 659;
tone_map('Z') = 831;

% Build baseband by concatenating letter tones
x = [];
for k = 1:numel(letters)
    L = letters(k);
    f0 = tone_map(L);
    t  = (0:1/Fs:dur-1/Fs).';
    tg = (0:1/Fs:gap-1/Fs).';
    env = hann(numel(t));              % soft attack/decay
    tone = 0.3 * env .* sin(2*pi*f0*t);
    x = [x; tone; zeros(size(tg))];
end

% Optional noise
x = x + 0.01*randn(size(x));

% AM modulation y = x .* cos(2*pi*Fc*t)
t = (0:numel(x)-1).' / Fs;
carrier = cos(2*pi*Fc*t);
y = x .* carrier;

save("Question_01.mat", "y", "Fs");
fprintf("Synthetic dataset saved to Question_01.mat (Fs=%d Hz, Fc=%d Hz, length=%.2f s)\n", Fs, Fc, numel(y)/Fs);
