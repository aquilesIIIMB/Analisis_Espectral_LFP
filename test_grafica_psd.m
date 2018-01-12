pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
semilogy(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, quantil_pre','Color',[0 0.4470 0.7410])
hold on
quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
semilogy(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, quantil_on','Color',[0.85, 0.325, 0.098])
hold on
quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);
semilogy(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, quantil_post','Color',[0.929, 0.694, 0.125])

xlim([0 100])


% Grafico de psd
quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
temp = ones(size(quantil_pre));
temp(:,1:4:end) = quantil_pre(:,1:4:end);
quantil_pre = temp; % Para tener los datos cada 3 partiendo de 1
errorbar(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)), 'power'), db(quantil_pre(1,:), 'power'), db(quantil_pre(5,:), 'power'), 'Color', [0 0.4470 0.7410],'CapSize',20,'LineWidth',0.5)
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)), 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3)
hold on

quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
temp = ones(size(quantil_on));
temp(:,2:4:end) = quantil_on(:,2:4:end);
quantil_on = temp; % Para tener los datos cada 3 partiendo de 1
errorbar(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:)), 'power'), db(quantil_on(1,:), 'power'), db(quantil_on(5,:), 'power'), 'Color', [0.85, 0.325, 0.098],'CapSize',20,'LineWidth',0.5)
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:)), 'power'),'Color',[0.85, 0.325, 0.098],'LineWidth',3)
hold on

quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);
temp = ones(size(quantil_post));
temp(:,3:4:end) = quantil_post(:,3:4:end);
quantil_post = temp; % Para tener los datos cada 3 partiendo de 1
errorbar(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:)), 'power'), db(quantil_post(1,:), 'power'), db(quantil_post(5,:), 'power'), 'Color', [0.929, 0.694, 0.125],'CapSize',20,'LineWidth',0.5)
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:)), 'power'),'Color',[0.929, 0.694, 0.125],'LineWidth',3)
xlim([0 100])


quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(quantil_pre(3,:), 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3)
hold on
quantil_pre([1,2,4,5],1:2:end) = 1;
errorbar(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(quantil_pre(3,:), 'power'), db(quantil_pre(1,:), 'power'), db(quantil_pre(5,:), 'power'), 'Color', [0 0.4470 0.7410],'CapSize',10)
hold on
quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
quantil_on(:,1:2:end) = 0;
errorbar(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(quantil_on(3,:), 'power'), db(quantil_on(1,:), 'power'), db(quantil_on(5,:), 'power'), 'Color', [0.85, 0.325, 0.098],'CapSize',10)
hold on
semilogy(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(quantil_on(3,:), 'power'),'Color',[0.85, 0.325, 0.098],'LineWidth',3)
hold on
quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);
quantil_post(:,1:2:end) = 0;
errorbar(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(quantil_post(3,:), 'power'), db(quantil_post(1,:), 'power'), db(quantil_post(5,:), 'power'), 'Color', [0.929, 0.694, 0.125],'CapSize',10)
hold on
semilogy(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(quantil_post(3,:), 'power'),'Color',[0.929, 0.694, 0.125],'LineWidth',3)
xlim([0 100])


quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
plot(quantil_pre(3,:))
hold on
plot(mean(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)))
hold on
plot(median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)))

