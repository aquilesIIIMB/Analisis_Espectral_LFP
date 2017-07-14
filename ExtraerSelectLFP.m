%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ExtraerSelectLFP.m
fprintf('\nExtraerSelectLFP\n')
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Verificacion de los Parametros
fprintf('\n***Etapa de Evaluacion*** \n');
fprintf('__Parametros escogidos:\n\n');
fprintf('Ruta:\n\t%s\n', path);
pause(1)
fprintf('Codificacion de cada canal:\n\t%s\n', channel_codes);
pause(1)
fprintf('Canales Usados:\n');
for k = 1:length(canales_eval)
    
    fprintf('\tCH%s\t\n',int2str(canales_eval(k)));
end
pause(2)
fprintf('El tipo de referencia es:\n\t%s\n', upper(tipo_de_referencia));
pause(1)
fprintf('El tiempo inicial es:\n\t%d segundos\n', tinicial);
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

% tiempos(s) de cada evento: pre, on, post estimulacion
pre_m = (tinicial + timeRange(1)*60.0)/60.0;
on_inicio_m = (tinicial + timeRange(1)*60.0 + 30)/60.0;
on_final_m = (tinicial + timeRange(1)*60.0 + timeRange(2)*60.0 + 30)/60.0;
post_m = (tinicial + timeRange(1)*60.0 + timeRange(2)*60.0 + 60)/60.0;
tiempo_total = (tinicial + timeRange(1)*60.0 + timeRange(2)*60.0 + timeRange(3)*60.0 + 60)/60.0;

% Se carga la codficiacion del canal
T = readtable(channel_codes);

% Prefijo de los archivos dentro de la ruta
dir_signals = dir([path,'10*_CH*.continuous']);

% Listado de los nombre de los archivos de los LFP
dir_signals = char(natsortfiles({dir_signals.name})); % Ordena los nombres de los archivos correctamente
largo_dir = length(dir_signals);

% Cargar los numeros de los canales y los nombres de las areas
Channel = T.Channel;
Area = T.Area;

% Prefijo del nombre del registro (ej: 100_CH)
ruta_con100 = dir_signals(1,1:6);

% Nombre del archivo donde esta el registro
ruta_regEval = [ruta_con100,int2str(canales_eval(1)),'.continuous'];
disp(ruta_regEval)

% Obtener la informacion del primer archivo
[data, timestamps, info] = load_open_ephys_data_faster(strtrim([path,ruta_regEval]));

% Tasa de muestreo de los registros
simpleRate = info.header.sampleRate;
% Frecuencia de Nyquist
fNyq = simpleRate/2;
% Tasa de muestreo deseada
desiredSimpleRate = 1000;

% Parametros del filtro pasa banda
N_filt = 20;
fc1 = 3;
fc2 = 300;

% Disenno del filtro pasa banda
d = fdesign.bandpass('N,F3dB1,F3dB2',N_filt,fc1,fc2,simpleRate);
Hd = design(d,'butter');
%fvtool(Hd)

% Filtrado del primer LFP
data_filt = filter(Hd,data);
% Downsamplear el primer LFP para llevar los registros a la tasa de muestro requerida
data_downS = downsample(data_filt,simpleRate/desiredSimpleRate);

% Tiempo maximo de registro
tiempo_max_seg = length(data)/30000;
% Tiempo total en minutos
time_step_m = linspace(0,tiempo_max_seg/60,length(data_downS)); % minutos

% Eliminar los datos del primer LFP sobre los 960 segundos
data_elim_maxTime = data_downS((time_step_m<tiempo_total)); % Si se eliminan los primeros segundos, es como si inicial fuese cero, por lo que cambian los limites de las barras de las fases
eval(['data_',int2str(canales_eval(1)),' = data_elim_maxTime;']);
eval(['data_all = data_',int2str(canales_eval(1)),';']);

for i = 2:length(canales_eval) %canales_eval(2:end) % largo_dir

    % Nombre del archivo donde esta el registro
    ruta_regEval = [ruta_con100,int2str(canales_eval(i)),'.continuous'];
    disp(ruta_regEval)
    
    % Obtener la informacion del archivo "i"
    [data, timestamps, info] = load_open_ephys_data_faster(strtrim([path,ruta_regEval]));
    
    % Filtrado del LFP "i"
    data_filt = filter(Hd,data);
    
    % Downsamplear el LFP "i" para llevar los registros a la tasa de muestro requerida
    data_downS = downsample(data_filt,simpleRate/desiredSimpleRate);
    
    % Eliminar los datos del LFP "i" sobre los 960 segundos
    data_elim_maxTime = data_downS((time_step_m<tiempo_total)); % Tal vez eliminar los primeros segundos
    
    % Guardar los datos modificados
    eval(['data_',int2str(canales_eval(i)),'= data_elim_maxTime;']);
    
    % guardar solo el filtrado
    eval(['data_all = [data_all,data_',int2str(canales_eval(i)),'];']);
    
end

% Guardar matrices en .mat
slash_backslash = find(path=='\' | path=='/');
inicio_name_registro = slash_backslash(length(slash_backslash)-1);
name_registro = path(inicio_name_registro+1:length(path)-1);
save(name_registro,'data_all');
save(name_registro,'etapa','-append');
