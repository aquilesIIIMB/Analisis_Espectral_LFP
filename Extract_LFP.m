%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Extract_LFP.m
fprintf('\nExtraerLFP\n')
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extraer lfp de los registros de cada canal
if ~registroLFP.stage.initialization
   error('Falta el bloque de inicializacion') 
end
% Prefijo de los archivos dentro de la ruta, obtiene todos los canales, los
% que se quieren evaluar y los que no
dir_signals = dir([path,'10*_CH*.continuous']);

% Listado de los nombre de los archivos de los LFP
dir_signals = char(natsortfiles({dir_signals.name})); % Ordena los nombres de los archivos correctamente

% Nombre del archivo donde esta el registro de los canales que se desean
ruta_regEval = dir_signals(canales_eval(1),:);
disp(ruta_regEval)

% Obtener la informacion del primer archivo
[data, registroLFP.open_ephys.timestamps, registroLFP.open_ephys.info] = load_open_ephys_data_faster(strtrim([path,ruta_regEval]));

% Tasa de muestreo de los registros
sampleRate = registroLFP.open_ephys.info.header.sampleRate;

% Disenno del filtro pasa banda
%d = fdesign.bandpass('N,F3dB1,F3dB2',registroLFP.filter_param.n,registroLFP.filter_param.fc1,registroLFP.filter_param.fc2,sampleRate);
%Hd = design(d,'butter'); 
Hd = designfilt(registroLFP.filter_param.type,'FilterOrder',registroLFP.filter_param.n, ...
'HalfPowerFrequency',registroLFP.filter_param.fc,'DesignMethod',registroLFP.filter_param.design_method,'SampleRate',sampleRate);

% Filtrado del primer LFP
%data_filt = filter(Hd,data);
data_filt = filtfilt(Hd,data);

% Downsamplear el primer LFP para llevar los registros a la tasa de muestro requerida
data_downS = downsample(data_filt,sampleRate/registroLFP.desired_fs);

% Invertir de izquerda a derecha el registro ?
%data_downS = flipud(data_downS);

% TTL
%a = load_open_ephys_data_faster('C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\+2500\arturo_2017-06-09_15-24-39\100_ADC8.continuous');
%b = filter(Hd,a);
%b_downS = downsample(b,sampleRate/registroLFP.desired_fs);
%t_downS = linspace(0,(length(b_downS)/1000)/60.0,length(b_downS));
%plot(t_downS,b_downS)

% Tiempo maximo de registro
time_max_reg_seg = length(data)/sampleRate;
registroLFP.times.total_recorded_m = time_max_reg_seg/60.0;

% Tiempo total en minutos de lo registrado
time_step_m = linspace(0,time_max_reg_seg/60,length(data_downS)); % minutos

% Intervalo de tiempo total del protocolo
time_step_m_tiempoTotal = time_step_m(time_step_m >= registroLFP.times.extra_time_s/60 & time_step_m <= registroLFP.times.end_m+registroLFP.times.extra_time_s/60) - registroLFP.times.extra_time_s/60;
registroLFP.times.steps_m = time_step_m_tiempoTotal;

% Eliminar los datos del primer LFP sobre los 960 segundos
data_elim_maxTime = data_downS((time_step_m >= registroLFP.times.extra_time_s/60 & time_step_m <= registroLFP.times.end_m+registroLFP.times.extra_time_s/60)); % Si se eliminan los primeros segundos, es como si inicial fuese cero, por lo que cambian los limites de las barras de las fases
    
% Almacenamiento de los LFP en la estructura
% Datos filtrados, downsampleados, acortados y sin artefactos
registroLFP.channel(canales_eval(1)).data_raw = data_elim_maxTime;

tic;
for i = 2:length(canales_eval) 

    % Nombre del archivo donde esta el registro
    ruta_regEval = dir_signals(canales_eval(i),:);
    disp(ruta_regEval)
    
    % Obtener la informacion del archivo "i"
    [data, ~, ~] = load_open_ephys_data_faster(strtrim([path,ruta_regEval]));
    
    % Filtrado del LFP "i"
    %data_filt = filter(Hd,data);
    data_filt = filtfilt(Hd,data);
    
    % Downsamplear el LFP "i" para llevar los registros a la tasa de muestro requerida
    data_downS = downsample(data_filt,sampleRate/registroLFP.desired_fs);
    
    % Eliminar los datos del LFP "i" sobre los 960 segundos
    data_elim_maxTime = data_downS((time_step_m >= registroLFP.times.extra_time_s/60 & time_step_m <= registroLFP.times.end_m+registroLFP.times.extra_time_s/60)); % Tal vez eliminar los primeros segundos
     
    % Guardar los datos filtrados, downsampleados, acortados y sin artefactos
    % Almacenamiento de los LFP en la estructura
    % Datos filtrados, downsampleados, acortados y sin artefactos
    registroLFP.channel(canales_eval(i)).data_raw = data_elim_maxTime;
        
end
toc;

registroLFP.stage.extract_lfp = 1;

% Eliminacion de variables no utilizadas
clear data data_filt data_downS data_elim_maxTime umbral data_deartifacted
clear i d Hd k confirmacion_Param largo_dir T tinicial tipo_de_referencia
clear timeRange time_step_m time_step_m_tiempoTotal time_max_reg_seg
clear ruta_con100 ruta_regEval dir_signals channel_codes sampleRate canales_eval
clear path path_name_registro slash_backslash inicio_new_dir1 inicio_new_dir2
clear inicio_name_registro


%Hd = designfilt('lowpassiir','FilterOrder',40, ...
%'HalfPowerFrequency',150,'DesignMethod','butter','SampleRate',sampleRate);
%fvtool(Hd)

%bpFilt = designfilt('bandpassiir','FilterOrder',40, ...
%         'HalfPowerFrequency1',1,'HalfPowerFrequency2',150, ...
%         'SampleRate',30000);
%fvtool(bpFilt)

