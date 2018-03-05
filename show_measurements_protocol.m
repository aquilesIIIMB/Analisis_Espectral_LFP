function show_measurements_protocol(measurementsProtocol, path)

num_record = length(measurementsProtocol.register_checked);
num_areas_spectral = length(measurementsProtocol.injured.power_band);
num_areas_coherence = length(measurementsProtocol.injured.coherence);
num_bands = length(measurementsProtocol.injured.power_band(1).oscillations);

azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];

% Grafica

% Crear carpeta para guardar las imagnes 35:end
slash_backslash = find(path=='\' | path=='/');
inicio_new_dir1 = slash_backslash(length(slash_backslash)-3);
inicio_new_dir2 = slash_backslash(length(slash_backslash)-2);
inicio_new_dir3 = slash_backslash(length(slash_backslash)-1);
foldername = path(inicio_new_dir2:inicio_new_dir3); % /+375/arturo2_2017-06-02_12-58-57/
inicio_foldername = path(1:inicio_new_dir1); % /home/cmanalisis/Aquiles/Registros/
if ~exist(foldername, 'dir')
    mkdir(inicio_foldername,'Images');
    mkdir([inicio_foldername,'Images'],foldername);
    mkdir([inicio_foldername,'Images', foldername],'Protocol');
end
slash_system = foldername(length(foldername));

% Espectral
disp(' ') 
      
inj_band_power_total = [];
uninj_band_power_total = [];

inj_fractal_power_total = [];
uninj_fractal_power_total = [];
    
inj_band_power_total_norm = [];
uninj_band_power_total_norm = [];

inj_fractal_power_total_norm = [];
uninj_fractal_power_total_norm = [];

inj_fractal_exponent = [];
uninj_fractal_exponent = [];

for band_actual = 1:num_bands

    %Cargar datos
    % Spectral
    inj_band_power = [];
    uninj_band_power = [];

    inj_fractal_power = [];
    uninj_fractal_power = [];
    
    inj_band_power_norm = [];
    uninj_band_power_norm = [];

    inj_fractal_power_norm = [];
    uninj_fractal_power_norm = [];

    % Coherence
    inj_sum_MSC_total = [];
    uninj_sum_MSC_total = [];

    inj_coupling_strength_total = [];
    uninj_coupling_strength_total = [];

    inj_delay_total = [];
    uninj_delay_total = [];

    for area_actual = 1:max([num_areas_spectral, num_areas_coherence])

        if area_actual <= num_areas_spectral
            % Spectral
            inj_band_power = [inj_band_power, measurementsProtocol.injured.power_band(area_actual).oscillations(band_actual).pre', measurementsProtocol.injured.power_band(area_actual).oscillations(band_actual).on', measurementsProtocol.injured.power_band(area_actual).oscillations(band_actual).post'];           
            uninj_band_power = [uninj_band_power, measurementsProtocol.uninjured.power_band(area_actual).oscillations(band_actual).pre', measurementsProtocol.uninjured.power_band(area_actual).oscillations(band_actual).on', measurementsProtocol.uninjured.power_band(area_actual).oscillations(band_actual).post'];
            
            inj_fractal_power = [inj_fractal_power, measurementsProtocol.injured.power_band(area_actual).fractals(band_actual).pre', measurementsProtocol.injured.power_band(area_actual).fractals(band_actual).on', measurementsProtocol.injured.power_band(area_actual).fractals(band_actual).post'];
            uninj_fractal_power = [uninj_fractal_power, measurementsProtocol.uninjured.power_band(area_actual).fractals(band_actual).pre', measurementsProtocol.uninjured.power_band(area_actual).fractals(band_actual).on', measurementsProtocol.uninjured.power_band(area_actual).fractals(band_actual).post'];
            
            inj_band_power_norm = [inj_band_power_norm, measurementsProtocol.injured.power_band(area_actual).oscillations(band_actual).pre_norm', measurementsProtocol.injured.power_band(area_actual).oscillations(band_actual).on_norm', measurementsProtocol.injured.power_band(area_actual).oscillations(band_actual).post_norm'];           
            uninj_band_power_norm = [uninj_band_power_norm, measurementsProtocol.uninjured.power_band(area_actual).oscillations(band_actual).pre_norm', measurementsProtocol.uninjured.power_band(area_actual).oscillations(band_actual).on_norm', measurementsProtocol.uninjured.power_band(area_actual).oscillations(band_actual).post_norm'];
            
            inj_fractal_power_norm = [inj_fractal_power_norm, measurementsProtocol.injured.power_band(area_actual).fractals(band_actual).pre_norm', measurementsProtocol.injured.power_band(area_actual).fractals(band_actual).on_norm', measurementsProtocol.injured.power_band(area_actual).fractals(band_actual).post_norm'];
            uninj_fractal_power_norm = [uninj_fractal_power_norm, measurementsProtocol.uninjured.power_band(area_actual).fractals(band_actual).pre_norm', measurementsProtocol.uninjured.power_band(area_actual).fractals(band_actual).on_norm', measurementsProtocol.uninjured.power_band(area_actual).fractals(band_actual).post_norm'];
            
            if band_actual == 1
                inj_band_power_total = [inj_band_power_total, measurementsProtocol.injured.power_total(area_actual).oscillations.pre', measurementsProtocol.injured.power_total(area_actual).oscillations.on', measurementsProtocol.injured.power_total(area_actual).oscillations.post'];           
                uninj_band_power_total = [uninj_band_power_total, measurementsProtocol.uninjured.power_total(area_actual).oscillations.pre', measurementsProtocol.uninjured.power_total(area_actual).oscillations.on', measurementsProtocol.uninjured.power_total(area_actual).oscillations.post'];

                inj_fractal_power_total = [inj_fractal_power_total, measurementsProtocol.injured.power_total(area_actual).fractals.pre', measurementsProtocol.injured.power_total(area_actual).fractals.on', measurementsProtocol.injured.power_total(area_actual).fractals.post'];
                uninj_fractal_power_total = [uninj_fractal_power_total, measurementsProtocol.uninjured.power_total(area_actual).fractals.pre', measurementsProtocol.uninjured.power_total(area_actual).fractals.on', measurementsProtocol.uninjured.power_total(area_actual).fractals.post'];

                inj_band_power_total_norm = [inj_band_power_total_norm, measurementsProtocol.injured.power_total(area_actual).oscillations.pre_norm', measurementsProtocol.injured.power_total(area_actual).oscillations.on_norm', measurementsProtocol.injured.power_total(area_actual).oscillations.post_norm'];           
                uninj_band_power_total_norm = [uninj_band_power_total_norm, measurementsProtocol.uninjured.power_total(area_actual).oscillations.pre_norm', measurementsProtocol.uninjured.power_total(area_actual).oscillations.on_norm', measurementsProtocol.uninjured.power_total(area_actual).oscillations.post_norm'];

                inj_fractal_power_total_norm = [inj_fractal_power_total_norm, measurementsProtocol.injured.power_total(area_actual).fractals.pre_norm', measurementsProtocol.injured.power_total(area_actual).fractals.on_norm', measurementsProtocol.injured.power_total(area_actual).fractals.post_norm'];
                uninj_fractal_power_total_norm = [uninj_fractal_power_total_norm, measurementsProtocol.uninjured.power_total(area_actual).fractals.pre_norm', measurementsProtocol.uninjured.power_total(area_actual).fractals.on_norm', measurementsProtocol.uninjured.power_total(area_actual).fractals.post_norm'];

                inj_fractal_exponent = [inj_fractal_exponent, measurementsProtocol.injured.power_total(area_actual).beta_exponent.pre', measurementsProtocol.injured.power_total(area_actual).beta_exponent.on', measurementsProtocol.injured.power_total(area_actual).beta_exponent.post'];           
                uninj_fractal_exponent = [uninj_fractal_exponent, measurementsProtocol.uninjured.power_total(area_actual).beta_exponent.pre', measurementsProtocol.uninjured.power_total(area_actual).beta_exponent.on', measurementsProtocol.uninjured.power_total(area_actual).beta_exponent.post'];

            end
        end

        % Coherence
        inj_sum_MSC_total = [inj_sum_MSC_total, measurementsProtocol.injured.coherence(area_actual).sum_MSC(band_actual).pre', measurementsProtocol.injured.coherence(area_actual).sum_MSC(band_actual).on', measurementsProtocol.injured.coherence(area_actual).sum_MSC(band_actual).post'];
        uninj_sum_MSC_total = [uninj_sum_MSC_total, measurementsProtocol.uninjured.coherence(area_actual).sum_MSC(band_actual).pre', measurementsProtocol.uninjured.coherence(area_actual).sum_MSC(band_actual).on', measurementsProtocol.uninjured.coherence(area_actual).sum_MSC(band_actual).post'];
        
        inj_coupling_strength_total = [inj_coupling_strength_total, measurementsProtocol.injured.coherence(area_actual).coupling_strength(band_actual).pre', measurementsProtocol.injured.coherence(area_actual).coupling_strength(band_actual).on', measurementsProtocol.injured.coherence(area_actual).coupling_strength(band_actual).post'];
        uninj_coupling_strength_total = [uninj_coupling_strength_total, measurementsProtocol.uninjured.coherence(area_actual).coupling_strength(band_actual).pre', measurementsProtocol.uninjured.coherence(area_actual).coupling_strength(band_actual).on', measurementsProtocol.uninjured.coherence(area_actual).coupling_strength(band_actual).post'];
        
        inj_delay_total = [inj_delay_total, measurementsProtocol.injured.coherence(area_actual).delay(band_actual).pre', measurementsProtocol.injured.coherence(area_actual).delay(band_actual).on', measurementsProtocol.injured.coherence(area_actual).delay(band_actual).post'];
        uninj_delay_total = [uninj_delay_total, measurementsProtocol.uninjured.coherence(area_actual).delay(band_actual).pre', measurementsProtocol.uninjured.coherence(area_actual).delay(band_actual).on', measurementsProtocol.uninjured.coherence(area_actual).delay(band_actual).post'];
        
        
    end


    banda_eval = measurementsProtocol.injured.power_band(1).oscillations(band_actual).freq;
    banda_name = measurementsProtocol.injured.power_band(1).oscillations(band_actual).band;
    areas = {measurementsProtocol.injured.power_band.area};
    
    % Power Oscillations

    % Graficar cambio en la potencia  % Graficar cambio en la potencia   
    y_etiqueta = 'Oscillatory Signal Power';
    titulo = ['Oscillatory Signal Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-1)Power of Oscillation in (',int2str(band_actual),')',banda_name,' of injured area'];
    boxplot_custom(inj_band_power, areas, num_record, [0 1], y_etiqueta, titulo, name_figure_save); 

    y_etiqueta = 'Oscillatory Signal Power';
    titulo = ['Oscillatory Signal Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-1)Power of Oscillation in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    boxplot_custom(uninj_band_power, areas, num_record, [0 1], y_etiqueta, titulo, name_figure_save); 

    % Graficar cambio en la potencia   
    fig_13 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),inj_band_power(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),inj_band_power(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),inj_band_power(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 1])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Oscillatory Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Oscillatory Signal Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-2)Power of Oscillation in (',int2str(band_actual),')',banda_name,' of injured area'];
    saveas(fig_13,name_figure_save,'png');
    %%saveas(fig_13,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_13)   

    fig_14 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),uninj_band_power(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),uninj_band_power(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),uninj_band_power(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 1])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Oscillatory Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Oscillatory Signal Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-2)Power of Oscillation in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    saveas(fig_14,name_figure_save,'png');
    %%saveas(fig_14,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_14)   
    
    % Power Oscillations Normalized
    
    % Graficar cambio en la potencia  % Graficar cambio en la potencia   
    y_etiqueta = 'Normalized oscillatory Signal Power';
    titulo = ['Normalized Oscillatory Signal Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-3)Power of Oscillation Normalized in (',int2str(band_actual),')',banda_name,' of injured area'];
    boxplot_custom(inj_band_power_norm, areas, num_record, [0 10], y_etiqueta, titulo, name_figure_save); 

    y_etiqueta = 'Normalized oscillatory Signal Power';
    titulo = ['Normalized Oscillatory Signal Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-3)Power of Oscillation Normalized in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    boxplot_custom(uninj_band_power_norm, areas, num_record, [0 10], y_etiqueta, titulo, name_figure_save); 

    % Graficar cambio en la potencia   
    fig_23 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),inj_band_power_norm(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),inj_band_power_norm(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),inj_band_power_norm(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 10])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Normalized Oscillatory Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Normalized Oscillatory Signal Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-4)Power of Oscillation Normalized in (',int2str(band_actual),')',banda_name,' of injured area'];
    saveas(fig_23,name_figure_save,'png');
    %%saveas(fig_23,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_23)   

    fig_24 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),uninj_band_power_norm(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),uninj_band_power_norm(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),uninj_band_power_norm(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 10])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Normalized Oscillatory Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Normalized Oscillatory Signal Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-4)Power of Oscillation Normalized in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    saveas(fig_24,name_figure_save,'png');
    %%saveas(fig_24,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_24)   
    
    % Power Fractals
    
    % Graficar cambio en la potencia  % Graficar cambio en la potencia   
    y_etiqueta = 'Scale-free Signal Power';
    titulo = ['Scale-free activity Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2-1)Power Scale-free activity in (',int2str(band_actual),')',banda_name,' of injured area'];
    boxplot_custom(inj_fractal_power, areas, num_record, [0 1.3], y_etiqueta, titulo, name_figure_save); 

    y_etiqueta = 'Scale-free Signal Power';
    titulo = ['Scale-free activity Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2-1)Power Scale-free activity in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    boxplot_custom(uninj_fractal_power, areas, num_record, [0 1.3], y_etiqueta, titulo, name_figure_save); 

    % Graficar cambio en la potencia   
    fig_33 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),inj_fractal_power(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),inj_fractal_power(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),inj_fractal_power(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 1.3])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Scale-free Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Scale-free Signal Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2-2)Power Scale-free activity in (',int2str(band_actual),')',banda_name,' of injured area'];
    saveas(fig_33,name_figure_save,'png');
    %%saveas(fig_33,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_33)   

    fig_34 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),uninj_fractal_power(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),uninj_fractal_power(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),uninj_fractal_power(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 1.3])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Scale-free Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Scale-free Signal Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2-2)Power Scale-free activity in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    saveas(fig_34,name_figure_save,'png');
    %%saveas(fig_34,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_34) 
    
    % Power Fractals Normalized
    
    % Graficar cambio en la potencia  % Graficar cambio en la potencia   
    y_etiqueta = 'Normalized Scale-free Signal Power';
    titulo = ['Normalized Scale-free Signal Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2-3)Power Scale-free activity Normalized in (',int2str(band_actual),')',banda_name,' of injured area'];
    boxplot_custom(inj_fractal_power_norm, areas, num_record, [0 10], y_etiqueta, titulo, name_figure_save); 

    y_etiqueta = 'Normalized Scale-free activity Power';
    titulo = ['Normalized Scale-free Signal Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2-3)Power Scale-free activity Normalized in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    boxplot_custom(uninj_fractal_power_norm, areas, num_record, [0 10], y_etiqueta, titulo, name_figure_save); 

    % Graficar cambio en la potencia   
    fig_43 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),inj_fractal_power_norm(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),inj_fractal_power_norm(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),inj_fractal_power_norm(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 10])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Normalized Scale-free Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Normalized Scale-free Signal Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2-4)Power Scale-free activity Normalized in (',int2str(band_actual),')',banda_name,' of injured area'];
    saveas(fig_43,name_figure_save,'png');
    %%saveas(fig_43,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_43)   

    fig_44 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),uninj_fractal_power_norm(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),uninj_fractal_power_norm(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),uninj_fractal_power_norm(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 10])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Normalized Scale-free Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Normalized Scale-free Signal Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2-4)Power Scale-free activity Normalized in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    saveas(fig_44,name_figure_save,'png');
    %%saveas(fig_44,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_44) 
    
    
    banda_eval = measurementsProtocol.injured.coherence(1).sum_MSC(band_actual).freq;
    banda_name = measurementsProtocol.injured.coherence(1).sum_MSC(band_actual).band;
    areas1 = {measurementsProtocol.injured.coherence.area1};
    areas2 = {measurementsProtocol.injured.coherence.area2};
    [vs{1:length(string(areas1))}] = deal('&');
    areas = join([string(areas1)',vs',string(areas2)'],'');
    
    % Sum MSC

    y_etiqueta = 'Sum MSC';
    titulo = ['Sum Magnitude-Squared Coherence (MSC) of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3-1)Sum MSC in (',int2str(band_actual),')',banda_name,' of injured area'];
    boxplot_custom(inj_sum_MSC_total, areas', num_record, [0 26], y_etiqueta, titulo, name_figure_save); 

    y_etiqueta = 'Sum MSC';
    titulo = ['Sum Magnitude-Squared Coherence (MSC) of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3-1)Sum MSC in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    boxplot_custom(uninj_sum_MSC_total, areas', num_record, [0 26], y_etiqueta, titulo, name_figure_save); 
    
    % Graficar cambio en la potencia   
    fig_53 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),inj_sum_MSC_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),inj_sum_MSC_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),inj_sum_MSC_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 26])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Sum MSC', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Sum Magnitude-Squared Coherence (MSC) of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3-2)Sum MSC in (',int2str(band_actual),')',banda_name,' of injured area'];
    saveas(fig_53,name_figure_save,'png');
    %%saveas(fig_53,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_53)   

    fig_54 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),uninj_sum_MSC_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),uninj_sum_MSC_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),uninj_sum_MSC_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 26])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Sum MSC', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Sum Magnitude-Squared Coherence (MSC) of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3-2)Sum MSC in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    saveas(fig_54,name_figure_save,'png');
    %%saveas(fig_54,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_54) 

    % Coupling Strength
    
    y_etiqueta = 'Coupling Strength';
    titulo = ['Coupling Strength of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(4-1)Coupling Strength in (',int2str(band_actual),')',banda_name,' of injured area'];
    boxplot_custom(inj_coupling_strength_total, areas', num_record, [0.05 0.65], y_etiqueta, titulo, name_figure_save); 

    y_etiqueta = 'Coupling Strength';
    titulo = ['Coupling Strength of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(4-1)Coupling Strength in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    boxplot_custom(uninj_coupling_strength_total, areas', num_record, [0.05 0.65], y_etiqueta, titulo, name_figure_save); 

    fig_63 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]'; 
    pre = plot(x(:,1),inj_coupling_strength_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),inj_coupling_strength_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),inj_coupling_strength_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0.05 0.65])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Coupling Strength', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Coupling Strength of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(4-2)Coupling Strength in (',int2str(band_actual),')',banda_name,' of injured area'];
    saveas(fig_63,name_figure_save,'png');
    %%saveas(fig_63,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_63)

    fig_64 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),uninj_coupling_strength_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),uninj_coupling_strength_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),uninj_coupling_strength_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)        
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0.05 0.65])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Coupling Strength', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Coupling Strength of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(4-2)Coupling Strength in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    saveas(fig_64,name_figure_save,'png');
    %%saveas(fig_64,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_64)

    % Delay
    
    y_etiqueta = 'Delay [ms]';
    titulo = ['Delay of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(5-1)Delay in (',int2str(band_actual),')',banda_name,' of injured area'];
    boxplot_custom(inj_delay_total.*1000, areas', num_record, [0 200], y_etiqueta, titulo, name_figure_save); 

    y_etiqueta = 'Delay [ms]';
    titulo = ['Delay of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(5-1)Delay in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    boxplot_custom(uninj_delay_total.*1000, areas', num_record, [0 200], y_etiqueta, titulo, name_figure_save); 
    
    fig_73 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]'; 
    pre = plot(x(:,1),inj_delay_total(:,1:3:end)'.*1000,'+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),inj_delay_total(:,2:3:end)'.*1000,'o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),inj_delay_total(:,3:3:end)'.*1000,'x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 200])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Delay [ms]', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Delay of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(5-2)Delay in (',int2str(band_actual),')',banda_name,' of injured area'];
    saveas(fig_73,name_figure_save,'png');
    %%saveas(fig_73,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_73)

    fig_74 = figure('units','normalized','outerposition',[0 0 1 1]);
    xt = 1:length(areas);
    x = [xt-0.225;xt;xt+0.225]';
    pre = plot(x(:,1),uninj_delay_total(:,1:3:end)'.*1000,'+','Color',azul,'MarkerSize',15,'LineWidth',3);
    hold on
    on = plot(x(:,2),uninj_delay_total(:,2:3:end)'.*1000,'o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
    hold on
    post = plot(x(:,3),uninj_delay_total(:,3:3:end)'.*1000,'x','Color',verde,'MarkerSize',15,'LineWidth',3);
    set(gca, 'XTick', xt, 'XTickLabel', areas)        
    lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 20;
    grid on
    ylim([0 200])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Delay [ms]', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Delay of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(5-2)Delay in (',int2str(band_actual),')',banda_name,' of uninjured area'];
    saveas(fig_74,name_figure_save,'png');
    %%saveas(fig_74,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_74)

end

areas = {measurementsProtocol.injured.power_total.area};
    
% Power total Oscillations

% Graficar cambio en la potencia  % Graficar cambio en la potencia   
y_etiqueta = 'Oscillatory Signal Power';
titulo = ['Oscillatory Signal Power of injured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(6-1)Oscillatory Signal Power of injured area'];
boxplot_custom(inj_band_power_total, areas, num_record, [0 1.3], y_etiqueta, titulo, name_figure_save); 

y_etiqueta = 'Oscillatory Signal Power';
titulo = ['Oscillatory Signal Power of uninjured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(6-1)Oscillatory Signal Power of uninjured area'];
boxplot_custom(uninj_band_power_total, areas, num_record, [0 1.3], y_etiqueta, titulo, name_figure_save); 

% Graficar cambio en la potencia   
fig_83 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),inj_band_power_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),inj_band_power_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),inj_band_power_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 1.3])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Oscillatory Signal Power', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Oscillatory Signal Power of injured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(6-2)Oscillatory Signal Power of injured area'];
saveas(fig_83,name_figure_save,'png');
%%saveas(fig_83,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_83)   

