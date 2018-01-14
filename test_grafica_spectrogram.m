
canales_eval = find(~[registroLFP.channel.removed]);
slash_system = foldername(length(foldername));

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

[C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');
m = 1;
i = ia(m);
Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.data;
Spectrogram_mean_raw = registroLFP.average_spectrum(m).spectrogram.data_raw;

t_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.tiempo;
f_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.frecuencia; 

fig_6 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(db(Spectrogram_mean'+1,'power'),1,numel(Spectrogram_mean)),[5 99]);
imagesc(t_Spectrogram_mean,f_Spectrogram_mean,db(Spectrogram_mean'+1,'power'),clim); 
%cmap = colormap('jet');
min_spect = min(min(db(Spectrogram_mean'+1,'power')));
max_spect = max(max(db(Spectrogram_mean'+1,'power')));
dist_maxmin = max_spect - min_spect;
cmap = colormap(jet((round(max_spect) - round(min_spect))*5));
axis xy
ylabel('Frequency (Hz)')
xlabel('Time (sec)');
ylim([1 100])
c=colorbar('southoutside');
alphamax = 0.3; % Cuanto se acerca el max al minimo 
alphamin = 0; % Cuanto se acercca el minimo al maximo
alphashift_left = 0.5; % Cuanto se corre a la izquierda los valores
caxis([alphamin * dist_maxmin + min_spect - alphashift_left*dist_maxmin, max_spect - alphamax * dist_maxmin]); %[-10, 10] ([-20, 15]) [-15, 20]
hold on
line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
title(['Espectrograma Multitaper Promedio de los LFP ',C{ic(1)}])
ylabel(c,'Power (dB)')

figure('units','normalized','outerposition',[0 0 1 1]);    
z = db(Spectrogram_mean'+1,'power');
t = t_Spectrogram_mean;
x = f_Spectrogram_mean;
line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
hold on
surf(t,x,z,'EdgeColor','none');   
axis xy; axis tight; colormap(jet); view(0,90);
c=colorbar('southoutside');
caxis([-10, 15]);  





