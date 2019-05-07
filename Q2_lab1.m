[serial_1, time_1, signal_1] = textread('4096_wo.txt', '%f %f %f');
[serial_2, time_2, signal_2] = textread('4096_wec.txt', '%f %f %f');


N1 = size(time_1, 1);
N2 = size(time_2, 1);

Correlation_12 = conv(fliplr(signal_2), signal_1);

hann_ = hann(N1);
signal_hann_1 = hann_ .* signal_1;

signal_freq_1 = fft(detrend(signal_1), N1);
Pyy_1 = signal_freq_1 .* conj(signal_freq_1) ./ N1;
f_max_1 = 1 ./ (2.*(time_1(2) - time_1(1)));
fs_1 = 2 .* f_max_1;

Pyy_to_plot_1 = 0.5 .* db(Pyy_1(1:N1/2 + 1)./max(Pyy_1(1:N1/2 + 1)));

frequencies_1 = fs_1 .* (0:N1/2) ./ N1;

plot(frequencies_1(2:end), Pyy_to_plot_1(2:end), 'LineWidth', 2);
hold on;
signal_hann_2 = hann_ .* signal_2;

signal_freq_2 = fft(detrend(signal_2), N2);
Pyy_2 = signal_freq_2 .* conj(signal_freq_2) ./ N2;
f_max_2 = 1 ./ (2.*(time_2(2) - time_2(1)));
fs_2 = 2 .* f_max_2;

Pyy_to_plot_2 = 0.5 .* db(Pyy_2(1:N2/2 + 1)./max(Pyy_2(1:N2/2 + 1)));

frequencies_2 = fs_2 .* (0:N2/2) ./ N2;

plot(frequencies_2(2:end), Pyy_to_plot_2(2:end), 'LineWidth', 2);

%ylim([0 80]);

xlabel('Frequencies(GHz)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Pyy_1, Pyy_2 [dB]', 'FontSize', 12, 'FontWeight', 'bold');
title('Mono Pulse in freq domain', 'FontSize', 12, 'FontWeight', 'bold');
grid on;

xlim([0 10])

del_t_1 = (time_1(2) - time_1(1));
del_t_2 = (time_2(2) - time_2(1));

phi_1 = atan(imag(signal_freq_1)./real(signal_freq_1));
phi_2 = atan(imag(signal_freq_2)./real(signal_freq_2));

figure(2);

plot(frequencies_1(2:end), phi_1(2:N1/2+1), 'LineWidth', 2);
hold on;
plot(frequencies_2(2:end), phi_2(2:N2/2+1), 'LineWidth', 2);

hold on;
plot(frequencies_2(2:end), phi_2(2:N2/2+1) - phi_1(2:N1/2+1), 'LineWidth', 2);



xlim([0 1.2])


%ylim([0 80]);

xlabel('Frequencies(GHz)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('\Delta\phi_1, \Delta\phi_2 [rad]', 'FontSize', 12, 'FontWeight', 'bold');
title('Mono Pulse phase in freq domain', 'FontSize', 12, 'FontWeight', 'bold');
grid on;


figure(3);
plot(time_1, signal_1, 'LineWidth', 2);
hold on;
plot(time_2, signal_2, 'LineWidth', 2);

% plot(time_1, Correlation_12, 'LineWidth', 2);
% xlabel('Time(nS)', 'FontSize', 12, 'FontWeight', 'bold');
% ylabel('conv(fliplr(signal_2), signal_1)', 'FontSize', 12, 'FontWeight', 'bold');
% title('Correlation of Signal 1 and Signal 2', 'FontSize', 12, 'FontWeight', 'bold');
% grid on;
% 
% 
% xlabel('Frequencies(GHz)', 'FontSize', 12, 'FontWeight', 'bold');
% ylabel('Signal(mV)', 'FontSize', 12, 'FontWeight', 'bold');
% title('Mono Pulse in freq domain', 'FontSize', 12, 'FontWeight', 'bold');
% grid on;