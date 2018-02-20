function power_band = power_measurements_IRASA(registroLFP, banda_eval, visualization, save_image, path)

    banda_actual = 'None';
    
    if banda_eval == [1, 4]
        banda_actual = 'delta';
    elseif banda_eval == [4, 8]
        banda_actual = 'theta';
    elseif banda_eval == [8, 12]
        banda_actual = 'alpha';
    elseif banda_eval == [12, 20]
        banda_actual = 'beta_low';
    elseif banda_eval == [20, 30]
        banda_actual = 'beta_high';
    elseif banda_eval == [12, 30]
        banda_actual = 'beta';
    elseif banda_eval == [8, 30]
        banda_actual = 'beta_parkinson';
    elseif banda_eval == [30, 60]
        banda_actual = 'gamma_low';
    elseif banda_eval == [60, 90]
        banda_actual = 'gamma_high';
    elseif banda_eval == [30, 90]
        banda_actual = 'gamma';
    end
        
        
    power_band = [];
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
    
        freq = registroLFP.average_spectrum(i).spectrogram.frequency; 
        area_actual = registroLFP.average_spectrum(i).area;       
        
        psd_pre = registroLFP.average_spectrum(i).psd.pre.data;        
        psd_on = registroLFP.average_spectrum(i).psd.on.data;
        psd_post = registroLFP.average_spectrum(i).psd.post.data;
        
        min_psd = min([min(psd_pre),min(psd_on),min(psd_post)]);
        
        min_f = min(freq);
        max_f = max(freq);
        
        if banda_eval(1) < min_f
            banda_eval(1) = min_f;
        end
        
        if banda_eval(2) > max_f
            banda_eval(2) = max_f;
        end

        power_band_pre = bandpower(psd_pre-min_psd, freq, banda_eval,'psd');
        power_band_on = bandpower(psd_on-min_psd, freq, banda_eval,'psd');
        power_band_post = bandpower(psd_post-min_psd, freq, banda_eval,'psd');
        
        power_band_pre_total = bandpower(psd_pre-min_psd, freq, [min_f, max_f],'psd');
        power_band_on_total = bandpower(psd_on-min_psd, freq, [min_f, max_f],'psd');
        power_band_post_total = bandpower(psd_post-min_psd, freq, [min_f, max_f],'psd');       

        areas = {areas{:},area_actual};
        power_band = [power_band; [power_band_pre/power_band_pre_total, power_band_on/power_band_on_total, power_band_post/power_band_post_total]];

        if visualization
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
            fprintf('Porcentaje de banda en pre: %.2f \n', power_band_pre)
            fprintf('Porcentaje de banda en on: %.2f \n', power_band_on)
            fprintf('Porcentaje de banda en post: %.2f \n\n', power_band_post)
        end
    end

    if visualization
        disp(' ')
        fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', mean(power_band(idx_areas_izq,:)))
        fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n',mean(power_band(idx_areas_der,:)))    

        if length(idx_areas_izq) == 1
            y_max = max([max(power_band(idx_areas_izq,:)) max(power_band(idx_areas_der,:))]);
            y_min = min([min(power_band(idx_areas_izq,:)) min(power_band(idx_areas_der,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            bar_izqder = bar(power_band,'grouped');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            title(['Normalized Oscillatory Power in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])
            
        else
            y_max = max([max(power_band(idx_areas_izq,:)) max(power_band(idx_areas_der,:))]);
            y_min = min([min(power_band(idx_areas_izq,:)) min(power_band(idx_areas_der,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar_izq = bar(power_band(idx_areas_izq,:),'grouped');
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            title(['Normalized Oscillatory Power in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])
            subplot(2,1,2)
            bar_der = bar(power_band(idx_areas_der,:),'grouped');
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
            bar_izqder = bar(power_band,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            grid on
            ylim([0 1])
            ylabel('Normalized Oscillatory Signal Power', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Normalized Oscillatory Signal Power of left and right hemisphere in ',banda_actual,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Oscillatory Signal Power Normalized in band ',banda_actual,' of left and right hemisphere'];
            saveas(fig_11,name_figure_save,'png');
            saveas(fig_11,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_11)
        
        else
            % Graficar cambio en la potencia    
            fig_11 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izq = bar(power_band(idx_areas_izq,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            lgd = legend([bar_izq(1) bar_izq(2) bar_izq(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            grid on
            ylim([0 1])
            ylabel('Normalized Oscillatory Signal Power', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Normalized Oscillatory Signal Power of left hemisphere in ',banda_actual,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Oscillatory Signal Power Normalized in band ',banda_actual,' of left hemisphere'];
            saveas(fig_11,name_figure_save,'png');
            saveas(fig_11,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_11)   

            fig_12 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_der = bar(power_band(idx_areas_der,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_der))
            lgd = legend([bar_der(1) bar_der(2) bar_der(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_der(1).FaceColor = azul; bar_der(2).FaceColor = rojo; bar_der(3).FaceColor = verde;
            grid on
            ylim([0 1])
            ylabel('Normalized Oscillatory Signal Power', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Normalized Oscillatory Signal Power of rigth hemisphere in ',banda_actual,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Oscillatory Signal Power Normalized in band ',banda_actual,' of rigth hemisphere'];
            saveas(fig_12,name_figure_save,'png');
            saveas(fig_12,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_12)   
        end
    end
    
end

