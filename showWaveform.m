function [graphObj] = showWaveform(t,x,fig)
    %SHOWWAVEFORM
    graphObj = fig;
    plot(t,x,'r');
    xlabel('Time [s]');
    ylabel('Amplitude');
    axis tight
end

