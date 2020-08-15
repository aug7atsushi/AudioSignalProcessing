function [normalizedX] = StationaryNormalaization(X,window,fftSize)
    %STATIONARYNORMALAIZATION
    %Powerが１の連続スペクトル(または雑音のパワースペクトル)の周波数平均が0 dBに正規化
    %Reference: http://www.asp.c.dendai.ac.jp/ASP/asp_01_001.pdf
    
    switch window
        case 'hamming'
            Window = hamming(fftSize);
        case 'hann'
            Window = hann(fftSize);
        case 'rectangular'
            Window = rectwin(fftSize);
        case 'blackman'
            Window = blackman(fftSize);
    end

    nor = 1 / sqrt(sum(Window.^2));
    normalizedX = nor .* X;
end

