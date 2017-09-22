% show señales, espectrogramas y psd de todo un protocolo

% Señales LFP
signal_inj = [protocoloLFP.injured.area_signals];
signal_uninj = [protocoloLFP.uninjured.area_signals];
min_amp = min([min([signal_inj(:).data]), min([signal_uninj(:).data])]);
max_amp = max([max([signal_inj(:).data]), max([signal_uninj(:).data])]);
for i = 1:length(protocoloLFP.injured)
    
    % Injured
    lfp_data = protocoloLFP.injured(i).area_signals.data;
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
    xlabel('Tiempo (minutos)'); ylabel('Amplitud')
    title(['LFP en el tiempo del area ',protocoloLFP.injured(i).area,' Lesionada'])
    
    % Uninjured
    lfp_data = protocoloLFP.uninjured(i).area_signals.data;
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
    xlabel('Tiempo (minutos)'); ylabel('Amplitud')
    title(['LFP en el tiempo del area ',protocoloLFP.uninjured(i).area,' No Lesionada'])
        
    % Guardar imagen de la figura
    %name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'LFPs',slash_system,C{ic(i)},' LFP en bruto en el tiempo'];
    %saveas(fig_2,name_figure_save,'png');
    %saveas(fig_2,name_figure_save,'fig');
    %waitforbuttonpress;
    %close(fig_2)
    
end

% Espectrograma
Frec_sin = 90; % confirmar dentro de Frec_sin = registroLFP.frec_sin_artifacts; 

