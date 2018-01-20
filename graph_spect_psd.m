function graph_spect_psd(f_Spectrogram, t_Spectrogram, Spectrogram, Spectral_pre, Spectral_on, Spectral_post, registroLFP)

tinicial = registroLFP.times.extra_time_s;
pre_m = registroLFP.times.pre_m + tinicial/60;
on_inicio_m = registroLFP.times.start_on_m + tinicial/60;
on_final_m = registroLFP.times.end_on_m + tinicial/60;
post_m = registroLFP.times.post_m + tinicial/60;
tiempo_total = registroLFP.times.end_m + tinicial/60;

%--------------------Grafica-----------------------------------
%-------------------Plot---Spectrogram------------------------------------
fig_8 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(db(Spectrogram','power'),1,numel(Spectrogram)),[5 99]);
imagesc(t_Spectrogram,f_Spectrogram,db(Spectrogram','power'),clim); colormap('jet');
axis xy
ylabel('Frequency (Hz)', 'FontSize', 24)
xlabel('Time (sec)', 'FontSize', 24)
set(gca,'fontsize',20)
%ylim(registroLFP.multitaper.params.fpass)
ylim([4 100])
c=colorbar('southoutside');
%caxis([0, 30]); %[0, 30] [-10, 10] [-20, 15] [-15, 20]
hold on
line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
%set(fig_8,'fontsize',20)
title('Espectrograma Multitaper del LFP Ch1', 'FontSize', 24)
ylabel(c,'Power (dB)', 'FontSize', 17)
set(c,'fontsize',17)

fig_7 = figure('units','normalized','outerposition',[0 0 1 1]);
p1 = plot(f_Spectrogram, db(Spectral_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
hold on
p2 = plot(f_Spectrogram, db(Spectral_on, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',3);
hold on
p3 = plot(f_Spectrogram, db(Spectral_post, 'power'),'Color', [0.466, 0.674, 0.188],'LineWidth',3);
xlim([4 100])
lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
lgd.FontSize = 20;
set(gca,'fontsize',20)
xlabel('Frecuencia [Hz]', 'FontSize', 24); ylabel('Amplitud (dB)', 'FontSize', 24);
title('Respuesta en Frecuencia Multitaper del LFP Ch1', 'FontSize', 24)   

fig_10 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(convert_to_dBpink(f_Spectrogram, Spectrogram', [4 100]),1,numel(Spectrogram)),[5 99]);
imagesc(t_Spectrogram,f_Spectrogram,convert_to_dBpink(f_Spectrogram, Spectrogram', [4 100]),clim); colormap('jet');
axis xy
ylabel('Frequency (Hz)', 'FontSize', 24)
xlabel('Time (sec)', 'FontSize', 24)
set(gca,'fontsize',20)
%ylim(registroLFP.multitaper.params.fpass)
ylim([4 100])
c=colorbar('southoutside');
%caxis([-3, 3]); %[0, 30] [-10, 10] [-20, 15] [-15, 20]
hold on
line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
%set(fig_8,'fontsize',20)
title('Espectrograma Multitaper del LFP Ch1', 'FontSize', 24)
ylabel(c,'Power (dB)', 'FontSize', 17)
set(c,'fontsize',17)

fig_9 = figure('units','normalized','outerposition',[0 0 1 1]);
p1 = plot(f_Spectrogram, convert_to_dBpink(f_Spectrogram, Spectral_pre', [4 100]), 'Color', [0 0.4470 0.7410],'LineWidth',3);
hold on
p2 = plot(f_Spectrogram, convert_to_dBpink(f_Spectrogram, Spectral_on', [4 100]), 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
hold on
p3 = plot(f_Spectrogram, convert_to_dBpink(f_Spectrogram, Spectral_post', [4 100]),'Color', [0.466, 0.674, 0.188],'LineWidth',3);
xlim([4 100])
lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
lgd.FontSize = 20;
set(gca,'fontsize',20)
xlabel('Frecuencia [Hz]', 'FontSize', 24); ylabel('Amplitud (dB)', 'FontSize', 24);
title('Respuesta en Frecuencia Multitaper del LFP Ch1', 'FontSize', 24)

end
