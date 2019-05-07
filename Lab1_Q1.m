close all;
clear all;
[serial, time, signal] = textread('1024_t.txt', '%f %f %f');

N = size(time, 1);

hann_ = hamming(N);
signal_hann = hann_ .* signal;

signal_freq = fft(detrend(signal_hann), N);
Pyy = signal_freq .* conj(signal_freq) ./ N;
f_max = 1 ./ (2.*(time(2) - time(1)));
fs = 2 .* f_max;

Pyy_to_plot = 0.5 .* db(Pyy(3:N/2 + 1)./max(Pyy(3:N/2 + 1)));

frequencies = fs .* (0:N/2) ./ N;

plot(time, signal, 'LineWidth', 2);
xlabel('Time(nS)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Signal(mV)', 'FontSize', 12, 'FontWeight', 'bold');
title('Mono Pulse in time domain', 'FontSize', 12, 'FontWeight', 'bold');
grid on;
%print(['signal_1_Q1',  num2str(N)], '-depsc');

figure(2);
plot(frequencies(3:end), Pyy_to_plot(1:end), 'LineWidth', 2);
%ylim([0 80]);

xlabel('Frequencies(GHz)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Power Spectrum P_{yy}[dB]', 'FontSize', 12, 'FontWeight', 'bold');
title('Power Spectrum of Mono Pulse in freq domain Normalized', 'FontSize', 12, 'FontWeight', 'bold');
grid on;

%print(['signal_1_Q1_f', num2str(N)], '-depsc');