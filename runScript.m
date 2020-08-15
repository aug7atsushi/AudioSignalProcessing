clear all

%% Settings for Screen
set(0,'defaultAxesFontSize',20);
set(0,'defaultAxesFontName','times new roman');

scrsz = get(groot,'ScreenSize');
maxW = scrsz(3);
maxH = scrsz(4);
nw = 1.0;
nh = 0.5;

figure(1);
p = get(gcf,'Position');
dw = p(3)-min(nw*p(3),maxW);
dh = p(4)-min(nh*p(4),maxH);
set(gcf,'Position',[p(1)+dw/2  p(2)+dh  min(nw*p(3),maxW)  min(nh*p(4),maxH)]);

figure(2);
p = get(gcf,'Position');
dw = p(3)-min(nw*p(3),maxW);
dh = p(4)-min(nh*p(4),maxH);
set(gcf,'Position',[p(1)+dw/2  p(2)+dh  min(nw*p(3),maxW)  min(nh*p(4),maxH)])

%% some processing

% params
filename1 = sprintf('./arayuru.wav');
fftSize = 256;
shiftSize = fftSize/2;

% Audio read
[x1, fs1] = audioread(filename1);
taxis = 0:1/fs1:(length(x1)-1)/fs1;

[S1,F1,T1] = spectrogram(x1,hann(fftSize),shiftSize,fftSize,fs1,'onesided','power','yaxis');

S1 = SinusoidalNormalization(S1,'hann',fftSize); % Because window modification is not modified in spectrogram function
AmpS1 = 10*log10(abs(S1).^2);

%% plot area

% plot waveform
showWaveform(taxis,x1,figure(1));

% plot spectrogram
minVal = min( min(AmpS1) );
% maxVal = max( max(AmpS1) );
maxVal = 0;

% If you want to adjust the power in spectrogram, comment out
% minVal = -100;
% AmpS1(AmpS1 < minVal) = minVal;
showSpectrogram(T1,F1,AmpS1,minVal,maxVal,figure(2));
