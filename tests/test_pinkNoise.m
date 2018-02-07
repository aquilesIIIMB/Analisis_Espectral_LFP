i = 9; %M1R
banda_beta = [8, 20];
freq = registroLFP.average_spectrum(i).spectrogram.frecuencia;
freq_beta = freq(freq>=banda_beta(1) & freq<=banda_beta(2));
freq_beta_smooth = freq(freq>=banda_beta(1) & freq<=40);

psd_pre = registroLFP.average_spectrum(i).psd.pre.data;
psd_pre_beta = psd_pre(freq>=banda_beta(1) & freq<=banda_beta(2));
potencia_min_base = psd_pre_beta(1);
potencia_max_base = psd_pre_beta(end);
psd_pre_smooth = smooth(freq, psd_pre,0.05, 'loess');
psd_pre_smooth(freq>=min(freq_beta) & freq<=max(freq_beta)) = [];
freq_smooth = freq;
freq_smooth(freq>=min(freq_beta) & freq<=max(freq_beta)) = [];

%base=interp1([min(freq_beta), max(freq_beta)],[potencia_min_base, potencia_max_base],freq_beta,'linear');
base=interp1(freq(freq>=min(freq_beta) & freq<=40),psd_pre_smooth(freq>=min(freq_beta) & freq<=40),freq_beta_smooth,'spline');
psd_base = psd_pre;
psd_base(freq>=banda_beta(1) & freq<=40) = base;

figure
plot(freq_smooth, psd_pre_smooth,'*-')

figure
plot(freq, psd_pre,'*-')
hold on
%plot(freq(freq>=min(freq_beta)),psd_pre_smooth(freq>=min(freq_beta)))
plot(freq, psd_base,'*-')


psd_on = registroLFP.average_spectrum(i).psd.on.data;
psd_post = registroLFP.average_spectrum(i).psd.post.data;

%--------------------------------------------------------------
pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

Spectrogram_mean_raw = registroLFP.average_spectrum(i).spectrogram.data_raw;
    
t_Spectrogram_mean = registroLFP.average_spectrum(i).spectrogram.tiempo;
f_Spectrogram_mean = registroLFP.average_spectrum(i).spectrogram.frecuencia; 
idx_spect_artifacts = registroLFP.average_spectrum(i).spectrogram.ind_artifacts; 

freq  = f_Spectrogram_mean;

% Se le quita el ruido rosa, dejando mas plano el espectro
%Spectrogram_mean_raw = pink_noise_del(f_Spectrogram_mean, Spectrogram_mean_raw, idx_spect_artifacts); 

