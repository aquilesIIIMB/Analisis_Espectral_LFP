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
path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\+5000_300Hz\maravilla_2017-06-21_13-56-11\';

%%% Ubuntu
%path = '/home/cmanalisis/Aquiles/Registros/Database/+2500_300Hz/maravilla_2017-06-26_11-03-26/';

%% Codificacion de canales
%channel_codes = 'channel_codes_florencia.csv';
%channel_codes = 'channel_codes_florencia_2.csv';
channel_codes = 'channel_codes_florencia_PUC.csv';

%% Canales que se analizaran
%canales_eval = 33:40;
%canales_eval = [14:21,46:53];
canales_eval = 1:64;

%% Como se va a referenciar cada canal
tipo_de_referencia = 'general'; % 'none', 'general', 'area'

%% Tiempo de inicio (segundos)
tinicial = 12;

%% Intervalos de tiempo del protocolo
%timeRange = [5, 5, 5];
timeRange = [6, 6, 6]; %Mixtos

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