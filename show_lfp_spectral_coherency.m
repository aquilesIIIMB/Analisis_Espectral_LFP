% show se�ales, espectrogramas y psd de todo un protocolo

% Se�ales LFP
signal_inj = [protocoloLFP.injured.area_signals];
signal_uninj = [protocoloLFP.uninjured.area_signals];
min_amp = min([min([signal_inj(:).data]), min([signal_uninj(:).data])]);
max_amp = max([max([signal_inj(:).data]), max([signal_uninj(:).data])]);

slash_system = foldername(length(foldername));

for i = 1:length(protocoloLFP.injured)
    
    % Injured
    lfp_data = mean([protocoloLFP.injured(i).area_signals(:).data],2);
    time_data = protocoloLFP.injured(i).area_signals.time;
    
    fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
    % LFP
    plot(time_data, lfp_data)
    hold on;                  
    
    % Lineas divisorias de cada fase
    line([6 6], get(gca, 'ylim'),'Color','black','LineWidth',1.5,'Marker','.','LineStyle',':');
    line([6.5 6.5], get(gca, 'ylim'),'Color','black','LineWidth',1.5,'Marker','.','LineStyle',':');
    line([12.5 12.5], get(gca, 'ylim'),'Color','black','LineWidth',1.5,'Marker','.','LineStyle',':');
    line([13 13], get(gca, 'ylim'),'Color','black','LineWidth',1.5,'Marker','.','LineStyle',':');
    
    xlim([0 max(time_data)])
    ylim([min_amp  max_amp])
    xlabel('Time [Minutes]'); ylabel('LFP')
    title(['LFP of the area ',protocoloLFP.injured(i).area,' Injured ',strrep(protocoloLFP.name,'_',' ')])
    
    % Guardar imagen de la figura
    name_fig = ['LFP_of_the_area_',protocoloLFP.injured(i).area,'_Injured_',strrep(protocoloLFP.name,' ','_')];
    folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
    saveas(fig_1,folder_name_save,'png');
    saveas(fig_1,folder_name_save,'fig');
    %waitforbuttonpress;
    close(fig_1)
    
    
    % Uninjured
    lfp_data = mean([protocoloLFP.uninjured(i).area_signals(:).data],2);
    time_data = protocoloLFP.uninjured(i).area_signals.time;
    
    fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
    % LFP
    plot(time_data, lfp_data)
    hold on;                  
    
    % Lineas divisorias de cada fase
    line([6 6], get(gca, 'ylim'),'Color','black','LineWidth',1.5,'Marker','.','LineStyle',':');
    line([6.5 6.5], get(gca, 'ylim'),'Color','black','LineWidth',1.5,'Marker','.','LineStyle',':');
    line([12.5 12.5], get(gca, 'ylim'),'Color','black','LineWidth',1.5,'Marker','.','LineStyle',':');
    line([13 13], get(gca, 'ylim'),'Color','black','LineWidth',1.5,'Marker','.','LineStyle',':');
    
    xlim([0 max(time_data)])
    ylim([min_amp  max_amp])
    xlabel('Time [Minutes]'); ylabel('LFP')
    title(['LFP of the area ',protocoloLFP.uninjured(i).area,' Uninjured ',strrep(protocoloLFP.name,'_',' ')])
        
    % Guardar imagen de la figura
    name_fig = ['LFP_of_the_area_',protocoloLFP.uninjured(i).area,'_Uninjured_',strrep(protocoloLFP.name,' ','_')];
    folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
    saveas(fig_2,folder_name_save,'png');
    saveas(fig_2,folder_name_save,'fig');
    %waitforbuttonpress;
    close(fig_2)
    
end

% Espectrograma
Frec_sin = 90; % confirmar dentro de Frec_sin = registroLFP.frec_sin_artifacts; 

