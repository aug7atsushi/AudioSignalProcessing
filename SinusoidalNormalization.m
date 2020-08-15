function [normalizedX] = SinusoidalNormalization(X,window,fftSize)
    %SINUSOIDNORMALIZATION
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

    nor = sqrt(2)/sum(Window);
    normalizedX = nor .* X; 
end

