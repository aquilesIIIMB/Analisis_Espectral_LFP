%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AnalisisEspectral_1.m
fprintf('\nAnalisisEspectral_1\n')
fprintf('%s\n',etapa)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Spectrograma Parameters 
window= 4.1;  % Ventanas (En segundos) Probar con 2, se usa 4.1
winstep = window/2;  % Pasos de ventanas (segundos)
movingwin = ([window winstep]);

%%Spectrogram Precalculation tapers %%% Revisar estos valors
HalfTimeBandWidthProduct = 3; %TW
NumTapers       = 5; %K
params.tapers   = ([HalfTimeBandWidthProduct, NumTapers]);
                  %[TW K], (K <= to 2TW-1).

params.pad      = 2; % Cantidad de puntos multiplos de dos sobre el largo de la se�al
params.Fs       = REGISTRO.desiredSimpleRate; % Frecuencia de muestreo
params.fpass    = [1 150]; % Rango de frecuencia 
params.err      = 0; % Error considerado
params.trialave = 0; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

%% Calculo de la respuesta en frecuencia y espectrograma
for i = 1:largo_dataAll_select
    
    % Tomar el LFP del canal que se analizara. Formato samplesxCh\trials
    Data = dataAll_select_ref(:,i);
    
    % Multitaper estimation para el spectrograma
    [Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(Data,movingwin,params); 
    
    Spectrogram = pink_noise_del(f_Spectrogram, Spectrogram);
    
    % PSD del LFP
    Spectral_pre = mean(Spectrogram((t_Spectrogram<(pre_m*60.0-60)),:),1);
    Spectral_on = mean(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+60) & t_Spectrogram<(on_final_m*60.0-60),:),1);    
    Spectral_post = mean(Spectrogram(t_Spectrogram>(post_m*60.0+60) & t_Spectrogram<(tiempo_total*60),:),1);
    
    
    Spectrogram_pre = Spectrogram((t_Spectrogram<(pre_m*60.0)),:);
    Mean_Spectrogram_pre = mean(Spectrogram_pre,1);
    Desv_Spectrogram_pre = std(Spectrogram_pre,1);
    Spectrogram_pre = (Spectrogram_pre-ones(size(Spectrogram_pre))*diag(Mean_Spectrogram_pre))./(ones(size(Spectrogram_pre))*diag(Desv_Spectrogram_pre));
    
    Spectrogram_on = Spectrogram(t_Spectrogram>(on_inicio_m*60.0-30.0) & t_Spectrogram<(on_final_m*60.0+15.0),:);
    Spectrogram_on = (Spectrogram_on-ones(size(Spectrogram_on))*diag(Mean_Spectrogram_pre))./(ones(size(Spectrogram_on))*diag(Desv_Spectrogram_pre));
    
    Spectrogram_post = Spectrogram(t_Spectrogram>(post_m*60.0-15.0) & t_Spectrogram<(tiempo_total*60),:);
    Spectrogram_post = (Spectrogram_post-ones(size(Spectrogram_post))*diag(Mean_Spectrogram_pre))./(ones(size(Spectrogram_post))*diag(Desv_Spectrogram_pre));
    
    Spectrogram = [Spectrogram_pre; Spectrogram_on; Spectrogram_post];
    %Spectrogram = Spectrogram+abs(diag(min(Spectrogram,[],2))*ones(size(Spectrogram)));
    Spectrogram = Spectrogram+abs(min(min(Spectrogram)));
    
    eval(['spectrogram_',Channel_select{i},'=Spectrogram;']);
    
    eval(['spectral_pre_',Channel_select{i},'=Spectral_pre;']);
    eval(['spectral_on_',Channel_select{i},'=Spectral_on;']);
    eval(['spectral_post_',Channel_select{i},'=Spectral_post;']);
    
end

%% Graficos de la respuesta en frecuencia y espectrograma
for j = 1:largo_dataAll_select %Problemas con el de CH50 hay NAN
    
    % Cargar los datos que se mostraran
    eval(['Spectrogram=spectrogram_',Channel_select{j},';']);
    
    eval(['Spectral_pre=spectral_pre_',Channel_select{j},';']);
    eval(['Spectral_on=spectral_on_',Channel_select{j},';']);
    eval(['Spectral_post=spectral_post_',Channel_select{j},';']);
    
    %-------------------Plot---Sectral Frequency---------------------------
    fig_7 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(f_Spectrogram,Spectral_pre)
    hold on
    semilogy(f_Spectrogram,Spectral_on)    
    hold on
    semilogy(f_Spectrogram,Spectral_post)
    xlim(params.fpass)
    legend('pre-stim', 'on-stim', 'post-stim')
    xlabel('Frecuencia [Hz]'); ylabel('Amplitud (dB)');
    title(['Respuesta en Frecuencia Multitaper del ',Area_select{j},' LFP ',Channel_select{j}])
    name_figure_save = [inicio_foldername,'Imagenes',foldername,' PSD del ',Area_select{j},' LFP ',Channel_select{j}];
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
    ylim(params.fpass)
    c=colorbar('southoutside');
    caxis([-10, 10]); %([-20, 15]) [-15, 20]
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',1.75,'Marker','.','LineStyle',':');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',1.75,'Marker','.','LineStyle',':');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    title(['Espectrograma Multitaper del ',Area_select{j},' LFP ',Channel_select{j}])
    ylabel(c,'Power (dB)')
    name_figure_save = [inicio_foldername,'Imagenes',foldername,' Espectrograma Multitaper del ',Area_select{j},' LFP ',Channel_select{j}];
    saveas(fig_8,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_8)
end

etapa = 'seleccion';
save(path_name_registro,'etapa','largo_dataAll','canales_eval','-append');
save(path_name_registro,'Channel','Area','tipo_de_referencia','-append');
save(path_name_registro,'pre_m','on_inicio_m','on_final_m','post_m','-append');
save(path_name_registro,'tiempo_total','name_registro','tipo_de_referencia','-append');
save(path_name_registro,'inicio_new_dir1','inicio_new_dir2','-append');

