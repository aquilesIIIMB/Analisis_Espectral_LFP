%%% TEST
banda_beta = [8, 20];
percent_power_band = [];
areas = {};

for i = 1:length(registroLFP.average_spectrum)
    freq = registroLFP.average_spectrum(i).spectrogram.frecuencia;
    freq_beta = freq(freq>=banda_beta(1) & freq<=banda_beta(2));

    psd_pre = db(registroLFP.average_spectrum(i).psd.pre.data,'power');
    psd_pre_beta = psd_pre(freq>=banda_beta(1) & freq<=banda_beta(2));
    potencia_min_base = psd_pre_beta(1);
    potencia_max_base = psd_pre_beta(end);

    base=interp1([min(freq_beta), max(freq_beta)],[potencia_min_base, potencia_max_base],freq_beta,'linear');
    psd_base = psd_pre;
    psd_base(freq>=banda_beta(1) & freq<=banda_beta(2)) = base;

    psd_on = db(registroLFP.average_spectrum(i).psd.on.data,'power');
    psd_post = db(registroLFP.average_spectrum(i).psd.post.data,'power');

    min_valor_psd = min([min(psd_pre), min(psd_on), min(psd_post)]);
    power_band_base = bandpower(psd_base-min_valor_psd,freq,banda_beta,'psd');
    power_band_pre = bandpower(psd_pre-min_valor_psd,freq,banda_beta,'psd');
    power_band_on = bandpower(psd_on-min_valor_psd,freq,banda_beta,'psd');
    power_band_post = bandpower(psd_post-min_valor_psd,freq,banda_beta,'psd');

    percent_power_band_pre = (100*power_band_pre/power_band_base)-100;
    percent_power_band_on = (100*power_band_on/power_band_base)-100;
    percent_power_band_post = (100*power_band_post/power_band_base)-100;
    
    area_actual = registroLFP.average_spectrum(i).area{1};
    areas = {areas{:},area_actual};
    percent_power_band = [percent_power_band; [percent_power_band_pre,percent_power_band_on,percent_power_band_post]];
    
    fprintf('%s\n', area_actual)
    fprintf('Porcentaje de banda beta en pre: %.2f \n', percent_power_band_pre)
    fprintf('Porcentaje de banda beta en on: %.2f \n', percent_power_band_on)
    fprintf('Porcentaje de banda beta en post: %.2f \n\n', percent_power_band_post)
end
disp(' ')
subplot(2,1,1)
bar(percent_power_band(1:5,:),'grouped');
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', areas(1:5))
legend('Pre', 'Stim', 'Post');
subplot(2,1,2)
bar(percent_power_band(6:10,:),'grouped');
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', areas(6:10))
legend('Pre', 'Stim', 'Post');
%colormap autumn(5)
%plot(freq,psd_base,freq,psd_pre,freq,psd_on,freq,psd_post)

%% Coherencia 
signal1 = mean([registroLFP.channel(48:53).data],2);
signal2 = mean([registroLFP.channel(34:37).data],2);
%(tiempo>7*60.0 & tiempo<12*60.0) (tiempo<6*60.0)
%(tiempo>7 & tiempo<12) (tiempo<6) (tiempo>14)

tiempo = registroLFP.times.steps_m;
signal1_pre = signal1(tiempo<6);
signal1_on = signal1(tiempo>7 & tiempo<12);
signal1_post = signal1(tiempo>14);
signal2_pre = signal2(tiempo<6);
signal2_on = signal2(tiempo>7 & tiempo<12);
signal2_post = signal2(tiempo>14);

% Chronux
params = registroLFP.multitaper.params;
params.fpass = [1 150];
% Pre
[C,phi,S12,S1,S2,f]=coherencyc(signal1_pre,signal2_pre,params);
MSC_pre = C.^2;
mean_cohe_beta_pre = mean(MSC_pre(f>=banda_beta(1) & f<=banda_beta(2)));
sum_cohe_beta_pre = sum(MSC_pre(f>=banda_beta(1) & f<=banda_beta(2)));
disp(mean_cohe_beta_pre)
disp(sum_cohe_beta_pre)
MSC_smooth_pre = envelope(MSC_pre,500,'rms');
% On
[C,phi,S12,S1,S2,f]=coherencyc(signal1_on,signal2_on,params);
MSC_on = C.^2;
mean_cohe_beta_on = mean(MSC_on(f>=banda_beta(1) & f<=banda_beta(2)));
sum_cohe_beta_on = sum(MSC_on(f>=banda_beta(1) & f<=banda_beta(2)));
disp(mean_cohe_beta_on)
disp(sum_cohe_beta_on)
MSC_smooth_on = envelope(MSC_on,500,'rms');
% Post
[C,phi,S12,S1,S2,f]=coherencyc(signal1_post,signal2_post,params);
MSC_post = C.^2;
mean_cohe_beta_post = mean(MSC_post(f>=banda_beta(1) & f<=banda_beta(2)));
sum_cohe_beta_post = sum(MSC_post(f>=banda_beta(1) & f<=banda_beta(2)));
disp(mean_cohe_beta_post)
disp(sum_cohe_beta_post)
MSC_smooth_post = envelope(MSC_post,500,'rms');

