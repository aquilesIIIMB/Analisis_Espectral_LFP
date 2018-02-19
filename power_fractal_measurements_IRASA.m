function power_fractal_band = power_fractal_measurements_IRASA(registroLFP, visualization, save_image, path)
        
    power_fractal_band = [];
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
        psd_pre = mean(FracSpectrogram_pre,1);    
        psd_on = mean(FracSpectrogram_on,1);    
        psd_post = mean(FracSpectrogram_post,1);
        
        power_band_pre = bandpower(psd_pre, freq, [1, 90],'psd');
        power_band_on = bandpower(psd_on, freq, [1, 90],'psd');
        power_band_post = bandpower(psd_post, freq, [1, 90],'psd');
        
        power_band_total = power_band_pre + power_band_on + power_band_post;       

        areas = {areas{:},area_actual};
        %power_fractal_band = [power_fractal_band; [100*power_band_pre/power_band_total, 100*power_band_on/power_band_total, 100*power_band_post/power_band_total]];
        power_fractal_band = [power_fractal_band; [power_band_pre/power_band_pre, power_band_on/power_band_pre, power_band_post/power_band_pre]];

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
            fprintf('Porcentaje de banda beta en pre: %.2f \n', power_band_pre)
            fprintf('Porcentaje de banda beta en on: %.2f \n', power_band_on)
            fprintf('Porcentaje de banda beta en post: %.2f \n\n', power_band_post)
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
            title(['Fractal Power Percentage'])
            
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
            title(['Fractal Power Percentage'])
            subplot(2,1,2)
            bar_der = bar(power_fractal_band(idx_areas_der,:),'grouped');
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
            ylim([0 2])
            ylabel('Fractal Power Percentage', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Fractal Signal Power Percentage of left and right hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Fractal Signal Power Percentage of left and right hemisphere'];
            saveas(fig_11,name_figure_save,'png');
            saveas(fig_11,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_11)
        
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
            ylim([0 2])
            ylabel('Fractal Power Percentage', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Fractal Signal Power Percentage of left hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Fractal Signal Power Percentage of left hemisphere'];
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
            ylim([0 2])
            ylabel('Fractal Power Percentage', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Fractal Signal Power Percentage of rigth hemisphere'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Fractal Signal Power Percentage of rigth hemisphere'];
            saveas(fig_12,name_figure_save,'png');
            saveas(fig_12,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_12)   
        end
    end
    
end

