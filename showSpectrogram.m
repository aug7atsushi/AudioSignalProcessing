function [graphObj] = showSpectrogram(T,F,logSpectrogram,minVal,maxVal,fig)
    %SHOWSPECTROGRAM 
    
    graphObj = fig;
    imagesc(T,fliplr(F),logSpectrogram);
    
    ax = gca;
    ax.YDir = 'normal';
    xlabel('Time [s]');
    ylabel('Frequency [Hz]');
    c = colorbar;
    c.Label.FontSize = 20;
    colormap('jet');
    c.Label.String ='Power [dB]';
    caxis([minVal, maxVal]);
    
end