%MSC_smooth = medfilt1(MSC,300);
%MSC_smooth = hampel(MSC,13);
%MSC_smooth = envelope(MSC,30,'peak');

figure;
subplot(3,1,1);
plot(f,MSC_pre)
xlim([0 50])
subplot(3,1,2);
plot(f,MSC_on)
xlim([0 50])
subplot(3,1,3);
plot(f,MSC_post)
xlim([0 50])

figure;
subplot(3,1,1);
plot(f,MSC_smooth_pre)
xlim([0 50])
ylim([min([min(MSC_smooth_pre),min(MSC_smooth_on),min(MSC_smooth_post)]) max([max(MSC_smooth_pre),max(MSC_smooth_on),max(MSC_smooth_post)])])
grid on
subplot(3,1,2);
plot(f,MSC_smooth_on)
xlim([0 50])
ylim([min([min(MSC_smooth_pre),min(MSC_smooth_on),min(MSC_smooth_post)]) max([max(MSC_smooth_pre),max(MSC_smooth_on),max(MSC_smooth_post)])])
grid on
subplot(3,1,3);
plot(f,MSC_smooth_post)
xlim([0 50])
ylim([min([min(MSC_smooth_pre),min(MSC_smooth_on),min(MSC_smooth_post)]) max([max(MSC_smooth_pre),max(MSC_smooth_on),max(MSC_smooth_post)])])
grid on

figure;
plot(f,MSC_smooth_pre,'LineWidth',2.0)
hold on
plot(f,MSC_smooth_on,'LineWidth',2.0)
plot(f,MSC_smooth_post,':','LineWidth',2.0)
grid on
xlim([5 25])

%figure;
%subplot(3,1,1);
%plot(f(1:1000:end),MSC_smooth_pre(1:1000:end),'LineWidth',2.0)
%xlim([0 50])
%hold on
%subplot(3,1,2);
%plot(f(1:1000:end),MSC_smooth_on(1:1000:end),'-.','LineWidth',2.0)
%xlim([0 50])
%subplot(3,1,3);
%plot(f(1:1000:end),MSC_smooth_post(1:1000:end),':','LineWidth',2.0)
%xlim([0 50])
%legend('pre','on','post')

% Lib Matlab
[Cxy,f] = mscohere(signal1,signal2,hamming(100),2,2048,1000);
plot(f,Cxy)
xlim([0 100])

%%% Coherogram
banda_beta = [8, 20];

signal1 = mean([registroLFP.channel(48:53).data],2);
signal2 = mean([registroLFP.channel(34:37).data],2);
params = registroLFP.multitaper.params;
movingwin = [registroLFP.multitaper.movingwin.window registroLFP.multitaper.movingwin.winstep];
[C,phi,S12,S1,S2,t,f]=cohgramc(signal1,signal2,movingwin,params);

% Coherencia promedio por etapa
Coherency_pre_mean = mean(C((t<6*60),:),1);
Coherency_on_mean = mean(C((t>7*60.0 & t<12*60.0),:),1);
Coherency_post_mean = mean(C((t>14*60),:),1);

% Metricas en la banda beta
mean_cohe_beta_pre = mean(Coherency_pre_mean(f>=banda_beta(1) & f<=banda_beta(2)));
sum_cohe_beta_pre = sum(Coherency_pre_mean(f>=banda_beta(1) & f<=banda_beta(2)));
fprintf('Promedio de la coherencia en beta en etapa pre: %.4f \n', mean_cohe_beta_pre)
fprintf('Cantidad integrada de coherencia en beta en etapa pre: %.2f \n\n', sum_cohe_beta_pre)

mean_cohe_beta_on = mean(Coherency_on_mean(f>=banda_beta(1) & f<=banda_beta(2)));
sum_cohe_beta_on = sum(Coherency_on_mean(f>=banda_beta(1) & f<=banda_beta(2)));
fprintf('Promedio de la coherencia en beta en etapa de stim: %.4f \n', mean_cohe_beta_on)
fprintf('Cantidad integrada de coherencia en beta en etapa de stim: %.2f \n\n', sum_cohe_beta_on)

mean_cohe_beta_post = mean(Coherency_post_mean(f>=banda_beta(1) & f<=banda_beta(2)));
sum_cohe_beta_post = sum(Coherency_post_mean(f>=banda_beta(1) & f<=banda_beta(2)));
fprintf('Promedio de la coherencia en beta en etapa post: %.4f \n', mean_cohe_beta_post)
fprintf('Cantidad integrada de coherencia en beta en etapa post: %.2f \n\n', sum_cohe_beta_post)

figure;
plot(f,Coherency_pre_mean,'LineWidth',2.0)
hold on
plot(f,Coherency_on_mean,'LineWidth',2.0)
plot(f,Coherency_post_mean,':','LineWidth',2.0)
grid on
xlim([0 100])
legend('pre','on','post')

