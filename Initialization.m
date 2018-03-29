%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Initialization.m
fprintf('\nInicializacion\n')
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear registroLFP % Se elimina el registro cargado en el workspace

% Como se va a referenciar cada canal
reference_type = 'area'; % 'none', 'general', 'area'
% Verificacion de los Parametros
fprintf('\n***Evaluation of parameters *** \n');
fprintf('__Chosen Parameters:\n\n');
fprintf('Path:\n\t%s\n', path);
pause(1)
fprintf('Coding of each channel:\n\t%s\n', channel_codes);
pause(1)
% Se carga la codficiacion del canal
T = readtable(channel_codes);
fprintf('Available Channels:\n');
fprintf('\tChannel\t\tArea\n');
for k = 1:length(eval_channels)
    fprintf('\t %s\t\t %s\n',T.Channel{(eval_channels(k))},T.Area{(eval_channels(k))});
end
pause(2)
fprintf('Reference type:\n\t%s\n', upper(reference_type));
pause(1)
fprintf('Threshold amplitudes to reject artifacts:\n\t%d \n', threshold_amplitudes);
pause(1)
fprintf('Experiment time ranges:\n\tPre Stimulation: %d min\n\tOn Stimulation: %d min\n\tPost Stimulation: %d min\n', timeRanges(1), timeRanges(2), timeRanges(3));
pause(1)

% Confirma que los parametros estan correctos
try
    confirmation = input('Are the parameters Ok?[Press Enter]:  ','s');
catch
    error('Check the parameters');
end
if ~isempty(confirmation)    
    error('Check the parameters');
else
    fprintf('\nEVERYTHING READY TO BEGIN THE ANALYSIS :D\n\n');
end

%% Inicializacion de la estructura
clear registroLFP
% Datos base
registroLFP.path = path;
registroLFP.name = [];
registroLFP.open_ephys = [];
registroLFP.channel_codes = channel_codes;
registroLFP.reference_type = reference_type;
registroLFP.sampleRate = []; % Tasa de muestreo de los registros
registroLFP.desired_fs = 1000;
registroLFP.freq_sin_artifacts = 110; % Frecuencia de la sinusoide que reemplaza a los artefactos
registroLFP.amp_threshold = threshold_amplitudes;

% Datos del filtro
registroLFP.filter_param(1).type = 'lowpassiir';
registroLFP.filter_param(1).design_method = 'butter'; 
registroLFP.filter_param(1).n = 15; % grado del filtro
registroLFP.filter_param(1).fc = 150; 
registroLFP.filter_param(1).fs = registroLFP.sampleRate;  
registroLFP.filter_param(2).type = 'highpassiir';
registroLFP.filter_param(2).design_method = 'butter';
registroLFP.filter_param(2).n = 15; % grado del filtro
registroLFP.filter_param(2).fc = 0.1; 
registroLFP.filter_param(2).fs = registroLFP.desired_fs; 

% Datos para el tiempo 
dir_pulse = dir([path,'10*_ADC8.continuous']);

% Si existe el ADC8 con los pulsos de estimulacion
if exist(strcat(path, dir_pulse.name),'file') && ~isempty(dir_pulse)
    [data, timestamps, info] = load_open_ephys_data_faster(strcat(path, dir_pulse.name));
    time_max_reg_seg = length(data) / info.header.sampleRate;
    time_step_s = linspace(0,time_max_reg_seg,length(data)); % minutos
        
    pulse_rect = data>0;
    deriv_pulse = diff(pulse_rect);
    idx_change_pulse = find(deriv_pulse~=0)+1;
    
    % Si los pulsos de estimulacion estan correctos
    if ~isempty(idx_change_pulse)
        
        fin_pre = idx_change_pulse(1);
        inicio_post = idx_change_pulse(end)-1;
        inicio_stim = idx_change_pulse(2)-1;
        fin_stim = idx_change_pulse(end-1);

        tiempo_fin_pre = time_step_s(fin_pre);
        tinicial = tiempo_fin_pre - timeRanges(1)*60;
        tiempo_inicio_stim_sennal = time_step_s(inicio_stim);
        tiempo_fin_stim_sennal = time_step_s(fin_stim);
        tiempo_inicio_post = time_step_s(inicio_post);
        tiempo_fin_post = tiempo_inicio_post + timeRanges(3)*60;

        tiempo_inicio_stim = tiempo_fin_pre + ((tiempo_inicio_post - tiempo_fin_pre) - timeRanges(2)*60) / 2;  % Sirve para cualqier tiempo de rampa, pero upramp y downramp deben ser igual tiempo
        tiempo_fin_stim = tiempo_inicio_post - ((tiempo_inicio_post - tiempo_fin_pre) - timeRanges(2)*60) / 2;  % Sirve para cualquier tiempo de rampa, pero upramp y downramp deben ser igual tiempo
        
        if length(idx_change_pulse) > 10
            fprintf('STIMULATION FREQUENCY!!!: %.2fHz\n\n', 1/mean(diff(time_step_s(deriv_pulse>0))))
        else
            fprintf('STIMULATION FREQUENCY!!!: Inf (DC)\n\n')
        end
        
    else
        while 1
            try
                extra_time = input('Extra time?(s):  ');
            catch
                continue;
            end

            if isnumeric(extra_time)

                tinicial = extra_time;
                tiempo_fin_pre = timeRanges(1)*60 + tinicial;
                tiempo_inicio_stim = timeRanges(1)*60 + tinicial + 30;
                tiempo_fin_stim = (timeRanges(1) + timeRanges(2))*60 + tinicial + 30;
                tiempo_inicio_post =  (timeRanges(1) + timeRanges(2))*60 + tinicial + 60;
                tiempo_fin_post = (timeRanges(1) + timeRanges(2) + timeRanges(3))*60 + tinicial + 60;
                
                break
            end
        end
        
    end
    
