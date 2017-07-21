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
%% Dejar todo con dataALL o data_CHi
%% Eliminar los outlayers
%% Opcion de repetir eleccion de eliminaion de CH y borrar outlayers (forma automatica)
%% Los outlayer se podrian eliminar antes de mostrar de la eleccion
%% Hacer la definicion de los rangos para cada area
%% Colocar en los espectrogramas y PSD debe tener el protocolo usado (20Hz por ej)
%% Si hay un area que solo tiene un canal sale error
%% Hacer que se muestre matlab cuando se tenga que det los rangos
%% Para mejorar lo de los artefactos, restar el lado derecho con el izquierdo

%% Pregunatar a Romulo como se elimnan los artefactos, de forma manual o
% de forma automatica (umbral) y mostrarle los artefactos de los registros
%% Guardar las imagnes de forma automatica
%% La referencia por area tiene que ser hecha solo por el promedio del control y aplicado en control y lesionado

%% Parametros editables por el usuario (FLO)
%% Ruta de la carpeta de los LFP
%%% Windows
%path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\300Hz\orlando2_2016-12-19_12-55-05\';
%path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\20Hz\orlando_2016-12-26_14-40-18\';
%path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\+375\Orlando_2016-12-01_16-01-59\';
%path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\+375\arturo_2017-06-02_12-58-17\'; % MAL COPIADO
%path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\+375\charles_2017-06-15_11-18-58\'; 
%path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\+2500\arturo2_2017-06-08_12-20-02\';
%path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\+2500_300Hz\arturo2_2017-06-08_12-20-02\';
path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\+2500_300Hz\orlando_2017-01-25_15-53-09\';
%path = 'C:\Users\Aquiles\Downloads\Trabajo de titulo\Database\+2500_300Hz\maravilla_2017-06-17_16-39-32\';

%%% Ubuntu
%path = '/home/cmanalisis/Aquiles/Registros/Database/+375/arturo2_2017-06-02_12-58-57/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/20Hz/orlando_2016-12-26_14-40-18/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+375/Orlando_2016-12-01_16-01-59/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/-375/orlando_2016-12-14_16-48-54/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+750/orlando2_2016-12-23_11-17-57/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+2500_300Hz/arturo_2017-06-09_15-24-39/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+2500_300Hz/maravilla_2017-06-17_16-39-32/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+375_300Hz/arturo_2017-06-01_12-08-54/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+375_300Hz/maravilla_2017-06-08_12-42-34/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+375_300Hz/charles_2017-06-09_16-16-13/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+5000_300Hz/maravilla_2017-06-21_13-56-11/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+375/maravilla_2017-06-07_14-39-40/';
%path = '/home/cmanalisis/Aquiles/Registros/Database/+2500_300Hz/orlando_2017-01-25_15-53-09/';

%% Codificacion de canales
%channel_codes = 'channel_codes_florencia.csv';
%channel_codes = 'channel_codes_florencia_2.csv';
channel_codes = 'channel_codes_florencia_PUC.csv';

%% Canales que se analizaran
%canales_eval = 33:40;
canales_eval = [14:21,46:53];
%canales_eval = 1:64;

%% Como se va a referenciar cada canal
tipo_de_referencia = 'general'; % 'none', 'general', 'area'

%% Tiempo de inicio (segundos)
tinicial = 25;

%% Intervalos de tiempo del protocolo
%timeRange = [5, 5, 5];
timeRange = [6, 6, 6]; %Mixtos

%% Fin de los parametros

%% Ejecucion del programa (No cambiar)

% Etapa de generacion de todos los lfp (Evaluacion)
ExtraerSelectLFP;

VisualizacionLFP;

EliminacionCH;

Referenciacion;

AnalisisEspectral_1;

% Etapa de eliminacion de ch y lfp promedios (Seleccion)
EliminacionCH;

Referenciacion;

AnalisisEspectral_2;


% Tipo de errores:
% Index exceeds matrix dimensions. ---> Revisar "path" y "dir_signals"