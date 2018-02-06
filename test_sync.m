fig_15 = figure('units','normalized','outerposition',[0 0 1 1]);
imagesc(t,f,phi'); 
cmap = colormap(parula(40));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([1 100])
c=colorbar('southoutside');
%caxis([0 1])
hold on
line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
title(['Mean Coherenciogram multitaper between ','areas ',registroLFP.average_sync{i,j}.names{1},' & ',registroLFP.average_sync{i,j}.names{2}], 'FontSize', 24)
ylabel(c,'Normalized Power [u.a.]', 'FontSize', 17)
set(c,'fontsize',17)

signal1 = registroLFP.area(7).data; %
signal2 = registroLFP.area(8).data;
[C,phi,S12,S1,S2,t,f]=cohgramc(signal1,signal2,[registroLFP.multitaper.coherence.movingwin.window registroLFP.multitaper.coherence.movingwin.winstep],params);
pha12 = angle(S12);

pha12_pre = pha12(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
pha12_on = pha12(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
pha12_post = pha12(idx_post(~ismember(idx_post, idx_spect_artifacts)),:); 

% pre
pha12_pre_delta = pha12_pre(:,(f>=1 & f<=4));
mean_pha12_pre_delta = mean(pha12_pre_delta, 2);
figure
polarhistogram(mean_pha12_pre_delta,'BinWidth',20*(pi/180),'Normalization','probability')

pha12_pre_theta = pha12_pre(:,(f>=4 & f<=8));
mean_pha12_pre_theta = mean(pha12_pre_theta, 2);
figure
polarhistogram(mean_pha12_pre_theta,'BinWidth',20*(pi/180),'Normalization','probability')

pha12_pre_beta = pha12_pre(:,(f>=8 & f<=30));
mean_pha12_pre_beta = mean(pha12_pre_beta, 2);
figure
polarhistogram(mean_pha12_pre_beta,'BinWidth',20*(pi/180),'Normalization','probability')

pha12_pre_gamma = pha12_pre(:,(f>=30 & f<=100));
mean_pha12_pre_gamma = mean(pha12_pre_gamma, 2);
figure
polarhistogram(mean_pha12_pre_gamma,'BinWidth',20*(pi/180),'Normalization','probability')

% On
pha12_on_delta = pha12_on(:,(f>=1 & f<=4));
mean_pha12_on_delta = mean(pha12_on_delta, 2);
figure
polarhistogram(mean_pha12_on_delta,'BinWidth',20*(pi/180),'Normalization','probability')

pha12_on_theta = pha12_on(:,(f>=4 & f<=8));
mean_pha12_on_theta = mean(pha12_on_theta, 2);
figure
polarhistogram(mean_pha12_on_theta,'BinWidth',20*(pi/180),'Normalization','probability')

pha12_on_beta = pha12_on(:,(f>=8 & f<=30));
mean_pha12_on_beta = mean(pha12_on_beta, 2);
figure
polarhistogram(mean_pha12_on_beta,'BinWidth',20*(pi/180),'Normalization','probability')

pha12_on_gamma = pha12_on(:,(f>=30 & f<=100));
mean_pha12_on_gamma = mean(pha12_on_gamma, 2);
figure
polarhistogram(mean_pha12_on_gamma,'BinWidth',20*(pi/180),'Normalization','probability')

% Post
pha12_post_delta = pha12_post(:,(f>=1 & f<=4));
mean_pha12_post_delta = mean(pha12_post_delta, 2);
figure
polarhistogram(mean_pha12_post_delta,'BinWidth',20*(pi/180),'Normalization','probability')

pha12_post_theta = pha12_post(:,(f>=4 & f<=8));
mean_pha12_post_theta = mean(pha12_post_theta, 2);
figure
polarhistogram(mean_pha12_post_theta,'BinWidth',20*(pi/180),'Normalization','probability')

pha12_post_beta = pha12_post(:,(f>=8 & f<=30));
mean_pha12_post_beta = mean(pha12_post_beta, 2);
figure
polarhistogram(mean_pha12_post_beta,'BinWidth',20*(pi/180),'Normalization','probability')

pha12_post_gamma = pha12_post(:,(f>=30 & f<=100));
mean_pha12_post_gamma = mean(pha12_post_gamma, 2);
figure
polarhistogram(mean_pha12_post_gamma,'BinWidth',20*(pi/180),'Normalization','probability')


pha12_pre_beta = pha12_pre(:,(f>=8 & f<=30));
mean_pha12_pre_beta = mean(pha12_pre_beta, 2);
pha12_on_beta = pha12_on(:,(f>=8 & f<=30));
mean_pha12_on_beta = mean(pha12_on_beta, 2);
pha12_post_beta = pha12_post(:,(f>=8 & f<=30));
mean_pha12_post_beta = mean(pha12_post_beta, 2);
figure
polarhistogram(mean_pha12_pre_beta,'BinWidth',10*(pi/180),'Normalization','pdf')
hold on
polarhistogram(mean_pha12_on_beta,'BinWidth',10*(pi/180),'Normalization','pdf')
hold on
polarhistogram(mean_pha12_post_beta,'BinWidth',10*(pi/180),'Normalization','pdf')

% Coherence

signal1 = registroLFP.area(7).data; %
signal2 = registroLFP.area(8).data;
[C,phi,S12,S1,S2,t,f]=cohgramc(signal1,signal2,[registroLFP.multitaper.coherence.movingwin.window registroLFP.multitaper.coherence.movingwin.winstep],params);
pha12 = angle(S12);

pha_pre = pha12(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
pha_on = pha12(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
pha_post = pha12(idx_post(~ismember(idx_post, idx_spect_artifacts)),:); 

C_pre = pha12(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
C_on = pha12(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
C_post = pha12(idx_post(~ismember(idx_post, idx_spect_artifacts)),:); 

pha_pre_beta = pha_pre(:,(f>=8 & f<=30));
mean_pha_pre_beta = mean(pha_pre_beta, 2);

pha_on_beta = pha_on(:,(f>=8 & f<=30));
mean_pha_on_beta = mean(pha_on_beta, 2);

pha_post_beta = pha_post(:,(f>=8 & f<=30));
mean_pha_post_beta = mean(pha_post_beta, 2);

C_pre_beta = C_pre(:,(f>=8 & f<=30));
mean_C_pre_beta = mean(C_pre_beta, 2);

C_on_beta = C_on(:,(f>=8 & f<=30));
mean_C_on_beta = mean(C_on_beta, 2);

C_post_beta = C_post(:,(f>=8 & f<=30));
mean_C_post_beta = mean(C_post_beta, 2);

figure
compass(mean_C_pre_beta, mean_pha_pre_beta)
hold on
compass(mean_C_on_beta, mean_pha_on_beta)
hold on
compass(mean_C_post_beta, mean_pha_post_beta)
