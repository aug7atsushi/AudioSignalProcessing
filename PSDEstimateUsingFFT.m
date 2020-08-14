% PSD estimates using FFT
% Results are equal to "periodogram(x,rectwin(length(x)),length(x),Fs)"
% 振幅1の正弦波のピークが-3dBに表示される
% 片側ピリオドグラムを採用するため，0とナイキスト周波数 1/2Δt 以外の周波数のパワーは2倍 (Parseval's theoremを担保するため)
% 参考:https://ocw.hokudai.ac.jp/wp-content/uploads/2016/01/MeterologyAndOceanology-2001-Note-03.pdf

clear all

set(0,'defaultAxesFontSize',20);
set(0,'defaultAxesFontName','times new roman');

Fs = 1000;
t = 0:1/Fs:1-1/Fs;
x = sin(2*pi*100*t) + randn(size(t));
N = length(x);

xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;

plot(freq,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

peak = max(10*log10(psdx));
