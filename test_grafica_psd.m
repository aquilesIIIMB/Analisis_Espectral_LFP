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

figure;
canales_eval = find(~[registroLFP.channel.removed]);
Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.data;
f_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.frecuencia;
t_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.tiempo;
quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(quantil_pre(1,:), 'power'))
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(quantil_pre(3,:), 'power'))
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(quantil_pre(5,:), 'power'))
figure;
quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
%temp = ones(size(quantil_pre));
%temp(:,1:4:end) = quantil_pre(:,1:4:end);
%quantil_pre = temp; % Para tener los datos cada 3 partiendo de 1
errorbar(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)), 'power'), db(median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)), 'power') - db(quantil_pre(1,:), 'power'), db(quantil_pre(5,:), 'power') - db(median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)), 'power'), 'Color', [0 0.4470 0.7410],'CapSize',20,'LineWidth',0.5)
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)), 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3)

% plot con curva llena
Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.data;
f_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.frecuencia;
t_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.tiempo;
quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);

x=f_Spectrogram;
y1=db(quantil_pre(1,:), 'power');
y2=db(quantil_pre(5,:), 'power');
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,[0 0.4470 0.7410]);                  %#plot filled area
alpha(.3)
hold on
x=f_Spectrogram;
y1=db(quantil_on(1,:), 'power');
y2=db(quantil_on(5,:), 'power');
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,[0.85, 0.325, 0.098]);                  %#plot filled area
alpha(.3)
hold on
x=f_Spectrogram;
y1=db(quantil_post(1,:), 'power');
y2=db(quantil_post(5,:), 'power');
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,[0.929, 0.694, 0.125]);                  %#plot filled area
alpha(.3)
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)), 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3)
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:)), 'power'), 'Color', [0.85, 0.325, 0.098],'LineWidth',3)
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:)), 'power'), 'Color', [0.929, 0.694, 0.125],'LineWidth',3)



%%
figure;
pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

canales_eval = find(~[registroLFP.channel.removed]);
Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.data;
f_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.frecuencia;
t_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.tiempo;

