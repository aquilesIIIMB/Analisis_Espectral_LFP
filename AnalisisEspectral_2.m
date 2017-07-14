%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AnalisisEspectral_3.m
fprintf('\nAnalisisEspectral_3\n')
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Spectrograma Parameters 
window= 2;  % Ventanas (En segundos) Probar con 2, se usa 4.1!!
winstep = window/2;  % Pasos de ventanas (segundos)
movingwin = ([window winstep]);

%%Spectrogram Precalculation tapers %%% Revisar estos valors
HalfTimeBandWidthProduct = 3; %TW
NumTapers       = 5; %K
params.tapers   = ([HalfTimeBandWidthProduct, NumTapers]);
                  %[TW K], (K <= to 2TW-1).

params.pad      = 5; % Cantidad de puntos multiplos de dos sobre el largo de la se�al
params.Fs       = desiredSimpleRate; % Frecuencia de muestreo
params.fpass    = [1 150]; % Rango de frecuencia 
params.err      = 0; % Error considerado
params.trialave = 1; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

%% Calculos para el analisis del promedio de las Areas
[C,ia,ic] = unique(Area_select,'stable');

for m = 1:length(ia)%1:largo_dataAll  
    i = ia(m);
    % pasar con un boton
    areas_actuales = find(ic == ic(i));
    
    % Cargar datos de todos los registros de un area
    Data_for_Spect = dataAll_select_ref(:,areas_actuales);
    
    % Cargar los valores de los rangos analizados en el PSD
    %eval(['rango_preStim_sinArtefactos = rango_preStim_sinArtefactos_',C{ic(i)},';']);
    %eval(['rango_onStim_sinArtefactos = rango_onStim_sinArtefactos_',C{ic(i)},';']);
    %eval(['rango_postStim_sinArtefactos = rango_postStim_sinArtefactos_',C{ic(i)},';']);
    
    % Multitaper estimation para el spectrograma%%%%%%%%%%%%
    [Spectrogram_mean,t_Spectrogram_mean,f_Spectrogram_mean]= mtspecgramc(Data_for_Spect,movingwin,params);  

    Spectrogram_mean = pink_noise_del(f_Spectrogram_mean, Spectrogram_mean);

    % PSD del LFP
    % Para eliminar artefactos
    %Spectral_pre_mean = mean(Spectrogram_mean(t_Spectrogram_mean>(rango_preStim_sinArtefactos(1)*60.0) & t_Spectrogram_mean<(rango_preStim_sinArtefactos(2)*60.0),:),1);
    %Spectral_on_mean = mean(Spectrogram_mean(t_Spectrogram_mean>(rango_onStim_sinArtefactos(1)*60.0) & t_Spectrogram_mean<(rango_onStim_sinArtefactos(2)*60.0),:),1);
    %Spectral_post_mean = mean(Spectrogram_mean(t_Spectrogram_mean>(rango_postStim_sinArtefactos(1)*60.0) & t_Spectrogram_mean<(rango_postStim_sinArtefactos(2)*60.0),:),1);
    
    % Sin eliminar artefactos
    Spectral_pre_mean = mean(Spectrogram_mean((t_Spectrogram_mean<(pre_m*60.0-60)),:),1);
    Spectral_on_mean = mean(Spectrogram_mean(t_Spectrogram_mean>(on_inicio_m*60.0+60) & t_Spectrogram_mean<(on_final_m*60.0-60),:),1);
    Spectral_post_mean = mean(Spectrogram_mean(t_Spectrogram_mean>(post_m*60.0+60) & t_Spectrogram_mean<(tiempo_total*60),:),1);

    % Spectrograma final
    Spectrogram_pre_mean = Spectrogram_mean((t_Spectrogram_mean<(pre_m*60.0)),:);
    Mean_Spectrogram_pre_mean = mean(Spectrogram_pre_mean,1);
    Desv_Spectrogram_pre_mean = std(Spectrogram_pre_mean,1);
    Spectrogram_pre_mean = (Spectrogram_pre_mean-ones(size(Spectrogram_pre_mean))*diag(Mean_Spectrogram_pre_mean))./(ones(size(Spectrogram_pre_mean))*diag(Desv_Spectrogram_pre_mean));

    Spectrogram_on_mean = Spectrogram_mean(t_Spectrogram_mean>(on_inicio_m*60.0-30.0) & t_Spectrogram_mean<(on_final_m*60.0+15.0),:);
    Spectrogram_on_mean = (Spectrogram_on_mean-ones(size(Spectrogram_on_mean))*diag(Mean_Spectrogram_pre_mean))./(ones(size(Spectrogram_on_mean))*diag(Desv_Spectrogram_pre_mean));

    Spectrogram_post_mean = Spectrogram_mean((t_Spectrogram_mean>(post_m*60.0-15.0) & t_Spectrogram_mean<(tiempo_total*60)),:);
    Spectrogram_post_mean = (Spectrogram_post_mean-ones(size(Spectrogram_post_mean))*diag(Mean_Spectrogram_pre_mean))./(ones(size(Spectrogram_post_mean))*diag(Desv_Spectrogram_pre_mean));

    Spectrogram_mean = [Spectrogram_pre_mean; Spectrogram_on_mean; Spectrogram_post_mean];
    %Spectrogram_mean = Spectrogram_mean+abs(diag(min(Spectrogram_mean,[],2))*ones(size(Spectrogram_mean)));
    Spectrogram_mean = Spectrogram_mean+abs(min(min(Spectrogram_mean)));
    
    % Almacenamiento de los analisis
    eval(['Spectral_pre_mean_',C{ic(i)},' = Spectral_pre_mean;']);
    eval(['Spectral_on_mean_',C{ic(i)},' = Spectral_on_mean;']);
    eval(['Spectral_post_mean_',C{ic(i)},' = Spectral_post_mean;']);
    
    eval(['Spectrogram_mean_',C{ic(i)},' = Spectrogram_mean;']); 
end

for m = 1:length(ia)%1:largo_dataAll  
    i = ia(m);
    
    % Cargar datos
    eval(['Spectral_pre_mean = Spectral_pre_mean_',C{ic(i)},';']);
    eval(['Spectral_on_mean = Spectral_on_mean_',C{ic(i)},';']);
    eval(['Spectral_post_mean = Spectral_post_mean_',C{ic(i)},';']);
    
    eval(['Spectrogram_mean = Spectrogram_mean_',C{ic(i)},';']); 
    
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
    name_figure_save = ['Imagenes',path(inicio_new_dir:length(path)),' PSD Promedio de los LFP ',C{ic(i)}];
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
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',1.75,'Marker','.','LineStyle',':');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',1.75,'Marker','.','LineStyle',':');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    %caxis([min(min(10*log10(Spectrogram_mean))) max(max(10*log10(Spectrogram_mean)))]); %([-20, 15]) ([-10, 20])
    title(['Espectrograma Multitaper Promedio de los LFP ',C{ic(i)}])
    ylabel(c,'Power (dB)')
    name_figure_save = ['Imagenes',path(inicio_new_dir:length(path)),' Espectrograma Multitaper Promedio de los LFP ',C{ic(i)}];
    saveas(fig_6,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_6)
    
end

%%% Mostrar canales por area
%[C,ia,ic] = unique(Area_select,'stable');

%for m = 1:length(ia)%1:largo_dataAll  
%    i = ia(m);
%    % pasar con un boton
%    areas_actuales = find(ic == ic(i));

%    for q = 1:length(areas_actuales)
%        
%        disp(C(ic(i)));
%        disp(Channel_select{areas_actuales(q)});
%    end       
%end
