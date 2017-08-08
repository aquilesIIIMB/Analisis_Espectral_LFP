%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Spectral_Analysis_Average_10.m
fprintf('\nAnalisis Espectral Promedio\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.stage.referencing || ~registroLFP.stage.delete_channel
    error('Falta el bloque de eliminacion de canales y referenciacion');
    
end

registroLFP.multitaper.movingwin.window = 2; % Ventanas (En segundos)
registroLFP.multitaper.movingwin.winstep = registroLFP.multitaper.movingwin.window/2; % Pasos de ventanas (segundos)
registroLFP.multitaper.params.trialave = 1; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

canales_eval = find(~[registroLFP.channel.removed]);

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

%% Calculos para el analisis del promedio de las Areas
[C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');

for m = 1:length(ia)%1:largo_dataAll  
    i = ia(m);

    areas_actuales = find(ic == ic(i));
    
    % Cargar datos de todos los registros de un area
    Data_ref = [registroLFP.channel(canales_eval(areas_actuales)).data_ref];
    
    % Eliminacion de los intervalos donde hay artefactos
    ind_over_threshold_totals = (sum([registroLFP.channel(canales_eval(areas_actuales)).ind_over_threshold],2)>0);
    Data_ref(ind_over_threshold_totals,:) = [];
    
    % Multitaper estimation para el spectrograma%%%%%%%%%%%%
    [Spectrogram_mean,t_Spectrogram_mean,f_Spectrogram_mean] = mtspecgramc(Data_ref,[registroLFP.multitaper.movingwin.window registroLFP.multitaper.movingwin.winstep],registroLFP.multitaper.params);     
    
    % Se le quita el ruido rosa, dejando mas plano el espectro
    Spectrogram_mean = pink_noise_del(f_Spectrogram_mean, Spectrogram_mean);
  
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
    Spectrogram_mean = Spectrogram_mean+abs(min(min(Spectrogram_mean)));
    
    % Almacenamiento de los analisis
    % Datos de los especterogramas promedio
    registroLFP.average_spectrum(m).area = C(m);
    registroLFP.average_spectrum(m).spectrogram.data = Spectrogram_mean;    
    registroLFP.average_spectrum(m).spectrogram.mean_spect_pre = Mean_Spectrogram_pre_mean;
    registroLFP.average_spectrum(m).spectrogram.std_spect_pre = Desv_Spectrogram_pre_mean;
    registroLFP.average_spectrum(m).spectrogram.tiempo = t_Spectrogram_mean;
    registroLFP.average_spectrum(m).spectrogram.frecuencia = f_Spectrogram_mean; 

    % Datos de los PSD promedio
    registroLFP.average_spectrum(m).psd.pre.data = Spectral_pre_mean;
    registroLFP.average_spectrum(m).psd.on.data = Spectral_on_mean;
    registroLFP.average_spectrum(m).psd.post.data = Spectral_post_mean;
    
end

registroLFP.stage.spectral_analysis_average = 1;

% Guardar matrices en .mat
path_name_registro = [inicio_foldername,'Imagenes',foldername,name_registro];

%save(path_name_registro,'registroLFP');
%save(path_name_registro,'name_registro','-append');
%save(path_name_registro,'inicio_foldername','-append');
%save(path_name_registro,'foldername','-append');

% Eliminacion de variables no utilizadas
clear Spectrogram_mean Spectral_pre_mean Spectral_on_mean Spectral_post_mean m C ia ic i
clear Mean_Spectrogram_pre_mean Desv_Spectrogram_pre_mean pre_m on_inicio_m on_final_m
clear Spectral_pre_mean Spectral_on_mean Spectral_post_mean post_m tiempo_total canales_eval largo_canales_eval
clear Data_ref areas_actuales f_Spectrogram_mean t_Spectrogram_mean 
clear Spectrogram_on_mean Spectrogram_pre_mean Spectrogram_post_mean

save(path_name_registro,'-v7.3')
