channels = [46:53];
Data_total = [];

for i = channels
    [data, timestamps, info] = load_open_ephys_data_faster(['D:\Descargas\Trabajo de titulo\Database\+2500_300Hz\maravilla_2017-06-17_16-39-32\100_CH',int2str(i),'.continuous']);
    Data_total = [Data_total, data];
end

% Tasa de muestreo de los registros
sampleRate = info.header.sampleRate;

n = 20; fc1 = 1; fc2 = 150;

%data_downsample = downsample(data, sampleRate/1000);


%figure;
%plot(data)
%figure;
%plot(data_downsample)
%figure;
%plot(data_filt_original)
%figure;
%plot(data_filt_kaiser)

%---------------------Original con 30K------------------------------------
% Datos de los parametros usados para calcular los multitapers (Chronux)
params.tapers = ([3 5]); % [TW K], (K <= to 2TW-1)
params.pad = 5; % Cantidad de puntos multiplos de dos sobre el largo de la se�al
params.Fs = 30000; %registroLFP.desired_fs; % Frecuencia de muestreo
params.fpass = [4 100]; % Rango de frecuencias
params.err = 0; % Error considerado
params.trialave = 1; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

tinicial = registroLFP.times.extra_time_s;
pre_m = registroLFP.times.pre_m + tinicial/60;
on_inicio_m = registroLFP.times.start_on_m + tinicial/60;
on_final_m = registroLFP.times.end_on_m + tinicial/60;
post_m = registroLFP.times.post_m + tinicial/60;
tiempo_total = registroLFP.times.end_m + tinicial/60;

[Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(Data_total,[1 0.5], params); 
Spectral_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-5)),:),1);
Spectral_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+5) & t_Spectrogram<(on_final_m*60.0-5),:),1);    
Spectral_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+5) & t_Spectrogram<(tiempo_total*60),:),1);
%spectral = median(Spectrogram,1);

graph_spect_psd(f_Spectrogram, t_Spectrogram, Spectrogram, Spectral_pre, Spectral_on, Spectral_post, registroLFP)  

%[pow_dBpink, fitStats, pow_pinknoise] = convert_to_dBpink(f_Spectrogram, Spectral_pre, [0 100]);

%---------------------------Downsampling con 1K--------------------------
data_downsample = downsample(Data_total, sampleRate/1000);

% Datos de los parametros usados para calcular los multitapers (Chronux)
params.tapers = ([3 5]); % [TW K], (K <= to 2TW-1)
params.pad = 5; % Cantidad de puntos multiplos de dos sobre el largo de la se�al
params.Fs = 1000; %registroLFP.desired_fs; % Frecuencia de muestreo
params.fpass = [4 100]; % Rango de frecuencias
params.err = 0; % Error considerado
params.trialave = 1; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

tinicial = registroLFP.times.extra_time_s;
pre_m = registroLFP.times.pre_m + tinicial/60;
on_inicio_m = registroLFP.times.start_on_m + tinicial/60;
on_final_m = registroLFP.times.end_on_m + tinicial/60;
post_m = registroLFP.times.post_m + tinicial/60;
tiempo_total = registroLFP.times.end_m + tinicial/60;

[Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(data_downsample,[1 0.5], params); 
Spectral_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-5)),:),1);
Spectral_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+5) & t_Spectrogram<(on_final_m*60.0-5),:),1);    
Spectral_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+5) & t_Spectrogram<(tiempo_total*60),:),1);
%spectral = median(Spectrogram,1);

graph_spect_psd(f_Spectrogram, t_Spectrogram, Spectrogram, Spectral_pre, Spectral_on, Spectral_post, registroLFP)  

%---------------------------butter con 1K--------------------------
data_downsample = downsample(Data_total, sampleRate/1000);

% Disenno del filtro pasa banda
d = fdesign.bandpass('N,F3dB1,F3dB2', n, fc1, fc2, 1000);
Hd = design(d,'butter'); 
%freqz(Hd)

% Filtrado del primer LFP
data_filt_original = filter(Hd,data_downsample);

% Datos de los parametros usados para calcular los multitapers (Chronux)
params.tapers = ([3 5]); % [TW K], (K <= to 2TW-1)
params.pad = 5; % Cantidad de puntos multiplos de dos sobre el largo de la se�al
params.Fs = 1000; %registroLFP.desired_fs; % Frecuencia de muestreo
params.fpass = [4 100]; % Rango de frecuencias
params.err = 0; % Error considerado
params.trialave = 1; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

tinicial = registroLFP.times.extra_time_s;
pre_m = registroLFP.times.pre_m + tinicial/60;
on_inicio_m = registroLFP.times.start_on_m + tinicial/60;
on_final_m = registroLFP.times.end_on_m + tinicial/60;
post_m = registroLFP.times.post_m + tinicial/60;
tiempo_total = registroLFP.times.end_m + tinicial/60;

[Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(data_filt_original,[1 0.5], params); 
Spectral_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-5)),:),1);
Spectral_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+5) & t_Spectrogram<(on_final_m*60.0-5),:),1);    
Spectral_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+5) & t_Spectrogram<(tiempo_total*60),:),1);
%spectral = median(Spectrogram,1);

