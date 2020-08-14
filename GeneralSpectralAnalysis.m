%% General Spectal Analysis tips
clear all

%% 高調波測定(DC, 60Hz, 120Hz, 180Hz(雑音に埋もれている))
load ampoutput1.mat
Fs = 3600;
NFFT = length(y);

% Power spectrum is computed when you pass a 'power' flag input
[P,F] = periodogram(y,[],NFFT,Fs,'power');

helperFrequencyAnalysisPlot2(F,10*log10(P),'Frequency in Hz','Power spectrum (dBW)',[],[],[-0.5 200]);

PdBW = 10*log10(P);
power_at_DC_dBW = PdBW(F==0);   % dBW

[peakPowers_dBW, peakFreqIdx] = findpeaks(PdBW,'minpeakheight',-11);
peakFreqs_Hz = F(peakFreqIdx);

%% Pwelchを用いた測定(改良)
% 上ではノイズを含む信号に対して，一度しか解析していないので，埋もれる -> 複数回平均をとれば精度向上(pwelch)
% 信号をセグメントに分けて，セグメントごとにピリオドグラムを計算し，平滑化

load ampoutput2.mat
SegmentLength = NFFT;

% Power spectrum is computed when you pass a 'power' flag input
[P,F] = pwelch(y,ones(SegmentLength,1),0,NFFT,Fs,'power');

helperFrequencyAnalysisPlot2(F,10*log10(P),'Frequency in Hz','Power spectrum (dBW)',[],[],[-0.5 200])

%% 平均パワーの合計比較

% 時間領域での平均パワーの合計
pwr = sum(y.^2)/length(y); % in watts

% 周波数領域での平均パワーの合計
pwr1 = sum(P); % in watts

%% 周波数帯域ごとのパワーの比較

% 時間信号をbandpowerに渡して，50 Hz~70 Hz のパワーを計算
pwr_band = bandpower(y,Fs,[50 70]);
pwr_band_dBW = 10*log10(pwr_band); % dBW

% pwelchで得られたPSDをbandpowerに渡して，50 Hz~70 Hz のパワーを計算
[PSD,F]  = pwelch(y,ones(SegmentLength,1),0,NFFT,Fs,'psd');
pwr_band1 = bandpower(PSD,F,[50 70],'psd');
pwr_band_dBW1 = 10*log10(pwr_band1); % dBW