fig_84 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),uninj_band_power_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),uninj_band_power_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),uninj_band_power_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 1.3])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Oscillatory Signal Power', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Oscillatory Signal Power of uninjured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(6-2)Oscillatory Signal Power of uninjured area'];
saveas(fig_84,name_figure_save,'png');
%%saveas(fig_84,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_84)

% Power total Oscillations Normalized

% Graficar cambio en la potencia  % Graficar cambio en la potencia   
y_etiqueta = 'Normalized Oscillatory Signal Power';
titulo = ['Normalized Oscillatory Signal Power of injured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(6-3)Oscillatory Signal Power Normalized of injured area'];
boxplot_custom(inj_band_power_total_norm, areas, num_record, [0 25], y_etiqueta, titulo, name_figure_save); 

y_etiqueta = 'Normalized Oscillatory Signal Power';
titulo = ['Normalized Oscillatory Signal Power of uninjured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(6-3)Oscillatory Signal Power Normalized of uninjured area'];
boxplot_custom(uninj_band_power_total_norm, areas, num_record, [0 25], y_etiqueta, titulo, name_figure_save); 

% Graficar cambio en la potencia   
fig_93 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),inj_band_power_total_norm(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),inj_band_power_total_norm(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),inj_band_power_total_norm(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 25])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Normalized Oscillatory Signal Power', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Normalized Oscillatory Signal Power of injured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(6-4)Oscillatory Signal Power Normalized of injured area'];
saveas(fig_93,name_figure_save,'png');
%%saveas(fig_93,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_93)   

