%% Wingbeat Frequency Analysis(Fundamental Frequency)
% Extracts wingbeat fundamental frequency from insect flight audio
% using FFT peak detection with biological constraints

%% 1. Load audio signal
file = input('Enter full file name and type: ', 's'); %Take user input file name
chartName = input('Enter Run Number, Mosquito Strain, Sex: ', 's'); %Used for graph title
[x, fs] = audioread(file);

% Convert to mono if stereo
x = mean(x, 2);

% Remove DC offset
x = x - mean(x);

%% 2. Bandpass filter
% Mosquito wingbeat range
lowCut  = 300;    % Hz  Broad range of frequncy encapsulating the fundamental frequency of male and female mosquitoes in non-swarming time
highCut = 900;    % Hz

x = bandpass(x, [lowCut highCut], fs);

%% 3. Window the signal
N = length(x);
window = hann(N);
xw = x .* window;

%% 4. FFT-based frequency analysis
X = abs(fft(xw));
f = (0:N-1) * (fs / N);

% Keep only positive frequencies
halfIdx = 1:floor(N/2);
X = X(halfIdx);
f = f(halfIdx);

%% 5. Restrict FFT to expected wingbeat band
validBand = f >= 400 & f <= 700;
X_band = X(validBand);
f_band = f(validBand);

%% 6. Detect dominant peak in wingbeat band
[pks, locs] = findpeaks(X_band, f_band, ...
    'MinPeakHeight', 0.2 * max(X_band), ...
    'MinPeakDistance', 40);

% Take strongest peak (not lowest!)
[~, idx] = max(pks);
f0_fft = locs(idx);

%% 7. Harmonic correction (safety check)
% If detected frequency is a harmonic, divide down
if f0_fft > 650
    f0_fft = f0_fft / 2;
end

%% 8. Display results
fprintf('Wingbeat Frequency (FFT): %.2f Hz\n', f0_fft);

%% 9. Plot results for verification
figure;

% Time-domain signal
subplot(2,1,1)
t = (0:N-1) / fs;
plot(t, x)
xlabel('Time (s)')
ylabel('Amplitude')
title('Time-Domain Signal')

% Frequency spectrum
subplot(2,1,2)
plot(f, X)
xlim([0 1500])
hold on
h = xline(f0_fft, 'r--', 'LineWidth', 1.5)
h.Label = sprintf('%.1f Hz', f0_fft);
h.LabelOrientation = 'horizontal';
h.LabelVerticalAlignment = 'top';
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Frequency Spectrum (FFT)')
legend('Spectrum', 'Wingbeat Frequency')

sgtitle(chartName)
