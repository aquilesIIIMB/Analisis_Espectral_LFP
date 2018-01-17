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
    p1 = plot(f_Spectrogram, db(Spectral_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on
    p2 = plot(f_Spectrogram, db(Spectral_on, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on
    p3 = plot(f_Spectrogram, db(Spectral_post, 'power'),'Color', [0.466, 0.674, 0.188],'LineWidth',3);
    xlim([1 100])
    lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frecuencia [Hz]', 'FontSize', 24); ylabel('Amplitud (dB)', 'FontSize', 24);
    title(['Respuesta en Frecuencia Multitaper del LFP ',registroLFP.channel(canales_eval(j)).area,' ',registroLFP.channel(canales_eval(j)).name], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channel(canales_eval(j)).area,' de ',registroLFP.channel(canales_eval(j)).name,' PSD del LFP'];
    saveas(fig_7,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_7)
    
    %-------------------Plot---Sectral Frequency in Beta [8-20]Hz---------------------------
    fig_10 = figure('units','points','position',[0,0,300,600]);
    quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
    quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
    quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);
    %x=f_Spectrogram;
    %y1=db(quantil_pre(2,:), 'power');
    %y2=db(quantil_pre(4,:), 'power');
    %X=[x,fliplr(x)];                %#create continuous x value array for plotting
    %Y=[y1,fliplr(y2)];              %#create y values for out and then back
    %area_ext_pre = fill(X,Y,[0 0.4470 0.7410]);                  %#plot filled area
    %alpha(area_ext_pre, .1)
    %hold on
    %y1=db(quantil_on(2,:), 'power');
    %y2=db(quantil_on(4,:), 'power');
    %X=[x,fliplr(x)];                %#create continuous x value array for plotting
    %Y=[y1,fliplr(y2)];              %#create y values for out and then back
    %area_ext_on = fill(X,Y,[0.85, 0.325, 0.098]);                  %#plot filled area
    %alpha(area_ext_on, .2)
    %hold on
    %y1=db(quantil_post(2,:), 'power');
    %y2=db(quantil_post(4,:), 'power');
    %X=[x,fliplr(x)];                %#create continuous x value array for plotting
    %Y=[y1,fliplr(y2)];              %#create y values for out and then back
    %area_ext_post = fill(X,Y,[0.466, 0.674, 0.188]);                  %#plot filled area
    %alpha(area_ext_post, .3)
    %hold on
    plot(f_Spectrogram, db(Spectral_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3)
    hold on
    plot(f_Spectrogram, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
    hold on
    %plot(f_Spectrogram, db(quantil_pre(2,:), 'power'), '-', 'Color', [0 0.4470 0.7410],'LineWidth',1);
    %hold on
    %plot(f_Spectrogram, db(quantil_pre(4,:), 'power'), '-', 'Color', [0 0.4470 0.7410],'LineWidth',1);
    %hold on
    plot(f_Spectrogram, db(Spectral_on, 'power'), 'Color', [0.85, 0.325, 0.098],'LineWidth',3)
    hold on
    plot(f_Spectrogram, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
    hold on
    %plot(f_Spectrogram, db(quantil_on(2,:), 'power'), '-', 'Color', [0.85, 0.325, 0.098],'LineWidth',1);
    %hold on
    %plot(f_Spectrogram, db(quantil_on(4,:), 'power'), '-', 'Color', [0.85, 0.325, 0.098],'LineWidth',1);
    %hold on
    plot(f_Spectrogram, db(Spectral_post, 'power'), 'Color', [0.466, 0.674, 0.188],'LineWidth',3)
    hold on
    plot(f_Spectrogram, db(quantil_post(1,:), 'power'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram, db(quantil_post(5,:), 'power'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
    %hold on
    %plot(f_Spectrogram, db(quantil_post(2,:), 'power'), '-', 'Color', [0.466, 0.674, 0.188],'LineWidth',1);
    %hold on
    %plot(f_Spectrogram, db(quantil_post(4,:), 'power'), '-', 'Color', [0.466, 0.674, 0.188],'LineWidth',1);
    xlim([5 25])
    %lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    %lgd.FontSize = 20;
    set(gca,'fontsize',15)
    xlabel('Frecuencia [Hz]', 'FontSize', 20); %ylabel('Amplitud (dB)', 'FontSize', 24);
    title(['PSD en beta ',registroLFP.channel(canales_eval(j)).area,' ',registroLFP.channel(canales_eval(j)).name], 'FontSize', 15)
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channel(canales_eval(j)).area,' de ',registroLFP.channel(canales_eval(j)).name,' PSD en beta del LFP'];
    saveas(fig_10,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_10)

    %-------------------Plot---Spectrogram------------------------------------
    fig_8 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(Spectrogram'+1,'power'),1,numel(Spectrogram)),[5 99]);
    imagesc(t_Spectrogram,f_Spectrogram,db(Spectrogram'+1,'power'),clim); colormap('jet');
    axis xy
    ylabel('Frequency (Hz)', 'FontSize', 24)
    xlabel('Time (sec)', 'FontSize', 24)
    set(gca,'fontsize',20)
    %ylim(registroLFP.multitaper.params.fpass)
    ylim([1 100])
    c=colorbar('southoutside');
    caxis([0, 30]); %[0, 30] [-10, 10] [-20, 15] [-15, 20]
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    %set(fig_8,'fontsize',20)
    title(['Espectrograma Multitaper del LFP ',registroLFP.channel(canales_eval(j)).area,' ',registroLFP.channel(canales_eval(j)).name], 'FontSize', 24)
    ylabel(c,'Power (dB)', 'FontSize', 17)
    set(c,'fontsize',17)
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
    p1 = plot(f_Spectrogram_mean, db(Spectral_pre_mean, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on
    p2 = plot(f_Spectrogram_mean, db(Spectral_on_mean, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on
    p3 = plot(f_Spectrogram_mean, db(Spectral_post_mean, 'power'),'Color', [0.466, 0.674, 0.188],'LineWidth',3);
    xlim([1 100])
    lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency (Hz)', 'FontSize', 24); ylabel('Power (dB)', 'FontSize', 24)
    title(['Respuesta en Frecuencia Multitaper Promedio de los LFP ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' PSD de los LFP '];
    saveas(fig_5,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_5)
    
    %-------------------Plot---Sectral Frequency in Beta [8-20]Hz---------------------------
    fig_11 = figure('units','points','position',[0,0,300,600]);
    quantil_pre = quantile(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:),[.025 .25 .50 .75 .975]);
    quantil_on = quantile(Spectrogram_on_mean(ind_noartefactos_Spec_on,:),[.025 .25 .50 .75 .975]);
    quantil_post = quantile(Spectrogram_post_mean(ind_noartefactos_Spec_post,:),[.025 .25 .50 .75 .975]);
    %x=f_Spectrogram_mean;
    %y1=db(quantil_pre(1,:), 'power');
    %y2=db(quantil_pre(5,:), 'power');
    %X=[x,fliplr(x)];                %#create continuous x value array for plotting
    %Y=[y1,fliplr(y2)];              %#create y values for out and then back
    %area_ext_pre = fill(X,Y,[0 0.4470 0.7410]);                  %#plot filled area
    %alpha(area_ext_pre, .1)
    %hold on
    %y1=db(quantil_on(1,:), 'power');
    %y2=db(quantil_on(5,:), 'power');
    %X=[x,fliplr(x)];                %#create continuous x value array for plotting
    %Y=[y1,fliplr(y2)];              %#create y values for out and then back
    %area_ext_on = fill(X,Y,[0.85, 0.325, 0.098]);                  %#plot filled area
    %alpha(area_ext_on, .2)
    %hold on
    %y1=db(quantil_post(1,:), 'power');
    %y2=db(quantil_post(5,:), 'power');
    %X=[x,fliplr(x)];                %#create continuous x value array for plotting
    %Y=[y1,fliplr(y2)];              %#create y values for out and then back
    %area_ext_post = fill(X,Y,[0.466, 0.674, 0.188]);                  %#plot filled area
    %alpha(area_ext_post, .3)
    %hold on
    plot(f_Spectrogram_mean, db(Spectral_pre_mean, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3)
    hold on
    plot(f_Spectrogram_mean, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram_mean, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
    hold on
    %plot(f_Spectrogram_mean, db(quantil_pre(2,:), 'power'), '-', 'Color', [0 0.4470 0.7410],'LineWidth',1);
    %hold on
    %plot(f_Spectrogram_mean, db(quantil_pre(4,:), 'power'), '-', 'Color', [0 0.4470 0.7410],'LineWidth',1);
    %hold on
    plot(f_Spectrogram_mean, db(Spectral_on_mean, 'power'), 'Color', [0.85, 0.325, 0.098],'LineWidth',3)
    hold on
    plot(f_Spectrogram_mean, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram_mean, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
    hold on
    %plot(f_Spectrogram_mean, db(quantil_on(2,:), 'power'), '-', 'Color', [0.85, 0.325, 0.098],'LineWidth',1);
    %hold on
    %plot(f_Spectrogram_mean, db(quantil_on(4,:), 'power'), '-', 'Color', [0.85, 0.325, 0.098],'LineWidth',1);
    %hold on
    plot(f_Spectrogram_mean, db(Spectral_post_mean, 'power'), 'Color', [0.466, 0.674, 0.188],'LineWidth',3)
    hold on
    plot(f_Spectrogram_mean, db(quantil_post(1,:), 'power'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
    hold on
    plot(f_Spectrogram_mean, db(quantil_post(5,:), 'power'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
    hold on
    %plot(f_Spectrogram_mean, db(quantil_post(2,:), 'power'), '-', 'Color', [0.466, 0.674, 0.188],'LineWidth',1);
    %hold on
    %plot(f_Spectrogram_mean, db(quantil_post(4,:), 'power'), '-', 'Color', [0.466, 0.674, 0.188],'LineWidth',1);
    xlim([5 25])
    %lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    %lgd.FontSize = 20;
    set(gca,'fontsize',15)
    xlabel('Frecuencia [Hz]', 'FontSize', 20); %ylabel('Amplitud (dB)', 'FontSize', 24);
    title(['PSD en beta ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' PSD en beta de los LFP '];
    saveas(fig_11,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_11)

    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_6 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(Spectrogram_mean'+1,'power'),1,numel(Spectrogram_mean)),[5 99]);
    imagesc(t_Spectrogram_mean,f_Spectrogram_mean,db(Spectrogram_mean'+1,'power'),clim); 
    %min_spect = min(min(db(Spectrogram_mean'+1,'power')));
    %max_spect = max(max(db(Spectrogram_mean'+1,'power')));
    min_spect = min(min(db(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:)'+1,'power')));
    max_spect = max(max(db(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:)'+1,'power')));
    dist_maxmin = max_spect - min_spect;
    cmap = colormap(jet((round(max_spect) - round(min_spect))*5));
    axis xy
    ylabel('Frequency (Hz)', 'FontSize', 24)
    xlabel('Time (sec)', 'FontSize', 24)
    set(gca,'fontsize',20)
    ylim([1 100])
    c=colorbar('southoutside');
    alphamax = 0.3; % Cuanto se acerca el max al minimo 
    alphamin = 0; % Cuanto se acercca el minimo al maximo
    alphashift_left = 0.5; % Cuanto se corre a la izquierda los valores
    %caxis([alphamin * dist_maxmin + min_spect - alphashift_left*dist_maxmin, max_spect - alphamax * dist_maxmin]); %[-10, 10] ([-20, 15]) [-15, 20]
    caxis([min_spect max_spect])
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Espectrograma Multitaper Promedio de los LFP ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Power (dB)', 'FontSize', 17)
    set(c,'fontsize',17)
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

