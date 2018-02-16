%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Extract_LFP.m
fprintf('\nExtraerLFP\n')
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extraer lfp de los registros de cada canal
if ~registroLFP.analysis_stages.initialization
   error('Falta el bloque de inicializacion') 
end

% Prefijo de los archivos dentro de la ruta, obtiene todos los canales, los
% que se quieren evaluar y los que no
dir_signals = dir([path,'10*_CH*.continuous']);

% Listado de los nombre de los archivos de los LFP
dir_signals = char(natsortfiles({dir_signals.name})); % Ordena los nombres de los archivos correctamente

% Nombre del archivo donde esta el registro de los canales que se desean
ruta_regEval = dir_signals(eval_channels(1),:);
disp(ruta_regEval)

% Obtener la informacion del primer archivo
[data, registroLFP.open_ephys.timestamps, registroLFP.open_ephys.info] = load_open_ephys_data_faster(strtrim([path,ruta_regEval]));

% Tasa de muestreo de los registros
sampleRate = registroLFP.open_ephys.info.header.sampleRate;

% Disenno del filtro pasa banda
%d = fdesign.bandpass('N,F3dB1,F3dB2',registroLFP.filter_param.n,registroLFP.filter_param.fc1,registroLFP.filter_param.fc2,sampleRate);
%Hd = design(d,'butter'); 
Hd_low = designfilt(registroLFP.filter_param.type,'FilterOrder',registroLFP.filter_param.n, ...
'HalfPowerFrequency',registroLFP.filter_param.fc,'DesignMethod',registroLFP.filter_param.design_method,'SampleRate',sampleRate);
%Hd = designfilt('bandpassiir','FilterOrder',20, ...
%         'HalfPowerFrequency1',0.1,'HalfPowerFrequency2',150, ...
%         'SampleRate',sampleRate);

% Filtrado del primer LFP
%data_filt = filter(Hd,data);
data_filt = filtfilt(Hd_low,data);

% Downsamplear el primer LFP para llevar los registros a la tasa de muestro requerida
data_downS = downsample(data_filt,sampleRate/registroLFP.desired_fs);

% Filtro pasa alto despues de downsamplin debido a la baja Fc
Hd_high = designfilt('highpassiir','FilterOrder',15, ...
'HalfPowerFrequency',0.1,'DesignMethod','butter','SampleRate',1000);

data_downS_filtHigh = filtfilt(Hd_high,data_downS);

% Tiempo maximo de registro
time_max_reg_seg = length(data)/sampleRate;
registroLFP.times.total_recorded_m = time_max_reg_seg/60.0;

% Tiempo total en minutos de lo registrado
time_step_m = linspace(0,time_max_reg_seg/60,length(data_downS_filtHigh)); % minutos

% Intervalo de tiempo total del protocolo
time_step_m_tiempoTotal = time_step_m(time_step_m >= registroLFP.times.extra_time_s/60 & time_step_m <= registroLFP.times.end_m+registroLFP.times.extra_time_s/60) - registroLFP.times.extra_time_s/60;
registroLFP.times.steps_m = time_step_m_tiempoTotal;

% Eliminar los datos del primer LFP sobre los 960 segundos
data_elim_maxTime = data_downS_filtHigh((time_step_m >= registroLFP.times.extra_time_s/60 & time_step_m <= registroLFP.times.end_m+registroLFP.times.extra_time_s/60)); % Si se eliminan los primeros segundos, es como si inicial fuese cero, por lo que cambian los limites de las barras de las fases

% Calcular el umbral
umbral = registroLFP.amp_threshold * median(sort(abs(data_elim_maxTime)))/0.675;

% Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
Fc = registroLFP.frec_sin_artifacts;      % hertz Freq: 110Hz
[~, ind_fueraUmbral] = rmArtifacts_threshold(data_elim_maxTime, umbral, Fc);
    
% Almacenamiento de los LFP en la estructura
% Datos filtrados, downsampleados, acortados y estandarizados con zscore de los datos bajo el umbral 
registroLFP.channel(eval_channels(1)).data_raw = zscore_noartifacted(data_elim_maxTime, ind_fueraUmbral); %data_elim_maxTime;

tic;
for i = 2:length(eval_channels) 

    % Nombre del archivo donde esta el registro
    ruta_regEval = dir_signals(eval_channels(i),:);
    disp(ruta_regEval)
    
    % Obtener la informacion del archivo "i"
    [data, ~, ~] = load_open_ephys_data_faster(strtrim([path,ruta_regEval]));
    
    % Filtrado del LFP "i"
    %data_filt = filter(Hd,data);
    data_filt = filtfilt(Hd_low,data);
    
    % Downsamplear el LFP "i" para llevar los registros a la tasa de muestro requerida
    data_downS = downsample(data_filt,sampleRate/registroLFP.desired_fs);
    
    % Filtro pasa alto despues de downsamplin debido a la baja Fc
    data_downS_filtHigh = filtfilt(Hd_high,data_downS);

    % Eliminar los datos del LFP "i" sobre los 960 segundos
    data_elim_maxTime = data_downS_filtHigh((time_step_m >= registroLFP.times.extra_time_s/60 & time_step_m <= registroLFP.times.end_m+registroLFP.times.extra_time_s/60)); % Tal vez eliminar los primeros segundos
    
    % Calcular el umbral
    umbral = registroLFP.amp_threshold * median(sort(abs(data_elim_maxTime)))/0.675;
    
    [~, ind_fueraUmbral] = rmArtifacts_threshold(data_elim_maxTime, umbral, Fc);

     
    % Guardar los datos filtrados, downsampleados, acortados y sin artefactos
    % Almacenamiento de los LFP en la estructura
    % Datos filtrados, downsampleados, acortados y sin artefactos
    registroLFP.channel(eval_channels(i)).data_raw = zscore_noartifacted(data_elim_maxTime, ind_fueraUmbral); %data_elim_maxTime;
        
end
toc;

registroLFP.analysis_stages.extract_lfp = 1;

% Eliminacion de variables que no se guardaran
clearvars -except registroLFP path name_registro foldername inicio_foldername

%Hd = designfilt('lowpassiir','FilterOrder',40, ...
%'HalfPowerFrequency',150,'DesignMethod','butter','SampleRate',sampleRate);
%fvtool(Hd)

%bpFilt = designfilt('bandpassiir','FilterOrder',40, ...
%         'HalfPowerFrequency1',1,'HalfPowerFrequency2',150, ...
%         'SampleRate',30000);
%fvtool(bpFilt)

