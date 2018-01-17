%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Spectral_Analysis_Average.m
fprintf('\nAnalisis Espectral Promedio\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.stage.referencing || ~registroLFP.stage.delete_channel
    error('Falta el bloque de eliminacion de canales y referenciacion');
    
end

registroLFP.multitaper.movingwin.window = 1; % Ventanas (En segundos)
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
    Data_ref = [registroLFP.channel(canales_eval(areas_actuales)).data];
    
    % Ponderacion de las señales del area segun sus zonas de no artefacto
    Frec_sin = registroLFP.frec_sin_artifacts;    % hertz Freq: 120Hz
    ind_over_threshold_totals = ~[registroLFP.channel(canales_eval(areas_actuales)).ind_over_threshold];
    Data_ref_sum = sum(Data_ref.*ind_over_threshold_totals,2);
    count_total = sum(ind_over_threshold_totals,2);
    indices_cero = find(count_total == 0);
    count_total(indices_cero) = 1;
    Data_ref_sum = replacing_values(Data_ref_sum, indices_cero, Frec_sin);
    Data_ref_pond = Data_ref_sum./count_total;
    
    % Multitaper estimation para el spectrograma
    [Spectrogram_mean,t_Spectrogram_mean,f_Spectrogram_mean] = mtspecgramc(Data_ref_pond,[registroLFP.multitaper.movingwin.window registroLFP.multitaper.movingwin.winstep],registroLFP.multitaper.params);     
    Spectrogram_mean_raw = Spectrogram_mean; 
    
    % Se le quita el ruido rosa, dejando mas plano el espectro
    Spectrogram_mean = pink_noise_del(f_Spectrogram_mean, Spectrogram_mean); 
    
    % Separacion por etapas el espectrograma    
    Spectrogram_pre_mean = Spectrogram_mean((t_Spectrogram_mean<(pre_m*60.0-30)),:);
    [~,ind_max] = max(Spectrogram_pre_mean,[],2); % Indice de los maximos en cada bin de tiempo
    frec_ind_max = f_Spectrogram_mean(ind_max); % Frecuencia de los maximos en cada bin de tiempo
    ind_noartefactos_Spec_pre = ~((frec_ind_max > Frec_sin-5) & (frec_ind_max < Frec_sin+5)); % Se ignoran los indices que estan cerca de la frecuencia del seno, ignora algunos bin de tiempo
    
    Spectrogram_on_mean = Spectrogram_mean(t_Spectrogram_mean>(on_inicio_m*60.0+30) & t_Spectrogram_mean<(on_final_m*60.0-30),:);
    [~,ind_max] = max(Spectrogram_on_mean,[],2);
    frec_ind_max = f_Spectrogram_mean(ind_max);
    ind_noartefactos_Spec_on = ~((frec_ind_max > Frec_sin-5) & (frec_ind_max < Frec_sin+5));  
    
    Spectrogram_post_mean = Spectrogram_mean(t_Spectrogram_mean>(post_m*60.0+30) & t_Spectrogram_mean<(tiempo_total*60),:);
    [~,ind_max] = max(Spectrogram_post_mean,[],2);
    frec_ind_max = f_Spectrogram_mean(ind_max);
    ind_noartefactos_Spec_post = ~((frec_ind_max > Frec_sin-5) & (frec_ind_max < Frec_sin+5));  
    
    % PSD sin normalizar por la frecuencia de la fase pre (No contar los valores cercanos a la sinusoidal)
    Spectral_pre_mean = median(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:),1);
    Spectral_on_mean = median(Spectrogram_on_mean(ind_noartefactos_Spec_on,:),1);
    Spectral_post_mean = median(Spectrogram_post_mean(ind_noartefactos_Spec_post,:),1);

    % Spectrograma final %%%%%%%%%%% Ver si mean es mejor q median para normalizar (probar) preguntarle a rodrigo 
    %Spectrogram_pre_mean = Spectrogram_mean((t_Spectrogram_mean<(pre_m*60.0)),:);
    Mean_Spectrogram_pre_mean = median(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:),1);
    %Desv_Spectrogram_pre_mean = std(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:),1);
    quantil_pre = quantile(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:),[.05 .25 .50 .75 .95]);
    Desv_Spectrogram_pre_mean = quantil_pre(3,:) - quantil_pre(2,:);
    
    Spectrogram_mean = (Spectrogram_mean-ones(size(Spectrogram_mean))*diag(Mean_Spectrogram_pre_mean))./(ones(size(Spectrogram_mean))*diag(Desv_Spectrogram_pre_mean));
    Spectrogram_mean = Spectrogram_mean+abs(min(min(Spectrogram_mean)));
    
    % Almacenamiento de los analisis
    % Datos de los especterogramas promedio
    registroLFP.average_spectrum(m).area = C(m);
    registroLFP.average_spectrum(m).spectrogram.data_raw = Spectrogram_mean_raw;
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
%save(path_name_registro,'foldername','-append');

% Eliminacion de variables no utilizadas
clear Spectrogram_mean Spectral_pre_mean Spectral_on_mean Spectral_post_mean m C ia ic i
clear Mean_Spectrogram_pre_mean Desv_Spectrogram_pre_mean pre_m on_inicio_m on_final_m
clear Spectral_pre_mean Spectral_on_mean Spectral_post_mean post_m tiempo_total canales_eval largo_canales_eval
clear Data_ref areas_actuales f_Spectrogram_mean t_Spectrogram_mean 
clear Spectrogram_on_mean Spectrogram_pre_mean Spectrogram_post_mean
clear Data_ref_pond Data_ref_sum frec_ind_max new_on_final_m new_post_m
clear count_total total_time_noartifacted ind_over_threshold_totals
clear ind_max ind_noartefactos_Spec_on ind_noartefactos_Spec_post ind_noartefactos_Spec_pre
clear indices_cero Frec_sin Fc 


% Descomentar
%save(path_name_registro,'-v7.3')

