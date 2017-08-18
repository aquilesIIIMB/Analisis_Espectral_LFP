%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% View_Spectrum_6_11.m
fprintf('\nVisualizacion del Espectro\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.stage.spectral_analysis_single 
    error('Falta el bloque de analisis espectral para cada canal');
    
end

if ~registroLFP.stage.spectral_analysis_average
    fprintf('Visualizacion del espectro de cada canal\n');
    
canales_eval = find(~[registroLFP.channel.removed]);
slash_system = foldername(length(foldername));
largo_canales_eval = size(canales_eval,2);

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;

%% Graficos de la respuesta en frecuencia y espectrograma
for j = 1:largo_canales_eval 
    
    % Cargar los datos que se mostraran
    Spectrogram = registroLFP.channel(canales_eval(j)).spectrogram.data;
    f_Spectrogram = registroLFP.channel(canales_eval(j)).spectrogram.frecuencia;
    t_Spectrogram = registroLFP.channel(canales_eval(j)).spectrogram.tiempo;
    
    Spectral_pre = registroLFP.channel(canales_eval(j)).psd.pre.data;
    Spectral_on = registroLFP.channel(canales_eval(j)).psd.on.data;
    Spectral_post = registroLFP.channel(canales_eval(j)).psd.post.data;
    
    %-------------------Plot---Sectral Frequency---------------------------
    fig_7 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(f_Spectrogram,Spectral_pre)
    hold on
    semilogy(f_Spectrogram,Spectral_on)    
    hold on
    semilogy(f_Spectrogram,Spectral_post)
    xlim(registroLFP.multitaper.params.fpass)
    legend('pre-stim', 'on-stim', 'post-stim')
    xlabel('Frecuencia [Hz]'); ylabel('Amplitud (dB)');
    title(['Respuesta en Frecuencia Multitaper del LFP ',registroLFP.channel(canales_eval(j)).area,' ',registroLFP.channel(canales_eval(j)).name])
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channel(canales_eval(j)).area,' de ',registroLFP.channel(canales_eval(j)).name,' PSD del LFP'];
    saveas(fig_7,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_7)

    %-------------------Plot---Spectrogram------------------------------------
    fig_8 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(Spectrogram','power'),1,numel(Spectrogram)),[5 99]);
    imagesc(t_Spectrogram,f_Spectrogram,db(Spectrogram','power'),clim); colormap('jet');
    axis xy
    ylabel('Frequency (Hz)')
    xlabel('Time (sec)');
    ylim(registroLFP.multitaper.params.fpass)
    c=colorbar('southoutside');
    caxis([0, 30]); %[0, 30] [-10, 10] [-20, 15] [-15, 20]
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',1.75,'Marker','.','LineStyle',':');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',1.75,'Marker','.','LineStyle',':');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    title(['Espectrograma Multitaper del LFP ',registroLFP.channel(canales_eval(j)).area,' ',registroLFP.channel(canales_eval(j)).name])
    ylabel(c,'Power (dB)')
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channel(canales_eval(j)).area,' Espectrograma Multitaper del LFP de ',registroLFP.channel(canales_eval(j)).name];
    saveas(fig_8,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_8)
end

else
    fprintf('Visualizacion del espectro promedio\n');
    
canales_eval = find(~[registroLFP.channel.removed]);
slash_system = foldername(length(foldername));

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;

[C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');

%% Calculos para el analisis del promedio de las Areas
for m = 1:length(ia) 
    i = ia(m);
    
    % Cargar los datos que se mostraran
    Spectral_pre_mean = registroLFP.average_spectrum(m).psd.pre.data;
    Spectral_on_mean = registroLFP.average_spectrum(m).psd.on.data;
    Spectral_post_mean = registroLFP.average_spectrum(m).psd.post.data;
    
    Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.data;
    
    t_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.tiempo;
    f_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.frecuencia; 
    
    new_pre_m = registroLFP.average_spectrum(m).times.pre_m_deartifacted;
    new_on_inicio_m = registroLFP.average_spectrum(m).times.start_on_m_deartifacted;
    new_on_final_m = registroLFP.average_spectrum(m).times.end_on_m_deartifacted;
    new_post_m = registroLFP.average_spectrum(m).times.post_m_deartifacted;
    new_tiempo_total = registroLFP.average_spectrum(m).times.end_m_deartifacted; 
    new_total_time = registroLFP.average_spectrum(m).times.steps_m_deartifacted;
    
    %% Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(f_Spectrogram_mean,Spectral_pre_mean)
    hold on
    semilogy(f_Spectrogram_mean,Spectral_on_mean)
    hold on
    semilogy(f_Spectrogram_mean,Spectral_post_mean)
    xlim([1 100])
    legend('pre-stim', 'on-stim', 'post-stim')
    xlabel('Frequency (Hz)'); ylabel('Power (dB)')
    title(['Respuesta en Frecuencia Multitaper Promedio de los LFP ',C{ic(i)}])
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' PSD de los LFP '];
    saveas(fig_5,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_5)

    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_6 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(Spectrogram_mean','power'),1,numel(Spectrogram_mean)),[5 99]);
    imagesc(t_Spectrogram_mean,f_Spectrogram_mean,db(Spectrogram_mean','power'),clim); colormap('jet');
    axis xy
    ylabel('Frequency (Hz)')
    xlabel('Time (sec)');
    ylim([1 100])
    c=colorbar('southoutside');
    caxis([-10, 10]); %([-20, 15]) [-15, 20]
    hold on
    line([new_pre_m*60.0 new_pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',1.75,'Marker','.','LineStyle',':');
    line([new_on_inicio_m*60.0 new_on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',1.75,'Marker','.','LineStyle',':');
    line([new_on_final_m*60.0 new_on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([new_post_m*60.0 new_post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    %caxis([min(min(10*log10(Spectrogram_mean))) max(max(10*log10(Spectrogram_mean)))]); %([-20, 15]) ([-10, 20])
    title(['Espectrograma Multitaper Promedio de los LFP ',C{ic(i)}])
    ylabel(c,'Power (dB)')
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Espectrograma Multitaper de los LFP '];
    saveas(fig_6,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_6)
    
end
    
end

registroLFP.stage.view_spectrum = 1;

% Eliminacion de variables no utilizadas
clear fig_5 fig_6 fig_7 fig_8 name_figure_save canales_eval Spectrogram f_Spectrogram t_Spectrogram
clear slash_system largo_canales_eval pre_m on_inicio_m on_final_m post_m 
clear Spectral_pre Spectral_on Spectral_post
clear Spectrogram_mean f_Spectrogram_mean t_Spectrogram_mean
clear Spectral_post_mean Spectral_on_mean Spectral_pre_mean
clear c j clim C i ia ic m