for i = 1:length(protocoloLFP.injured)
    
    % Injured
    spectrograma_data = protocoloLFP.injured(i).spectrogram.data;
    t_Spectrogram_data = protocoloLFP.injured(i).spectrogram.time;
    f_Spectrogram_data = protocoloLFP.injured(i).spectrogram.frequency;
    
    % spectrograma con valores positivos
    spectrograma_data = spectrograma_data-(min(min(spectrograma_data)));
    
    
    area_data = protocoloLFP.injured(i).area;
    
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(spectrograma_data','power'),1,numel(spectrograma_data)),[5 99]);
    imagesc(t_Spectrogram_data,f_Spectrogram_data,db(spectrograma_data','power'),clim); colormap('jet');
    axis xy
    ylabel('Frequency [Hz]')
    xlabel('Time (sec)');
    ylim([1 100])
    c=colorbar('southoutside');
    %cmap = colormap('autumn(10)');
    %cmap = cmap(end:-1:1,:);
    %colormap(cmap);
    hold on
    line([6*60.0-10 6*60.0-10], get(gca, 'ylim'),'Color','black','LineWidth',2.25,'Marker','.','LineStyle',':');
    line([6*60.0+40 6*60.0+40], get(gca, 'ylim'),'Color','black','LineWidth',2.25,'Marker','.','LineStyle',':');
    line([12*60.0+20 12*60.0+20], get(gca, 'ylim'),'Color','black','LineWidth',2.25,'Marker','.','LineStyle',':');
    line([12*60.0+70 12*60.0+70], get(gca, 'ylim'),'Color','black','LineWidth',2.25,'Marker','.','LineStyle',':');
    title(['Spectrogram of the area ',area_data,' Injured ',strrep(protocoloLFP.name,'_',' ')])
    ylabel(c,'Power [dB]')
    
    % Guardar imagen de la figura
    name_fig = ['Spectrogram_of_the_area_',area_data,'_Injured_',strrep(protocoloLFP.name,' ','_')];
    folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
    saveas(fig_5,folder_name_save,'png');
    saveas(fig_5,folder_name_save,'fig');
    close(fig_5)
    
    
    % Uninjured
    spectrograma_data = protocoloLFP.uninjured(i).spectrogram.data;
    t_Spectrogram_data = protocoloLFP.uninjured(i).spectrogram.time;
    f_Spectrogram_data = protocoloLFP.uninjured(i).spectrogram.frequency;
    
    spectrograma_data = spectrograma_data-(min(min(spectrograma_data)));
    
    
    area_data = protocoloLFP.uninjured(i).area;
    
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_6 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(spectrograma_data','power'),1,numel(spectrograma_data)),[5 99]);
    imagesc(t_Spectrogram_data,f_Spectrogram_data,db(spectrograma_data','power'),clim); colormap('jet');
    axis xy
    ylabel('Frequency [Hz]')
    xlabel('Time (sec)');
    ylim([1 100])
    c=colorbar('southoutside');
    cmap = colormap('autumn(10)');
    cmap = cmap(end:-1:1,:);
    colormap(cmap);
    hold on
    line([6*60.0-10 6*60.0-10], get(gca, 'ylim'),'Color','black','LineWidth',2.25,'Marker','.','LineStyle',':');
    line([6*60.0+40 6*60.0+40], get(gca, 'ylim'),'Color','black','LineWidth',2.25,'Marker','.','LineStyle',':');
    line([12*60.0+20 12*60.0+20], get(gca, 'ylim'),'Color','black','LineWidth',2.25,'Marker','.','LineStyle',':');
    line([12*60.0+70 12*60.0+70], get(gca, 'ylim'),'Color','black','LineWidth',2.25,'Marker','.','LineStyle',':');
    title(['Spectrogram of the area ',area_data,' Uninjured ',strrep(protocoloLFP.name,'_',' ')])
    ylabel(c,'Power [dB]')
    
    % Guardar imagen de la figura
    name_fig = ['Spectrogram_of_the_area_',area_data,'_Uninjured_',strrep(protocoloLFP.name,' ','_')];
    folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
    saveas(fig_6,folder_name_save,'png');
    saveas(fig_6,folder_name_save,'fig');
    close(fig_6)
    
end

% PSD 
for i = 1:length(protocoloLFP.injured)
    
    % Injured
    pre_temp = reshape([protocoloLFP.injured(i).psd.pre(:).data], length(protocoloLFP.injured(i).psd.pre(1).data), length(protocoloLFP.injured(i).psd.pre));
    on_temp = reshape([protocoloLFP.injured(i).psd.on(:).data], length(protocoloLFP.injured(i).psd.on(1).data), length(protocoloLFP.injured(i).psd.on));
    post_temp = reshape([protocoloLFP.injured(i).psd.post(:).data], length(protocoloLFP.injured(i).psd.post(1).data), length(protocoloLFP.injured(i).psd.post));
    Spectral_pre = mean(pre_temp,2);
    Spectral_pre_all = pre_temp;
    Spectral_on = mean(on_temp,2);
    Spectral_on_all = on_temp;
    Spectral_post = mean(post_temp,2);
    Spectral_post_all = on_temp;
    
    freq_psd = protocoloLFP.injured(i).psd.frequency; 
    
    % Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_4 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(freq_psd,Spectral_pre,'LineWidth',3.0)
    hold on
    semilogy(freq_psd,Spectral_on,'LineWidth',3.0)
    hold on
    semilogy(freq_psd,Spectral_post,'LineWidth',3.0)
    xlim([1 100])
    grid on
    legend('pre-stim', 'on-stim', 'post-stim')
    xlabel('Frequency [Hz]'); ylabel('Power [dB]')
    title(['PSD of the area ',protocoloLFP.injured(i).area,' Injured ',strrep(protocoloLFP.name,'_',' ')])

    % Guardar imagen de la figura
    name_fig = ['PSD_of_the_area_',protocoloLFP.injured(i).area,'_Injured_',strrep(protocoloLFP.name,' ','_')];
    folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
    saveas(fig_4,folder_name_save,'png');
    saveas(fig_4,folder_name_save,'fig');
    close(fig_4)
    
    
    % Uninjured
    pre_temp = reshape([protocoloLFP.uninjured(i).psd.pre(:).data], length(protocoloLFP.uninjured(i).psd.pre(1).data), length(protocoloLFP.uninjured(i).psd.pre));
    on_temp = reshape([protocoloLFP.uninjured(i).psd.on(:).data], length(protocoloLFP.uninjured(i).psd.on(1).data), length(protocoloLFP.uninjured(i).psd.on));
    post_temp = reshape([protocoloLFP.uninjured(i).psd.post(:).data], length(protocoloLFP.uninjured(i).psd.post(1).data), length(protocoloLFP.uninjured(i).psd.post));
    Spectral_pre = mean(pre_temp,2);
    Spectral_on = mean(on_temp,2);
    Spectral_post = mean(post_temp,2);
    
    freq_psd = protocoloLFP.uninjured(i).psd.frequency; 
    
    % Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(freq_psd,Spectral_pre,'LineWidth',3.0)
    hold on
    semilogy(freq_psd,Spectral_on,'LineWidth',3.0)
    hold on
    semilogy(freq_psd,Spectral_post,'LineWidth',3.0)
    xlim([1 100])
    grid on
    legend('pre-stim', 'on-stim', 'post-stim')
    xlabel('Frequency [Hz]'); ylabel('Power [dB]')
    title(['PSD of the area ',protocoloLFP.uninjured(i).area,' Uninjured ',strrep(protocoloLFP.name,'_',' ')])
    
    % Guardar imagen de la figura
    name_fig = ['PSD_of_the_area_',protocoloLFP.uninjured(i).area,'_Uninjured_',strrep(protocoloLFP.name,' ','_')];
    folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
    saveas(fig_5,folder_name_save,'png');
    saveas(fig_5,folder_name_save,'fig');
    close(fig_5)
end

% Coherencia individual

% Injured
p = 2;

for i=1:length(protocoloLFP.injured)-1

    % Coherencia    
    for j = length(protocoloLFP.injured):-1:p

        Coherency_pre_mean = protocoloLFP.coherency.injured.pre.data{i,j};
        Coherency_on_mean = protocoloLFP.coherency.injured.on.data{i,j};
        Coherency_post_mean = protocoloLFP.coherency.injured.post.data{i,j};
        f = protocoloLFP.coherency.injured.frequency;

        fig_7 = figure;
        plot(f,Coherency_pre_mean,'LineWidth',2.0)
        hold on
        plot(f,Coherency_on_mean,'LineWidth',2.0)
        plot(f,Coherency_post_mean,':','LineWidth',2.0)
        grid on
        xlim([0 100])
        ylabel('Mean Coherence')
        xlabel('Frequency [Hz]')
        legend('pre','on','post')
        title(['Mean Coherence in beta between ', protocoloLFP.injured(i).area, ' vs ', protocoloLFP.injured(j).area, ' Injured'])
                
        % Guardar imagen de la figura
        name_fig = ['Mean_Coherence_in_beta_between_', protocoloLFP.injured(i).area, '_vs_', protocoloLFP.injured(j).area, '_Injured_',strrep(protocoloLFP.name,' ','_')];
        folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
        saveas(fig_7,folder_name_save,'png');
        saveas(fig_7,folder_name_save,'fig');
        close(fig_7) 

    end
    
    p=p+1;
    
end


% Uninjured
p = 2;

for i=1:length(protocoloLFP.uninjured)-1

    % Coherencia    
    for j = length(protocoloLFP.uninjured):-1:p

        Coherency_pre_mean = protocoloLFP.coherency.uninjured.pre.data{i,j};
        Coherency_on_mean = protocoloLFP.coherency.uninjured.on.data{i,j};
        Coherency_post_mean = protocoloLFP.coherency.uninjured.post.data{i,j};
        f = protocoloLFP.coherency.uninjured.frequency;

        fig_8 = figure;
        plot(f,Coherency_pre_mean,'LineWidth',2.0)
        hold on
        plot(f,Coherency_on_mean,'LineWidth',2.0)
        plot(f,Coherency_post_mean,':','LineWidth',2.0)
        grid on
        xlim([0 100])    
        ylabel('Mean Coherence')
        xlabel('Frecuencia [Hz]')
        legend('pre','on','post')
        title(['Mean Coherence in beta between ', protocoloLFP.uninjured(i).area, ' vs ', protocoloLFP.uninjured(j).area, ' Uninjured'])
                
        % Guardar imagen de la figura
        name_fig = ['Mean_Coherence_in_beta_between_', protocoloLFP.injured(i).area, '_vs_', protocoloLFP.injured(j).area, '_Uninjured_',strrep(protocoloLFP.name,' ','_')];
        folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
        saveas(fig_8,folder_name_save,'png');
        saveas(fig_8,folder_name_save,'fig');
        close(fig_8)

    end
    
    p=p+1;
    
end


