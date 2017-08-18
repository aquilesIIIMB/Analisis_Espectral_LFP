%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Spectral_Analysis_Single.m
fprintf('\nAnalisis Espectral Individual\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.stage.view_lfp 
    error('Falta el bloque de visualizacion');
    
end

canales_eval = find(~[registroLFP.channel.removed]);
largo_canales_eval = size(canales_eval,2);

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

%% Calculo de la respuesta en frecuencia y espectrograma
for i = 1:largo_canales_eval
    
    % Tomar el LFP del canal que se analizara. Formato samplesxCh\trials
    Data = registroLFP.channel(canales_eval(i)).data_raw;
    
    % Multitaper estimation para el spectrograma
    [Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(Data,[registroLFP.multitaper.movingwin.window registroLFP.multitaper.movingwin.winstep],registroLFP.multitaper.params); 
    
    % Se le quita el ruido rosa, dejando mas plano el espectro
    %Spectrogram = pink_noise_del(f_Spectrogram, Spectrogram);
    
    % PSD del LFP
    Spectral_pre = mean(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),1);
    Spectral_on = mean(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),1);    
    Spectral_post = mean(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),1);
    
    registroLFP.channel(canales_eval(i)).spectrogram.data = Spectrogram;
    registroLFP.channel(canales_eval(i)).spectrogram.tiempo = t_Spectrogram;
    registroLFP.channel(canales_eval(i)).spectrogram.frecuencia = f_Spectrogram;
    
    registroLFP.channel(canales_eval(i)).psd.pre.data = Spectral_pre;
    registroLFP.channel(canales_eval(i)).psd.on.data = Spectral_on;
    registroLFP.channel(canales_eval(i)).psd.post.data = Spectral_post;
    
end

registroLFP.stage.spectral_analysis_single = 1;

% Eliminacion de variables no utilizadas
clear Spectrogram Spectrogram_pre Spectrogram_on Spectrogram_post i Data
clear Mean_Spectrogram_pre Desv_Spectrogram_pre pre_m on_inicio_m on_final_m
clear Spectral_pre Spectral_on Spectral_post post_m tiempo_total canales_eval largo_canales_eval
clear t_Spectrogram f_Spectrogram