% dB Spect
%Spectrogram_mean_raw = db(Spectrogram_mean_raw','power')';

% Separacion por etapas el espectrograma  
idx_pre = find(t_Spectrogram_mean<(pre_m*60.0-5));
Spectrogram_pre_mean = Spectrogram_mean_raw(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);

idx_on = find(t_Spectrogram_mean>(on_inicio_m*60.0+5) & t_Spectrogram_mean<(on_final_m*60.0-5));
Spectrogram_on_mean = Spectrogram_mean_raw(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);

idx_post = find(t_Spectrogram_mean>(post_m*60.0+5) & t_Spectrogram_mean<(tiempo_total*60));
Spectrogram_post_mean = Spectrogram_mean_raw(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);
    
quantil_pre = quantile(Spectrogram_pre_mean,[.025 .25 .50 .75 .975]);
quantil_on = quantile(Spectrogram_on_mean,[.025 .25 .50 .75 .975]);
quantil_post = quantile(Spectrogram_post_mean,[.025 .25 .50 .75 .975]);
    
curva_base = mean([quantil_pre(1,:); quantil_on(1,:); quantil_post(1,:)]);
curva_base = smooth(freq, curva_base,0.1, 'loess')';
[~, idx] = min(abs(freq-banda_beta(1)));
%curva_base = curva_base + (psd_pre(idx) - curva_base(idx));

%plot(freq, psd_pre)
%hold on
%plot(freq, curva_base)


[pow_dBpink, fitStats, pow_pinknoise] = convert_to_dBpink(freq, Spectrogram_mean_raw', [4 10;70 90]);

pow_pinknoise_pre = pow_pinknoise(:,idx_pre(~ismember(idx_pre, idx_spect_artifacts)))';
pow_pinknoise_on = pow_pinknoise(:,idx_on(~ismember(idx_on, idx_spect_artifacts)))';
pow_pinknoise_post = pow_pinknoise(:,idx_post(~ismember(idx_post, idx_spect_artifacts)))';

figure;
plot(freq, db(median(Spectrogram_pre_mean),'power')-db(median(real(pow_pinknoise_pre)),'power'))
hold on
plot(freq, db(median(Spectrogram_on_mean),'power')-db(median(real(pow_pinknoise_on)),'power'))
plot(freq, db(median(Spectrogram_post_mean),'power')-db(median(real(pow_pinknoise_post)),'power'))

figure;
plot(freq, median(Spectrogram_pre_mean)-median(real(pow_pinknoise_pre)))
hold on
plot(freq, median(Spectrogram_on_mean)-median(real(pow_pinknoise_pre)))
plot(freq, median(Spectrogram_post_mean)-median(real(pow_pinknoise_pre)))

figure;
plot(freq, median(Spectrogram_pre_mean))
hold on
plot(freq, median(Spectrogram_on_mean))
plot(freq, median(Spectrogram_post_mean))

figure;
plot(freq, db(median(Spectrogram_pre_mean),'power'))
hold on
plot(freq, db(median(real(pow_pinknoise_pre)),'power'))

figure;
plot(freq, db(median(Spectrogram_on_mean),'power'))
hold on
plot(freq, db(median(real(pow_pinknoise_on)),'power'))

figure;
plot(freq, db(median(Spectrogram_post_mean),'power'))
hold on
plot(freq, db(median(real(pow_pinknoise_post)),'power'))

%Spectrogram_mean = Spectrogram_mean_raw - pow_pinknoise_pre;
Spectrogram_mean = Spectrogram_mean_raw - ones(size(Spectrogram_mean_raw))*diag(median(real(pow_pinknoise_pre)));

Spectrogram_mean_pre = Spectrogram_mean_raw - ones(size(Spectrogram_mean_raw))*diag(median(real(pow_pinknoise_pre)));
Spectrogram_mean_on = Spectrogram_mean_raw - ones(size(Spectrogram_mean_raw))*diag(median(real(pow_pinknoise_on)));
Spectrogram_mean_post = Spectrogram_mean_raw - ones(size(Spectrogram_mean_raw))*diag(median(real(pow_pinknoise_post)));
Spectrogram_mean(idx_pre,:) = Spectrogram_mean_pre(idx_pre,:);
Spectrogram_mean(idx_on,:) = Spectrogram_mean_on(idx_on,:);
Spectrogram_mean(idx_post,:) = Spectrogram_mean_post(idx_post,:);

%Spectrogram_mean = pow_dBpink';
for i = 1:length(t_Spectrogram_mean)
    Spectrogram_mean(i,:) = smooth(freq, Spectrogram_mean(i,:),0.05, 'loess');
end
%-------------------Plot---Mean Spectrogram------------------------------------
fig_6 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(Spectrogram_mean',1,numel(Spectrogram_mean)),[5 99]);
imagesc(t_Spectrogram_mean,freq,Spectrogram_mean',clim); 
%min_spect = min(min(db(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:)'+1,'power')));
%max_spect = max(max(db(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:)'+1,'power')));
%dist_maxmin = max_spect - min_spect;
cmap = colormap(parula(40));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([4 100])
c=colorbar('southoutside');
alphamax = 0.3; % Cuanto se acerca el max al minimo 
alphamin = 0; % Cuanto se acercca el minimo al maximo
alphashift_left = 0.5; % Cuanto se corre a la izquierda los valores
%caxis([alphamin * dist_maxmin + min_spect - alphashift_left*dist_maxmin, max_spect - alphamax * dist_maxmin]); %[-10, 10] ([-20, 15]) [-15, 20]
%caxis([-3 3])
hold on
line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
ylabel(c,'Normalized (u.a.)', 'FontSize', 17)
set(c,'fontsize',17)
