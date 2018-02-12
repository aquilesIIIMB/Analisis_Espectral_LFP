%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% main.m
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all
% Primero izquerdo y despues hemisferio derecho. Analisis de las mismas
% areas en ambos hemisferios
%% Parametros editables por el usuario 
%% Ruta de la carpeta de los LFP
%%% Windows
path = 'D:\Descargas\Trabajo de titulo\Database\+2500_300Hz\arturo_2017-06-09_15-24-39\'; 

%%% Ubuntu
%path = '/home/cmanalisis/Aquiles/Registros/Database/+2500_300Hz/maravilla_2017-06-17_16-39-32/';

%% Intervalos de tiempo del protocolo
%timeRanges = [5, 5, 5]; %DC or AC
timeRanges = [6, 6, 6]; %Mixtos

%% Amplitud del umbral para remover artefactos
threshold_amplitudes = [15, 10, 10]; % 8,9,10 desde el mas sucio al mas limpio

%% Canales que se analizaran
%eval_channels = [2:5,14:21,34:37,46:53];
%eval_channels = [14:21,46:53];
eval_channels = 1:64;

%% Codificacion de canales
%channel_codes = 'channel_codes_florencia.csv'; % Flo
%channel_codes = 'channel_codes_florencia_2.csv'; % Flo Esgrima UCH
channel_codes = 'channel_codes_florencia_PUC.csv'; % Flo Futbolistas UC
%channel_codes = 'channel_codes_Rata_R01.csv'; % Caro

%% Fin de los parametros

%% Ejecucion del programa (No cambiar)
tic;
% Etapa de generacion de todos los lfp
Initialization;

Extract_LFP;

View_LFP_Raw_Ref;

Spectral_Channel;

View_Spectrum_Channel_Area;

% Etapa de eliminacion de ch y lfp promedios
Delete_CH;

Referencing;

View_LFP_Raw_Ref;

Spectral_Area;

View_Spectrum_Channel_Area;

Coherence_Area;

View_Coherence_Area;
toc;

sonido_alarma;

%%% Cambiar el umbral, ver los parametros del multitapers y entregar el PSD
%%% sin pink noise

% Tipo de errores:
% Index exceeds matrix dimensions. ---> Revisar "path" y "dir_signals"


% OBS
% Guardar una vector dentro de un vector de subcampo de una estructura
%a = num2cell([1 2]);
%[registroLFP.channel([18;19]).removed] = a{:};
%
% Guardar un mismo valor dentro de un vector de subcampo de una estructura
%[registroLFP.channel([18;19]).removed] = deal(1);

% Simular estimulacion
% Mixta
%f = 1200; %// Hz
%f_c = 1/2; %// Hz
%T = 1 / f; %// Sampling period from f
%t = 0 : T : 19*60.0; %// Determine time values from 0 to 5 in steps of the sampling period

%y_ru = t(t< 30).*sin(2*pi*f_c*t(t< 30));
%y_rd = y_ru(end:-1:1);
%A = max(y_ru);
%y_stim = A.*sin(2*pi*f_c*t(t>6*60.0+30 & t< 12*60.0+30));
%y_pre = 0*t(t< 6*60.0);
%y_post = 0*t(t> 13*60.0);
%y = [y_pre,y_ru,y_stim,y_rd,y_post];

% Plot carrier signal and modulated signal
%figure;
%plot(y);
%grid;


