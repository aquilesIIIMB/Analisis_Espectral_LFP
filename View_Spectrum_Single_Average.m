%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% View_Spectrum_Single_Average.m
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
tiempo_total = registroLFP.times.end_m;

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
    quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_pre = db(Spectral_pre, 'power') - db(quantil_pre(1,:), 'power');
    temp = zeros(size(neg_quintil_1_pre));
    temp(:,1:4:end) = neg_quintil_1_pre(:,1:4:end);
    neg_quintil_1_pre = temp; % Para tener los datos cada 3 partiendo de 1
    pos_quintil_5_pre = db(quantil_pre(5,:), 'power') - db(Spectral_pre, 'power');
    temp = zeros(size(pos_quintil_5_pre));
    temp(:,1:4:end) = pos_quintil_5_pre(:,1:4:end);
    pos_quintil_5_pre = temp; % Para tener los datos cada 3 partiendo de 1
    plot(f_Spectrogram, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on
    plot(f_Spectrogram, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on

    quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_on = db(Spectral_on, 'power') - db(quantil_on(1,:), 'power');
    temp = zeros(size(neg_quintil_1_on));
    temp(:,2:4:end) = neg_quintil_1_on(:,2:4:end);
    neg_quintil_1_on = temp; % Para tener los datos cada 3 partiendo de 2
    pos_quintil_5_on = db(quantil_on(5,:), 'power') - db(Spectral_on, 'power');
    temp = zeros(size(pos_quintil_5_on));
    temp(:,2:4:end) = pos_quintil_5_on(:,2:4:end);
    pos_quintil_5_on = temp; % Para tener los datos cada 3 partiendo de 2
    plot(f_Spectrogram, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on
    plot(f_Spectrogram, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on

    quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_post = db(Spectral_post, 'power') - db(quantil_post(1,:), 'power');
    temp = zeros(size(neg_quintil_1_post));
    temp(:,3:4:end) = neg_quintil_1_post(:,3:4:end);
    neg_quintil_1_post = temp; % Para tener los datos cada 3 partiendo de 2
    pos_quintil_5_post = db(quantil_post(5,:), 'power') - db(Spectral_post, 'power');
    temp = zeros(size(pos_quintil_5_post));
    temp(:,3:4:end) = pos_quintil_5_post(:,3:4:end);
    pos_quintil_5_post = temp; % Para tener los datos cada 3 partiendo de 2
    plot(f_Spectrogram, db(quantil_post(1,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
    hold on
    plot(f_Spectrogram, db(quantil_post(5,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
    hold on

    errorbar(f_Spectrogram, db(Spectral_pre, 'power'), neg_quintil_1_pre, pos_quintil_5_pre, 'Color', [0 0.4470 0.7410],'CapSize',5,'LineWidth',0.5)
    hold on
    p1 = plot(f_Spectrogram, db(Spectral_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on

    errorbar(f_Spectrogram, db(Spectral_on, 'power'), neg_quintil_1_on, pos_quintil_5_on, 'Color', [0.85, 0.325, 0.098],'CapSize',5,'LineWidth',0.5)
    hold on
    p2 = plot(f_Spectrogram, db(Spectral_on, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on

    errorbar(f_Spectrogram, db(Spectral_post, 'power'), neg_quintil_1_post, pos_quintil_5_post, 'Color', [0.929, 0.694, 0.125],'CapSize',5,'LineWidth',0.5)
    hold on
    p3 = plot(f_Spectrogram, db(Spectral_post, 'power'),'Color', [0.929, 0.694, 0.125],'LineWidth',3);
    xlim([1 100])
    legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim')
    xlabel('Frecuencia [Hz]'); ylabel('Amplitud (dB)');
    title(['Respuesta en Frecuencia Multitaper del LFP ',registroLFP.channel(canales_eval(j)).area,' ',registroLFP.channel(canales_eval(j)).name])
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channel(canales_eval(j)).area,' de ',registroLFP.channel(canales_eval(j)).name,' PSD del LFP'];
    saveas(fig_7,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_7)

    %-------------------Plot---Spectrogram------------------------------------
    fig_8 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(Spectrogram'+1,'power'),1,numel(Spectrogram)),[5 99]);
    imagesc(t_Spectrogram,f_Spectrogram,db(Spectrogram'+1,'power'),clim); colormap('jet');
    axis xy
    ylabel('Frequency (Hz)')
    xlabel('Time (sec)');
    %ylim(registroLFP.multitaper.params.fpass)
    ylim([1 100])
    c=colorbar('southoutside');
    caxis([0, 30]); %[0, 30] [-10, 10] [-20, 15] [-15, 20]
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
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
    
    t_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.tiempo;
    f_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.frecuencia; 
    
    % Separacion por etapas el espectrograma 
    Frec_sin = registroLFP.frec_sin_artifacts;    % hertz Freq: 120Hz
    
    % Se le quita el ruido rosa, dejando mas plano el espectro
    Spectrogram_mean_raw = pink_noise_del(f_Spectrogram_mean, Spectrogram_mean_raw); 
    
    Spectrogram_pre_mean = Spectrogram_mean_raw((t_Spectrogram_mean<(pre_m*60.0-30)),:);
    [~,ind_max] = max(Spectrogram_pre_mean,[],2);
    frec_ind_max = f_Spectrogram_mean(ind_max);
    ind_noartefactos_Spec_pre = ~((frec_ind_max > Frec_sin-5) & (frec_ind_max < Frec_sin+5));  % revisar esto
    
    Spectrogram_on_mean = Spectrogram_mean_raw(t_Spectrogram_mean>(on_inicio_m*60.0+30) & t_Spectrogram_mean<(on_final_m*60.0-30),:);
    [~,ind_max] = max(Spectrogram_on_mean,[],2);
    frec_ind_max = f_Spectrogram_mean(ind_max);
    ind_noartefactos_Spec_on = ~((frec_ind_max > Frec_sin-5) & (frec_ind_max < Frec_sin+5));  
    
    Spectrogram_post_mean = Spectrogram_mean_raw(t_Spectrogram_mean>(post_m*60.0+30) & t_Spectrogram_mean<(tiempo_total*60),:);
    [~,ind_max] = max(Spectrogram_post_mean,[],2);
    frec_ind_max = f_Spectrogram_mean(ind_max);
    ind_noartefactos_Spec_post = ~((frec_ind_max > Frec_sin-5) & (frec_ind_max < Frec_sin+5));  
    
    %% Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    %Spectral_pre_mean = median(Spectrogram_mean((t_Spectrogram<(pre_m*60.0-30)),:));
    quantil_pre = quantile(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_pre = db(Spectral_pre_mean, 'power') - db(quantil_pre(1,:), 'power');
    temp = zeros(size(neg_quintil_1_pre));
    temp(:,1:4:end) = neg_quintil_1_pre(:,1:4:end);
    neg_quintil_1_pre = temp; % Para tener los datos cada 3 partiendo de 1
    pos_quintil_5_pre = db(quantil_pre(5,:), 'power') - db(Spectral_pre_mean, 'power');
    temp = zeros(size(pos_quintil_5_pre));
    temp(:,1:4:end) = pos_quintil_5_pre(:,1:4:end);
    pos_quintil_5_pre = temp; % Para tener los datos cada 3 partiendo de 1
    plot(f_Spectrogram_mean, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on
    plot(f_Spectrogram_mean, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on

    %Spectral_on_mean = median(Spectrogram_mean(t_Spectrogram_mean>(on_inicio_m*60.0+30) & t_Spectrogram_mean<(on_final_m*60.0-30),:));
    quantil_on = quantile(Spectrogram_on_mean(ind_noartefactos_Spec_on,:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_on = db(Spectral_on_mean, 'power') - db(quantil_on(1,:), 'power');
    temp = zeros(size(neg_quintil_1_on));
    temp(:,2:4:end) = neg_quintil_1_on(:,2:4:end);
    neg_quintil_1_on = temp; % Para tener los datos cada 3 partiendo de 2
    pos_quintil_5_on = db(quantil_on(5,:), 'power') - db(Spectral_on_mean, 'power');
    temp = zeros(size(pos_quintil_5_on));
    temp(:,2:4:end) = pos_quintil_5_on(:,2:4:end);
    pos_quintil_5_on = temp; % Para tener los datos cada 3 partiendo de 2
    plot(f_Spectrogram_mean, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on
    plot(f_Spectrogram_mean, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on

    %Spectral_post_mean = median(Spectrogram_mean(t_Spectrogram_mean>(post_m*60.0+30) & t_Spectrogram_mean<(tiempo_total*60),:));
    quantil_post = quantile(Spectrogram_post_mean(ind_noartefactos_Spec_post,:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_post = db(Spectral_post_mean, 'power') - db(quantil_post(1,:), 'power');
    temp = zeros(size(neg_quintil_1_post));
    temp(:,3:4:end) = neg_quintil_1_post(:,3:4:end);
    neg_quintil_1_post = temp; % Para tener los datos cada 3 partiendo de 2
    pos_quintil_5_post = db(quantil_post(5,:), 'power') - db(Spectral_post_mean, 'power');
    temp = zeros(size(pos_quintil_5_post));
    temp(:,3:4:end) = pos_quintil_5_post(:,3:4:end);
    pos_quintil_5_post = temp; % Para tener los datos cada 3 partiendo de 2
    plot(f_Spectrogram_mean, db(quantil_post(1,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
    hold on
    plot(f_Spectrogram_mean, db(quantil_post(5,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
    hold on

    errorbar(f_Spectrogram_mean, db(Spectral_pre_mean, 'power'), neg_quintil_1_pre, pos_quintil_5_pre, 'Color', [0 0.4470 0.7410],'CapSize',5,'LineWidth',0.5)
    hold on
    p1 = plot(f_Spectrogram_mean, db(Spectral_pre_mean, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on

    errorbar(f_Spectrogram_mean, db(Spectral_on_mean, 'power'), neg_quintil_1_on, pos_quintil_5_on, 'Color', [0.85, 0.325, 0.098],'CapSize',5,'LineWidth',0.5)
    hold on
    p2 = plot(f_Spectrogram_mean, db(Spectral_on_mean, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on

    errorbar(f_Spectrogram_mean, db(Spectral_post_mean, 'power'), neg_quintil_1_post, pos_quintil_5_post, 'Color', [0.929, 0.694, 0.125],'CapSize',5,'LineWidth',0.5)
    hold on
    p3 = plot(f_Spectrogram_mean, db(Spectral_post_mean, 'power'),'Color', [0.929, 0.694, 0.125],'LineWidth',3);
    xlim([1 100])
    legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim')
    xlabel('Frequency (Hz)'); ylabel('Power (dB)')
    title(['Respuesta en Frecuencia Multitaper Promedio de los LFP ',C{ic(i)}])
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' PSD de los LFP '];
    saveas(fig_5,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_5)

    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_6 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(Spectrogram_mean'+1,'power'),1,numel(Spectrogram_mean)),[5 99]);
    imagesc(t_Spectrogram_mean,f_Spectrogram_mean,db(Spectrogram_mean'+1,'power'),clim); 
    min_spect = min(min(db(Spectrogram_mean'+1,'power')));
    max_spect = max(max(db(Spectrogram_mean'+1,'power')));
    dist_maxmin = max_spect - min_spect;
    cmap = colormap(jet((round(max_spect) - round(min_spect))*5));
    axis xy
    ylabel('Frequency (Hz)')
    xlabel('Time (sec)');
    ylim([1 100])
    c=colorbar('southoutside');
    alphamax = 0.3; % Cuanto se acerca el max al minimo 
    alphamin = 0; % Cuanto se acercca el minimo al maximo
    alphashift_left = 0.5; % Cuanto se corre a la izquierda los valores
    caxis([alphamin * dist_maxmin + min_spect - alphashift_left*dist_maxmin, max_spect - alphamax * dist_maxmin]); %[-10, 10] ([-20, 15]) [-15, 20]
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
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
clear c j clim C i ia ic m new_pre_m new_on_inicio_m new_on_final_m new_post_m

