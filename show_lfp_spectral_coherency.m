 % show sennales, espectrogramas y psd de todo un protocolo

% Sennales LFP
signal_inj = [protocoloLFP.injured.area_signals];
signal_uninj = [protocoloLFP.uninjured.area_signals];
min_amp = min([min([signal_inj(:).data]), min([signal_uninj(:).data])]);
max_amp = max([max([signal_inj(:).data]), max([signal_uninj(:).data])]);
max_lim_y = max([abs(min_amp), abs(max_amp)]);

%slash_system = foldername(length(foldername));

% Crear carpeta para guardar las imagnes 35:end
slash_system_idx = find(path_name_registro=='\' | path_name_registro=='/');
slash_system = path_name_registro(slash_system_idx(1));
%inicio_new_dir1 = slash_system(length(slash_system)-3);
%inicio_new_dir2 = slash_system(length(slash_system)-2);
%foldername = path(inicio_new_dir2:length(path)); % /+375/arturo2_2017-06-02_12-58-57/
%inicio_foldername = path(1:inicio_new_dir1); % /home/cmanalisis/Aquiles/Registros/
if ~exist(foldername, 'dir')
    mkdir([inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo']);
end

for i = 1:length(protocoloLFP.injured)
    
    % Injured
    lfp_data = mean([protocoloLFP.injured(i).area_signals(:).data],2);
    time_data = protocoloLFP.injured(i).area_signals.time;
    
    fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
    % LFP
    plot(time_data, lfp_data)
    hold on;                  
    
    % Lineas divisorias de cada fase
    line([protocoloLFP.times.phase_range_m(1) protocoloLFP.times.phase_range_m(1)],[-max_lim_y  max_lim_y],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([protocoloLFP.times.phase_range_m(1)+0.5 protocoloLFP.times.phase_range_m(1)+0.5],[-max_lim_y  max_lim_y],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([protocoloLFP.times.phase_range_m(1)*2+0.5 protocoloLFP.times.phase_range_m(1)*2+0.5],[-max_lim_y  max_lim_y],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([protocoloLFP.times.phase_range_m(1)*2+1 protocoloLFP.times.phase_range_m(1)*2+1],[-max_lim_y  max_lim_y],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    
    xlim([0 max(time_data)])
    ylim([-max_lim_y  max_lim_y])
    set(gca,'fontsize',20)
    xlabel('Time [Min]', 'FontSize', 24); ylabel('Amplitude [u.a.]', 'FontSize', 24)
    title(['LFP of the area ',protocoloLFP.injured(i).area,' Injured ',strrep(protocoloLFP.name,'_',' ')], 'FontSize', 24)
    
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
    line([protocoloLFP.times.phase_range_m(1) protocoloLFP.times.phase_range_m(1)],[-max_lim_y  max_lim_y],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([protocoloLFP.times.phase_range_m(1)+0.5 protocoloLFP.times.phase_range_m(1)+0.5],[-max_lim_y  max_lim_y],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([protocoloLFP.times.phase_range_m(1)*2+0.5 protocoloLFP.times.phase_range_m(1)*2+0.5],[-max_lim_y  max_lim_y],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([protocoloLFP.times.phase_range_m(1)*2+1 protocoloLFP.times.phase_range_m(1)*2+1],[-max_lim_y  max_lim_y],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
      
    xlim([0 max(time_data)])
    ylim([-max_lim_y  max_lim_y])
    set(gca,'fontsize',20)
    xlabel('Time [Min]', 'FontSize', 24); ylabel('Amplitude [u.a.]', 'FontSize', 24)
    title(['LFP of the area ',protocoloLFP.uninjured(i).area,' Uninjured ',strrep(protocoloLFP.name,'_',' ')], 'FontSize', 24)
        
    % Guardar imagen de la figura
    name_fig = ['LFP_of_the_area_',protocoloLFP.uninjured(i).area,'_Uninjured_',strrep(protocoloLFP.name,' ','_')];
    folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
    saveas(fig_2,folder_name_save,'png');
    saveas(fig_2,folder_name_save,'fig');
    %waitforbuttonpress;
    close(fig_2)
    
end


% Espectrograma
Frec_sin = 100; % confirmar dentro de Frec_sin = registroLFP.frec_sin_artifacts; 

for i = 1:length(protocoloLFP.injured)
    
    % Injured
    spectrograma_data = protocoloLFP.injured(i).spectrogram.data;
    t_Spectrogram_data = protocoloLFP.injured(i).spectrogram.time;
    f_Spectrogram_data = protocoloLFP.injured(i).spectrogram.frequency;
    
    % spectrograma con valores positivos
    spectrograma_data = spectrograma_data-(min(min(spectrograma_data)));
    
    % Suavizado
    spect_smooth = imgaussfilt(db(spectrograma_data','power'),[1 2]);
    
    area_data = protocoloLFP.injured(i).area;
    
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(spect_smooth,1,numel(spectrograma_data)),[10 99]);
    imagesc(t_Spectrogram_data,f_Spectrogram_data,spect_smooth,clim); colormap('jet');
    axis xy
    set(gca,'fontsize',20)
    ylabel('Frequency [Hz]', 'FontSize', 24);
    xlabel('Time [s]', 'FontSize', 24);
    ylim([1 100])
    c=colorbar('southoutside');
    %cmap = colormap('autumn(10)');
    %cmap = cmap(end:-1:1,:);
    %colormap(cmap);
    hold on
    line([protocoloLFP.times.phase_range_m(1)*60 protocoloLFP.times.phase_range_m(1)*60], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([protocoloLFP.times.phase_range_m(1)*60+30 protocoloLFP.times.phase_range_m(1)*60+30], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([protocoloLFP.times.phase_range_m(1)*60*2+30 protocoloLFP.times.phase_range_m(1)*60*2+30], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([protocoloLFP.times.phase_range_m(1)*60*2+60 protocoloLFP.times.phase_range_m(1)*60*2+60], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Spectrogram of the area ',area_data,' Injured ',strrep(protocoloLFP.name,'_',' ')], 'FontSize', 24)
    ylabel(c,'Power [dB]', 'FontSize', 17)
    
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
    
    % Suavizado
    spect_smooth = imgaussfilt(db(spectrograma_data','power'),[1 2]);
    
    area_data = protocoloLFP.uninjured(i).area;
    
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_6 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(spect_smooth,1,numel(spectrograma_data)),[10 99]);
    imagesc(t_Spectrogram_data,f_Spectrogram_data,spect_smooth,clim); colormap('jet');
    axis xy
    set(gca,'fontsize',20)
    ylabel('Frequency [Hz]', 'FontSize', 24);
    xlabel('Time [s]', 'FontSize', 24);
    ylim([1 100])
    c=colorbar('southoutside');
    %cmap = colormap('autumn(10)');
    %cmap = cmap(end:-1:1,:);
    %colormap(cmap);
    hold on
    line([protocoloLFP.times.phase_range_m(1)*60 protocoloLFP.times.phase_range_m(1)*60], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([protocoloLFP.times.phase_range_m(1)*60+30 protocoloLFP.times.phase_range_m(1)*60+30], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([protocoloLFP.times.phase_range_m(1)*60*2+30 protocoloLFP.times.phase_range_m(1)*60*2+30], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([protocoloLFP.times.phase_range_m(1)*60*2+60 protocoloLFP.times.phase_range_m(1)*60*2+60], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Spectrogram of the area ',area_data,' Uninjured ',strrep(protocoloLFP.name,'_',' ')], 'FontSize', 24)
    ylabel(c,'Normalized Power [u.a.]')
    
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
    %Spectral_pre_all = pre_temp;
    Spectral_on = mean(on_temp,2);
    %Spectral_on_all = on_temp;
    Spectral_post = mean(post_temp,2);
    %Spectral_post_all = post_temp;
    
    freq_psd = protocoloLFP.injured(i).psd.frequency; 
    
    % Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_4 = figure('units','normalized','outerposition',[0 0 1 1]);
    plot(freq_psd,Spectral_pre,'LineWidth',3.0)
    hold on
    plot(freq_psd,Spectral_on,'LineWidth',3.0)
    hold on
    plot(freq_psd,Spectral_post,'LineWidth',3.0)
    xlim([1 100])
    ylim([-5 5])
    grid on
    set(gca,'fontsize',20)
    lgd = legend('pre-stim', 'on-stim', 'post-stim');
    lgd.FontSize = 20;
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Power [dB]', 'FontSize', 24)
    title(['PSD of the area ',protocoloLFP.injured(i).area,' Injured ',strrep(protocoloLFP.name,'_',' ')], 'FontSize', 24)

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
    plot(freq_psd,Spectral_pre,'LineWidth',3.0)
    hold on
    plot(freq_psd,Spectral_on,'LineWidth',3.0)
    hold on
    plot(freq_psd,Spectral_post,'LineWidth',3.0)
    xlim([1 100])
    ylim([-5 5])
    grid on
    set(gca,'fontsize',20)
    lgd = legend('pre-stim', 'on-stim', 'post-stim');
    lgd.FontSize = 20;
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Power [dB]', 'FontSize', 24)
    title(['PSD of the area ',protocoloLFP.uninjured(i).area,' Uninjured ',strrep(protocoloLFP.name,'_',' ')], 'FontSize', 24)
    
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

        fig_7 = figure('units','normalized','outerposition',[0 0 1 1]);
        plot(f,Coherency_pre_mean,'LineWidth',2.0)
        hold on
        plot(f,Coherency_on_mean,'LineWidth',2.0)
        plot(f,Coherency_post_mean,'LineWidth',2.0)
        grid on
        xlim([0 100])
        ylim([0.3 0.9])
        set(gca,'fontsize',20)
        ylabel('Mean Coherence', 'FontSize', 24)
        xlabel('Frequency [Hz]', 'FontSize', 24)
        lgd = legend('pre','on','post');
        lgd.FontSize = 20;
        title(['Mean Coherence in beta between ', protocoloLFP.injured(i).area, ' vs ', protocoloLFP.injured(j).area, ' Injured'], 'FontSize', 24)
                
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

        fig_8 = figure('units','normalized','outerposition',[0 0 1 1]);
        plot(f,Coherency_pre_mean,'LineWidth',2.0)
        hold on
        plot(f,Coherency_on_mean,'LineWidth',2.0)
        plot(f,Coherency_post_mean,'LineWidth',2.0)
        grid on
        xlim([0 100]) 
        ylim([0.3 0.9])
        set(gca,'fontsize',20)
        ylabel('Mean Coherence', 'FontSize', 24)
        xlabel('Frecuencia [Hz]', 'FontSize', 24)
        lgd = legend('pre','on','post');        
        lgd.FontSize = 20;
        title(['Mean Coherence in beta between ', protocoloLFP.uninjured(i).area, ' vs ', protocoloLFP.uninjured(j).area, ' Uninjured'], 'FontSize', 24)
                
        % Guardar imagen de la figura
        name_fig = ['Mean_Coherence_in_beta_between_', protocoloLFP.injured(i).area, '_vs_', protocoloLFP.injured(j).area, '_Uninjured_',strrep(protocoloLFP.name,' ','_')];
        folder_name_save = [inicio_foldername,'Imagenes',slash_system, strrep(strrep(protocoloLFP.name,' ',''),'control','control '), slash_system,'Imagenes Protocolo',slash_system,name_fig];
        saveas(fig_8,folder_name_save,'png');
        saveas(fig_8,folder_name_save,'fig');
        close(fig_8)

    end
    
    p=p+1;
    
end


