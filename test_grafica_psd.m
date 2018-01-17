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
fig_7 = figure('units','points','position',[10,10,600,400]);
Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.data;
f_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.frecuencia;
t_Spectrogram = registroLFP.channel(canales_eval(1)).spectrogram.tiempo;
quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);

x=f_Spectrogram;
y1=db(quantil_pre(2,:), 'power');
y2=db(quantil_pre(4,:), 'power');
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
area_ext_pre = fill(X,Y,[0 0.4470 0.7410]);                  %#plot filled area
alpha(area_ext_pre, .2)
hold on
x=f_Spectrogram;
y1=db(quantil_on(2,:), 'power');
y2=db(quantil_on(4,:), 'power');
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
area_ext_on = fill(X,Y,[0.85, 0.325, 0.098]);                  %#plot filled area
alpha(area_ext_on, .3)
hold on
x=f_Spectrogram;
y1=db(quantil_post(2,:), 'power');
y2=db(quantil_post(4,:), 'power');
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
area_ext_post = fill(X,Y,[0.466, 0.674, 0.188]);                  %#plot filled area
alpha(area_ext_post, .4)
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:)), 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3)
hold on
plot(f_Spectrogram, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
hold on
plot(f_Spectrogram, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.7);
hold on
plot(f_Spectrogram, db(quantil_pre(2,:), 'power'), '-', 'Color', [0 0.4470 0.7410],'LineWidth',1);
hold on
plot(f_Spectrogram, db(quantil_pre(4,:), 'power'), '-', 'Color', [0 0.4470 0.7410],'LineWidth',1);
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:)), 'power'), 'Color', [0.85, 0.325, 0.098],'LineWidth',3)
hold on
plot(f_Spectrogram, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
hold on
plot(f_Spectrogram, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.7);
hold on
plot(f_Spectrogram, db(quantil_on(2,:), 'power'), '-', 'Color', [0.85, 0.325, 0.098],'LineWidth',1);
hold on
plot(f_Spectrogram, db(quantil_on(4,:), 'power'), '-', 'Color', [0.85, 0.325, 0.098],'LineWidth',1);
hold on
plot(registroLFP.channel(canales_eval(1)).spectrogram.frecuencia, db(median(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:)), 'power'), 'Color', [0.466, 0.674, 0.188],'LineWidth',3)
hold on
plot(f_Spectrogram, db(quantil_post(1,:), 'power'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
hold on
plot(f_Spectrogram, db(quantil_post(5,:), 'power'), ':', 'Color', [0.466, 0.674, 0.188],'LineWidth',1.7);
hold on
plot(f_Spectrogram, db(quantil_post(2,:), 'power'), '-', 'Color', [0.466, 0.674, 0.188],'LineWidth',1);
hold on
plot(f_Spectrogram, db(quantil_post(4,:), 'power'), '-', 'Color', [0.466, 0.674, 0.188],'LineWidth',1);
xlim([8 20])

% Verde [0.466, 0.674, 0.188] amarillo [0.929, 0.694, 0.125] azul [0 0.4470 0.7410] rojo [0.85, 0.325, 0.098]
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

%-------------------Plot---Sectral Frequency in Beta [8-20]Hz---------------------------
    fig_10 = figure('units','points','position',[10,10,600,400]);
    quantil_pre = quantile(Spectrogram((t_Spectrogram<(pre_m*60.0-30)),:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_pre = db(Spectral_pre, 'power') - db(quantil_pre(1,:), 'power');
    temp = zeros(size(neg_quintil_1_pre));
    temp(:,1:3:end) = neg_quintil_1_pre(:,1:3:end);
    neg_quintil_1_pre = temp; % Para tener los datos cada 3 partiendo de 1
    
    neg_quintil_2_pre = db(Spectral_pre, 'power') - db(quantil_pre(2,:), 'power');
    temp = zeros(size(neg_quintil_2_pre));
    temp(:,1:3:end) = neg_quintil_2_pre(:,1:3:end);
    neg_quintil_2_pre = temp; % Para tener los datos cada 3 partiendo de 1
    
    pos_quintil_5_pre = db(quantil_pre(5,:), 'power') - db(Spectral_pre, 'power');
    temp = zeros(size(pos_quintil_5_pre));
    temp(:,1:3:end) = pos_quintil_5_pre(:,1:3:end);
    pos_quintil_5_pre = temp; % Para tener los datos cada 3 partiendo de 1
    
    pos_quintil_4_pre = db(quantil_pre(4,:), 'power') - db(Spectral_pre, 'power');
    temp = zeros(size(pos_quintil_4_pre));
    temp(:,1:3:end) = pos_quintil_4_pre(:,1:3:end);
    pos_quintil_4_pre = temp; % Para tener los datos cada 3 partiendo de 1
    
    plot(f_Spectrogram, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.5);
    hold on
    plot(f_Spectrogram, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',1.5);
    hold on
    plot(f_Spectrogram, db(quantil_pre(2,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',2);
    hold on
    plot(f_Spectrogram, db(quantil_pre(4,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',2);
    hold on

    quantil_on = quantile(Spectrogram(t_Spectrogram>(on_inicio_m*60.0+30) & t_Spectrogram<(on_final_m*60.0-30),:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_on = db(Spectral_on, 'power') - db(quantil_on(1,:), 'power');
    temp = zeros(size(neg_quintil_1_on));
    temp(:,2:3:end) = neg_quintil_1_on(:,2:3:end);
    neg_quintil_1_on = temp; % Para tener los datos cada 3 partiendo de 2
    
    neg_quintil_2_on = db(Spectral_on, 'power') - db(quantil_on(2,:), 'power');
    temp = zeros(size(neg_quintil_2_on));
    temp(:,2:3:end) = neg_quintil_2_on(:,2:3:end);
    neg_quintil_2_on = temp; % Para tener los datos cada 3 partiendo de 2
    
    pos_quintil_5_on = db(quantil_on(5,:), 'power') - db(Spectral_on, 'power');
    temp = zeros(size(pos_quintil_5_on));
    temp(:,2:3:end) = pos_quintil_5_on(:,2:3:end);
    pos_quintil_5_on = temp; % Para tener los datos cada 3 partiendo de 2
    
    pos_quintil_4_on = db(quantil_on(4,:), 'power') - db(Spectral_on, 'power');
    temp = zeros(size(pos_quintil_4_on));
    temp(:,2:3:end) = pos_quintil_4_on(:,2:3:end);
    pos_quintil_4_on = temp; % Para tener los datos cada 3 partiendo de 2
    
    plot(f_Spectrogram, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.5);
    hold on
    plot(f_Spectrogram, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',1.5);
    hold on
    plot(f_Spectrogram, db(quantil_on(2,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',2);
    hold on
    plot(f_Spectrogram, db(quantil_on(4,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',2);
    hold on

    quantil_post = quantile(Spectrogram(t_Spectrogram>(post_m*60.0+30) & t_Spectrogram<(tiempo_total*60),:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_post = db(Spectral_post, 'power') - db(quantil_post(1,:), 'power');
    temp = zeros(size(neg_quintil_1_post));
    temp(:,3:3:end) = neg_quintil_1_post(:,3:3:end);
    neg_quintil_1_post = temp; % Para tener los datos cada 3 partiendo de 2
    
    neg_quintil_2_post = db(Spectral_post, 'power') - db(quantil_post(2,:), 'power');
    temp = zeros(size(neg_quintil_2_post));
    temp(:,3:3:end) = neg_quintil_2_post(:,3:3:end);
    neg_quintil_2_post = temp; % Para tener los datos cada 3 partiendo de 2
    
    pos_quintil_5_post = db(quantil_post(5,:), 'power') - db(Spectral_post, 'power');
    temp = zeros(size(pos_quintil_5_post));
    temp(:,3:3:end) = pos_quintil_5_post(:,3:3:end);
    pos_quintil_5_post = temp; % Para tener los datos cada 3 partiendo de 2
    
    pos_quintil_4_post = db(quantil_post(4,:), 'power') - db(Spectral_post, 'power');
    temp = zeros(size(pos_quintil_4_post));
    temp(:,3:3:end) = pos_quintil_4_post(:,3:3:end);
    pos_quintil_4_post = temp; % Para tener los datos cada 3 partiendo de 2
    
    plot(f_Spectrogram, db(quantil_post(1,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',1.5);
    hold on
    plot(f_Spectrogram, db(quantil_post(5,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',1.5);
    hold on    
    plot(f_Spectrogram, db(quantil_post(2,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',2);
    hold on
    plot(f_Spectrogram, db(quantil_post(4,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',2);
    hold on

    errorbar(f_Spectrogram, db(Spectral_pre, 'power'), neg_quintil_1_pre, pos_quintil_5_pre, 'Color', [0 0.4470 0.7410],'CapSize',5,'LineWidth',0.5)
    hold on
    errorbar(f_Spectrogram, db(Spectral_pre, 'power'), neg_quintil_2_pre, pos_quintil_4_pre, 'Color', [0 0.4470 0.7410],'CapSize',5,'LineWidth',1.5)
    hold on
    p1 = plot(f_Spectrogram, db(Spectral_pre, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',4);
    hold on

    errorbar(f_Spectrogram, db(Spectral_on, 'power'), neg_quintil_1_on, pos_quintil_5_on, 'Color', [0.85, 0.325, 0.098],'CapSize',5,'LineWidth',0.5)
    hold on
    errorbar(f_Spectrogram, db(Spectral_on, 'power'), neg_quintil_2_on, pos_quintil_4_on, 'Color', [0.85, 0.325, 0.098],'CapSize',5,'LineWidth',1.5)
    hold on
    p2 = plot(f_Spectrogram, db(Spectral_on, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',4);
    hold on

    errorbar(f_Spectrogram, db(Spectral_post, 'power'), neg_quintil_1_post, pos_quintil_5_post, 'Color', [0.929, 0.694, 0.125],'CapSize',5,'LineWidth',0.5)
    hold on
    errorbar(f_Spectrogram, db(Spectral_post, 'power'), neg_quintil_2_post, pos_quintil_4_post, 'Color', [0.929, 0.694, 0.125],'CapSize',5,'LineWidth',1.5)
    hold on
    p3 = plot(f_Spectrogram, db(Spectral_post, 'power'),'Color', [0.929, 0.694, 0.125],'LineWidth',4);
    xlim([8 20])
    %lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    %lgd.FontSize = 20;
    set(gca,'fontsize',15)
    xlabel('Frecuencia [Hz]', 'FontSize', 20); %ylabel('Amplitud (dB)', 'FontSize', 24);
    title(['Respuesta en Frecuencia en beta ',registroLFP.channel(canales_eval(j)).area,' ',registroLFP.channel(canales_eval(j)).name], 'FontSize', 15)
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channel(canales_eval(j)).area,' de ',registroLFP.channel(canales_eval(j)).name,' PSD en beta del LFP'];
    saveas(fig_10,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_10)
    
        %% Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    %Spectral_pre_mean = median(Spectrogram_mean((t_Spectrogram<(pre_m*60.0-30)),:));
    quantil_pre = quantile(Spectrogram_pre_mean(ind_noartefactos_Spec_pre,:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_pre = db(Spectral_pre_mean, 'power') - db(quantil_pre(1,:), 'power');
    temp = zeros(size(neg_quintil_1_pre));
    temp(:,1:4:end) = neg_quintil_1_pre(:,1:4:end);
    neg_quintil_1_pre = temp; % Para tener los datos cada 3 partiendo de 1
    pos_quintil_5_pre = db(quantil_pre(5,:), 'power') - db(Spectral_pre_mean, 'power');
    temp = zeros(size(pos_quintil_5_pre));
    temp(:,1:4:end) = pos_quintil_5_pre(:,1:4:end);
    pos_quintil_5_pre = temp; % Para tener los datos cada 3 partiendo de 1
    plot(f_Spectrogram_mean, db(quantil_pre(1,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on
    plot(f_Spectrogram_mean, db(quantil_pre(5,:), 'power'), ':', 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on

    %Spectral_on_mean = median(Spectrogram_mean(t_Spectrogram_mean>(on_inicio_m*60.0+30) & t_Spectrogram_mean<(on_final_m*60.0-30),:));
    quantil_on = quantile(Spectrogram_on_mean(ind_noartefactos_Spec_on,:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_on = db(Spectral_on_mean, 'power') - db(quantil_on(1,:), 'power');
    temp = zeros(size(neg_quintil_1_on));
    temp(:,2:4:end) = neg_quintil_1_on(:,2:4:end);
    neg_quintil_1_on = temp; % Para tener los datos cada 3 partiendo de 2
    pos_quintil_5_on = db(quantil_on(5,:), 'power') - db(Spectral_on_mean, 'power');
    temp = zeros(size(pos_quintil_5_on));
    temp(:,2:4:end) = pos_quintil_5_on(:,2:4:end);
    pos_quintil_5_on = temp; % Para tener los datos cada 3 partiendo de 2
    plot(f_Spectrogram_mean, db(quantil_on(1,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on
    plot(f_Spectrogram_mean, db(quantil_on(5,:), 'power'), ':', 'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on

    %Spectral_post_mean = median(Spectrogram_mean(t_Spectrogram_mean>(post_m*60.0+30) & t_Spectrogram_mean<(tiempo_total*60),:));
    quantil_post = quantile(Spectrogram_post_mean(ind_noartefactos_Spec_post,:),[.05 .25 .50 .75 .95]);
    neg_quintil_1_post = db(Spectral_post_mean, 'power') - db(quantil_post(1,:), 'power');
    temp = zeros(size(neg_quintil_1_post));
    temp(:,3:4:end) = neg_quintil_1_post(:,3:4:end);
    neg_quintil_1_post = temp; % Para tener los datos cada 3 partiendo de 2
    pos_quintil_5_post = db(quantil_post(5,:), 'power') - db(Spectral_post_mean, 'power');
    temp = zeros(size(pos_quintil_5_post));
    temp(:,3:4:end) = pos_quintil_5_post(:,3:4:end);
    pos_quintil_5_post = temp; % Para tener los datos cada 3 partiendo de 2
    plot(f_Spectrogram_mean, db(quantil_post(1,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
    hold on
    plot(f_Spectrogram_mean, db(quantil_post(5,:), 'power'), ':', 'Color', [0.929, 0.694, 0.125],'LineWidth',3);
    hold on

    errorbar(f_Spectrogram_mean, db(Spectral_pre_mean, 'power'), neg_quintil_1_pre, pos_quintil_5_pre, 'Color', [0 0.4470 0.7410],'CapSize',5,'LineWidth',0.5)
    hold on
    p1 = plot(f_Spectrogram_mean, db(Spectral_pre_mean, 'power'), 'Color', [0 0.4470 0.7410],'LineWidth',3);
    hold on

    errorbar(f_Spectrogram_mean, db(Spectral_on_mean, 'power'), neg_quintil_1_on, pos_quintil_5_on, 'Color', [0.85, 0.325, 0.098],'CapSize',5,'LineWidth',0.5)
    hold on
    p2 = plot(f_Spectrogram_mean, db(Spectral_on_mean, 'power'),'Color', [0.85, 0.325, 0.098],'LineWidth',3);
    hold on

    errorbar(f_Spectrogram_mean, db(Spectral_post_mean, 'power'), neg_quintil_1_post, pos_quintil_5_post, 'Color', [0.929, 0.694, 0.125],'CapSize',5,'LineWidth',0.5)
    hold on
    p3 = plot(f_Spectrogram_mean, db(Spectral_post_mean, 'power'),'Color', [0.929, 0.694, 0.125],'LineWidth',3);
    xlim([1 100])
    lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency (Hz)', 'FontSize', 24); ylabel('Power (dB)', 'FontSize', 24)
    title(['Respuesta en Frecuencia Multitaper Promedio de los LFP ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' PSD de los LFP '];
    saveas(fig_5,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_5)
    
