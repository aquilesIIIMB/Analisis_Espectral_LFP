
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% main.m
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all

%%% !!Que falta: 
%% Para mejorar lo de los artefactos, restar el lado derecho con el izquierdo

%% Parametros editables por el usuario 
%% Ruta de la carpeta de los LFP
%%% Windows
path = 'D:\Descargas\Trabajo de titulo\Database\+2500_300Hz\maravilla_2017-06-17_16-39-32\'; %mixto

%%% Ubuntu
%path = '/home/cmanalisis/Aquiles/Registros/Database/+2500/maravilla_2017-06-09_15-51-41/';

%% Intervalos de tiempo del protocolo
%timeRange = [5, 5, 5];
timeRange = [6, 6, 6]; %Mixtos

%% Amplitud del umbral para remover artefactos
amplitud_umbral = 10; % 8,9,10 desde el mas sucio al mas limpio

%% Canales que se analizaran
%canales_eval = 33:40;
%canales_eval = [14:21,46:53];
canales_eval = 1:64;

%% Como se va a referenciar cada canal
tipo_de_referencia = 'general'; % 'none', 'general', 'area'

%% Codificacion de canales
%channel_codes = 'channel_codes_florencia.csv';
%channel_codes = 'channel_codes_florencia_2.csv';
channel_codes = 'channel_codes_florencia_PUC.csv';

%% Fin de los parametros

%% Ejecucion del programa (No cambiar)
tic;
% Etapa de generacion de todos los lfp
Initialization;

Extract_LFP;

View_LFP_Raw_Ref;

Spectral_Analysis_Single;

View_Spectrum_Single_Average;

% Etapa de eliminacion de ch y lfp promedios
Delete_CH;

Referencing;

View_LFP_Raw_Ref;

Spectral_Analysis_Average;

View_Spectrum_Single_Average;
toc;

sonido_alarma;

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