fig_94 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),uninj_band_power_total_norm(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),uninj_band_power_total_norm(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),uninj_band_power_total_norm(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 25])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Normalized Oscillatory Signal Power', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Normalized Oscillatory Signal Power of uninjured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(6-4)Oscillatory Signal Power Normalized of uninjured area'];
saveas(fig_94,name_figure_save,'png');
%%saveas(fig_94,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_94)


% Power total Fractals

% Graficar cambio en la potencia  % Graficar cambio en la potencia   
y_etiqueta = 'Scale-free Signal Power';
titulo = ['Scale-free Signal Power of injured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(7-1)Scale-free Signal Power of injured area'];
boxplot_custom(inj_fractal_power_total, areas, num_record, [0 2.5], y_etiqueta, titulo, name_figure_save); 

y_etiqueta = 'Scale-free Signal Power';
titulo = ['Scale-free Signal Power of uninjured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(7-1)Scale-free Signal Power of uninjured area'];
boxplot_custom(uninj_fractal_power_total, areas, num_record, [0 2.5], y_etiqueta, titulo, name_figure_save); 

% Graficar cambio en la potencia   
fig_103 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),inj_fractal_power_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),inj_fractal_power_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),inj_fractal_power_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 2.5])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Scale-free Signal Power', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Scale-free Signal Power of injured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(7-2)Scale-free Signal Power of injured area'];
saveas(fig_103,name_figure_save,'png');
%%saveas(fig_103,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_103)   

