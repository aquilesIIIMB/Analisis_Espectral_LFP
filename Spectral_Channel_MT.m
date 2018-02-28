%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Spectral_Channel.m
fprintf('\nAnalisis Espectral por Canal\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.analysis_stages.view_lfp 
    error('Falta el bloque de visualizacion');
    
end

canales_eval = find(~[registroLFP.channels.removed]);
largo_canales_eval = size(canales_eval,2);

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

%% Calculo de la respuesta en frecuencia y espectrograma
for i = 1:largo_canales_eval
    
    % Tomar el LFP del canal que se analizara. Formato samplesxCh\trials
    Data = registroLFP.channels(canales_eval(i)).data_raw;
    
    % Multitaper estimation para el spectrograma
    [Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(Data,[registroLFP.multitaper.spectrogram.movingwin.window registroLFP.multitaper.spectrogram.movingwin.winstep],registroLFP.multitaper.spectrogram.params); 
    
    % PSD del LFP
    Spectral_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-5)),:),1);
    Spectral_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+5) & t_Spectrogram<(on_final_m*60.0-5),:),1);    
    Spectral_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+5) & t_Spectrogram<(tiempo_total*60),:),1);
    
    % Almacenar datos
    registroLFP.channels(canales_eval(i)).spectrogram.mag = Spectrogram;
    registroLFP.channels(canales_eval(i)).spectrogram.time = t_Spectrogram;
    registroLFP.channels(canales_eval(i)).spectrogram.frequency = f_Spectrogram;
    
    registroLFP.channels(canales_eval(i)).psd.pre = Spectral_pre;
    registroLFP.channels(canales_eval(i)).psd.on = Spectral_on;
    registroLFP.channels(canales_eval(i)).psd.post = Spectral_post;
    
end

registroLFP.analysis_stages.spectral_channel = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP path name_registro foldername inicio_foldername

