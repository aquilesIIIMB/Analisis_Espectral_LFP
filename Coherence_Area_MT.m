%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Coherence_Area_MT.m
fprintf('\nAnalisis de Coherencia por Area\n')
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
[C,ia,ic] = unique({registroLFP.areas.name},'stable');
num_areas_izq = 0;
num_areas_der = 0;

for k = 1:length(C)
    area_actual = C{k};
    hemisferio = area_actual(end);
    if strcmp(hemisferio,'L')
        num_areas_izq = num_areas_izq + 1;
    elseif strcmp(hemisferio,'R')
        num_areas_der = num_areas_der + 1;
    end
end

% Analisis de la Coherencia en el Hemisferio Izquierdo
p = 2;
for i=1:num_areas_izq-1
    % Coherencia
    for j = num_areas_izq:-1:p
    
        signal1 = registroLFP.areas(i).data; %
        signal2 = registroLFP.areas(j).data;
        [C,phi,S12,S1,S2,t,f]=cohgramc(signal1,signal2,[registroLFP.multitaper.coherenciogram.movingwin.window registroLFP.multitaper.coherenciogram.movingwin.winstep],registroLFP.multitaper.coherenciogram.params);
        C = imresize(C, [length(t), 200]);
        phi = imresize(phi, [length(t), 200]);
        S1 = imresize(S1, [length(t), 200]);
        S2 = imresize(S2, [length(t), 200]);
        f = imresize(f,[1,200]);

        [~,ind_max] = max(S1,[],2); % Indice de los maximos en cada bin de tiempo
        frec_ind_max = f(ind_max); % Frecuencia de los maximos en cada bin de tiempo
        idx_spect_artifacts_s1 = ~((frec_ind_max > 100-5) & (frec_ind_max < 110+5)); % Se ignoran los indices que estan cerca de la frecuencia del seno, ignora algunos bin de tiempo
        idx_spect_artifacts_s1 = find(~idx_spect_artifacts_s1)';
        
        [~,ind_max] = max(S2,[],2); % Indice de los maximos en cada bin de tiempo
        frec_ind_max = f(ind_max); % Frecuencia de los maximos en cada bin de tiempo
        idx_spect_artifacts_s2 = ~((frec_ind_max > 100-5) & (frec_ind_max < 110+5)); % Se ignoran los indices que estan cerca de la frecuencia del seno, ignora algunos bin de tiempo
        idx_spect_artifacts_s2 = find(~idx_spect_artifacts_s2)';
        
        idx_spect_artifacts = unique([idx_spect_artifacts_s1, idx_spect_artifacts_s2]);

        % Indices de cada etapa
        idx_pre = find(t<(pre_m*60.0-5));
        idx_on = find(t>(on_inicio_m*60.0+5) & t<(on_final_m*60.0-5));
        idx_post = find(t>(post_m*60.0+5) & t<(tiempo_total*60));
        
        % Separacion por etapas el espectrograma  
        C_pre_mean = C(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
        C_on_mean = C(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
        C_post_mean = C(idx_post(~ismember(idx_post, idx_spect_artifacts)),:); 
        
        phi_pre_mean = phi(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
        phi_on_mean = phi(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
        phi_post_mean = phi(idx_post(~ismember(idx_post, idx_spect_artifacts)),:); 

        % PSD sin normalizar por la frecuencia de la fase pre (No contar los valores cercanos a la sinusoidal)
        Coherence_pre_mean = mean(C_pre_mean,1);
        Coherence_on_mean = mean(C_on_mean,1);
        Coherence_post_mean = mean(C_post_mean,1);
        
        Phase_pre_mean = mean(phi_pre_mean,1);
        Phase_on_mean = mean(phi_on_mean,1);
        Phase_post_mean = mean(phi_post_mean,1);
        
        % Smooth
        Coherence_pre_mean = smooth(f, Coherence_pre_mean,0.05,'rloess');
        Coherence_on_mean = smooth(f, Coherence_on_mean,0.05,'rloess');
        Coherence_post_mean = smooth(f, Coherence_post_mean,0.05,'rloess');
        
        Phase_pre_mean = smooth(f, Phase_pre_mean,0.05,'rloess');
        Phase_on_mean = smooth(f, Phase_on_mean,0.05,'rloess');
        Phase_post_mean = smooth(f, Phase_post_mean,0.05,'rloess');
       
        % Spectrograma final %%%%%%%%%%% Ver si mean es mejor q median para normalizar (probar) preguntarle a rodrigo 
        %Spectrogram_pre_mean = Spectrogram_mean((t_Spectrogram_mean<(pre_m*60.0)),:);
        Mean_C_pre = median(C_pre_mean,1);
        Desv_C_pre = std(C_pre_mean,1);
        %%quantil_pre = quantile(Spectrogram_pre_mean,[.025 .25 .50 .75 .975]);
        %%Desv_Spectrogram_pre_mean = quantil_pre(3,:) - quantil_pre(2,:);

        %C_norm = (C-ones(size(C))*diag(Mean_C_pre))./(ones(size(C))*diag(Desv_C_pre));    
                   
        % Almacenamiento de los analisis
        % Datos del coherenciograma promedio
        registroLFP.average_sync{i,j}.areas = string([{registroLFP.areas(i).name},{registroLFP.areas(j).name}]);
        registroLFP.average_sync{i,j}.coherenciogram.mag = C;  
        registroLFP.average_sync{i,j}.coherenciogram.phase = phi;
        registroLFP.average_sync{i,j}.coherenciogram.mean_mag_pre = Mean_C_pre;
        registroLFP.average_sync{i,j}.coherenciogram.std_mag_pre = Desv_C_pre;
        registroLFP.average_sync{i,j}.coherenciogram.time = t;
        registroLFP.average_sync{i,j}.coherenciogram.frequency = f; 
        registroLFP.average_sync{i,j}.coherenciogram.ind_artifacts = idx_spect_artifacts; 

        % Datos de la coherencia promedio
        registroLFP.average_sync{i,j}.coherence.pre = Coherence_pre_mean;
        registroLFP.average_sync{i,j}.coherence.on = Coherence_on_mean;
        registroLFP.average_sync{i,j}.coherence.post = Coherence_post_mean;
        
        registroLFP.average_sync{i,j}.phase.pre = Phase_pre_mean;
        registroLFP.average_sync{i,j}.phase.on = Phase_on_mean;
        registroLFP.average_sync{i,j}.phase.post = Phase_post_mean;
        

    end
    p=p+1;
end


% Analisis de la Coherencia en el Hemisferio Derecho
p = 2;
for i=1:num_areas_der-1
    % Coherencia
    for j = num_areas_der:-1:p
    
        signal1 = registroLFP.areas(i+num_areas_izq).data; %
        signal2 = registroLFP.areas(j+num_areas_izq).data;
        [C,phi,S12,S1,S2,t,f]=cohgramc(signal1,signal2,[registroLFP.multitaper.coherenciogram.movingwin.window registroLFP.multitaper.coherenciogram.movingwin.winstep],registroLFP.multitaper.coherenciogram.params);
        C = imresize(C, [length(t), 200]);
        phi = imresize(phi, [length(t), 200]);
        S1 = imresize(S1, [length(t), 200]);
        S2 = imresize(S2, [length(t), 200]);
        f = imresize(f,[1,200]);

        [~,ind_max] = max(S1,[],2); % Indice de los maximos en cada bin de tiempo
        frec_ind_max = f(ind_max); % Frecuencia de los maximos en cada bin de tiempo
        idx_spect_artifacts_s1 = ~((frec_ind_max > 100-5) & (frec_ind_max < 110+5)); % Se ignoran los indices que estan cerca de la frecuencia del seno, ignora algunos bin de tiempo
        idx_spect_artifacts_s1 = find(~idx_spect_artifacts_s1)';
        
        [~,ind_max] = max(S2,[],2); % Indice de los maximos en cada bin de tiempo
        frec_ind_max = f(ind_max); % Frecuencia de los maximos en cada bin de tiempo
        idx_spect_artifacts_s2 = ~((frec_ind_max > 100-5) & (frec_ind_max < 110+5)); % Se ignoran los indices que estan cerca de la frecuencia del seno, ignora algunos bin de tiempo
        idx_spect_artifacts_s2 = find(~idx_spect_artifacts_s2)';
        
        idx_spect_artifacts = unique([idx_spect_artifacts_s1, idx_spect_artifacts_s2]);

        % Indices de cada etapa
        idx_pre = find(t<(pre_m*60.0-5));
        idx_on = find(t>(on_inicio_m*60.0+5) & t<(on_final_m*60.0-5));
        idx_post = find(t>(post_m*60.0+5) & t<(tiempo_total*60));
        
        % Separacion por etapas el espectrograma  
        C_pre_mean = C(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
        C_on_mean = C(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
        C_post_mean = C(idx_post(~ismember(idx_post, idx_spect_artifacts)),:); 
        
        phi_pre_mean = phi(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
        phi_on_mean = phi(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
        phi_post_mean = phi(idx_post(~ismember(idx_post, idx_spect_artifacts)),:); 

        % PSD sin normalizar por la frecuencia de la fase pre (No contar los valores cercanos a la sinusoidal)
        Coherence_pre_mean = mean(C_pre_mean,1);
        Coherence_on_mean = mean(C_on_mean,1);
        Coherence_post_mean = mean(C_post_mean,1);
        
        Phase_pre_mean = mean(phi_pre_mean,1);
        Phase_on_mean = mean(phi_on_mean,1);
        Phase_post_mean = mean(phi_post_mean,1);
        
        % Smooth
        Coherence_pre_mean = smooth(f, Coherence_pre_mean,0.05,'rloess');
        Coherence_on_mean = smooth(f, Coherence_on_mean,0.05,'rloess');
        Coherence_post_mean = smooth(f, Coherence_post_mean,0.05,'rloess');
        
        Phase_pre_mean = smooth(f, Phase_pre_mean,0.05,'rloess');
        Phase_on_mean = smooth(f, Phase_on_mean,0.05,'rloess');
        Phase_post_mean = smooth(f, Phase_post_mean,0.05,'rloess');
        
        % Spectrograma final %%%%%%%%%%% Ver si mean es mejor q median para normalizar (probar) preguntarle a rodrigo 
        %Spectrogram_pre_mean = Spectrogram_mean((t_Spectrogram_mean<(pre_m*60.0)),:);
        Mean_C_pre = median(C_pre_mean,1);
        Desv_C_pre = std(C_pre_mean,1);
        %%quantil_pre = quantile(Spectrogram_pre_mean,[.025 .25 .50 .75 .975]);
        %%Desv_Spectrogram_pre_mean = quantil_pre(3,:) - quantil_pre(2,:);

        C_norm = (C-ones(size(C))*diag(Mean_C_pre))./(ones(size(C))*diag(Desv_C_pre));    
        
        % Almacenamiento de los analisis
        % Datos del coherenciograma promedio
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.areas = string([{registroLFP.areas(i+num_areas_izq).name},{registroLFP.areas(j+num_areas_izq).name}]);
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.mag = C;
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.phase = phi;
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.mean_mag_pre = Mean_C_pre;
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.std_mag_pre = Desv_C_pre;
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.time = t;
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.frequency = f; 
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.ind_artifacts = idx_spect_artifacts; 

        % Datos de la coherencia promedio
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherence.pre = Coherence_pre_mean;
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherence.on = Coherence_on_mean;
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherence.post = Coherence_post_mean;
        
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.phase.pre = Phase_pre_mean;
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.phase.on = Phase_on_mean;
        registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.phase.post = Phase_post_mean;
           
    end
    p=p+1;
end

registroLFP.analysis_stages.coherence_area = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP path name_registro foldername inicio_foldername

% Guardar matrices en .mat
path_name_registro = [inicio_foldername,'Images',foldername,name_registro];

% Descomentar para guardar
save(path_name_registro,'-v7.3')

disp(['It was saved in: ',path_name_registro])
