function percent_power_band = power_measurements_MT(registroLFP, banda_eval, visualization, save_image, path)

    banda_actual = 'None';
    
    if banda_eval == [4, 8]
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
        
        
    percent_power_band = [];
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
        Spectrogram_mean_raw = registroLFP.average_spectrum(i).spectrogram.data_raw;
    
        time = registroLFP.average_spectrum(i).spectrogram.time;
        freq = registroLFP.average_spectrum(i).spectrogram.frequency; 
        area_actual = registroLFP.average_spectrum(i).area;
        idx_spect_artifacts = registroLFP.average_spectrum(i).spectrogram.ind_artifacts;     

        % Indices de cada etapa
        idx_pre = find(time<(pre_m*60.0-5));
        idx_on = find(time>(on_inicio_m*60.0+5) & time<(on_final_m*60.0-5));
        idx_post = find(time>(post_m*60.0+5) & time<(tiempo_total*60));

        % PSD sin Pink Noise
        PSD_pre_mean_raw = mean(Spectrogram_mean_raw(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:),1);    
        PSD_on_mean_raw = mean(Spectrogram_mean_raw(idx_on(~ismember(idx_on, idx_spect_artifacts)),:),1);    
        PSD_post_mean_raw = mean(Spectrogram_mean_raw(idx_post(~ismember(idx_post, idx_spect_artifacts)),:),1);        
        
        psd_pre = PSD_pre_mean_raw;%registroLFP.average_spectrum(i).psd.pre.data;        
        psd_on = PSD_on_mean_raw;%registroLFP.average_spectrum(i).psd.on.data;
        psd_post = PSD_post_mean_raw;%registroLFP.average_spectrum(i).psd.post.data;
        %base=interp1(freq(freq>=min(freq_beta) & freq<=40),psd_pre_smooth(freq>=min(freq_beta) & freq<=40),freq_beta,'spline');
        %PSD_pre_mean_raw_temp = PSD_pre_mean_raw;
        %PSD_pre_mean_raw_temp(freq>=banda_beta(1) & freq<=banda_beta(2)) = [];
        %freq_temp = freq;
        %freq_temp(freq>=banda_beta(1) & freq<=banda_beta(2)) = [];
        %[~,idx_max] = max(PSD_pre_mean_raw_temp);
        
        %base = interp1(freq_temp(idx_max:end),PSD_pre_mean_raw_temp(idx_max:end),freq(idx_max:end),'pchip');
        [~, ~, base_pre] = convert_to_dBpink(freq, PSD_pre_mean_raw', [1 100]);

        psd_base_pre = psd_pre;
        %psd_base(idx_max:end) = base;
        psd_base_pre(freq>=banda_eval(1) & freq<=banda_eval(2)) = base_pre(freq>=banda_eval(1) & freq<=banda_eval(2));
        
        [~, ~, base_on] = convert_to_dBpink(freq, PSD_on_mean_raw', [1 100]);
        
        psd_base_on = psd_on;
        %psd_base(idx_max:end) = base;
        psd_base_on(freq>=banda_eval(1) & freq<=banda_eval(2)) = base_on(freq>=banda_eval(1) & freq<=banda_eval(2));
        
        [~, ~, base_post] = convert_to_dBpink(freq, PSD_post_mean_raw', [1 100]);
        
        psd_base_post = psd_post;
        %psd_base(idx_max:end) = base;
        psd_base_post(freq>=banda_eval(1) & freq<=banda_eval(2)) = base_post(freq>=banda_eval(1) & freq<=banda_eval(2));

        min_valor_psd = min([min(psd_pre), min(psd_on), min(psd_post)]); % Ver por q esto???
        power_band_base_pre = bandpower(psd_base_pre-min_valor_psd,freq,banda_eval,'psd');
        power_band_base_on = bandpower(psd_base_on-min_valor_psd,freq,banda_eval,'psd');
        power_band_base_post = bandpower(psd_base_post-min_valor_psd,freq,banda_eval,'psd');
        power_band_pre = bandpower(psd_pre-min_valor_psd,freq,banda_eval,'psd');
        power_band_on = bandpower(psd_on-min_valor_psd,freq,banda_eval,'psd');
        power_band_post = bandpower(psd_post-min_valor_psd,freq,banda_eval,'psd');

        percent_power_band_pre = (100*power_band_pre/power_band_base_pre)-100;
        percent_power_band_on = (100*power_band_on/power_band_base_on)-100;
        percent_power_band_post = (100*power_band_post/power_band_base_post)-100;

        areas = {areas{:},area_actual};
        percent_power_band = [percent_power_band; [percent_power_band_pre,percent_power_band_on,percent_power_band_post]];

        if visualization
            figure;
            plot(freq, psd_pre)
            hold on
            plot(freq, psd_base_pre)
            hold on
            plot(freq, base_pre)
            %hold on
            %plot(freq, psd_on)
            %hold on
            %plot(freq, psd_post)
            ylim([-inf max(psd_pre)*1.1])
            title(area_actual)

            fprintf('%s\n', area_actual)
            fprintf('Porcentaje de banda beta en pre: %.2f \n', percent_power_band_pre)
            fprintf('Porcentaje de banda beta en on: %.2f \n', percent_power_band_on)
            fprintf('Porcentaje de banda beta en post: %.2f \n\n', percent_power_band_post)
        end
    end

    if visualization
        disp(' ')
        fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', mean(percent_power_band(idx_areas_izq,:)))
        fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n',mean(percent_power_band(idx_areas_der,:)))    

        if length(idx_areas_izq) == 1
            y_max = max([max(percent_power_band(idx_areas_izq,:)) max(percent_power_band(idx_areas_der,:))]);
            y_min = min([min(percent_power_band(idx_areas_izq,:)) min(percent_power_band(idx_areas_der,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            bar_izqder = bar(percent_power_band,'grouped');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            title(['Change in Power in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])
            
        else
            y_max = max([max(percent_power_band(idx_areas_izq,:)) max(percent_power_band(idx_areas_der,:))]);
            y_min = min([min(percent_power_band(idx_areas_izq,:)) min(percent_power_band(idx_areas_der,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar_izq = bar(percent_power_band(idx_areas_izq,:),'grouped');
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            title(['Change in Power in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])
            subplot(2,1,2)
            bar_der = bar(percent_power_band(idx_areas_der,:),'grouped');
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
            bar_izqder = bar(percent_power_band,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            bar_izqder(1).FaceColor = azul; bar_izqder(2).FaceColor = rojo; bar_izqder(3).FaceColor = verde;
            grid on
            ylim([-50 300])
            ylabel('Signal/Pink noise Power Rate', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Signal/Pink noise Power Rate of left and right hemisphere in ',banda_actual,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Change in Power in band ',banda_actual,' of left and right hemisphere'];
            saveas(fig_11,name_figure_save,'png');
            saveas(fig_11,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_11)
        
        else
            % Graficar cambio en la potencia    
            fig_11 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_izq = bar(percent_power_band(idx_areas_izq,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            lgd = legend([bar_izq(1) bar_izq(2) bar_izq(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_izq(1).FaceColor = azul; bar_izq(2).FaceColor = rojo; bar_izq(3).FaceColor = verde;
            grid on
            ylim([-50 300])
            ylabel('Signal/Pink noise Power Rate', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Signal/Pink noise Power Rate of left hemisphere in ',banda_actual,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Change in Power in band ',banda_actual,' of left hemisphere'];
            saveas(fig_11,name_figure_save,'png');
            saveas(fig_11,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_11)   

            fig_12 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_der = bar(percent_power_band(idx_areas_der,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_der))
            lgd = legend([bar_der(1) bar_der(2) bar_der(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_der(1).FaceColor = azul; bar_der(2).FaceColor = rojo; bar_der(3).FaceColor = verde;
            grid on
            ylim([-50 300])
            ylabel('Signal/Pink noise Power Rate', 'FontSize', 24)
            set(gca,'fontsize',20)
            title(['Signal/Pink noise Power Rate of rigth hemisphere in ',banda_actual,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Change in Power in band ',banda_actual,' of rigth hemisphere'];
            saveas(fig_12,name_figure_save,'png');
            saveas(fig_12,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_12)   
        end
    end
    
end

