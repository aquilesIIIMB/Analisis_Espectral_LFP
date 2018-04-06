figure;
for i = 1:5
    plot(registroLFP.average_spectrum(i).spectrogram.irasa.Beta)
    hold on
end

figure;
for i = 1:5
    plot(registroLFP.average_spectrum(i+5).spectrogram.irasa.Beta)
    hold on
end

time = registroLFP.average_spectrum(i).spectrogram.irasa.time;

% Mejor
azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];
    
names_areas = {registroLFP.area.name};
% Eliminar la ultima letra de las areas (el hemisferio)
names_areas = cellfun(@(S) S(1:end-1), names_areas, 'Uniform', 0);
names_areas = unique(names_areas,'stable');

fig_11 = figure('units','normalized','outerposition',[0 0 1 1]);
for i = 1:5
    y = registroLFP.average_spectrum(i).spectrogram.irasa.Beta;
    idx_spect_artifacts = registroLFP.average_spectrum(i).spectrogram.ind_artifacts;
    idx_pre = (time<6*60);
    idx_on = (time>7*60 & time<12*60);
    idx_post = (time>13.5*60);
    
    y_pre = mean(y(idx_pre(~ismember(idx_pre, idx_spect_artifacts))));
    y_on = mean(y(idx_on(~ismember(idx_on, idx_spect_artifacts))));
    y_post = mean(y(idx_post(~ismember(idx_post, idx_spect_artifacts))));
    
    %plot(i-0.2,y_pre,'bO','MarkerSize',10,'MarkerFaceColor','b')
    %hold on
    %plot(i,y_on,'rO','MarkerSize',10,'MarkerFaceColor','r')
    %hold on
    %plot(i+0.2,y_post,'gO','MarkerSize',10,'MarkerFaceColor','g')
    %hold on
    bar_pre = bar(2*i-0.5,y_pre,0.5,'grouped');
    hold on;
    bar_on = bar(2*i,y_on,0.5,'grouped');
    hold on;
    bar_post = bar(2*i+0.5,y_post,0.5,'grouped');
    hold on;
    %xt = get(gca, 'XTick');
    xt = 2:2:10;
    set(gca, 'XTick', xt, 'XTickLabel', names_areas)
    legend('Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    bar_pre.FaceColor = azul; bar_on.FaceColor = rojo; bar_post.FaceColor = verde;
    grid on
    %ylim([0 4])
    %ylabel('Scale-free activity Power [W/Hz]', 'FontSize', 24)
    %set(gca,'fontsize',20)
    %title(['Scale-free activity Signal Power of left and right hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            
end
xlim([0 12])

fig_12 = figure('units','normalized','outerposition',[0 0 1 1]);
for i = 1:5
    y = registroLFP.average_spectrum(i+5).spectrogram.irasa.Beta;
    idx_spect_artifacts = registroLFP.average_spectrum(i+5).spectrogram.ind_artifacts;
    idx_pre = (time<6*60);
    idx_on = (time>7*60 & time<12*60);
    idx_post = (time>13.5*60);
    
    y_pre = mean(y(idx_pre(~ismember(idx_pre, idx_spect_artifacts))));
    y_on = mean(y(idx_on(~ismember(idx_on, idx_spect_artifacts))));
    y_post = mean(y(idx_post(~ismember(idx_post, idx_spect_artifacts))));
    
    %plot(i-0.2,y_pre,'bO','MarkerSize',10,'MarkerFaceColor','b')
    %hold on
    %plot(i,y_on,'rO','MarkerSize',10,'MarkerFaceColor','r')
    %hold on
    %plot(i+0.2,y_post,'gO','MarkerSize',10,'MarkerFaceColor','g')
    %hold on
    bar_pre = bar(2*i-0.5,y_pre,0.5,'grouped');
    hold on;
    bar_on = bar(2*i,y_on,0.5,'grouped');
    hold on;
    bar_post = bar(2*i+0.5,y_post,0.5,'grouped');
    hold on;
    %xt = get(gca, 'XTick');
    xt = 2:2:10;
    set(gca, 'XTick', xt, 'XTickLabel', names_areas)
    legend('Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    bar_pre.FaceColor = azul; bar_on.FaceColor = rojo; bar_post.FaceColor = verde;
    grid on
    %ylim([0 4])
    %ylabel('Scale-free activity Power [W/Hz]', 'FontSize', 24)
    %set(gca,'fontsize',20)
    %title(['Scale-free activity Signal Power of left and right hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            
end
xlim([0 12])


% Bueno pero mediana no se usa tanto
figure;
for i = 1:5
    y = registroLFP.average_spectrum(i).spectrogram.irasa.Beta;
    idx_spect_artifacts = registroLFP.average_spectrum(i).spectrogram.ind_artifacts;
    idx_pre = (time<6*60);
    idx_on = (time>7*60 & time<12*60);
    idx_post = (time>13.5*60);
    
    y_pre = median(y(idx_pre(~ismember(idx_pre, idx_spect_artifacts))));
    y_on = median(y(idx_on(~ismember(idx_on, idx_spect_artifacts))));
    y_post = median(y(idx_post(~ismember(idx_post, idx_spect_artifacts))));
    
    plot(1,y_pre,'bO')
    hold on
    plot(2,y_on,'rO')
    hold on
    plot(3,y_post,'gO')
    hold on
end
xlim([0 4])

figure;
for i = 1:5
    y = registroLFP.average_spectrum(i+5).spectrogram.irasa.Beta;
    idx_spect_artifacts = registroLFP.average_spectrum(i+5).spectrogram.ind_artifacts;
    idx_pre = (time<6*60);
    idx_on = (time>7*60 & time<12*60);
    idx_post = (time>13.5*60);
    
    y_pre = median(y(idx_pre(~ismember(idx_pre, idx_spect_artifacts))));
    y_on = median(y(idx_on(~ismember(idx_on, idx_spect_artifacts))));
    y_post = median(y(idx_post(~ismember(idx_post, idx_spect_artifacts))));
    
    plot(1,y_pre,'bO')
    hold on
    plot(2,y_on,'rO')
    hold on
    plot(3,y_post,'gO')
    hold on
end
xlim([0 4])

% No adecuado
figure;
for i = 1:5
    y = registroLFP.average_spectrum(i).spectrogram.irasa.Beta;
    idx_spect_artifacts = registroLFP.average_spectrum(i).spectrogram.ind_artifacts;
    idx_pre = (time<6*60);
    idx_on = (time>7*60 & time<12*60);
    idx_post = (time>13.5*60);
    
    y_pre = (y(idx_pre(~ismember(idx_pre, idx_spect_artifacts))));
    y_on = (y(idx_on(~ismember(idx_on, idx_spect_artifacts))));
    y_post = (y(idx_post(~ismember(idx_post, idx_spect_artifacts))));
    
    plot(1,y_pre,'bO')
    hold on
    plot(2,y_on,'rO')
    hold on
    plot(3,y_post,'gO')
    hold on
end
xlim([0 4])

figure;
for i = 1:5
    y = registroLFP.average_spectrum(i+5).spectrogram.irasa.Beta;
    idx_spect_artifacts = registroLFP.average_spectrum(i+5).spectrogram.ind_artifacts;
    idx_pre = (time<6*60);
    idx_on = (time>7*60 & time<12*60);
    idx_post = (time>13.5*60);
    
    y_pre = (y(idx_pre(~ismember(idx_pre, idx_spect_artifacts))));
    y_on = (y(idx_on(~ismember(idx_on, idx_spect_artifacts))));
    y_post = (y(idx_post(~ismember(idx_post, idx_spect_artifacts))));
    
    plot(1,y_pre,'bO')
    hold on
    plot(2,y_on,'rO')
    hold on
    plot(3,y_post,'gO')
    hold on
end
xlim([0 4])