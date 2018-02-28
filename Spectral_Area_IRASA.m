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

canales_eval = find(~[registroLFP.channels.removed]);

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

%% Calculos para el analisis del promedio de las Areas
[C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');

for m = 1:length(ia) 
    i = ia(m);
    
    % Cargar datos de un area
    Data_ref = registroLFP.areas(m).data;
    
    % Multitaper estimation para el spectrograma
    irasa = irasaspecgram(Data_ref,[registroLFP.irasa.spectrogram.movingwin.window registroLFP.irasa.spectrogram.movingwin.winstep],registroLFP.irasa.spectrogram.params);
    Spectrogram_mixed_mean = irasa.mixd';
    Phase_mixed_mean = irasa.phase';
    Spectrogram_osci_mean = irasa.osci';
    Spectrogram_frac_mean = irasa.frac';
    beta_Spectrogram_mean = irasa.Beta;
    t_Spectrogram_mean = irasa.time;
    f_Spectrogram_mean = irasa.freq;
        
    % Resize frecuencia para obtener bines de 0.5 Hz
    f_Spectrogram_mean = imresize(f_Spectrogram_mean,[200, 1]);
    Spectrogram_mixed_mean = imresize(Spectrogram_mixed_mean, [length(t_Spectrogram_mean), 200]);
    Phase_mixed_mean = imresize(Phase_mixed_mean, [length(t_Spectrogram_mean), 200]);
    Spectrogram_osci_mean = imresize(Spectrogram_osci_mean, [length(t_Spectrogram_mean), 200]);
    Spectrogram_frac_mean = imresize(Spectrogram_frac_mean, [length(t_Spectrogram_mean), 200]);
    
    [~,ind_max] = max(Spectrogram_mixed_mean,[],2); % Indice de los maximos en cada bin de tiempo
    frec_ind_max = f_Spectrogram_mean(ind_max); % Frecuencia de los maximos en cada bin de tiempo
    idx_spect_artifacts = ~((frec_ind_max > 100-5) & (frec_ind_max < 110+5)); % Se ignoran los indices que estan cerca de la frecuencia del seno, ignora algunos bin de tiempo
    idx_spect_artifacts = find(~idx_spect_artifacts)';
    
    % Indices de cada etapa
    idx_pre = find(t_Spectrogram_mean<(pre_m*60.0-5));
    idx_on = find(t_Spectrogram_mean>(on_inicio_m*60.0+5) & t_Spectrogram_mean<(on_final_m*60.0-5));
    idx_post = find(t_Spectrogram_mean>(post_m*60.0+5) & t_Spectrogram_mean<(tiempo_total*60));
    
    % Separacion por etapas el espectrograma  
    Spectrogram_mixed_pre_mean = Spectrogram_mixed_mean(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
    Spectrogram_mixed_on_mean = Spectrogram_mixed_mean(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
    Spectrogram_mixed_post_mean = Spectrogram_mixed_mean(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);
    
    Spectrogram_osci_pre_mean = Spectrogram_osci_mean(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
    Spectrogram_osci_on_mean = Spectrogram_osci_mean(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
    Spectrogram_osci_post_mean = Spectrogram_osci_mean(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);
    
    Spectrogram_frac_pre_mean = Spectrogram_frac_mean(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
    Spectrogram_frac_on_mean = Spectrogram_frac_mean(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
    Spectrogram_frac_post_mean = Spectrogram_frac_mean(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);
    
    % PSD sin normalizar por la frecuencia de la fase pre (No contar los valores cercanos a la sinusoidal)
    Spectral_mixed_pre_mean = mean(Spectrogram_mixed_pre_mean,1);
    Spectral_mixed_on_mean = mean(Spectrogram_mixed_on_mean,1);
    Spectral_mixed_post_mean = mean(Spectrogram_mixed_post_mean,1);
    
    Spectral_osci_pre_mean = mean(Spectrogram_osci_pre_mean,1);
    Spectral_osci_on_mean = mean(Spectrogram_osci_on_mean,1);
    Spectral_osci_post_mean = mean(Spectrogram_osci_post_mean,1);
    
    Spectral_frac_pre_mean = mean(Spectrogram_frac_pre_mean,1);
    Spectral_frac_on_mean = mean(Spectrogram_frac_on_mean,1);
    Spectral_frac_post_mean = mean(Spectrogram_frac_post_mean,1);
    
    % Spectrograma final 
    Mean_Spectrogram_mixed_pre_mean = median(Spectrogram_mixed_pre_mean,1);
    %Desv_Spectrogram_mixed_pre_mean = std(Spectrogram_mixed_pre_mean,1);
    quantil_mixed_pre = quantile(Spectrogram_mixed_pre_mean,[.025 .25 .50 .75 .975]);
    Desv_Spectrogram_mixed_pre_mean = quantil_mixed_pre(3,:) - quantil_mixed_pre(2,:);
    
    Mean_Spectrogram_osci_pre_mean = median(Spectrogram_osci_pre_mean,1);
    %Desv_Spectrogram_osci_pre_mean = std(Spectrogram_osci_pre_mean,1);
    quantil_osci_pre = quantile(Spectrogram_osci_pre_mean,[.025 .25 .50 .75 .975]);
    Desv_Spectrogram_osci_pre_mean = quantil_osci_pre(3,:) - quantil_osci_pre(2,:);
    
    Mean_Spectrogram_frac_pre_mean = median(Spectrogram_frac_pre_mean,1);
    %Desv_Spectrogram_frac_pre_mean = std(Spectrogram_frac_pre_mean,1);
    quantil_frac_pre = quantile(Spectrogram_frac_pre_mean,[.025 .25 .50 .75 .975]);
    Desv_Spectrogram_frac_pre_mean = quantil_frac_pre(3,:) - quantil_frac_pre(2,:);
    
    %Spectrogram_osci_mean = (Spectrogram_osci_mean-ones(size(Spectrogram_osci_mean))*diag(Mean_Spectrogram_pre_mean))./(ones(size(Spectrogram_osci_mean))*diag(Desv_Spectrogram_pre_mean));
    
    % Almacenamiento de los analisis
    % Datos de los especterogramas promedio
    registroLFP.average_spectrum(m).area = C{m};    
    registroLFP.average_spectrum(m).spectrogram.mixed.mag = Spectrogram_mixed_mean;
    registroLFP.average_spectrum(m).spectrogram.mixed.phase = Phase_mixed_mean;
    registroLFP.average_spectrum(m).spectrogram.mixed.mean_mag_pre = Mean_Spectrogram_mixed_pre_mean; 
    registroLFP.average_spectrum(m).spectrogram.mixed.std_mag_pre = Desv_Spectrogram_mixed_pre_mean;  
    registroLFP.average_spectrum(m).spectrogram.oscillations.mag = Spectrogram_osci_mean;
    registroLFP.average_spectrum(m).spectrogram.oscillations.mean_mag_pre = Mean_Spectrogram_osci_pre_mean; 
    registroLFP.average_spectrum(m).spectrogram.oscillations.std_mag_pre = Desv_Spectrogram_osci_pre_mean;  
    registroLFP.average_spectrum(m).spectrogram.fractals.mag = Spectrogram_frac_mean;
    registroLFP.average_spectrum(m).spectrogram.fractals.mean_mag_pre = Mean_Spectrogram_frac_pre_mean; 
    registroLFP.average_spectrum(m).spectrogram.fractals.std_mag_pre = Desv_Spectrogram_frac_pre_mean; 
    registroLFP.average_spectrum(m).spectrogram.beta = beta_Spectrogram_mean; 
    registroLFP.average_spectrum(m).spectrogram.time = t_Spectrogram_mean;
    registroLFP.average_spectrum(m).spectrogram.frequency = f_Spectrogram_mean;  
    registroLFP.average_spectrum(m).spectrogram.ind_artifacts = idx_spect_artifacts; 
    registroLFP.average_spectrum(m).spectrogram.irasa = irasa;

    % Datos de los PSD promedio
    registroLFP.average_spectrum(m).psd.mixed.pre = Spectral_mixed_pre_mean;
    registroLFP.average_spectrum(m).psd.mixed.on = Spectral_mixed_on_mean;
    registroLFP.average_spectrum(m).psd.mixed.post = Spectral_mixed_post_mean;
    registroLFP.average_spectrum(m).psd.oscillations.pre = Spectral_osci_pre_mean;
    registroLFP.average_spectrum(m).psd.oscillations.on = Spectral_osci_on_mean;
    registroLFP.average_spectrum(m).psd.oscillations.post = Spectral_osci_post_mean;
    registroLFP.average_spectrum(m).psd.fractals.pre = Spectral_frac_pre_mean;
    registroLFP.average_spectrum(m).psd.fractals.on = Spectral_frac_on_mean;
    registroLFP.average_spectrum(m).psd.fractals.post = Spectral_frac_post_mean;
        
end

registroLFP.analysis_stages.spectral_area = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP path name_registro foldername inicio_foldername