median_psd_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:));
quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
neg_quintil_1_pre = db(median_psd_pre, 'power') - db(quantil_pre(1,:), 'power');
temp = zeros(size(neg_quintil_1_pre));
temp(:,1:4:end) = neg_quintil_1_pre(:,1:4:end);
neg_quintil_1_pre = temp; % Para tener los datos cada 3 partiendo de 1
pos_quintil_5_pre = db(quantil_pre(5,:), 'power') - db(median_psd_pre, 'power');
temp = zeros(size(pos_quintil_5_pre));
temp(:,1:4:end) = pos_quintil_5_pre(:,1:4:end);
pos_quintil_5_pre = temp; % Para tener los datos cada 3 partiendo de 1
plot(f_Spectrogram, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
hold on
plot(f_Spectrogram, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
hold on

median_psd_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:));
quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
neg_quintil_1_on = db(median_psd_on, 'power') - db(quantil_on(1,:), 'power');
temp = zeros(size(neg_quintil_1_on));
temp(:,2:4:end) = neg_quintil_1_on(:,2:4:end);
neg_quintil_1_on = temp; % Para tener los datos cada 3 partiendo de 2
pos_quintil_5_on = db(quantil_on(5,:), 'power') - db(median_psd_on, 'power');
temp = zeros(size(pos_quintil_5_on));
temp(:,2:4:end) = pos_quintil_5_on(:,2:4:end);
pos_quintil_5_on = temp; % Para tener los datos cada 3 partiendo de 2
plot(f_Spectrogram, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
hold on
plot(f_Spectrogram, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
hold on

median_psd_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:));
quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);
neg_quintil_1_post = db(median_psd_post, 'power') - db(quantil_post(1,:), 'power');
temp = zeros(size(neg_quintil_1_post));
temp(:,3:4:end) = neg_quintil_1_post(:,3:4:end);
neg_quintil_1_post = temp; % Para tener los datos cada 3 partiendo de 2
pos_quintil_5_post = db(quantil_post(5,:), 'power') - db(median_psd_post, 'power');
temp = zeros(size(pos_quintil_5_post));
temp(:,3:4:end) = pos_quintil_5_post(:,3:4:end);
pos_quintil_5_post = temp; % Para tener los datos cada 3 partiendo de 2
plot(f_Spectrogram, db(quantil_post(1,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
hold on
plot(f_Spectrogram, db(quantil_post(5,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
hold on

errorbar(f_Spectrogram, db(median_psd_pre, 'power'), neg_quintil_1_pre, pos_quintil_5_pre, 'Color', [0 0.4470 0.7410],'CapSize',5,'LineWidth',0.5)
hold on
p1 = plot(f_Spectrogram, db(median_psd_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
hold on

errorbar(f_Spectrogram, db(median_psd_on, 'power'), neg_quintil_1_on, pos_quintil_5_on, 'Color', [0.85, 0.325, 0.098],'CapSize',5,'LineWidth',0.5)
hold on
p2 = plot(f_Spectrogram, db(median_psd_on, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',3);
hold on

errorbar(f_Spectrogram, db(median_psd_post, 'power'), neg_quintil_1_post, pos_quintil_5_post, 'Color', [0.929, 0.694, 0.125],'CapSize',5,'LineWidth',0.5)
hold on
p3 = plot(f_Spectrogram, db(median_psd_post, 'power'),'Color', [0.929, 0.694, 0.125],'LineWidth',3);
xlim([1 100])
legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim')

%%
figure;
pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

canales_eval = find(~[registroLFP.channel.removed]);
Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.data;
f_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.frecuencia;
t_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.tiempo;

median_psd_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:));
quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
neg_quintil_1_pre = db(median_psd_pre, 'power') - db(quantil_pre(1,:), 'power');
pos_quintil_5_pre = db(quantil_pre(5,:), 'power') - db(median_psd_pre, 'power');
plot(f_Spectrogram, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
hold on
plot(f_Spectrogram, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
hold on

median_psd_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:));
quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
neg_quintil_1_on = db(median_psd_on, 'power') - db(quantil_on(1,:), 'power');
pos_quintil_5_on = db(quantil_on(5,:), 'power') - db(median_psd_on, 'power');
plot(f_Spectrogram, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
hold on
plot(f_Spectrogram, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
hold on

median_psd_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:));
quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);
neg_quintil_1_post = db(median_psd_post, 'power') - db(quantil_post(1,:), 'power');
pos_quintil_5_post = db(quantil_post(5,:), 'power') - db(median_psd_post, 'power');
plot(f_Spectrogram, db(quantil_post(1,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
hold on
plot(f_Spectrogram, db(quantil_post(5,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
hold on

errorbar(f_Spectrogram, db(median_psd_pre, 'power'), neg_quintil_1_pre, pos_quintil_5_pre, 'Color', [0 0.4470 0.7410],'CapSize',5,'LineWidth',0.5)
hold on
p1 = plot(f_Spectrogram, db(median_psd_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
hold on

errorbar(f_Spectrogram, db(median_psd_on, 'power'), neg_quintil_1_on, pos_quintil_5_on, 'Color', [0.85, 0.325, 0.098],'CapSize',5,'LineWidth',0.5)
hold on
p2 = plot(f_Spectrogram, db(median_psd_on, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',3);
hold on

errorbar(f_Spectrogram, db(median_psd_post, 'power'), neg_quintil_1_post, pos_quintil_5_post, 'Color', [0.929, 0.694, 0.125],'CapSize',5,'LineWidth',0.5)
hold on
p3 = plot(f_Spectrogram, db(median_psd_post, 'power'),'Color', [0.929, 0.694, 0.125],'LineWidth',3);
xlim([1 100])
legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim')

%%
figure;
pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

canales_eval = find(~[registroLFP.channel.removed]);
Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.data;
f_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.frecuencia;
t_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.tiempo;
quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);
median_psd_pre = median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:));
median_psd_on = median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:));
median_psd_post = median(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:));

x=f_Spectrogram;
y1=db(quantil_pre(1,:), 'power');
y2=db(quantil_pre(5,:), 'power');
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,[0 0.4470 0.7410]);                  %#plot filled area
alpha(.3)
hold on
x=f_Spectrogram;
y1=db(quantil_on(1,:), 'power');
y2=db(quantil_on(5,:), 'power');
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,[0.85, 0.325, 0.098]);                  %#plot filled area
alpha(.3)
hold on
x=f_Spectrogram;
y1=db(quantil_post(1,:), 'power');
y2=db(quantil_post(5,:), 'power');
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,[0.929, 0.694, 0.125]);                  %#plot filled area
alpha(.3)
hold on
p1 = plot(f_Spectrogram, db(median_psd_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
hold on
p2 = plot(f_Spectrogram, db(median_psd_on, 'power'), 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
hold on
p3 = plot(f_Spectrogram, db(median_psd_post, 'power'), 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
xlim([1 100])
legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim')


