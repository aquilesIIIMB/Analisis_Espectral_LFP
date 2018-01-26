% Test Pink noise
m=2;

Spectral_pre_mean = registroLFP.average_spectrum(m).psd.pre.data;
Spectral_on_mean = registroLFP.average_spectrum(m).psd.on.data;
Spectral_post_mean = registroLFP.average_spectrum(m).psd.post.data;

Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.data;
Spectrogram_mean_raw = registroLFP.average_spectrum(m).spectrogram.data_raw;

t_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.tiempo;
f_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.frecuencia; 
idx_spect_artifacts = registroLFP.average_spectrum(m).spectrogram.ind_artifacts;     

% Indices de cada etapa
idx_pre = find(t_Spectrogram_mean<(pre_m*60.0-5));
idx_on = find(t_Spectrogram_mean>(on_inicio_m*60.0+5) & t_Spectrogram_mean<(on_final_m*60.0-5));
idx_post = find(t_Spectrogram_mean>(post_m*60.0+5) & t_Spectrogram_mean<(tiempo_total*60));

% PSD sin Pink Noise
PSD_pre_mean_raw = mean(Spectrogram_mean_raw(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:),1);    
PSD_on_mean_raw = mean(Spectrogram_mean_raw(idx_on(~ismember(idx_on, idx_spect_artifacts)),:),1);    
PSD_post_mean_raw = mean(Spectrogram_mean_raw(idx_post(~ismember(idx_post, idx_spect_artifacts)),:),1);
    
%-------------------Convert to dBPink--------------------------------------
[~, imax_pre] = max(PSD_pre_mean_raw);
[~, imax_on] = max(PSD_on_mean_raw);
[~, imax_post] = max(PSD_post_mean_raw);

