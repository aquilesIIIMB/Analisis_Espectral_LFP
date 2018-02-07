%%% Probar que area es la lesionada
function percent_power_band = power_measurements(registroLFP, banda_eval, visualization)
    percent_power_band = [];
    areas = {};
    
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
            bar(percent_power_band,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas)
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            
        else
            y_max = max([max(percent_power_band(idx_areas_izq,:)) max(percent_power_band(idx_areas_der,:))]);
            y_min = min([min(percent_power_band(idx_areas_izq,:)) min(percent_power_band(idx_areas_der,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar(percent_power_band(idx_areas_izq,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_izq))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            subplot(2,1,2)
            bar(percent_power_band(idx_areas_der,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', areas(idx_areas_der))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
        end
    end
    
end

