function [power_band_total, power_band_total_norm, power_fractal_band,power_fractal_band_norm] = power_total_measurements_IRASA(registroLFP, visualization, save_image, path)
        
    power_fractal_band = [];
    power_fractal_band_norm = [];
    power_band_total = [];
    power_band_total_norm = [];
    areas = {};
       
    azul = [0 0.4470 0.7410];
    rojo = [0.85, 0.325, 0.098];
    verde = [0.466, 0.674, 0.188];
    
    slash_backslash = find(path=='\' | path=='/');
    inicio_new_dir1 = slash_backslash(length(slash_backslash)-3);
    inicio_new_dir2 = slash_backslash(length(slash_backslash)-2);
    foldername = path(inicio_new_dir2:length(path)); % /+375/arturo2_2017-06-02_12-58-57/
    inicio_foldername = path(1:inicio_new_dir1); % /home/cmanalisis/Aquiles/Registros/
    if ~exist(foldername, 'dir')
        mkdir(inicio_foldername,'Images');
        mkdir([inicio_foldername,'Images'],foldername);
    end
    slash_system = foldername(length(foldername));
    
    pre_m = registroLFP.times.pre_m;
    on_inicio_m = registroLFP.times.start_on_m;
    on_final_m = registroLFP.times.end_on_m;
    post_m = registroLFP.times.post_m;
    tiempo_total = registroLFP.times.end_m;
    
    [C,~,~] = unique({registroLFP.area.name},'stable');
    idx_areas_izq = [];
    idx_areas_der = [];
    
    for k = 1:length(C)
        area_actual = C{k};
        hemisferio = area_actual(end);
        if strcmp(hemisferio,'L')
            idx_areas_izq = [idx_areas_izq, k];
        elseif strcmp(hemisferio,'R')
            idx_areas_der = [idx_areas_der, k];
        end
    end

    for i = 1:length(registroLFP.average_spectrum)
        
        freq = registroLFP.average_spectrum(i).spectrogram.irasa.freq;
        time = registroLFP.average_spectrum(i).spectrogram.irasa.time;
        area_actual = registroLFP.average_spectrum(i).area; 
    
        % Espectrograma de fractales
        FracSpectrogram = registroLFP.average_spectrum(i).spectrogram.irasa.frac';
        FracSpectrogram = imresize(FracSpectrogram, [length(time), 200]);
        freq = imresize(freq,[200, 1]);

        [~,ind_max] = max(FracSpectrogram,[],2); % Indice de los maximos en cada bin de tiempo
        frec_ind_max = freq(ind_max); % Frecuencia de los maximos en cada bin de tiempo
        idx_spect_artifacts = ~((frec_ind_max > 100-5) & (frec_ind_max < 100+5)); % Se ignoran los indices que estan cerca de la frecuencia del seno, ignora algunos bin de tiempo
        idx_spect_artifacts = find(~idx_spect_artifacts)';
        
        % Indices de cada etapa
        idx_pre = find(time<(pre_m*60.0-5));
        idx_on = find(time>(on_inicio_m*60.0+5) & time<(on_final_m*60.0-5));
        idx_post = find(time>(post_m*60.0+5) & time<(tiempo_total*60));

        FracSpectrogram_pre = FracSpectrogram(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
        FracSpectrogram_on = FracSpectrogram(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
        FracSpectrogram_post = FracSpectrogram(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);

        % PSD
        psd_pre_frac = mean(FracSpectrogram_pre,1);    
        psd_on_frac = mean(FracSpectrogram_on,1);    
        psd_post_frac = mean(FracSpectrogram_post,1);
        
        power_band_pre = bandpower(psd_pre_frac, freq, [min(freq), max(freq)],'psd');
        power_band_on = bandpower(psd_on_frac, freq, [min(freq), max(freq)],'psd');
        power_band_post = bandpower(psd_post_frac, freq, [min(freq), max(freq)],'psd');
        
        areas = {areas{:},area_actual};
        power_fractal_band = [power_fractal_band; [power_band_pre, power_band_on, power_band_post]];        
        power_fractal_band_norm = [power_fractal_band_norm; [power_band_pre/power_band_pre, power_band_on/power_band_pre, power_band_post/power_band_pre]];
        
        % Oscillatory
        freq = registroLFP.average_spectrum(i).spectrogram.frequency; 
        area_actual = registroLFP.average_spectrum(i).area;       
        
        psd_pre = registroLFP.average_spectrum(i).psd.pre.data;        
        psd_on = registroLFP.average_spectrum(i).psd.on.data;
        psd_post = registroLFP.average_spectrum(i).psd.post.data;
        
        min_psd = min([min(psd_pre),min(psd_on),min(psd_post)]);        
        
        power_band_pre_total = bandpower(psd_pre-min_psd, freq, [min(freq), max(freq)],'psd');
        power_band_on_total = bandpower(psd_on-min_psd, freq, [min(freq), max(freq)],'psd');
        power_band_post_total = bandpower(psd_post-min_psd, freq, [min(freq), max(freq)],'psd');
        power_band_total = [power_band_total; [power_band_pre_total, power_band_on_total, power_band_post_total]];
        power_band_total_norm = [power_band_total_norm; [power_band_pre_total/power_band_pre_total, power_band_on_total/power_band_pre_total, power_band_post_total/power_band_pre_total]];

        if visualization
            figure;
            plot(freq, psd_pre_frac)
            hold on
            plot(freq, psd_on_frac)
            hold on
            plot(freq, psd_post_frac)
            %hold on
            %plot(freq, psd_on)
            %hold on
            %plot(freq, psd_post)
            ylim([-inf max(psd_pre_frac)*1.1])
            title(area_actual)
            
            figure;
            plot(freq, psd_pre)
            hold on
            plot(freq, psd_on)
            hold on
            plot(freq, psd_post)
            %hold on
            %plot(freq, psd_on)
            %hold on
            %plot(freq, psd_post)
            ylim([-inf max(psd_pre)*1.1])
            title(area_actual)

            fprintf('%s\n', area_actual)
            fprintf('Porcentaje fractal de banda en pre: %.2f \n', power_band_pre)
            fprintf('Porcentaje fractal de banda en on: %.2f \n', power_band_on)
            fprintf('Porcentaje fractal de banda en post: %.2f \n\n', power_band_post)
            
            fprintf('%s\n', area_actual)
            fprintf('Porcentaje Osc de banda en pre: %.2f \n', power_band_pre_total)
            fprintf('Porcentaje Osc de banda en on: %.2f \n', power_band_on_total)
            fprintf('Porcentaje Osc de banda en post: %.2f \n\n', power_band_post_total)
        end
    end

    if visualization
        disp(' ')
        fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', mean(power_fractal_band(idx_areas_izq,:)))
        fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n',mean(power_fractal_band(idx_areas_der,:)))    

        if length(idx_areas_izq) == 1
            y_max = max([max(power_fractal_band(idx_areas_izq,:)) max(power_fractal_band(idx_areas_der,:))]);
            y_min = min([min(power_fractal_band(idx_areas_izq,:)) min(power_fractal_band(idx_areas_der,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            bar_izqder = bar(power_fractal_band,'grouped');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            title(['Scale-free activity Power'])
            
        else
            y_max = max([max(power_fractal_band(idx_areas_izq,:)) max(power_fractal_band(idx_areas_der,:))]);
            y_min = min([min(power_fractal_band(idx_areas_izq,:)) min(power_fractal_band(idx_areas_der,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar_izq = bar(power_fractal_band(idx_areas_izq,:),'grouped');
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            title(['Scale-free activity Power'])
            subplot(2,1,2)
            bar_der = bar(power_fractal_band(idx_areas_der,:),'grouped');
            bar_der(1).FaceColor = azul; bar_der(2).FaceColor = rojo; bar_der(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_der))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            
        end
        
        % Oscilatorio
        disp(' ')
        fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', mean(power_band_total(idx_areas_izq,:)))
        fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n',mean(power_band_total(idx_areas_der,:)))    

        if length(idx_areas_izq) == 1
            y_max = max([max(power_band_total(idx_areas_izq,:)) max(power_band_total(idx_areas_der,:))]);
            y_min = min([min(power_band_total(idx_areas_izq,:)) min(power_band_total(idx_areas_der,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            bar_izqder = bar(power_band_total,'grouped');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            title(['Scale-free activity Power'])
            
        else
            y_max = max([max(power_band_total(idx_areas_izq,:)) max(power_band_total(idx_areas_der,:))]);
            y_min = min([min(power_band_total(idx_areas_izq,:)) min(power_band_total(idx_areas_der,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar_izq = bar(power_band_total(idx_areas_izq,:),'grouped');
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            title(['Scale-free activity Power'])
            subplot(2,1,2)
            bar_der = bar(power_band_total(idx_areas_der,:),'grouped');
            bar_der(1).FaceColor = azul; bar_der(2).FaceColor = rojo; bar_der(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_der))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
        end
    end
        
    if save_image
        
        if length(idx_areas_izq) == 1
            fig_11 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izqder = bar(power_fractal_band,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            grid on
            ylim([0 4])
            ylabel('Scale-free activity Power [W/Hz]', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Scale-free activity Signal Power of left and right hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Scale-free activity Signal Power of left and right hemisphere'];
            saveas(fig_11,name_figure_save,'png');
            saveas(fig_11,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_11)
            
            fig_13 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izqder = bar(power_fractal_band_norm,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            grid on
            ylim([0 2])
            ylabel('Normalized Scale-free activity Power', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Normalized Scale-free activity Signal Power by Pre-Stim of left and right hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Scale-free activity Signal Power Normalized of left and right hemisphere'];
            saveas(fig_13,name_figure_save,'png');
            saveas(fig_13,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_13)
        
        else
            % Graficar cambio en la potencia    
            fig_11 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izq = bar(power_fractal_band(idx_areas_izq,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            lgd = legend([bar_izq(1) bar_izq(2) bar_izq(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            grid on
            ylim([0 4])
            ylabel('Scale-free activity Power [W/Hz]', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Scale-free activity Signal Power of left hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Scale-free activity Signal Power of left hemisphere'];
            saveas(fig_11,name_figure_save,'png');
            saveas(fig_11,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_11)   

            fig_12 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_der = bar(power_fractal_band(idx_areas_der,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_der))
            lgd = legend([bar_der(1) bar_der(2) bar_der(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_der(1).FaceColor = azul; bar_der(2).FaceColor = rojo; bar_der(3).FaceColor = verde;
            grid on
            ylim([0 4])
            ylabel('Scale-free activity Power [W/Hz]', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Scale-free activity Signal Power of rigth hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Scale-free activity Signal Power of rigth hemisphere'];
            saveas(fig_12,name_figure_save,'png');
            saveas(fig_12,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_12)   
            
            % Graficar cambio en la potencia    
            fig_14 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izq = bar(power_fractal_band_norm(idx_areas_izq,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            lgd = legend([bar_izq(1) bar_izq(2) bar_izq(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            grid on
            ylim([0 2])
            ylabel('Normalized Scale-free activity Power', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Normalized Scale-free activity Signal Power by Pre-Stim of left hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Scale-free activity Signal Power Normalized of left hemisphere'];
            saveas(fig_14,name_figure_save,'png');
            saveas(fig_14,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_14)   

            fig_15 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_der = bar(power_fractal_band_norm(idx_areas_der,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_der))
            lgd = legend([bar_der(1) bar_der(2) bar_der(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_der(1).FaceColor = azul; bar_der(2).FaceColor = rojo; bar_der(3).FaceColor = verde;
            grid on
            ylim([0 2])
            ylabel('Normalized Scale-free activity Power', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Normalized Scale-free activity Signal Power by Pre-Stim of rigth hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Scale-free activity Signal Power Normalized of rigth hemisphere'];
            saveas(fig_15,name_figure_save,'png');
            saveas(fig_15,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_15)   
            
            % Oscilatorio
            if length(idx_areas_izq) == 1
            fig_11 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izqder = bar(power_band_total,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            grid on
            ylim([0 4])
            ylabel('Oscillatory Power [W/Hz]', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Oscillatory Signal Power of left and right hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Oscillatory Signal Power of left and right hemisphere'];
            saveas(fig_11,name_figure_save,'png');
            saveas(fig_11,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_11)
            
            fig_13 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izqder = bar(power_band_total_norm,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            grid on
            ylim([0 2])
            ylabel('Normalized Oscillatory Power', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Normalized Oscillatory Signal Power by Pre-Stim of left and right hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Oscillatory Signal Power Normalized of left and right hemisphere'];
            saveas(fig_13,name_figure_save,'png');
            saveas(fig_13,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_13)
        
        else
            % Graficar cambio en la potencia    
            fig_11 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izq = bar(power_band_total(idx_areas_izq,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            lgd = legend([bar_izq(1) bar_izq(2) bar_izq(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            grid on
            ylim([0 4])
            ylabel('Oscillatory Power [W/Hz]', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Oscillatory Signal Power of left hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Oscillatory Signal Power of left hemisphere'];
            saveas(fig_11,name_figure_save,'png');
            saveas(fig_11,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_11)   

            fig_12 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_der = bar(power_band_total(idx_areas_der,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_der))
            lgd = legend([bar_der(1) bar_der(2) bar_der(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_der(1).FaceColor = azul; bar_der(2).FaceColor = rojo; bar_der(3).FaceColor = verde;
            grid on
            ylim([0 4])
            ylabel('Oscillatory Power [W/Hz]', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Oscillatory Signal Power of rigth hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Oscillatory Signal Power of rigth hemisphere'];
            saveas(fig_12,name_figure_save,'png');
            saveas(fig_12,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_12)   
            
            % Graficar cambio en la potencia    
            fig_14 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izq = bar(power_band_total_norm(idx_areas_izq,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            lgd = legend([bar_izq(1) bar_izq(2) bar_izq(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            grid on
            ylim([0 2])
            ylabel('Normalized Oscillatory Power', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Normalized Oscillatory Signal Power by Pre-Stim of left hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Oscillatory Signal Power Normalized of left hemisphere'];
            saveas(fig_14,name_figure_save,'png');
            saveas(fig_14,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_14)   

            fig_15 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_der = bar(power_band_total_norm(idx_areas_der,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_der))
            lgd = legend([bar_der(1) bar_der(2) bar_der(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_der(1).FaceColor = azul; bar_der(2).FaceColor = rojo; bar_der(3).FaceColor = verde;
            grid on
            ylim([0 2])
            ylabel('Normalized Oscillatory Power', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Normalized Oscillatory Signal Power by Pre-Stim of rigth hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Oscillatory Signal Power Normalized of rigth hemisphere'];
            saveas(fig_15,name_figure_save,'png');
            saveas(fig_15,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_15)   
            
        end
    end
    
end