else
    name_ch1 = dir([path,'10*_CH1.continuous']);
    [data, timestamps, info] = load_open_ephys_data_faster(strcat(path, name_ch1.name));
    time_max_reg_seg = length(data) / info.header.sampleRate;
    time_step_s = linspace(0,time_max_reg_seg,length(data)); % minutos
      
    while 1
        try
            extra_time = input('Extra time?(s):  ');
        catch
            continue;
        end

        if isnumeric(extra_time)

            tinicial = extra_time;
            tiempo_fin_pre = timeRanges(1)*60 + tinicial;
            tiempo_inicio_stim = timeRanges(1)*60 + tinicial + 30;
            tiempo_fin_stim = (timeRanges(1) + timeRanges(2))*60 + tinicial + 30;
            tiempo_inicio_post =  (timeRanges(1) + timeRanges(2))*60 + tinicial + 60;
            tiempo_fin_post = (timeRanges(1) + timeRanges(2) + timeRanges(3))*60 + tinicial + 60;

            break
        end
    end
end
    

%tiempos_etapas = [tinicial, tiempo_fin_pre, tiempo_inicio_stim,
%   tiempo_inicio_stim_sennal, tiempo_fin_stim_sennal, tiempo_fin_stim,
%   tiempo_inicio_post, tiempo_fin_post]; % en segundos

% Definiciones de tiempo y sus rangos de las fases
registroLFP.times.stages_timeRanges_m = timeRanges;
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
registroLFP.multitaper.spectrogram.params.tapers = ([4 7]); % [TW K], (K <= to 2TW-1)
registroLFP.multitaper.spectrogram.params.pad = 2; % Cantidad de puntos multiplos de dos sobre el largo de la sennal
registroLFP.multitaper.spectrogram.params.Fs = registroLFP.desired_fs; % Frecuencia de muestreo
registroLFP.multitaper.spectrogram.params.fpass = [0.1 100]; % Rango de frecuencias
registroLFP.multitaper.spectrogram.params.err = 0; % Error considerado
registroLFP.multitaper.spectrogram.params.trialave = 0; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

% Datos para definir el ventaneo y avance de las ventanas en multitaper
registroLFP.multitaper.spectrogram.movingwin.window = 4; % Ventanas (En segundos)
registroLFP.multitaper.spectrogram.movingwin.winstep = registroLFP.multitaper.spectrogram.movingwin.window/2; % Pasos de ventanas (segundos)

% Datos de los parametros usados para calcular los multitapers (Chronux)
registroLFP.multitaper.coherenciogram.params.tapers = ([4 7]); % [TW K], (K <= to 2TW-1)
registroLFP.multitaper.coherenciogram.params.pad = 2; % Cantidad de puntos multiplos de dos sobre el largo de la sennal
registroLFP.multitaper.coherenciogram.params.Fs = registroLFP.desired_fs; % Frecuencia de muestreo
registroLFP.multitaper.coherenciogram.params.fpass = [0.1 100]; % Rango de frecuencias
registroLFP.multitaper.coherenciogram.params.err = 0; % Error considerado
registroLFP.multitaper.coherenciogram.params.trialave = 0; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

% Datos para definir el ventaneo y avance de las ventanas en multitaper
registroLFP.multitaper.coherenciogram.movingwin.window = 8; % Ventanas (En segundos)
registroLFP.multitaper.coherenciogram.movingwin.winstep = registroLFP.multitaper.coherenciogram.movingwin.window/2; % Pasos de ventanas (segundos)

% Datos de los parametros usados para calcular los multitapers (Chronux)
registroLFP.irasa.spectrogram.params.Fs = registroLFP.desired_fs; % Frecuencia de muestreo
registroLFP.irasa.spectrogram.params.fpass = [0.1 100]; % Rango de frecuencias

% Datos para definir el ventaneo y avance de las ventanas en multitaper
registroLFP.irasa.spectrogram.movingwin.window = 1; % Ventanas (En segundos)
registroLFP.irasa.spectrogram.movingwin.winstep = registroLFP.irasa.spectrogram.movingwin.window/2; % Pasos de ventanas (segundos)

