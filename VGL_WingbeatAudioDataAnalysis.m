%% Transposed Spectrogram-Style Plot (PSD Log-Normalized)
file1 = input('Enter audio file 1: ', 's');
file2 = input('Enter audio file 2: ', 's');
file3 = input('Enter audio file 3: ', 's');
file4 = input('Enter audio file 4: ', 's');

% Load and convert to mono
[audio1, fs1] = audioread(file1);
[audio2, fs2] = audioread(file2);
[audio3, fs3] = audioread(file3);
[audio4, fs4] = audioread(file4);

if size(audio1, 2) > 1, audio1 = mean(audio1, 2); end
if size(audio2, 2) > 1, audio2 = mean(audio2, 2); end
if size(audio3, 2) > 1, audio3 = mean(audio3, 2); end
if size(audio4, 2) > 1, audio4 = mean(audio4, 2); end

% Spectrogram parameters
window = hamming(1024);
noverlap = 512;
nfft = 2048;

% Generate spectrograms
[S1, F1, T1] = spectrogram(audio1, window, noverlap, nfft, fs1);
[S2, F2, T2] = spectrogram(audio2, window, noverlap, nfft, fs2);
[S3, F3, T3] = spectrogram(audio3, window, noverlap, nfft, fs3);
[S4, F4, T4] = spectrogram(audio4, window, noverlap, nfft, fs4);

% Convert to log power and normalize
toNorm = @(S) (10*log10(abs(S).^2));
normalize = @(S) (S - min(S(:))) / (max(S(:)) - min(S(:)));

S1_norm = normalize(toNorm(S1));
S2_norm = normalize(toNorm(S2));
S3_norm = normalize(toNorm(S3));
S4_norm = normalize(toNorm(S4));

% Frequency range for plotting
fmin = 200; fmax = 2000;
idx1 = F1 >= fmin & F1 <= fmax;
idx2 = F2 >= fmin & F2 <= fmax;
idx3 = F3 >= fmin & F3 <= fmax;
idx4 = F4 >= fmin & F4 <= fmax;

% Spectrogram Plots
figure('Name','Transposed Normalized Spectrograms','Color','w');
tiledlayout(2,2);

% WT Male
nexttile;
imagesc(F1(idx1), [], S1_norm(idx1,:)');
axis xy; xlabel('Frequency (Hz)'); ylabel('Time Bins');
title('WT Male'); colorbar; colormap turbo; caxis([0 1]);

% GM Female
nexttile;
imagesc(F2(idx2), [], S2_norm(idx2,:)');
axis xy; xlabel('Frequency (Hz)'); ylabel('Time Bins');
title('GM Female'); colorbar; colormap turbo; caxis([0 1]);

% WT Female
nexttile;
imagesc(F3(idx3), [], S3_norm(idx3,:)');
axis xy; xlabel('Frequency (Hz)'); ylabel('Time Bins');
title('WT Female'); colorbar; colormap turbo; caxis([0 1]);

% GM Male
nexttile;
imagesc(F4(idx4), [], S4_norm(idx4,:)');
axis xy; xlabel('Frequency (Hz)'); ylabel('Time Bins');
title('GM Male'); colorbar; colormap turbo; caxis([0 1]);

%% Peak Frequency From Normalized Signal Strength

% Average signal strength per frequency
avg_signal_strength1 = mean(S1_norm(idx1, :), 2);
avg_signal_strength2 = mean(S2_norm(idx2, :), 2);
avg_signal_strength3 = mean(S3_norm(idx3, :), 2);
avg_signal_strength4 = mean(S4_norm(idx4, :), 2);

% Extract corresponding frequency axes
f1 = F1(idx1); f2 = F2(idx2); f3 = F3(idx3); f4 = F4(idx4);

% Find peak frequency for each
[~, p1] = max(avg_signal_strength1);
[~, p2] = max(avg_signal_strength2);
[~, p3] = max(avg_signal_strength3);
[~, p4] = max(avg_signal_strength4);

% Plot signal strength vs frequency
figure('Name','Normalized Signal Strength vs Frequency','Color','w');
hold on;

plot(f1, avg_signal_strength1, 'g', 'LineWidth', 1.5);
plot(f2, avg_signal_strength2, 'r', 'LineWidth', 1.5);
plot(f3, avg_signal_strength3, 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1.5);
plot(f4, avg_signal_strength4, 'Color', [1, 0.5, 0], 'LineWidth', 1.5);

% Mark peaks
plot(f1(p1), avg_signal_strength1(p1), 'go', 'MarkerFaceColor', 'g');
plot(f2(p2), avg_signal_strength2(p2), 'mo', 'MarkerFaceColor', 'r');
plot(f3(p3), avg_signal_strength3(p3), 'bo', 'Color', [0.9290 0.6940 0.1250], 'MarkerFaceColor',[0.9290 0.6940 0.1250]);
plot(f4(p4), avg_signal_strength4(p4), 'o', 'Color', [1, 0.5, 0], 'MarkerFaceColor', [1, 0.5, 0]);

% Formatting
xlabel('Frequency (Hz)');
ylabel('Normalized Signal Strength');
title('Normalized Signal Strength vs Frequency');
legend('WT Male', 'GM Female', 'WT Female', 'GM Male', 'Location', 'NorthEast');
grid on;
xlim([200 2000]);
ylim([0.4 1]);
hold off;
