% Show metricas de todos los registros

% Protocolos que se evaluaran
protocolos = [protocolo_20Hz;protocolo_150Hz;protocolo_300Hz;...
    protocoloLFP_p375;protocolo_p2500;protocolo_p5000;...
    protocolo_p375_300Hz;protocolo_p2500_300Hz;protocolo_p5000_300Hz];

%% Band Power Beta
percent_power_band_injured_protocolos_total = {};
percent_power_band_injured_error_protocolos_total = {};
percent_power_band_uninjured_protocolos_total = {};
percent_power_band_uninjured_error_protocolos_total = {};
    
for ind_a = 1:length(protocolos(1).injured)
    
    % Band Power Beta
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
    
    percent_power_band_injured_protocolos = [];
    percent_power_band_injured_error_protocolos = [];
    percent_power_band_uninjured_protocolos = [];
    percent_power_band_uninjured_error_protocolos = [];

    for ind_p = 1:length(protocolos)
        percent_power_band_pre_injured = [percent_power_band_pre_injured; protocolos(ind_p).injured(ind_a).power_band.pre.mean];
        percent_power_band_on_injured = [percent_power_band_on_injured; protocolos(ind_p).injured(ind_a).power_band.on.mean];
        percent_power_band_post_injured = [percent_power_band_post_injured; protocolos(ind_p).injured(ind_a).power_band.post.mean];
        percent_power_band_pre_injured_error = [percent_power_band_pre_injured_error; protocolos(ind_p).injured(ind_a).power_band.pre.std];
        percent_power_band_on_injured_error = [percent_power_band_on_injured_error; protocolos(ind_p).injured(ind_a).power_band.on.std];
        percent_power_band_post_injured_error = [percent_power_band_post_injured_error; protocolos(ind_p).injured(ind_a).power_band.post.std];

        percent_power_band_pre_uninjured = [percent_power_band_pre_uninjured; protocolos(ind_p).uninjured(ind_a).power_band.pre.mean];
        percent_power_band_on_uninjured = [percent_power_band_on_uninjured; protocolos(ind_p).uninjured(ind_a).power_band.on.mean];
        percent_power_band_post_uninjured = [percent_power_band_post_uninjured; protocolos(ind_p).uninjured(ind_a).power_band.post.mean];
        percent_power_band_pre_uninjured_error = [percent_power_band_pre_uninjured_error; protocolos(ind_p).uninjured(ind_a).power_band.pre.std];
        percent_power_band_on_uninjured_error = [percent_power_band_on_uninjured_error; protocolos(ind_p).uninjured(ind_a).power_band.on.std];
        percent_power_band_post_uninjured_error = [percent_power_band_post_uninjured_error; protocolos(ind_p).uninjured(ind_a).power_band.post.std];
        
        percent_power_band_injured_protocolos = [percent_power_band_injured_protocolos, {[protocolos(ind_p).injured(ind_a).power_band.pre.mean, protocolos(ind_p).injured(ind_a).power_band.on.mean, protocolos(ind_p).injured(ind_a).power_band.post.mean]}];
        percent_power_band_injured_error_protocolos = [percent_power_band_injured_error_protocolos, {[protocolos(ind_p).injured(ind_a).power_band.pre.std, protocolos(ind_p).injured(ind_a).power_band.on.std, protocolos(ind_p).injured(ind_a).power_band.post.std]}];
        percent_power_band_uninjured_protocolos = [percent_power_band_uninjured_protocolos, {[protocolos(ind_p).uninjured(ind_a).power_band.pre.mean, protocolos(ind_p).uninjured(ind_a).power_band.on.mean, protocolos(ind_p).uninjured(ind_a).power_band.post.mean]}];
        percent_power_band_uninjured_error_protocolos = [percent_power_band_uninjured_error_protocolos, {[protocolos(ind_p).uninjured(ind_a).power_band.pre.std, protocolos(ind_p).uninjured(ind_a).power_band.on.std, protocolos(ind_p).uninjured(ind_a).power_band.post.std]}];
        
    end
    
    percent_power_band_injured_protocolos_total = [percent_power_band_injured_protocolos_total; percent_power_band_injured_protocolos];
    percent_power_band_injured_error_protocolos_total = [percent_power_band_injured_error_protocolos_total; percent_power_band_injured_error_protocolos];
    percent_power_band_uninjured_protocolos_total = [percent_power_band_uninjured_protocolos_total; percent_power_band_uninjured_protocolos];
    percent_power_band_uninjured_error_protocolos_total = [percent_power_band_uninjured_error_protocolos_total; percent_power_band_uninjured_error_protocolos];
    

    percent_power_band_injured = [percent_power_band_pre_injured, percent_power_band_on_injured, percent_power_band_post_injured];
    percent_power_band_injured_error = [percent_power_band_pre_injured_error, percent_power_band_on_injured_error, percent_power_band_post_injured_error];
    percent_power_band_uninjured = [percent_power_band_pre_uninjured, percent_power_band_on_uninjured, percent_power_band_post_uninjured];
    percent_power_band_uninjured_error = [percent_power_band_pre_uninjured_error, percent_power_band_on_uninjured_error, percent_power_band_post_uninjured_error];
    
    % Graficar    
    figure;
    subplot(2,1,1)
    %bar(percent_power_band_injured,'grouped')
    errorbar(percent_power_band_injured,percent_power_band_injured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
    %xt = get(gca, 'XTick');
    xt = 1:length(strrep({protocolos.name},'_',' '));
    set(gca, 'XTick', xt, 'XTickLabel', strrep({protocolos.name},'_',' '))
    ylim([min([min(percent_power_band_injured-percent_power_band_injured_error),min(percent_power_band_uninjured-percent_power_band_uninjured_error)])-1 max([max(percent_power_band_injured+percent_power_band_injured_error),max(percent_power_band_uninjured+percent_power_band_uninjured_error)])+1])
    ylabel('Porcentaje de potencia en beta')
    %legend('Pre', 'Stim', 'Post','Location','southwest');
    legend('Pre', 'Stim', 'Post');
    legend('boxoff')
    grid on
    title(['Porcentaje de potencia en beta en el Hemisferio Lesionado (',protocolos(ind_p).injured(ind_a).area,')'])

    subplot(2,1,2)
    %bar(percent_power_band_uninjured,'grouped');
    errorbar(percent_power_band_uninjured,percent_power_band_uninjured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
    %xt = get(gca, 'XTick');
    xt = 1:length(strrep({protocolos.name},'_',' '));
    set(gca, 'XTick', xt, 'XTickLabel', strrep({protocolos.name},'_',' '))
    ylim([min([min(percent_power_band_injured-percent_power_band_injured_error),min(percent_power_band_uninjured-percent_power_band_uninjured_error)])-1 max([max(percent_power_band_injured+percent_power_band_injured_error),max(percent_power_band_uninjured+percent_power_band_uninjured_error)])+1])
    ylabel('Porcentaje de potencia en beta')
    %legend('Pre', 'Stim', 'Post','Location','southwest');
    legend('Pre', 'Stim', 'Post');
    legend('boxoff')
    grid on
    title(['Porcentaje de potencia en beta en el Hemisferio No Lesionado (',protocolos(ind_p).injured(ind_a).area,')'])
    
end

% Tabla de porcentaje de potencia en beta

for ind_p = 1:length(protocolos)
    
    a = string(cell2mat([percent_power_band_injured_protocolos_total(:,ind_p)])-cell2mat([percent_power_band_injured_error_protocolos_total(:,ind_p)]));
    b = string(cell2mat([percent_power_band_injured_protocolos_total(:,ind_p)]));
    c = string(cell2mat([percent_power_band_injured_protocolos_total(:,ind_p)])+cell2mat([percent_power_band_injured_error_protocolos_total(:,ind_p)]));
    area_t = {protocolos(1).injured(:).area};
    x = [string(a(:,1)),string(b(:,1)),string(c(:,1))];
    y = [string(a(:,2)),string(b(:,2)),string(c(:,2))];
    z = [string(a(:,3)),string(b(:,3)),string(c(:,3))];
    T_injure = table(area_t',x,y,z,...
        'VariableNames',{'Areas','Pre_Inj','Stim_Inj','Post_Inj'});
    b_inj = b;
    
    a = string(cell2mat([percent_power_band_uninjured_protocolos_total(:,ind_p)])-cell2mat([percent_power_band_uninjured_error_protocolos_total(:,ind_p)]));
    b = string(cell2mat([percent_power_band_uninjured_protocolos_total(:,ind_p)]));
    c = string(cell2mat([percent_power_band_uninjured_protocolos_total(:,ind_p)])+cell2mat([percent_power_band_uninjured_error_protocolos_total(:,ind_p)]));
    area_t = {protocolos(1).uninjured(:).area};
    x = [string(a(:,1)),string(b(:,1)),string(c(:,1))];
    y = [string(a(:,2)),string(b(:,2)),string(c(:,2))];
    z = [string(a(:,3)),string(b(:,3)),string(c(:,3))];
    T_uninjure = table(area_t',x,y,z,...
        'VariableNames',{'Areas','Pre_Uninj','Stim_Uninj','Post_Uninj'});
    b_uninj = b;
    

    disp('Porecentaje de Potencia PSD en beta')
    disp(strrep(protocolos(ind_p).name,'_',' '))
    disp(T_injure)    
    fprintf('Promedio de %% Potencia en beta en Pre: %.2f\n',mean(str2double(b_inj(:,1))))
    fprintf('Promedio de %% Potencia en beta en Stim: %.2f\n',mean(str2double(b_inj(:,2))))
    fprintf('Promedio de %% Potencia en beta en Post: %.2f\n\n',mean(str2double(b_inj(:,3))))
    disp(T_uninjure)
    fprintf('Promedio de %% Potencia en beta en Pre: %.2f\n',mean(str2double(b_uninj(:,1))))
    fprintf('Promedio de %% Potencia en beta en Stim: %.2f\n',mean(str2double(b_uninj(:,2))))
    fprintf('Promedio de %% Potencia en beta en Post: %.2f\n\n\n',mean(str2double(b_uninj(:,3))))

end


%% Coherencia agrupada
%% Mean por protocolo
for ind_p = 1:length(protocolos)
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

    for i=1:length(protocolos(ind_p).injured)-1

        % Coherencia    
        for j = length(protocolos(ind_p).injured):-1:p

            mean_coherency_pre_injured = [mean_coherency_pre_injured; protocolos(ind_p).coherency.injured.pre.mean_beta{i,j}];
            mean_coherency_on_injured = [mean_coherency_on_injured; protocolos(ind_p).coherency.injured.on.mean_beta{i,j}];
            mean_coherency_post_injured = [mean_coherency_post_injured; protocolos(ind_p).coherency.injured.post.mean_beta{i,j}];
            mean_coherency_pre_injured_error = [mean_coherency_pre_injured_error; protocolos(ind_p).coherency.injured.pre.std_mean_beta{i,j}];
            mean_coherency_on_injured_error = [mean_coherency_on_injured_error; protocolos(ind_p).coherency.injured.on.std_mean_beta{i,j}];
            mean_coherency_post_injured_error = [mean_coherency_post_injured_error; protocolos(ind_p).coherency.injured.post.std_mean_beta{i,j}];
            areas_coherency_injured = {areas_coherency_injured{:}, [protocolos(ind_p).injured(i).area, ' vs ', protocolos(ind_p).injured(j).area]};

            mean_coherency_pre_uninjured = [mean_coherency_pre_uninjured; protocolos(ind_p).coherency.uninjured.pre.mean_beta{i,j}];
            mean_coherency_on_uninjured = [mean_coherency_on_uninjured; protocolos(ind_p).coherency.uninjured.on.mean_beta{i,j}];
            mean_coherency_post_uninjured = [mean_coherency_post_uninjured; protocolos(ind_p).coherency.uninjured.post.mean_beta{i,j}];
            mean_coherency_pre_uninjured_error = [mean_coherency_pre_uninjured_error; protocolos(ind_p).coherency.uninjured.pre.std_mean_beta{i,j}];
            mean_coherency_on_uninjured_error = [mean_coherency_on_uninjured_error; protocolos(ind_p).coherency.uninjured.on.std_mean_beta{i,j}];
            mean_coherency_post_uninjured_error = [mean_coherency_post_uninjured_error; protocolos(ind_p).coherency.uninjured.post.std_mean_beta{i,j}];
            areas_coherency_uninjured = {areas_coherency_uninjured{:}, [protocolos(ind_p).uninjured(i).area, ' vs ', protocolos(ind_p).uninjured(j).area]};

        end

        p=p+1;
    end

    mean_coherency_injured = [mean_coherency_pre_injured, mean_coherency_on_injured, mean_coherency_post_injured];
    mean_coherency_injured_error = [mean_coherency_pre_injured_error, mean_coherency_on_injured_error, mean_coherency_post_injured_error];
    mean_coherency_uninjured = [mean_coherency_pre_uninjured, mean_coherency_on_uninjured, mean_coherency_post_uninjured];
    mean_coherency_uninjured_error = [mean_coherency_pre_uninjured_error, mean_coherency_on_uninjured_error, mean_coherency_post_uninjured_error];
    
    % Ver si VALE la pena por el tiempo
    min_amp = min([(mean_coherency_injured(:,1)-mean_coherency_injured_error(:,1)),...
        (mean_coherency_injured(:,2)-mean_coherency_injured_error(:,2)),...
        (mean_coherency_injured(:,3)-mean_coherency_injured_error(:,3)),...
        (mean_coherency_uninjured(:,1)-mean_coherency_uninjured_error(:,1)),...
        (mean_coherency_uninjured(:,2)-mean_coherency_uninjured_error(:,2)),...
        (mean_coherency_uninjured(:,3)-mean_coherency_uninjured_error(:,3))]); 
    
    max_amp = max([(mean_coherency_injured(:,1)+mean_coherency_injured_error(:,1)),...
        (mean_coherency_injured(:,2)+mean_coherency_injured_error(:,2)),...
        (mean_coherency_injured(:,3)+mean_coherency_injured_error(:,3)),...
        (mean_coherency_uninjured(:,1)+mean_coherency_uninjured_error(:,1)),...
        (mean_coherency_uninjured(:,2)+mean_coherency_uninjured_error(:,2)),...
        (mean_coherency_uninjured(:,3)+mean_coherency_uninjured_error(:,3))]); 
    
    
    % Tabla de Coherencia
    T_injure = table(areas_coherency_injured',[string(mean_coherency_injured(:,1)-mean_coherency_injured_error(:,1)),string(mean_coherency_injured(:,1)),string(mean_coherency_injured(:,1)+mean_coherency_injured_error(:,1))],...
        [string(mean_coherency_injured(:,2)-mean_coherency_injured_error(:,2)),string(mean_coherency_injured(:,2)),string(mean_coherency_injured(:,2)+mean_coherency_injured_error(:,2))],...
        [string(mean_coherency_injured(:,3)-mean_coherency_injured_error(:,3)),string(mean_coherency_injured(:,3)),string(mean_coherency_injured(:,3)+mean_coherency_injured_error(:,3))],...)
    'VariableNames',{'Areas','Pre_Inj','Stim_Inj','Post_Inj'});

    T_uninjure = table(areas_coherency_uninjured',[string(mean_coherency_uninjured(:,1)-mean_coherency_uninjured_error(:,1)),string(mean_coherency_uninjured(:,1)),string(mean_coherency_uninjured(:,1)+mean_coherency_uninjured_error(:,1))],...
        [string(mean_coherency_uninjured(:,2)-mean_coherency_uninjured_error(:,2)),string(mean_coherency_uninjured(:,2)),string(mean_coherency_uninjured(:,2)+mean_coherency_uninjured_error(:,2))],...
        [string(mean_coherency_uninjured(:,3)-mean_coherency_uninjured_error(:,3)),string(mean_coherency_uninjured(:,3)),string(mean_coherency_uninjured(:,3)+mean_coherency_uninjured_error(:,3))],...)
    'VariableNames',{'Areas','Pre_Uninj','Stim_Uninj','Post_Uninj'});

    disp('Coherencia')
    disp(strrep(protocolos(ind_p).name,'_',' '))
    disp(T_injure)
    disp(T_uninjure)
    disp(' ')

    % Graficar
    figure;
    subplot(2,1,1)
    %plot(mean_coherency_injured,'o-','LineWidth',3.0,'MarkerSize',5,'MarkerFaceColor','k');
    errorbar(mean_coherency_injured,mean_coherency_injured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
    xt = get(gca, 'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', areas_coherency_injured)
    %ylim([min([min(mean_coherency_injured-mean_coherency_injured_error),min(mean_coherency_uninjured-mean_coherency_uninjured_error)])-0.01 max([max(mean_coherency_injured+mean_coherency_injured_error),max(mean_coherency_uninjured+mean_coherency_uninjured_error)])+0.01])
    ylim([min(min_amp)-0.05, max(max_amp+0.05)])
    ylabel('Mean Coherence')
    legend('Pre', 'Stim', 'Post');
    legend('boxoff')
    grid on
    title(['Mean Coherence in beta between areas in the Injured Hemisphere (',strrep(protocolos(ind_p).name,'_',' '),')'])

    subplot(2,1,2)
    %plot(mean_coherency_uninjured,'o-','LineWidth',3.0,'MarkerSize',5,'MarkerFaceColor','k');
    errorbar(mean_coherency_uninjured,mean_coherency_uninjured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
    xt = get(gca, 'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', areas_coherency_uninjured)
    %ylim([min([min(mean_coherency_injured-mean_coherency_injured_error),min(mean_coherency_uninjured-mean_coherency_uninjured_error)])-0.01 max([max(mean_coherency_injured+mean_coherency_injured_error),max(mean_coherency_uninjured+mean_coherency_uninjured_error)])+0.01])
    ylim([min(min_amp)-0.05, max(max_amp+0.05)])
    ylabel('Mean Coherence')
    legend('Pre', 'Stim', 'Post');
    legend('boxoff')
    grid on
    title(['Mean Coherence in beta between areas in the Uninjured Hemisphere (',strrep(protocolos(ind_p).name,'_',' '),')'])

end
    


%% Mean por area

p = 2;
areas_coherency_uninjured = {};
areas_coherency_injured = {};

for i=1:length(protocolos(1).injured)-1

    % Coherencia    
    for j = length(protocolos(1).injured):-1:p
        
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

        for ind_p = 1:length(protocolos)

            mean_coherency_pre_injured = [mean_coherency_pre_injured; protocolos(ind_p).coherency.injured.pre.mean_beta{i,j}];
            mean_coherency_on_injured = [mean_coherency_on_injured; protocolos(ind_p).coherency.injured.on.mean_beta{i,j}];
            mean_coherency_post_injured = [mean_coherency_post_injured; protocolos(ind_p).coherency.injured.post.mean_beta{i,j}];
            mean_coherency_pre_injured_error = [mean_coherency_pre_injured_error; protocolos(ind_p).coherency.injured.pre.std_mean_beta{i,j}];
            mean_coherency_on_injured_error = [mean_coherency_on_injured_error; protocolos(ind_p).coherency.injured.on.std_mean_beta{i,j}];
            mean_coherency_post_injured_error = [mean_coherency_post_injured_error; protocolos(ind_p).coherency.injured.post.std_mean_beta{i,j}];
            %areas_coherency_injured = {areas_coherency_injured{:}, [protocolos(ind_p).injured(i).area, ' vs ', protocolos(ind_p).injured(j).area]};

            mean_coherency_pre_uninjured = [mean_coherency_pre_uninjured; protocolos(ind_p).coherency.uninjured.pre.mean_beta{i,j}];
            mean_coherency_on_uninjured = [mean_coherency_on_uninjured; protocolos(ind_p).coherency.uninjured.on.mean_beta{i,j}];
            mean_coherency_post_uninjured = [mean_coherency_post_uninjured; protocolos(ind_p).coherency.uninjured.post.mean_beta{i,j}];
            mean_coherency_pre_uninjured_error = [mean_coherency_pre_uninjured_error; protocolos(ind_p).coherency.uninjured.pre.std_mean_beta{i,j}];
            mean_coherency_on_uninjured_error = [mean_coherency_on_uninjured_error; protocolos(ind_p).coherency.uninjured.on.std_mean_beta{i,j}];
            mean_coherency_post_uninjured_error = [mean_coherency_post_uninjured_error; protocolos(ind_p).coherency.uninjured.post.std_mean_beta{i,j}];
            %areas_coherency_uninjured = {areas_coherency_uninjured{:}, [protocolos(ind_p).uninjured(i).area, ' vs ', protocolos(ind_p).uninjured(j).area]};

        end
        
        mean_coherency_injured = [mean_coherency_pre_injured, mean_coherency_on_injured, mean_coherency_post_injured];
        mean_coherency_injured_error = [mean_coherency_pre_injured_error, mean_coherency_on_injured_error, mean_coherency_post_injured_error];
        mean_coherency_uninjured = [mean_coherency_pre_uninjured, mean_coherency_on_uninjured, mean_coherency_post_uninjured];
        mean_coherency_uninjured_error = [mean_coherency_pre_uninjured_error, mean_coherency_on_uninjured_error, mean_coherency_post_uninjured_error];
        
        % Ver si VALE la pena por el tiempo
        min_amp = min([(mean_coherency_injured(:,1)-mean_coherency_injured_error(:,1)),...
            (mean_coherency_injured(:,2)-mean_coherency_injured_error(:,2)),...
            (mean_coherency_injured(:,3)-mean_coherency_injured_error(:,3)),...
            (mean_coherency_uninjured(:,1)-mean_coherency_uninjured_error(:,1)),...
            (mean_coherency_uninjured(:,2)-mean_coherency_uninjured_error(:,2)),...
            (mean_coherency_uninjured(:,3)-mean_coherency_uninjured_error(:,3))]); 

        max_amp = max([(mean_coherency_injured(:,1)+mean_coherency_injured_error(:,1)),...
            (mean_coherency_injured(:,2)+mean_coherency_injured_error(:,2)),...
            (mean_coherency_injured(:,3)+mean_coherency_injured_error(:,3)),...
            (mean_coherency_uninjured(:,1)+mean_coherency_uninjured_error(:,1)),...
            (mean_coherency_uninjured(:,2)+mean_coherency_uninjured_error(:,2)),...
            (mean_coherency_uninjured(:,3)+mean_coherency_uninjured_error(:,3))]); 

        % Graficar
        figure;
        subplot(2,1,1)
        %plot(mean_coherency_injured,'o-','LineWidth',3.0,'MarkerSize',5,'MarkerFaceColor','k');
        errorbar(mean_coherency_injured,mean_coherency_injured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
        xt = 1:length(strrep({protocolos.name},'_',' '));
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', strrep({protocolos.name},'_',' '))
        %ylim([min([min(mean_coherency_injured-mean_coherency_injured_error),min(mean_coherency_uninjured-mean_coherency_uninjured_error)])-0.01 max([max(mean_coherency_injured+mean_coherency_injured_error),max(mean_coherency_uninjured+mean_coherency_uninjured_error)])+0.01])
        ylim([min(min_amp)-0.05, max(max_amp+0.05)])
        xlim([0.9, max(xt)+0.1])
        ylabel('Mean Coherence')
        legend('Pre', 'Stim', 'Post','Orientation','horizontal');
        legend('boxoff')
        grid on
        title(['Mean Coherence in beta between ', protocolos(ind_p).injured(i).area, ' vs ', protocolos(ind_p).injured(j).area, ' Injured'])

        subplot(2,1,2)
        %plot(mean_coherency_uninjured,'o-','LineWidth',3.0,'MarkerSize',5,'MarkerFaceColor','k');
        errorbar(mean_coherency_uninjured,mean_coherency_uninjured_error,'-s','LineWidth',2.0,'MarkerSize',7,'MarkerFaceColor','k')
        xt = 1:length(strrep({protocolos.name},'_',' '));
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', strrep({protocolos.name},'_',' '))
        %ylim([min([min(mean_coherency_injured-mean_coherency_injured_error),min(mean_coherency_uninjured-mean_coherency_uninjured_error)])-0.01 max([max(mean_coherency_injured+mean_coherency_injured_error),max(mean_coherency_uninjured+mean_coherency_uninjured_error)])+0.01])
        ylim([min(min_amp)-0.05, max(max_amp+0.05)])
        xlim([0.9, max(xt)+0.1])
        ylabel('Mean Coherence')
        legend('Pre', 'Stim', 'Post','Orientation','horizontal');
        legend('boxoff')
        grid on
        title(['Mean Coherence in beta between ', protocolos(ind_p).uninjured(i).area, ' vs ', protocolos(ind_p).uninjured(j).area, ' Uninjured'])

    end

    p=p+1;
end

    
    
   