% Identificadores de las etapas que se han hecho y las que quedan
registroLFP.analysis_stages.initialization = 1;
registroLFP.analysis_stages.extract_lfp = 0;
registroLFP.analysis_stages.view_lfp = 0;
registroLFP.analysis_stages.referencing = 0;
registroLFP.analysis_stages.spectral_channel = 0;
registroLFP.analysis_stages.view_spectrum = 0;
registroLFP.analysis_stages.delete_channel = 0;
registroLFP.analysis_stages.spectral_area = 0;
registroLFP.analysis_stages.coherence_area = 0;
 
% Datos de los canales
registroLFP.channels.name = [];
registroLFP.channels.area = [];
registroLFP.channels.data_ref = [];
registroLFP.channels.data_raw = [];
registroLFP.channels.spectrogram = [];
registroLFP.channels.psd = [];
registroLFP.channels.removed = [];

% Datos de cada espectrograma
registroLFP.channels.spectrogram.mag = [];
registroLFP.channels.spectrogram.time = [];
registroLFP.channels.spectrogram.frequency = [];    

% Datos de cada densidad de potencial espectral
registroLFP.channels.psd.pre = [];
registroLFP.channels.psd.on = [];
registroLFP.channels.psd.post = [];

% Datos de las areas en el tiempo
registroLFP.areas.name = [];
registroLFP.areas.data = [];
registroLFP.areas.data_raw = [];
registroLFP.areas.threshold = [];
registroLFP.areas.ind_over_threshold = [];

% Datos de los espectrogramas promedio por area
registroLFP.average_spectrum.area = [];
registroLFP.average_spectrum.spectrogram.mixed.mag = [];
registroLFP.average_spectrum.spectrogram.mixed.phase = [];
registroLFP.average_spectrum.spectrogram.mixed.mean_mag_pre = []; 
registroLFP.average_spectrum.spectrogram.mixed.std_mag_pre = [];  
registroLFP.average_spectrum.spectrogram.oscillations.mag = [];
registroLFP.average_spectrum.spectrogram.oscillations.mean_mag_pre = []; 
registroLFP.average_spectrum.spectrogram.oscillations.std_mag_pre = [];  
registroLFP.average_spectrum.spectrogram.fractals.mag = [];
registroLFP.average_spectrum.spectrogram.fractals.mean_mag_pre = []; 
registroLFP.average_spectrum.spectrogram.fractals.std_mag_pre = []; 
registroLFP.average_spectrum.spectrogram.beta = []; 
registroLFP.average_spectrum.spectrogram.time = [];
registroLFP.average_spectrum.spectrogram.frequency = [];  
registroLFP.average_spectrum.spectrogram.ind_artifacts = [];  
registroLFP.average_spectrum.spectrogram.irasa = [];

% Datos de los PSD promedio por area
registroLFP.average_spectrum.psd.mixed.pre = [];
registroLFP.average_spectrum.psd.mixed.on = [];
registroLFP.average_spectrum.psd.mixed.post = [];
registroLFP.average_spectrum.psd.oscillations.pre = [];
registroLFP.average_spectrum.psd.oscillations.on = [];
registroLFP.average_spectrum.psd.oscillations.post = [];
registroLFP.average_spectrum.psd.fractals.pre = [];
registroLFP.average_spectrum.psd.fractals.on = [];
registroLFP.average_spectrum.psd.fractals.post = [];

% Asignacion de los canales y areas que se usaran
[registroLFP.channels(1:64).name] = T.Channel{:}; % Cargar los numeros de los canales
[registroLFP.channels(1:64).area] = T.Area{:}; % Carga los nombres de las areas
[registroLFP.channels(1:64).removed] = deal(1);
[registroLFP.channels(eval_channels).removed] = deal(0);

% Crear carpeta para guardar las imagnes 35:end
slash_backslash = find(path=='\' | path=='/');
inicio_new_dir1 = slash_backslash(length(slash_backslash)-3);
inicio_new_dir2 = slash_backslash(length(slash_backslash)-2);
foldername = path(inicio_new_dir2:length(path)); % /+375/arturo2_2017-06-02_12-58-57/
inicio_foldername = path(1:inicio_new_dir1); % /home/cmanalisis/Aquiles/Registros/
if ~exist(foldername, 'dir')
    mkdir(inicio_foldername,'Images');
    mkdir([inicio_foldername,'Images'],foldername);
    mkdir([inicio_foldername,'Images', foldername],'LFPs');
    mkdir([inicio_foldername,'Images', foldername],'Spectrograms');
    mkdir([inicio_foldername,'Images', foldername],'Coherenciograms');
end

% Definir nombre del archivo .m donde iran las matrices guardadas
inicio_name_registro = slash_backslash(length(slash_backslash)-1);
name_registro = path(inicio_name_registro+1:length(path)-1);
registroLFP.name = name_registro;

% Eliminacion de variables que no se guardaran
clearvars -except registroLFP path name_registro foldername inicio_foldername eval_channels

