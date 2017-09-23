%%% show metricas

% Band Power Beta (Puntos y linea)
percent_power_band_pre_injured = [];
percent_power_band_on_injured = [];
percent_power_band_post_injured = [];
percent_power_band_pre_injured_error = [];
percent_power_band_on_injured_error = [];
percent_power_band_post_injured_error = [];

percent_power_band_pre_uninjured = [];
percent_power_band_on_uninjured = [];
percent_power_band_post_uninjured = [];
percent_power_band_pre_uninjured_error = [];
percent_power_band_on_uninjured_error = [];
percent_power_band_post_uninjured_error = [];

for i = 1:length(protocoloLFP.injured)
    percent_power_band_pre_injured = [percent_power_band_pre_injured; protocoloLFP.injured(i).power_band.pre.mean];
    percent_power_band_on_injured = [percent_power_band_on_injured; protocoloLFP.injured(i).power_band.on.mean];
    percent_power_band_post_injured = [percent_power_band_post_injured; protocoloLFP.injured(i).power_band.post.mean];
    percent_power_band_pre_injured_error = [percent_power_band_pre_injured_error; protocoloLFP.injured(i).power_band.pre.std];
    percent_power_band_on_injured_error = [percent_power_band_on_injured_error; protocoloLFP.injured(i).power_band.on.std];
    percent_power_band_post_injured_error = [percent_power_band_post_injured_error; protocoloLFP.injured(i).power_band.post.std];
    
    percent_power_band_pre_uninjured = [percent_power_band_pre_uninjured; protocoloLFP.uninjured(i).power_band.pre.mean];
    percent_power_band_on_uninjured = [percent_power_band_on_uninjured; protocoloLFP.uninjured(i).power_band.on.mean];
    percent_power_band_post_uninjured = [percent_power_band_post_uninjured; protocoloLFP.uninjured(i).power_band.post.mean];
    percent_power_band_pre_uninjured_error = [percent_power_band_pre_uninjured_error; protocoloLFP.uninjured(i).power_band.pre.std];
    percent_power_band_on_uninjured_error = [percent_power_band_on_uninjured_error; protocoloLFP.uninjured(i).power_band.on.std];
    percent_power_band_post_uninjured_error = [percent_power_band_post_uninjured_error; protocoloLFP.uninjured(i).power_band.post.std];
    
end

percent_power_band_injured = [percent_power_band_pre_injured, percent_power_band_on_injured, percent_power_band_post_injured];
percent_power_band_injured_error = [percent_power_band_pre_injured_error, percent_power_band_on_injured_error, percent_power_band_post_injured_error];
percent_power_band_uninjured = [percent_power_band_pre_uninjured, percent_power_band_on_uninjured, percent_power_band_post_uninjured];
percent_power_band_uninjured_error = [percent_power_band_pre_uninjured_error, percent_power_band_on_uninjured_error, percent_power_band_post_uninjured_error];

