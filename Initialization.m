%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Initialization.m
fprintf('\nInicializacion\n')
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear registroLFP
% Verificacion de los Parametros
fprintf('\n***Etapa de Evaluacion*** \n');
fprintf('__Parametros escogidos:\n\n');
fprintf('Ruta:\n\t%s\n', path);
pause(1)
fprintf('Codificacion de cada canal:\n\t%s\n', channel_codes);
pause(1)
% Se carga la codficiacion del canal
T = readtable(channel_codes);
fprintf('Canales Usados:\n');
fprintf('\tCanal\t\tArea\n');
for k = 1:length(canales_eval)
    fprintf('\t %s\t\t %s\n',T.Channel{(canales_eval(k))},T.Area{(canales_eval(k))});
end
pause(2)
fprintf('El tipo de referencia es:\n\t%s\n', upper(tipo_de_referencia));
pause(1)
fprintf('La amplitud del umbral de rechazo de artefactos es:\n\t%d \n', amplitud_umbral);
pause(1)
fprintf('Rangos de tiempo del experimento\n\tPre estimulacion: %d min\n\tEn estimulacion: %d min\n\tPost estimulacion: %d min\n', timeRange(1), timeRange(2), timeRange(3));
pause(1)


% Confirma que los parametros estan correctos
try
    confirmacion_Param = input('Estan todos los parametros Ok?[Press Enter]:  ','s');
catch
    error('Revisar los parametros');
end
if ~isempty(confirmacion_Param)    
    error('Revisar los parametros');
else
    fprintf('\nTODO LISTO PARA EMPEZAR LOS ANALISIS :D\n\n');
end

%% Inicializacion de la estructura
clear registroLFP
% Datos base
registroLFP.path = path;
registroLFP.name = [];
registroLFP.open_ephys = [];
registroLFP.channel_codes = channel_codes;
registroLFP.reference_type = tipo_de_referencia;
registroLFP.desired_fs = 1000;
registroLFP.frec_sin_artifacts = 120; % Frecuencia de la sinusoide que reemplaza a los artefactos
registroLFP.amp_threshold = amplitud_umbral;

% Datos de los canales
registroLFP.channel.name = [];
registroLFP.channel.area = [];
registroLFP.channel.data = [];
registroLFP.channel.data_raw = [];
registroLFP.channel.data_ref = [];
registroLFP.channel.data_noartifacted = [];
registroLFP.channel.spectrogram = [];
registroLFP.channel.psd = [];
registroLFP.channel.threshold = [];
registroLFP.channel.ind_over_threshold = [];
%registroLFP.channel.threshold_ref = [];
registroLFP.channel.removed = [];

% Datos del filtro
registroLFP.filter_param.type = 'Band pass';
registroLFP.filter_param.n = 20; % grado del filtro
registroLFP.filter_param.fc1 = 1; % 3Hz
registroLFP.filter_param.fc2 = 150; % 300Hz

% Datos de los espectrogramas promedio por area
registroLFP.average_spectrum.area = [];
registroLFP.average_spectrum.spectrogram.data = [];    
registroLFP.average_spectrum.spectrogram.mean_spect_pre = [];
registroLFP.average_spectrum.spectrogram.std_spect_pre = [];
registroLFP.average_spectrum.spectrogram.tiempo = [];
registroLFP.average_spectrum.spectrogram.frecuencia = [];  

% Datos de los PSD promedio por area
registroLFP.average_spectrum.psd.pre.data = [];
registroLFP.average_spectrum.psd.on.data = [];
registroLFP.average_spectrum.psd.post.data = [];

% Datos de cada espectrograma
registroLFP.channel.spectrogram.data = [];
%registroLFP.channel.spectrogram.mean_spect_pre = [];
%registroLFP.channel.spectrogram.std_spect_pre = [];
registroLFP.channel.spectrogram.tiempo = [];
registroLFP.channel.spectrogram.frecuencia = [];    

% Datos de cada densidad de potencial espectral
registroLFP.channel.psd.pre.data = [];
registroLFP.channel.psd.on.data = [];
registroLFP.channel.psd.post.data = [];

% Datos para el tiempo 
dir_pulse = dir([path,'10*_ADC8.continuous']);
[data, timestamps, info] = load_open_ephys_data_faster(strcat(path, dir_pulse.name));
pulse_rect = data>0;
deriv_pulse = diff(pulse_rect);
idx_change_pulse = find(deriv_pulse~=0)+1;
fin_pre = idx_change_pulse(1);
inicio_post = idx_change_pulse(end)-1;
inicio_stim = idx_change_pulse(2)-1;
fin_stim = idx_change_pulse(end-1);