fig_104 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),uninj_fractal_power_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),uninj_fractal_power_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),uninj_fractal_power_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 2.5])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Scale-free Signal Power', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Scale-free Signal Power of uninjured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(7-2)Scale-free Signal Power of uninjured area'];
saveas(fig_104,name_figure_save,'png');
%%saveas(fig_104,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_104)

% Power total Fractals Normalized

% Graficar cambio en la potencia  % Graficar cambio en la potencia   
y_etiqueta = 'Normalized Scale-free Signal Power';
titulo = ['Normalized Scale-free Signal Power of injured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(7-3)Scale-free Signal Power Normalized of injured area'];
boxplot_custom(inj_fractal_power_total_norm, areas, num_record, [0 25], y_etiqueta, titulo, name_figure_save); 

y_etiqueta = 'Normalized Scale-free Signal Power';
titulo = ['Normalized Scale-free Signal Power of uninjured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(7-3)Scale-free Signal Power Normalized of uninjured area'];
boxplot_custom(uninj_band_power_total_norm, areas, num_record, [0 25], y_etiqueta, titulo, name_figure_save); 

% Graficar cambio en la potencia   
fig_113 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),inj_fractal_power_total_norm(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),inj_fractal_power_total_norm(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),inj_fractal_power_total_norm(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 25])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Normalized Scale-free Signal Power', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Normalized Scale-free Signal Power of injured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(7-4)Scale-free Signal Power Normalized of injured area'];
saveas(fig_113,name_figure_save,'png');
%%saveas(fig_113,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_113)   

