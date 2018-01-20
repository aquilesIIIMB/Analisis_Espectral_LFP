    

for i = 1:length(registroLFP.average_spectrum)

    Spectrogram_mean = registroLFP.average_spectrum(i).spectrogram.data_raw;

    figure;
    for j = 1:size(Spectrogram_mean,2)
        hist(Spectrogram_mean(:,j),10000)
        hold on
    end
    
    
end