time_max_reg_seg = length(data) / info.header.sampleRate;
time_step_s = linspace(0,time_max_reg_seg,length(data)); % minutos

tiempo_fin_pre = time_step_s(fin_pre);
tinicial = tiempo_fin_pre - timeRange(1)*60;
tiempo_inicio_stim_sennal = time_step_s(inicio_stim);
tiempo_fin_stim_sennal = time_step_s(fin_stim);
tiempo_inicio_post = time_step_s(inicio_post);
tiempo_fin_post = tiempo_inicio_post + timeRange(3)*60;

tiempo_inicio_stim = tiempo_fin_pre + ((tiempo_inicio_post - tiempo_fin_pre) - timeRange(2)*60) / 2;
tiempo_fin_stim = tiempo_inicio_post - ((tiempo_inicio_post - tiempo_fin_pre) - timeRange(2)*60) / 2;

%tiempos_etapas = [tinicial, tiempo_fin_pre, tiempo_inicio_stim,
%   tiempo_inicio_stim_sennal, tiempo_fin_stim_sennal, tiempo_fin_stim,
%   tiempo_inicio_post, tiempo_fin_post]; % en segundos

% Definiciones de tiempo y sus rangos de las fases
registroLFP.times.phase_range_m = timeRange;
registroLFP.times.extra_time_s = tinicial;
registroLFP.times.start_s = 0; 
registroLFP.times.pre_m = (tiempo_fin_pre - tinicial) / 60;
registroLFP.times.start_on_m = (tiempo_inicio_stim - tinicial) / 60;
registroLFP.times.end_on_m = (tiempo_fin_stim - tinicial) / 60;
registroLFP.times.post_m = (tiempo_inicio_post - tinicial) / 60;
registroLFP.times.end_m = (tiempo_fin_post - tinicial) / 60; % tiempo total del protocolo
registroLFP.times.total_recorded_m = []; % tiempo de duracion del registro
registroLFP.times.steps_m = [];

% Datos de los parametros usados para calcular los multitapers (Chronux)
registroLFP.multitaper.params.tapers = ([3 5]); % [TW K], (K <= to 2TW-1)
registroLFP.multitaper.params.pad = 2; % Cantidad de puntos multiplos de dos sobre el largo de la se�al
registroLFP.multitaper.params.Fs = registroLFP.desired_fs; % Frecuencia de muestreo
registroLFP.multitaper.params.fpass = [1 150]; % Rango de frecuencias
registroLFP.multitaper.params.err = 0; % Error considerado
registroLFP.multitaper.params.trialave = 0; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

% Datos para definir el ventaneo y avance de las ventanas en multitaper
registroLFP.multitaper.movingwin.window = 2; % Ventanas (En segundos) Probar con 2, se usa 4.1
registroLFP.multitaper.movingwin.winstep = registroLFP.multitaper.movingwin.window/2; % Pasos de ventanas (segundos)

% Identificadores de las etapas que se han hecho y las que quedan
registroLFP.stage.initialization = 1;
registroLFP.stage.extract_lfp = 0;
registroLFP.stage.view_lfp = 0;
registroLFP.stage.referencing = 0;
registroLFP.stage.spectral_analysis_single = 0;
registroLFP.stage.view_spectrum = 0;
registroLFP.stage.delete_channel = 0;
registroLFP.stage.spectral_analysis_average = 0;
 
% Asignacion de los canales y areas que se usaran
[registroLFP.channel(1:64).name] = T.Channel{:}; % Cargar los numeros de los canales
[registroLFP.channel(1:64).area] = T.Area{:}; % Carga los nombres de las areas
[registroLFP.channel(1:64).removed] = deal(1);
[registroLFP.channel(canales_eval).removed] = deal(0);

% Crear carpeta para guardar las imagnes 35:end
slash_backslash = find(path=='\' | path=='/');
inicio_new_dir1 = slash_backslash(length(slash_backslash)-3);
inicio_new_dir2 = slash_backslash(length(slash_backslash)-2);
foldername = path(inicio_new_dir2:length(path)); % /+375/arturo2_2017-06-02_12-58-57/
inicio_foldername = path(1:inicio_new_dir1); % /home/cmanalisis/Aquiles/Registros/
if ~exist(foldername, 'dir')
    mkdir([inicio_foldername,'Imagenes'],foldername);
    mkdir([inicio_foldername,'Imagenes', foldername],'LFPs');
    mkdir([inicio_foldername,'Imagenes', foldername],'Spectrograms');
end

% Definir nombre del archivo .m donde iran las matrices guardadas
inicio_name_registro = slash_backslash(length(slash_backslash)-1);
name_registro = path(inicio_name_registro+1:length(path)-1);
registroLFP.name = name_registro;


