%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Spectral_Area.m
fprintf('\nAnalisis Espectral por Area\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.analysis_stages.referencing || ~registroLFP.analysis_stages.delete_channel
    error('Falta el bloque de eliminacion de canales y referenciacion');
    
end

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
    
    % Cargar datos de un area
    Data_ref = registroLFP.area(m).data;
    
    % Multitaper estimation para el spectrograma
    [Spectrogram_mean,t_Spectrogram_mean,f_Spectrogram_mean] = mtspecgramc(Data_ref,[registroLFP.multitaper.spectrogram.movingwin.window registroLFP.multitaper.spectrogram.movingwin.winstep],registroLFP.multitaper.spectrogram.params);
    Spectrogram_mean_raw = Spectrogram_mean; 
    
    % Resize frecuencia para obtener bines de 0.5 Hz
    f_Spectrogram_mean = imresize(f_Spectrogram_mean,[1,200]);
    Spectrogram_mean = imresize(Spectrogram_mean, [length(t_Spectrogram_mean), 200]);
    Spectrogram_mean_raw = imresize(Spectrogram_mean_raw, [length(t_Spectrogram_mean), 200]);
    
    [~,ind_max] = max(Spectrogram_mean,[],2); % Indice de los maximos en cada bin de tiempo
    frec_ind_max = f_Spectrogram_mean(ind_max); % Frecuencia de los maximos en cada bin de tiempo
    idx_spect_artifacts = ~((frec_ind_max > 100-5) & (frec_ind_max < 100+5)); % Se ignoran los indices que estan cerca de la frecuencia del seno, ignora algunos bin de tiempo
    idx_spect_artifacts = find(~idx_spect_artifacts)';
    
    % Indices de cada etapa
    idx_pre = find(t_Spectrogram_mean<(pre_m*60.0-5));
    idx_on = find(t_Spectrogram_mean>(on_inicio_m*60.0+5) & t_Spectrogram_mean<(on_final_m*60.0-5));
    idx_post = find(t_Spectrogram_mean>(post_m*60.0+5) & t_Spectrogram_mean<(tiempo_total*60));
    
    % Se le quita el ruido rosa, dejando mas plano el espectro
    %%Spectrogram_mean = pink_noise_del(f_Spectrogram_mean, Spectrogram_mean, idx_spect_artifacts); 
    
    % Nuevo Pink Noise
    [pow_dBpink, fitStats, pow_pinknoise] = convert_to_dBpink(f_Spectrogram_mean, Spectrogram_mean', [0 15;30 100]);
    Spectrogram_mean = pow_dBpink';

    %pow_pinknoise_pre = pow_pinknoise(:,idx_pre(~ismember(idx_pre, idx_spect_artifacts)))';
    %pow_pinknoise_on = pow_pinknoise(:,idx_on(~ismember(idx_on, idx_spect_artifacts)))';
    %pow_pinknoise_post = pow_pinknoise(:,idx_post(~ismember(idx_post, idx_spect_artifacts)))';
    
    %Spectrogram_mean = Spectrogram_mean - ones(size(Spectrogram_mean))*diag(median(real(pow_pinknoise_pre)));
    %Spectrogram_mean(idx_spect_artifacts,:) = db(Spectrogram_mean_raw(idx_spect_artifacts,:),'power');
    
    % dB Spect
    %%Spectrogram_mean = db(Spectrogram_mean','power')';
    
    % Separacion por etapas el espectrograma  
    Spectrogram_pre_mean = Spectrogram_mean(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
    Spectrogram_on_mean = Spectrogram_mean(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
    Spectrogram_post_mean = Spectrogram_mean(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);
    
    % PSD sin normalizar por la frecuencia de la fase pre (No contar los valores cercanos a la sinusoidal)
    Spectral_pre_mean = mean(Spectrogram_pre_mean,1);
    Spectral_on_mean = mean(Spectrogram_on_mean,1);
    Spectral_post_mean = mean(Spectrogram_post_mean,1);
    
    % Spectrograma final 
    Mean_Spectrogram_pre_mean = median(Spectrogram_pre_mean,1);
    %%Desv_Spectrogram_pre_mean = std(Spectrogram_pre_mean,1);
    quantil_pre = quantile(Spectrogram_pre_mean,[.025 .25 .50 .75 .975]);
    Desv_Spectrogram_pre_mean = quantil_pre(3,:) - quantil_pre(2,:);
    
    Spectrogram_mean = (Spectrogram_mean-ones(size(Spectrogram_mean))*diag(Mean_Spectrogram_pre_mean))./(ones(size(Spectrogram_mean))*diag(Desv_Spectrogram_pre_mean));
    
    % Almacenamiento de los analisis
    % Datos de los especterogramas promedio
    registroLFP.average_spectrum(m).area = C{m};
    registroLFP.average_spectrum(m).spectrogram.data_raw = Spectrogram_mean_raw;
    registroLFP.average_spectrum(m).spectrogram.data = Spectrogram_mean;    
    registroLFP.average_spectrum(m).spectrogram.time = t_Spectrogram_mean;
    registroLFP.average_spectrum(m).spectrogram.frequency = f_Spectrogram_mean; 
    registroLFP.average_spectrum(m).spectrogram.ind_artifacts = idx_spect_artifacts; 

    % Datos de los PSD promedio
    registroLFP.average_spectrum(m).psd.pre.data = Spectral_pre_mean;
    registroLFP.average_spectrum(m).psd.on.data = Spectral_on_mean;
    registroLFP.average_spectrum(m).psd.post.data = Spectral_post_mean;   
        
end

registroLFP.analysis_stages.spectral_area = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP path name_registro foldername inicio_foldername