for i = 1:length(protocoloLFP.injured)
    
    % Injured
    spectrograma_data = protocoloLFP.injured(i).spectrogram.data;
    t_Spectrogram_data = protocoloLFP.injured(i).spectrogram.time;
    f_Spectrogram_data = protocoloLFP.injured(i).spectrogram.frequency;
    
    % Se le quita el ruido rosa, dejando mas plano el espectro
    %spectrograma_data = pink_noise_del(f_Spectrogram_data, spectrograma_data); 
    
     % Separacion por etapas el espectrograma    
    %Spectrogram_pre = spectrograma_data((t_Spectrogram_data<(6*60.0-30)),:);
    %[~,ind_max] = max(Spectrogram_pre,[],2);
    %frec_ind_max = f_Spectrogram_data(ind_max);
    %ind_noartefactos_Spec_pre = ~((frec_ind_max > Frec_sin-5) & (frec_ind_max < Frec_sin+5));  
    
    %Spectrogram_on = spectrograma_data(t_Spectrogram_data>(6*60.0+60) & t_Spectrogram_data<(12*60.0),:);
    %[~,ind_max] = max(Spectrogram_on,[],2);
    %frec_ind_max = f_Spectrogram_data(ind_max);
    %ind_noartefactos_Spec_on = ~((frec_ind_max > Frec_sin-5) & (frec_ind_max < Frec_sin+5));  
    
    %Spectrogram_post = spectrograma_data(t_Spectrogram_data>(12*60.0+90),:);
    %[~,ind_max] = max(Spectrogram_post,[],2);
    %frec_ind_max = f_Spectrogram_data(ind_max);
    %ind_noartefactos_Spec_post = ~((frec_ind_max > Frec_sin-5) & (frec_ind_max < Frec_sin+5));  

    % Spectrograma final
    %Mean_Spectrogram_pre_mean = mean(Spectrogram_pre(ind_noartefactos_Spec_pre,:),1);
    %Desv_Spectrogram_pre_mean = std(Spectrogram_pre(ind_noartefactos_Spec_pre,:),1);
    
    %spectrograma_data = (spectrograma_data-ones(size(spectrograma_data))*diag(Mean_Spectrogram_pre_mean))./(ones(size(spectrograma_data))*diag(Desv_Spectrogram_pre_mean));
    %spectrograma_data = spectrograma_data-mean(mean(spectrograma_data))./std(std(spectrograma_data));
    spectrograma_data = spectrograma_data-(min(min(spectrograma_data)));
    
    
    area_data = protocoloLFP.injured(i).area;
    
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(spectrograma_data','power'),1,numel(spectrograma_data)),[5 99]);
    imagesc(t_Spectrogram_data,f_Spectrogram_data,db(spectrograma_data','power'),clim); colormap('jet');
    axis xy
    ylabel('Frequency (Hz)')
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
    title(['Espectrograma del area ',area_data,' Lesionada'])
    ylabel(c,'Power (dB)')
    %name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Espectrograma Multitaper de los LFP '];
    %saveas(fig_6,name_figure_save,'png');
    %waitforbuttonpress;
    %close(fig_6)    
    
    
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
    ylabel('Frequency (Hz)')
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
    title(['Espectrograma del area ',area_data,' No Lesionada'])
    ylabel(c,'Power (dB)')
    
end

% PSD 
for i = 1:length(protocoloLFP.injured)
    
    % Injured
    Spectral_pre = protocoloLFP.injured(i).psd.pre.data;
    Spectral_on = protocoloLFP.injured(i).psd.on.data;
    Spectral_post = protocoloLFP.injured(i).psd.post.data;
    
    freq_psd = protocoloLFP.injured(i).psd.frequency; 
    
    % Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_4 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(freq_psd,Spectral_pre)
    hold on
    semilogy(freq_psd,Spectral_on)
    hold on
    semilogy(freq_psd,Spectral_post)
    xlim([1 100])
    grid on
    legend('pre-stim', 'on-stim', 'post-stim')
    xlabel('Frequency (Hz)'); ylabel('Power (dB)')
    title(['PSD de los LFP del area ',protocoloLFP.injured(i).area,' Lesionada'])
    %name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' PSD de los LFP '];
    %saveas(fig_5,name_figure_save,'png');
    %waitforbuttonpress;
    %close(fig_5)
    
    % Uninjured
    Spectral_pre = protocoloLFP.uninjured(i).psd.pre.data;
    Spectral_on = protocoloLFP.uninjured(i).psd.on.data;
    Spectral_post = protocoloLFP.uninjured(i).psd.post.data;
    
    freq_psd = protocoloLFP.uninjured(i).psd.frequency; 
    
    % Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(freq_psd,Spectral_pre)
    hold on
    semilogy(freq_psd,Spectral_on)
    hold on
    semilogy(freq_psd,Spectral_post)
    xlim([1 100])
    grid on
    legend('pre-stim', 'on-stim', 'post-stim')
    xlabel('Frequency (Hz)'); ylabel('Power (dB)')
    title(['PSD de los LFP del area ',protocoloLFP.uninjured(i).area,' No Lesionada'])
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

    figure;
    plot(f,Coherency_pre_mean,'LineWidth',2.0)
    hold on
    plot(f,Coherency_on_mean,'LineWidth',2.0)
    plot(f,Coherency_post_mean,':','LineWidth',2.0)
    grid on
    xlim([0 100])
    ylabel('Coherencia')
    xlabel('Frecuencia [Hz]')
    legend('pre','on','post')
    title(['Coherencia de ', protocoloLFP.injured(i).area, ' vs ', protocoloLFP.injured(j).area, ' Lesionadas'])
    
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

    figure;
    plot(f,Coherency_pre_mean,'LineWidth',2.0)
    hold on
    plot(f,Coherency_on_mean,'LineWidth',2.0)
    plot(f,Coherency_post_mean,':','LineWidth',2.0)
    grid on
    xlim([0 100])    
    ylabel('Coherencia')
    xlabel('Frecuencia [Hz]')
    legend('pre','on','post')
    title(['Coherencia de ', protocoloLFP.uninjured(i).area, ' vs ', protocoloLFP.uninjured(j).area, ' No Lesionadas'])
    
    end
    
    p=p+1;
    
end


