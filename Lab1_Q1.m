close all;
clear all;
[serial, time, signal] = textread('128_t.txt', '%f %f %f');

N = size(time, 1);

hann_ = hamming(N);
signal_hann = hann_ .* signal;
time_i = zeros(1, (N));
for i = 1:N-1
    time_i(i) = time(i + 1) - time(i);
end
time_d_avg = sum(time_i.')./(N);


signal_freq = fft(detrend(signal_hann), N);
Pyy = signal_freq .* conj(signal_freq) ./ N;
%f_max = 1 ./ (2.*(time(2) - time(1)));
f_max = 1 ./ (2.*(time_d_avg));
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



Power_avg_time_m = zeros(1, N);
Power_avg_time_m_2 = zeros(1, N);

for m = 1:N - 1
    Power_avg_time_m(m) = signal(m).^2 .* (time(m + 1) - time(m));
end

for n = 1:N-1
    Power_avg_time_m_2(n) = signal(m).^2 .* time_d_avg;
end

Power_avg_time_1 = sum(Power_avg_time_m.') * 10^(-6) * 10^(-9) ./(2 * 50) * 10 * 10^6; %P_{avg} with jitter
Power_avg_time_2 = sum(Power_avg_time_m_2.') * 10^(-6) * 10^(-9) ./ (2 * 50) * 10 * 10^6; %P{avg} without jitter