[pow_dBpink_pre, fitStats_pre, pow_pinknoise_pre] = convert_to_dBpink(f_Spectrogram_mean, PSD_pre_mean_raw', [f_Spectrogram_mean(imax_pre) 100]);
[pow_dBpink_on, fitStats_on, pow_pinknoise_on] = convert_to_dBpink(f_Spectrogram_mean, PSD_on_mean_raw', [f_Spectrogram_mean(imax_on) 100]);
[pow_dBpink_post, fitStats_post, pow_pinknoise_post] = convert_to_dBpink(f_Spectrogram_mean, PSD_post_mean_raw', [f_Spectrogram_mean(imax_post) 100]);

figure
plot(f_Spectrogram_mean, PSD_pre_mean_raw)
hold on
plot(f_Spectrogram_mean, PSD_on_mean_raw)
hold on
plot(f_Spectrogram_mean, PSD_post_mean_raw)

figure
plot(f_Spectrogram_mean, PSD_pre_mean_raw)
hold on
plot(f_Spectrogram_mean, pow_pinknoise_pre)

figure
plot(f_Spectrogram_mean, PSD_on_mean_raw)
hold on
plot(f_Spectrogram_mean, pow_pinknoise_on)

figure
plot(f_Spectrogram_mean, PSD_post_mean_raw)
hold on
plot(f_Spectrogram_mean, pow_pinknoise_post)

figure
plot(f_Spectrogram_mean, pow_dBpink_pre)
hold on
plot(f_Spectrogram_mean, pow_dBpink_on)
hold on
plot(f_Spectrogram_mean, pow_dBpink_post)


%-------------------Pink Noise Del--------------------------------------
[pow_dBpink_pre, pow_pinknoise_pre] = pink_noise_del(f_Spectrogram_mean, PSD_pre_mean_raw, idx_spect_artifacts); 
[pow_dBpink_on, pow_pinknoise_on] = pink_noise_del(f_Spectrogram_mean, PSD_on_mean_raw, idx_spect_artifacts); 
[pow_dBpink_post, pow_pinknoise_post] = pink_noise_del(f_Spectrogram_mean, PSD_post_mean_raw, idx_spect_artifacts); 

figure
plot(f_Spectrogram_mean, PSD_pre_mean_raw)
hold on
plot(f_Spectrogram_mean, pow_pinknoise_pre)

figure
plot(f_Spectrogram_mean, PSD_on_mean_raw)
hold on
plot(f_Spectrogram_mean, pow_pinknoise_on)

figure
plot(f_Spectrogram_mean, PSD_post_mean_raw)
hold on
plot(f_Spectrogram_mean, pow_pinknoise_post)

figure
semilogy(f_Spectrogram_mean, pow_dBpink_pre)
hold on
semilogy(f_Spectrogram_mean, pow_dBpink_on)
hold on
semilogy(f_Spectrogram_mean, pow_dBpink_post)



%-----------------------Function pink noise-------------------------------
entrada_x = f_Spectrogram_mean;
entrada_y = PSD_pre_mean_raw;
idx_spect_artifacts = idx_spect_artifacts;

band_out = [1 50];

size_time = size(entrada_y,1);
size_frec = size(entrada_y,2);
salida = entrada_y;

for i = 1:size_time
    
    if find(i == idx_spect_artifacts)
        %disp('paso')        
        %disp(i)
        continue;
        
    end
    
    % Eliminacion del ruido rosa mediante polyfit, modelo a*x.^m (usado antes)
    [~,Ind_max]=max(entrada_y(i,:));
    x=entrada_x(Ind_max:size_frec);
    y=entrada_y(i, Ind_max:size_frec);
    p = polyfit(log(x),log(y),1);
    m = p(1);
    b = exp(p(2));

    modelo_eval = b*entrada_x.^m;
    salida(i,:) = entrada_y(i,:)./modelo_eval;

end

%---------------------------Spectrogram------------------------------------
Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.data_raw;

%idx_spect_artifacts = unique(round(indices_cero*(length(t_Spectrogram_mean)/length(Data_ref_pond))));
[~,ind_max] = max(Spectrogram_mean,[],2); % Indice de los maximos en cada bin de tiempo
frec_ind_max = f_Spectrogram_mean(ind_max); % Frecuencia de los maximos en cada bin de tiempo
idx_spect_artifacts = ~((frec_ind_max > 100-5) & (frec_ind_max < 100+5)); % Se ignoran los indices que estan cerca de la frecuencia del seno, ignora algunos bin de tiempo
idx_spect_artifacts = find(~idx_spect_artifacts)';

% Indices de cada etapa
idx_pre = find(t_Spectrogram_mean<(pre_m*60.0-5));
idx_on = find(t_Spectrogram_mean>(on_inicio_m*60.0+5) & t_Spectrogram_mean<(on_final_m*60.0-5));
idx_post = find(t_Spectrogram_mean>(post_m*60.0+5) & t_Spectrogram_mean<(tiempo_total*60));

% Se le quita el ruido rosa, dejando mas plano el espectro
Spectrogram_mean = pink_noise_del(f_Spectrogram_mean, Spectrogram_mean, idx_spect_artifacts); 

% dB Spect
Spectrogram_mean = db(Spectrogram_mean','power')';

% Separacion por etapas el espectrograma  
Spectrogram_pre_mean = Spectrogram_mean(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);

Spectrogram_on_mean = Spectrogram_mean(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);

Spectrogram_post_mean = Spectrogram_mean(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);

% PSD sin normalizar por la frecuencia de la fase pre (No contar los valores cercanos a la sinusoidal)
Spectral_pre_mean = mean(Spectrogram_pre_mean,1);
Spectral_on_mean = mean(Spectrogram_on_mean,1);
Spectral_post_mean = mean(Spectrogram_post_mean,1);

% Spectrograma final %%%%%%%%%%% Ver si mean es mejor q median para normalizar (probar) preguntarle a rodrigo 
%Spectrogram_pre_mean = Spectrogram_mean((t_Spectrogram_mean<(pre_m*60.0)),:);
Mean_Spectrogram_pre_mean = mean(Spectrogram_pre_mean,1);
Desv_Spectrogram_pre_mean = std(Spectrogram_pre_mean,1);
%quantil_pre = quantile(Spectrogram_pre_mean,[.025 .25 .50 .75 .975]);
%Desv_Spectrogram_pre_mean = quantil_pre(3,:) - quantil_pre(2,:);

Spectrogram_mean = (Spectrogram_mean-ones(size(Spectrogram_mean))*diag(Mean_Spectrogram_pre_mean))./(ones(size(Spectrogram_mean))*diag(Desv_Spectrogram_pre_mean));
%Spectrogram_mean = Spectrogram_mean+abs(min(min(Spectrogram_mean)));
    
fig_6 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(Spectrogram_mean',1,numel(Spectrogram_mean)),[5 99]);
imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_mean',clim); 
%min_spect = min(min(db(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:)'+1,'power')));
%max_spect = max(max(db(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:)'+1,'power')));
%dist_maxmin = max_spect - min_spect;
cmap = colormap(parula(40));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([1 100])
c=colorbar('southoutside');
alphamax = 0.3; % Cuanto se acerca el max al minimo 
alphamin = 0; % Cuanto se acercca el minimo al maximo
alphashift_left = 0.5; % Cuanto se corre a la izquierda los valores
%caxis([alphamin * dist_maxmin + min_spect - alphashift_left*dist_maxmin, max_spect - alphamax * dist_maxmin]); %[-10, 10] ([-20, 15]) [-15, 20]
caxis([-1 1])
hold on
line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
title(['Mean Spectrogram multitaper of LFPs in ',C{ic(i)}], 'FontSize', 24)
ylabel(c,'Normalized Power (u.a.)', 'FontSize', 17)
set(c,'fontsize',17)