graph_spect_psd(f_Spectrogram, t_Spectrogram, Spectrogram, Spectral_pre, Spectral_on, Spectral_post, registroLFP)  

%---------------------------kaiser con 1K--------------------------
data_downsample = downsample(Data_total, sampleRate/1000);

% Filtro pasa bajo
d = designfilt('lowpassfir','FilterOrder',80, ...
               'CutoffFrequency',0.15,'Window',{'kaiser',8});

%freqz(d)
data_filt_kaiser = filter(d,data_downsample);

% Datos de los parametros usados para calcular los multitapers (Chronux)
params.tapers = ([3 5]); % [TW K], (K <= to 2TW-1)
params.pad = 5; % Cantidad de puntos multiplos de dos sobre el largo de la se�al
params.Fs = 1000; %registroLFP.desired_fs; % Frecuencia de muestreo
params.fpass = [4 100]; % Rango de frecuencias
params.err = 0; % Error considerado
params.trialave = 1; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

tinicial = registroLFP.times.extra_time_s;
pre_m = registroLFP.times.pre_m + tinicial/60;
on_inicio_m = registroLFP.times.start_on_m + tinicial/60;
on_final_m = registroLFP.times.end_on_m + tinicial/60;
post_m = registroLFP.times.post_m + tinicial/60;
tiempo_total = registroLFP.times.end_m + tinicial/60;

[Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(data_filt_kaiser,[1 0.5], params); 
Spectral_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-5)),:),1);
Spectral_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+5) & t_Spectrogram<(on_final_m*60.0-5),:),1);    
Spectral_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+5) & t_Spectrogram<(tiempo_total*60),:),1);
%spectral = median(Spectrogram,1);

graph_spect_psd(f_Spectrogram, t_Spectrogram, Spectrogram, Spectral_pre, Spectral_on, Spectral_post, registroLFP)  

%----------------------kaiser con 1K Down After--------------------------

% Filtro pasa bajo
d = designfilt('lowpassfir','FilterOrder',80, ...
               'CutoffFrequency',150/15000,'Window',{'kaiser',8});

%freqz(d)
data_filt_kaiser = filter(d,Data_total);

data_downsample = downsample(data_filt_kaiser, sampleRate/1000);

% Datos de los parametros usados para calcular los multitapers (Chronux)
params.tapers = ([3 5]); % [TW K], (K <= to 2TW-1)
params.pad = 5; % Cantidad de puntos multiplos de dos sobre el largo de la se�al
params.Fs = 1000; %registroLFP.desired_fs; % Frecuencia de muestreo
params.fpass = [4 100]; % Rango de frecuencias
params.err = 0; % Error considerado
params.trialave = 1; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

tinicial = registroLFP.times.extra_time_s;
pre_m = registroLFP.times.pre_m + tinicial/60;
on_inicio_m = registroLFP.times.start_on_m + tinicial/60;
on_final_m = registroLFP.times.end_on_m + tinicial/60;
post_m = registroLFP.times.post_m + tinicial/60;
tiempo_total = registroLFP.times.end_m + tinicial/60;

[Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(data_downsample,[1 0.5], params); 
Spectral_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-5)),:),1);
Spectral_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+5) & t_Spectrogram<(on_final_m*60.0-5),:),1);    
Spectral_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+5) & t_Spectrogram<(tiempo_total*60),:),1);
%spectral = median(Spectrogram,1);

graph_spect_psd(f_Spectrogram, t_Spectrogram, Spectrogram, Spectral_pre, Spectral_on, Spectral_post, registroLFP)  

%-----------------------butter con 1K Down After--------------------------

% Disenno del filtro pasa banda
d = fdesign.bandpass('N,F3dB1,F3dB2', n, fc1, fc2, 30000);
Hd = design(d,'butter'); 
%freqz(Hd)

% Filtrado del primer LFP
data_filt_original = filter(Hd,Data_total);

data_downsample = downsample(data_filt_original, sampleRate/1000);

% Datos de los parametros usados para calcular los multitapers (Chronux)
params.tapers = ([3 5]); % [TW K], (K <= to 2TW-1)
params.pad = 5; % Cantidad de puntos multiplos de dos sobre el largo de la se�al
params.Fs = 1000; %registroLFP.desired_fs; % Frecuencia de muestreo
params.fpass = [4 100]; % Rango de frecuencias
params.err = 0; % Error considerado
params.trialave = 1; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

tinicial = registroLFP.times.extra_time_s;
pre_m = registroLFP.times.pre_m + tinicial/60;
on_inicio_m = registroLFP.times.start_on_m + tinicial/60;
on_final_m = registroLFP.times.end_on_m + tinicial/60;
post_m = registroLFP.times.post_m + tinicial/60;
tiempo_total = registroLFP.times.end_m + tinicial/60;

[Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(data_downsample,[1 0.5], params); 
Spectral_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-5)),:),1);
Spectral_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+5) & t_Spectrogram<(on_final_m*60.0-5),:),1);    
Spectral_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+5) & t_Spectrogram<(tiempo_total*60),:),1);
%spectral = median(Spectrogram,1);

graph_spect_psd(f_Spectrogram, t_Spectrogram, Spectrogram, Spectral_pre, Spectral_on, Spectral_post, registroLFP)  
