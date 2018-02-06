%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% View_Spectrum_Channel_Area.m
fprintf('\nVisualizacion del Espectro\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.analysis_stages.spectral_channel 
    error('Falta el bloque de analisis espectral para cada canal');
    
end

if ~registroLFP.analysis_stages.spectral_area
    fprintf('Visualizacion del espectro de cada canal\n');
    
canales_eval = find(~[registroLFP.channel.removed]);
slash_system = foldername(length(foldername));
largo_canales_eval = size(canales_eval,2);

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

%% Graficos de la respuesta en frecuencia y espectrograma
for j = 1:largo_canales_eval 
    
    % Cargar los datos que se mostraran
    Spectrogram = registroLFP.channel(canales_eval(j)).spectrogram.data;
    f_Spectrogram = registroLFP.channel(canales_eval(j)).spectrogram.frequency;
    t_Spectrogram = registroLFP.channel(canales_eval(j)).spectrogram.time;
    
    Spectral_pre = registroLFP.channel(canales_eval(j)).psd.pre.data;
    Spectral_on = registroLFP.channel(canales_eval(j)).psd.on.data;
    Spectral_post = registroLFP.channel(canales_eval(j)).psd.post.data;    
    
    %-------------------Plot---Sectral Frequency---------------------------
    fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
    p1 = plot(f_Spectrogram, db(Spectral_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on
    p2 = plot(f_Spectrogram, db(Spectral_on, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on
    p3 = plot(f_Spectrogram, db(Spectral_post, 'power'),'Color', [0.466, 0.674, 0.188],'LineWidth',3);
    xlim([1 100])
    lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Amplitude [dB]', 'FontSize', 24);
    title(['PSD multitaper of LFP ',registroLFP.channel(canales_eval(j)).name,' (',registroLFP.channel(canales_eval(j)).area, ')'], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channel(canales_eval(j)).area,' de ',registroLFP.channel(canales_eval(j)).name,' PSD del LFP'];
    saveas(fig_1,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_1)
    
    %-------------------Plot---Sectral Frequency in Beta [8-20]Hz---------------------------
    fig_3 = figure('units','points','position',[0,0,300,600]);
    quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
    quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
    quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);
    plot(f_Spectrogram, db(Spectral_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3)
    hold on
    plot(f_Spectrogram, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram, db(Spectral_on, 'power'), 'Color', [0.85, 0.325, 0.098],'LineWidth',3)
    hold on
    plot(f_Spectrogram, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram, db(Spectral_post, 'power'), 'Color', [0.466, 0.674, 0.188],'LineWidth',3)
    hold on
    plot(f_Spectrogram, db(quantil_post(1,:), 'power'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram, db(quantil_post(5,:), 'power'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
    xlim([5 25])
    set(gca,'fontsize',15)
    xlabel('Frequency [Hz]', 'FontSize', 20); %ylabel('Amplitud (dB)', 'FontSize', 24);
    title(['PSD multitaper in beta ',registroLFP.channel(canales_eval(j)).name,' (',registroLFP.channel(canales_eval(j)).area, ')'], 'FontSize', 12)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channel(canales_eval(j)).area,' de ',registroLFP.channel(canales_eval(j)).name,' PSD en beta del LFP'];
    saveas(fig_3,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_3)

    %-------------------Plot---Spectrogram------------------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(Spectrogram'+1,'power'),1,numel(Spectrogram)),[5 99]);
    imagesc(t_Spectrogram,f_Spectrogram,db(Spectrogram'+1,'power'),clim); colormap(parula(40));
    axis xy
    ylabel('Frequency [Hz]', 'FontSize', 24)
    xlabel('Time [s]', 'FontSize', 24)
    set(gca,'fontsize',20)
    ylim([1 100])
    c=colorbar('southoutside');
    caxis([0, 0.15]); %[0, 30] [-10, 10] [-20, 15] [-15, 20]
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Spectrogram multitaper of LFP ',registroLFP.channel(canales_eval(j)).name,' (',registroLFP.channel(canales_eval(j)).area, ')'], 'FontSize', 24)
    ylabel(c,'Power [dB]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channel(canales_eval(j)).area,' Espectrograma Multitaper del LFP de ',registroLFP.channel(canales_eval(j)).name];
    saveas(fig_5,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_5)

end

else
    fprintf('Visualizacion del espectro por area\n');
    
canales_eval = find(~[registroLFP.channel.removed]);
slash_system = foldername(length(foldername));

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

[C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');

%% Calculos para el analisis del promedio de las Areas
for m = 1:length(ia) 
    i = ia(m);
    
    % Cargar los datos que se mostraran
    Spectral_pre_mean = registroLFP.average_spectrum(m).psd.pre.data;
    Spectral_on_mean = registroLFP.average_spectrum(m).psd.on.data;
    Spectral_post_mean = registroLFP.average_spectrum(m).psd.post.data;
    
    Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.data;
    Spectrogram_mean_raw = registroLFP.average_spectrum(m).spectrogram.data_raw;
    
    t_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.time;
    f_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.frequency; 
    idx_spect_artifacts = registroLFP.average_spectrum(m).spectrogram.ind_artifacts;     
    
    % Indices de cada etapa
    idx_pre = find(t_Spectrogram_mean<(pre_m*60.0-5));
    idx_on = find(t_Spectrogram_mean>(on_inicio_m*60.0+5) & t_Spectrogram_mean<(on_final_m*60.0-5));
    idx_post = find(t_Spectrogram_mean>(post_m*60.0+5) & t_Spectrogram_mean<(tiempo_total*60));
    
    % PSD sin Pink Noise
    PSD_pre_mean_raw = mean(Spectrogram_mean_raw(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:),1);    
    PSD_on_mean_raw = mean(Spectrogram_mean_raw(idx_on(~ismember(idx_on, idx_spect_artifacts)),:),1);    
    PSD_post_mean_raw = mean(Spectrogram_mean_raw(idx_post(~ismember(idx_post, idx_spect_artifacts)),:),1);
    
    % Se le quita el ruido rosa, dejando mas plano el espectro
    %%[Spectrogram_mean_raw, pow_pinknoise] = pink_noise_del(f_Spectrogram_mean, Spectrogram_mean_raw, idx_spect_artifacts); 
    
    % Nuevo Pink Noise
    [pow_dBpink, fitStats, pow_pinknoise] = convert_to_dBpink(f_Spectrogram_mean, Spectrogram_mean_raw', [0 15;30 100]);
    Spectrogram_mean_raw = pow_dBpink';
    
    %pow_pinknoise_pre = pow_pinknoise(:,idx_pre(~ismember(idx_pre, idx_spect_artifacts)))';
    %pow_pinknoise_on = pow_pinknoise(:,idx_on(~ismember(idx_on, idx_spect_artifacts)))';
    %pow_pinknoise_post = pow_pinknoise(:,idx_post(~ismember(idx_post, idx_spect_artifacts)))';
    
    %Spectrogram_mean_raw_temp = Spectrogram_mean_raw - ones(size(Spectrogram_mean_raw))*diag(median(real(pow_pinknoise_pre)));
    %Spectrogram_mean_raw_temp(idx_spect_artifacts,:) = Spectrogram_mean_raw(idx_spect_artifacts,:);
    %Spectrogram_mean_raw = Spectrogram_mean_raw_temp;
    
    % dB Spect
    %%Spectrogram_mean_raw = db(Spectrogram_mean_raw','power')';
    
    % Separacion por etapas el espectrograma  
    Spectrogram_pre_mean = Spectrogram_mean_raw(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:); 
    pink_noise_pre = mean(pow_pinknoise(:,idx_pre(~ismember(idx_pre, idx_spect_artifacts)))');
    Spectrogram_on_mean = Spectrogram_mean_raw(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
    pink_noise_on = mean(pow_pinknoise(:,idx_on(~ismember(idx_on, idx_spect_artifacts)))');
    Spectrogram_post_mean = Spectrogram_mean_raw(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);
    pink_noise_post = mean(pow_pinknoise(:,idx_post(~ismember(idx_post, idx_spect_artifacts)))');
    
    %% Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
    p1 = plot(f_Spectrogram_mean, Spectral_pre_mean, 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on
    p2 = plot(f_Spectrogram_mean, Spectral_on_mean,'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on
    p3 = plot(f_Spectrogram_mean, Spectral_post_mean,'Color', [0.466, 0.674, 0.188],'LineWidth',3);
    xlim([1 100])
    ylim([-10 10])
    lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('PSD [u.a.]', 'FontSize', 24)
    title(['Mean PSD Pink Multitaper of LFPs in ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' PSD Pink de los LFP '];
    saveas(fig_2,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_2)
    
    
    fig_4 = figure('units','normalized','outerposition',[0 0 1 1]);
    p1 = plot(f_Spectrogram_mean, PSD_pre_mean_raw,'-','Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on
    plot(f_Spectrogram_mean, pink_noise_pre,'--','Color', [0 0.4470 0.7410],'LineWidth',1.5);
    hold on
    ylim([-inf max(PSD_pre_mean_raw)*1.05])
    ylabel('PSD (Pre) [Power/Hz]', 'FontSize', 24, 'Color','black')
    yyaxis right
    p2 = plot(f_Spectrogram_mean, PSD_on_mean_raw,'-','Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on
    plot(f_Spectrogram_mean, pink_noise_on,'--','Color', [0.85, 0.325, 0.098],'LineWidth',1.5);
    hold on
    p3 = plot(f_Spectrogram_mean, PSD_post_mean_raw,'-','Color', [0.466, 0.674, 0.188],'LineWidth',3);
    hold on
    plot(f_Spectrogram_mean, pink_noise_post,'--','Color', [0.466, 0.674, 0.188],'LineWidth',1.5);
    xlim([1 100])
    ylim([-inf max([max(PSD_on_mean_raw), max(PSD_post_mean_raw)])*1.3])
    lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    lgd.FontSize = 20;
    set(gca,'fontsize',20,'ycolor','black')
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('PSD (On & Post) [Power/Hz]', 'FontSize', 24, 'Color','black')
    title(['Mean PSD Multitaper of LFPs in ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' PSD de los LFP '];
    saveas(fig_4,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_4)
    
    %-------------------Plot---Sectral Frequency in Beta [8-20]Hz---------------------------
    fig_6 = figure('units','points','position',[0,0,250,600]);
    quantil_pre = quantile(Spectrogram_pre_mean,[.025 .25 .50 .75 .975]);
    quantil_on = quantile(Spectrogram_on_mean,[.025 .25 .50 .75 .975]);
    quantil_post = quantile(Spectrogram_post_mean,[.025 .25 .50 .75 .975]);
    plot(f_Spectrogram_mean, smooth(f_Spectrogram_mean, Spectral_pre_mean,0.021, 'loess'), 'Color', [0 0.4470 0.7410],'LineWidth',3)
    hold on
    plot(f_Spectrogram_mean, smooth(f_Spectrogram_mean, quantil_pre(1,:),0.02, 'loess'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram_mean, smooth(f_Spectrogram_mean, quantil_pre(5,:),0.02, 'loess'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram_mean, smooth(f_Spectrogram_mean, Spectral_on_mean,0.02, 'loess'), 'Color', [0.85, 0.325, 0.098],'LineWidth',3)
    hold on
    plot(f_Spectrogram_mean, smooth(f_Spectrogram_mean, quantil_on(1,:),0.02, 'loess'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram_mean, smooth(f_Spectrogram_mean, quantil_on(5,:),0.02, 'loess'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram_mean, smooth(f_Spectrogram_mean, Spectral_post_mean,0.02, 'loess'), 'Color', [0.466, 0.674, 0.188],'LineWidth',3)
    hold on
    plot(f_Spectrogram_mean, smooth(f_Spectrogram_mean, quantil_post(1,:),0.02, 'loess'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram_mean, smooth(f_Spectrogram_mean, quantil_post(5,:),0.02, 'loess'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
    hold on
    xlim([5 35])
    ylim([-15 15])
    set(gca,'fontsize',15)
    xlabel('Frecuencia [Hz]', 'FontSize', 20); %ylabel('Amplitud (dB)', 'FontSize', 24);
    title(['Mean PSD Pink multitaper in beta of ',C{ic(i)}], 'FontSize', 8)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' PSD Pink en beta de los LFP '];
    saveas(fig_6,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_6)

    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_8 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(Spectrogram_mean',1,numel(Spectrogram_mean)),[5 99]);
    imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_mean',clim);
    cmap = colormap(parula(40));
    axis xy
    ylabel('Frequency [Hz]', 'FontSize', 24)
    xlabel('Time [s]', 'FontSize', 24)
    set(gca,'fontsize',20)
    ylim([1 100])
    c=colorbar('southoutside');
    caxis([-1 1])
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Mean Spectrogram multitaper of LFPs in ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Normalized Power [u.a.]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Espectrograma Multitaper de los LFP '];
    saveas(fig_8,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_8)
    
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_10 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(Spectrogram_mean_raw',1,numel(Spectrogram_mean_raw)),[5 99]);
    imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_mean_raw',clim); 
    cmap = colormap(parula(40));
    axis xy
    ylabel('Frequency [Hz]', 'FontSize', 24)
    xlabel('Time [s]', 'FontSize', 24)
    set(gca,'fontsize',20)
    ylim([1 100])
    c=colorbar('southoutside');
    caxis([-3 3])
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Mean raw Spectrogram multitaper of LFPs in ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Normalized Power [u.a.]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Espectrograma en bruto Multitaper de los LFP '];
    saveas(fig_10,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_10)
    
    %-------------------Plot---Highlighted Mean Spectrogram------------------------------------
    Spectrogram_mean_raw(Spectrogram_mean_raw>3) = 3;
    Spectrogram_mean_raw(Spectrogram_mean_raw<-3) = -3;
    Spectrogram_mean(Spectrogram_mean>1) = 1;
    Spectrogram_mean(Spectrogram_mean<-1) = -1;
    Spectrogram_destacado = (Spectrogram_mean.*3+Spectrogram_mean_raw);
    
    fig_15 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(Spectrogram_destacado',1,numel(Spectrogram_destacado)),[5 99]);
    imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_destacado',clim); 
    cmap = colormap(parula(40));
    axis xy
    ylabel('Frequency [Hz]', 'FontSize', 24)
    xlabel('Time [s]', 'FontSize', 24)
    set(gca,'fontsize',20)
    ylim([1 100])
    c=colorbar('southoutside');
    caxis([-6 6])
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Mean raw Spectrogram multitaper of LFPs in ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Normalized Power [u.a.]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Espectrograma destacado Multitaper de los LFP '];
    saveas(fig_15,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_15)
end
    
end

registroLFP.analysis_stages.view_spectrum = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP path name_registro foldername inicio_foldername