figure;
subplot(2,1,1)
%bar(percent_power_band_injured,'grouped')
errorbar(percent_power_band_injured,percent_power_band_injured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
%xt = get(gca, 'XTick');
xt = 1:length({protocoloLFP.injured.area});
set(gca, 'XTick', xt, 'XTickLabel', {protocoloLFP.injured.area})
ylim([min([min(percent_power_band_injured-percent_power_band_injured_error),min(percent_power_band_uninjured-percent_power_band_uninjured_error)])-1 max([max(percent_power_band_injured+percent_power_band_injured_error),max(percent_power_band_uninjured+percent_power_band_uninjured_error)])+1])
ylabel('Percentage of Beta Power')
%legend('Pre', 'Stim', 'Post','Location','southwest');
legend('Pre', 'Stim', 'Post');
legend('boxoff')
grid on
title(['Percentage of Beta Power in the Injured Hemisphere ',strrep({protocoloLFP.name},'_',' ')])

subplot(2,1,2)
%bar(percent_power_band_uninjured,'grouped');
errorbar(percent_power_band_uninjured,percent_power_band_uninjured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
%xt = get(gca, 'XTick');
xt = 1:length({protocoloLFP.injured.area});
set(gca, 'XTick', xt, 'XTickLabel', {protocoloLFP.uninjured.area})
ylim([min([min(percent_power_band_injured-percent_power_band_injured_error),min(percent_power_band_uninjured-percent_power_band_uninjured_error)])-1 max([max(percent_power_band_injured+percent_power_band_injured_error),max(percent_power_band_uninjured+percent_power_band_uninjured_error)])+1])
ylabel('Percentage of Beta Power')
%legend('Pre', 'Stim', 'Post','Location','southwest');
legend('Pre', 'Stim', 'Post');
legend('boxoff')
grid on
title(['Percentage of Beta Power in the Uninjured Hemisphere ',strrep({protocoloLFP.name},'_',' ')])

% Band Power Beta (Barra)
figure;
subplot(2,1,1)
bar(percent_power_band_injured,'grouped')
%errorbar(percent_power_band_injured,percent_power_band_injured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
xt = get(gca, 'XTick');
%xt = 1:length({protocoloLFP.injured.area});
set(gca, 'XTick', xt, 'XTickLabel', {protocoloLFP.injured.area})
ylim([min([min(percent_power_band_injured-percent_power_band_injured_error),min(percent_power_band_uninjured-percent_power_band_uninjured_error)])-1 max([max(percent_power_band_injured+percent_power_band_injured_error),max(percent_power_band_uninjured+percent_power_band_uninjured_error)])+1])
ylabel('Percentage of Beta Power')
%legend('Pre', 'Stim', 'Post','Location','southwest');
legend('Pre', 'Stim', 'Post');
legend('boxoff')
grid on
title(['Percentage of Beta Power in the Injured Hemisphere ',strrep({protocoloLFP.name},'_',' ')])

subplot(2,1,2)
bar(percent_power_band_uninjured,'grouped');
%errorbar(percent_power_band_uninjured,percent_power_band_uninjured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
xt = get(gca, 'XTick');
%xt = 1:length({protocoloLFP.injured.area});
set(gca, 'XTick', xt, 'XTickLabel', {protocoloLFP.uninjured.area})
ylim([min([min(percent_power_band_injured-percent_power_band_injured_error),min(percent_power_band_uninjured-percent_power_band_uninjured_error)])-1 max([max(percent_power_band_injured+percent_power_band_injured_error),max(percent_power_band_uninjured+percent_power_band_uninjured_error)])+1])
ylabel('Percentage of Beta Power')
%legend('Pre', 'Stim', 'Post','Location','southwest');
legend('Pre', 'Stim', 'Post');
legend('boxoff')
grid on
title(['Percentage of Beta Power in the Uninjured Hemisphere ',strrep({protocoloLFP.name},'_',' ')])


% Coherencia agrupada
%Mean
mean_coherency_pre_injured = [];
mean_coherency_on_injured = [];
mean_coherency_post_injured = [];
mean_coherency_pre_injured_error = [];
mean_coherency_on_injured_error = [];
mean_coherency_post_injured_error = [];

mean_coherency_pre_uninjured = [];
mean_coherency_on_uninjured = [];
mean_coherency_post_uninjured = [];
mean_coherency_pre_uninjured_error = [];
mean_coherency_on_uninjured_error = [];
mean_coherency_post_uninjured_error = [];

p = 2;
areas_coherency_uninjured = {};
areas_coherency_injured = {};

for i=1:length(protocoloLFP.injured)-1

    % Coherencia    
    for j = length(protocoloLFP.injured):-1:p

        mean_coherency_pre_injured = [mean_coherency_pre_injured; protocoloLFP.coherency.injured.pre.mean_beta{i,j}];
        mean_coherency_on_injured = [mean_coherency_on_injured; protocoloLFP.coherency.injured.on.mean_beta{i,j}];
        mean_coherency_post_injured = [mean_coherency_post_injured; protocoloLFP.coherency.injured.post.mean_beta{i,j}];
        mean_coherency_pre_injured_error = [mean_coherency_pre_injured_error; protocoloLFP.coherency.injured.pre.std_mean_beta{i,j}];
        mean_coherency_on_injured_error = [mean_coherency_on_injured_error; protocoloLFP.coherency.injured.on.std_mean_beta{i,j}];
        mean_coherency_post_injured_error = [mean_coherency_post_injured_error; protocoloLFP.coherency.injured.post.std_mean_beta{i,j}];
        areas_coherency_injured = {areas_coherency_injured{:}, [protocoloLFP.injured(i).area, ' vs ', protocoloLFP.injured(j).area]};

        mean_coherency_pre_uninjured = [mean_coherency_pre_uninjured; protocoloLFP.coherency.uninjured.pre.mean_beta{i,j}];
        mean_coherency_on_uninjured = [mean_coherency_on_uninjured; protocoloLFP.coherency.uninjured.on.mean_beta{i,j}];
        mean_coherency_post_uninjured = [mean_coherency_post_uninjured; protocoloLFP.coherency.uninjured.post.mean_beta{i,j}];
        mean_coherency_pre_uninjured_error = [mean_coherency_pre_uninjured_error; protocoloLFP.coherency.uninjured.pre.std_mean_beta{i,j}];
        mean_coherency_on_uninjured_error = [mean_coherency_on_uninjured_error; protocoloLFP.coherency.uninjured.on.std_mean_beta{i,j}];
        mean_coherency_post_uninjured_error = [mean_coherency_post_uninjured_error; protocoloLFP.coherency.uninjured.post.std_mean_beta{i,j}];
        areas_coherency_uninjured = {areas_coherency_uninjured{:}, [protocoloLFP.uninjured(i).area, ' vs ', protocoloLFP.uninjured(j).area]};

    end
    
    p=p+1;
end

mean_coherency_injured = [mean_coherency_pre_injured, mean_coherency_on_injured, mean_coherency_post_injured];
mean_coherency_injured_error = [mean_coherency_pre_injured_error, mean_coherency_on_injured_error, mean_coherency_post_injured_error];
mean_coherency_uninjured = [mean_coherency_pre_uninjured, mean_coherency_on_uninjured, mean_coherency_post_uninjured];
mean_coherency_uninjured_error = [mean_coherency_pre_uninjured_error, mean_coherency_on_uninjured_error, mean_coherency_post_uninjured_error];


%figure;
%subplot(2,1,1)
%bar(mean_coherency_injured,'grouped');
%xt = get(gca, 'XTick');
%set(gca, 'XTick', xt, 'XTickLabel', areas_coherency_injured)
%legend('Injured Pre', 'Injured Stim', 'Injured Post','Location','southwest');
%legend('boxoff')
%grid on
%subplot(2,1,2)
%bar(mean_coherency_uninjured,'grouped');
%xt = get(gca, 'XTick');
%set(gca, 'XTick', xt, 'XTickLabel', areas_coherency_uninjured)
%legend('Uninjured Pre', 'Uninjured Stim', 'Uninjured Post','Location','southwest');
%legend('boxoff')
%grid on

figure;
subplot(2,1,1)
%plot(mean_coherency_injured,'o-','LineWidth',3.0,'MarkerSize',5,'MarkerFaceColor','k');
errorbar(mean_coherency_injured,mean_coherency_injured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', areas_coherency_injured)
ylim([min([min(mean_coherency_injured-mean_coherency_injured_error),min(mean_coherency_uninjured-mean_coherency_uninjured_error)])-0.01 max([max(mean_coherency_injured+mean_coherency_injured_error),max(mean_coherency_uninjured+mean_coherency_uninjured_error)])+0.01])
ylabel('Mean Coherence')
legend('Pre', 'Stim', 'Post');
legend('boxoff')
grid on
title(['Mean Coherence in beta between Areas of the Injured Hemisphere ',strrep({protocoloLFP.name},'_',' ')])

subplot(2,1,2)
%plot(mean_coherency_uninjured,'o-','LineWidth',3.0,'MarkerSize',5,'MarkerFaceColor','k');
errorbar(mean_coherency_uninjured,mean_coherency_uninjured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', areas_coherency_uninjured)
ylim([min([min(mean_coherency_injured-mean_coherency_injured_error),min(mean_coherency_uninjured-mean_coherency_uninjured_error)])-0.01 max([max(mean_coherency_injured+mean_coherency_injured_error),max(mean_coherency_uninjured+mean_coherency_uninjured_error)])+0.01])
ylabel('Mean Coherence')
legend('Pre', 'Stim', 'Post');
legend('boxoff')
grid on
title(['Mean Coherence in beta between Areas of the Uninjured Hemisphere ',strrep({protocoloLFP.name},'_',' ')])


%Sumada
%sum_coherency_pre_injured = [];
%sum_coherency_on_injured = [];
%sum_coherency_post_injured = [];
%sum_coherency_pre_injured_error = [];
%sum_coherency_on_injured_error = [];
%sum_coherency_post_injured_error = [];

%sum_coherency_pre_uninjured = [];
%sum_coherency_on_uninjured = [];
%sum_coherency_post_uninjured = [];
%sum_coherency_pre_uninjured_error = [];
%sum_coherency_on_uninjured_error = [];
%sum_coherency_post_uninjured_error = [];

%p = 2;
%areas_coherency_uninjured = {};
%areas_coherency_injured = {};

%for i=1:length(protocoloLFP.injured)-1

    % Coherencia    
%    for j = length(protocoloLFP.injured):-1:p

%        sum_coherency_pre_injured = [sum_coherency_pre_injured; protocoloLFP.coherency.injured.pre.sum_beta{i,j}];
%        sum_coherency_on_injured = [sum_coherency_on_injured; protocoloLFP.coherency.injured.on.sum_beta{i,j}];
%        sum_coherency_post_injured = [sum_coherency_post_injured; protocoloLFP.coherency.injured.post.sum_beta{i,j}];
%        sum_coherency_pre_injured_error = [sum_coherency_pre_injured_error; protocoloLFP.coherency.injured.pre.std_sum_beta{i,j}];
%        sum_coherency_on_injured_error = [sum_coherency_on_injured_error; protocoloLFP.coherency.injured.on.std_sum_beta{i,j}];
%        sum_coherency_post_injured_error = [sum_coherency_post_injured_error; protocoloLFP.coherency.injured.post.std_sum_beta{i,j}];
%        areas_coherency_injured = {areas_coherency_injured{:}, [protocoloLFP.injured(i).area, ' vs ', protocoloLFP.injured(j).area]};

%        sum_coherency_pre_uninjured = [sum_coherency_pre_uninjured; protocoloLFP.coherency.uninjured.pre.sum_beta{i,j}];
%        sum_coherency_on_uninjured = [sum_coherency_on_uninjured; protocoloLFP.coherency.uninjured.on.sum_beta{i,j}];
%        sum_coherency_post_uninjured = [sum_coherency_post_uninjured; protocoloLFP.coherency.uninjured.post.sum_beta{i,j}];
%        sum_coherency_pre_uninjured_error = [sum_coherency_pre_uninjured_error; protocoloLFP.coherency.uninjured.pre.std_sum_beta{i,j}];
%        sum_coherency_on_uninjured_error = [sum_coherency_on_uninjured_error; protocoloLFP.coherency.uninjured.on.std_sum_beta{i,j}];
%        sum_coherency_post_uninjured_error = [sum_coherency_post_uninjured_error; protocoloLFP.coherency.uninjured.post.std_sum_beta{i,j}];
%        areas_coherency_uninjured = {areas_coherency_uninjured{:}, [protocoloLFP.uninjured(i).area, ' vs ', protocoloLFP.uninjured(j).area]};

%    end
    
%    p=p+1;
%end

%sum_coherency_injured = [sum_coherency_pre_injured, sum_coherency_on_injured, sum_coherency_post_injured];
%sum_coherency_injured_error = [sum_coherency_pre_injured_error, sum_coherency_on_injured_error, sum_coherency_post_injured_error];
%sum_coherency_uninjured = [sum_coherency_pre_uninjured, sum_coherency_on_uninjured, sum_coherency_post_uninjured];
%sum_coherency_uninjured_error = [sum_coherency_pre_uninjured_error, sum_coherency_on_uninjured_error, sum_coherency_post_uninjured_error];

%figure;
%subplot(2,1,1)
%errorbar(sum_coherency_injured,sum_coherency_injured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
%xt = get(gca, 'XTick');
%set(gca, 'XTick', xt, 'XTickLabel', areas_coherency_injured)
%ylim([min([min(sum_coherency_injured-sum_coherency_injured_error),min(sum_coherency_uninjured-sum_coherency_uninjured_error)])-0.01 max([max(sum_coherency_injured+sum_coherency_injured_error),max(sum_coherency_uninjured+sum_coherency_uninjured_error)])+0.01])
%ylabel('Coherencia')
%legend('Pre', 'Stim', 'Post');
%legend('boxoff')
%grid on
%title('Comparacion de la coherencia entre areas del hemisferio lesionado')

%subplot(2,1,2)
%errorbar(sum_coherency_uninjured,sum_coherency_uninjured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
%xt = get(gca, 'XTick');
%set(gca, 'XTick', xt, 'XTickLabel', areas_coherency_uninjured)
%ylim([min([min(sum_coherency_injured-sum_coherency_injured_error),min(sum_coherency_uninjured-sum_coherency_uninjured_error)])-0.01 max([max(sum_coherency_injured+sum_coherency_injured_error),max(sum_coherency_uninjured+sum_coherency_uninjured_error)])+0.01])
%ylabel('Coherencia')
%legend('Pre', 'Stim', 'Post');
%legend('boxoff')
%grid on
%title('Comparacion de la coherencia entre areas del hemisferio no lesionado')

clear areas_coherency_injured areas_coherency_uninjured i j mean_coherency_injured
clear mean_coherency_injured_error mean_coherency_on_injured mean_coherency_on_injured_error
clear mean_coherency_on_uninjured mean_coherency_on_uninjured_error mean_coherency_post_injured
clear mean_coherency_post_injured_error mean_coherency_post_uninjured mean_coherency_post_uninjured_error
clear mean_coherency_pre_injured mean_coherency_pre_injured_error mean_coherency_pre_uninjured
clear mean_coherency_uninjured_error p 
clear mean_coherency_pre_uninjured_error mean_coherency_uninjured
clear percent_power_band_on_injured percent_power_band_on_injured_error percent_power_band_on_uninjured
clear percent_power_band_on_uninjured_error percent_power_band_post_injured percent_power_band_post_injured_error
clear percent_power_band_post_uninjured percent_power_band_post_uninjured_error percent_power_band_pre_injured
clear percent_power_band_pre_injured_error percent_power_band_pre_uninjured percent_power_band_pre_uninjured_error
clear xt

