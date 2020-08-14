%% 確定的周期信号のパワー推定
clear all

set(0,'defaultAxesFontSize',20);
set(0,'defaultAxesFontName','times new roman');

%% 単一正弦波のパワー測定
Fs = 1024;
t = 0:1/Fs:1-(1/Fs);
A = 1;
F1 = 128;
x = A*sin(2*pi*t*F1);

idx = 1:128;
plot(t(idx),x(idx))
ylabel('Amplitude')
xlabel('Time (seconds)')
axis tight
grid

power_theoretical = (A^2/4)*2;
% 0.5
% 各複素正弦波の理論的な平均パワー(平均2乗)は A^2/4 
% 正の周波数と負の周波数のパワーを考慮すると、平均パワーは2×A^2/4

ans = 10*log10(power_theoretical/2);
% -6.02dB

% periodogram('power')で平均パワーを測定してみる
% 'oneside'にすると-3dBのピークが現れる
periodogram(x,hamming(length(x)),[],Fs,'centered','power')
ylim([-10 -5.5])

%% PSDを用いて単一正弦波のパワー測定

periodogram(x,hamming(length(x)),[],Fs,'centered','psd')

% PSD曲線下の面積を積分すれば，信号の平均パワーと等価
[Pxx_hamming,F] = periodogram(x,hamming(length(x)),[],Fs,'psd');
power_freqdomain = bandpower(Pxx_hamming,F,'psd');

%% パーセバルの定理の確認(power_timedomain = power_freqdomain)
power_timedomain = sum(abs(x).^2)/length(x);

%% 複合正弦波のパワー推定

Fs = 1024;
t  = 0:1/Fs:1-(1/Fs);
Ao = 1.5;
A1 = 4;
A2 = 3;
F1 = 100;
F2 = 200;
x  = Ao + A1*sin(2*pi*t*F1) + A2*sin(2*pi*t*F2);

idx = 1:128;
plot(t(idx),x(idx))
grid
ylabel('Amplitude')
xlabel('Time (seconds)')
axis tight

power_theoretical = Ao^2 + (A1^2/4)*2 + (A2^2/4)*2;
% 14.75

ans = pow2db([Ao^2 A1^2/4 A2^2/4]);
% 3.5218    6.0206    3.5218


periodogram(x,hamming(length(x)),[],Fs,'centered','power')
ylim([0 7])

%% PSDを用いて複合正弦波のパワー測定
[Pxx, F] = periodogram(x, hamming(length(x)),[],Fs,'centered','psd');
power_freqdomain = bandpower(Pxx,F,'psd');

%% パーセバルの定理の確認(power_timedomain = power_freqdomain)
power_timedomain = sum(abs(x).^2)/length(x);