fig_114 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),uninj_band_power_total_norm(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),uninj_band_power_total_norm(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),uninj_band_power_total_norm(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 25])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Normalized Scale-free Signal Power', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Normalized Scale-free Signal Power of uninjured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(7-4)Scale-free Signal Power Normalized of uninjured area'];
saveas(fig_114,name_figure_save,'png');
%%saveas(fig_114,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_114)

% Fractal Beta Exponent 

% Graficar cambio en la potencia  % Graficar cambio en la potencia   
y_etiqueta = 'Scale-free Signal Exponent';
titulo = ['Scale-free Signal Exponent of injured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(8-1)Scale-free Signal Exponent of injured area'];
boxplot_custom(inj_fractal_exponent, areas, num_record, [0 2], y_etiqueta, titulo, name_figure_save); 

y_etiqueta = 'Scale-free Signal Exponent';
titulo = ['Scale-free Signal Exponent of uninjured area'];
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(8-1)Scale-free Signal Exponent of uninjured area'];
boxplot_custom(uninj_fractal_exponent, areas, num_record, [0 2], y_etiqueta, titulo, name_figure_save); 

% Graficar cambio en la potencia   
fig_123 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),inj_fractal_exponent(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),inj_fractal_exponent(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),inj_fractal_exponent(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 2])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Scale-free Signal Exponent', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Scale-free Signal Exponent of injured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(8-2)Scale-free Signal Exponent of injured area'];
saveas(fig_123,name_figure_save,'png');
%%saveas(fig_123,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_123)   

fig_124 = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';
pre = plot(x(:,1),uninj_fractal_exponent(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
hold on
on = plot(x(:,2),uninj_fractal_exponent(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
hold on
post = plot(x(:,3),uninj_fractal_exponent(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
set(gca, 'XTick', xt, 'XTickLabel', areas)
lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim([0 2])
xlim([xt(1)-0.5, xt(end)+0.5])
ylabel('Scale-free Signal Exponent', 'FontSize', 24)
set(gca,'fontsize',17)
title(['Scale-free Signal Exponent of uninjured area'], 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(8-2)Scale-free Signal Exponent of uninjured area'];
saveas(fig_124,name_figure_save,'png');
%%saveas(fig_124,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_124)

end