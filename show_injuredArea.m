%%% Probar que area es la lesionada
function show_injuredArea(registroLFP)
    banda_beta = [8, 20];
    percent_power_band = [];
    areas = {};

    for i = 1:length(registroLFP.average_spectrum)
        freq = registroLFP.average_spectrum(i).spectrogram.frecuencia;
        freq_beta = freq(freq>=banda_beta(1) & freq<=banda_beta(2));

        psd_pre = registroLFP.average_spectrum(i).psd.pre.data;
        psd_pre_beta = psd_pre(freq>=banda_beta(1) & freq<=banda_beta(2));
        potencia_min_base = psd_pre_beta(1);
        potencia_max_base = psd_pre_beta(end);
        psd_pre_smooth = smooth(freq, psd_pre,0.05, 'loess');
        
        %base=interp1([min(freq_beta), max(freq_beta)],[potencia_min_base, potencia_max_base],freq_beta,'linear');
        base=interp1(freq(freq>=min(freq_beta) & freq<=40),psd_pre_smooth(freq>=min(freq_beta) & freq<=40),freq_beta,'spline');
        psd_base = psd_pre;
        psd_base(freq>=banda_beta(1) & freq<=banda_beta(2)) = base;
        
        figure;
        plot(freq, psd_pre)
        hold on
        plot(freq, psd_base)

        psd_on = registroLFP.average_spectrum(i).psd.on.data;
        psd_post = registroLFP.average_spectrum(i).psd.post.data;

        min_valor_psd = min([min(psd_pre), min(psd_on), min(psd_post)]);
        power_band_base = bandpower(psd_base-min_valor_psd,freq,banda_beta,'psd');
        power_band_pre = bandpower(psd_pre-min_valor_psd,freq,banda_beta,'psd');
        power_band_on = bandpower(psd_on-min_valor_psd,freq,banda_beta,'psd');
        power_band_post = bandpower(psd_post-min_valor_psd,freq,banda_beta,'psd');

        percent_power_band_pre = (100*power_band_pre/power_band_base)-100;
        percent_power_band_on = (100*power_band_on/power_band_base)-100;
        percent_power_band_post = (100*power_band_post/power_band_base)-100;

        area_actual = registroLFP.average_spectrum(i).area{1};
        areas = {areas{:},area_actual};
        percent_power_band = [percent_power_band; [percent_power_band_pre,percent_power_band_on,percent_power_band_post]];

        fprintf('%s\n', area_actual)
        fprintf('Porcentaje de banda beta en pre: %.2f \n', percent_power_band_pre)
        fprintf('Porcentaje de banda beta en on: %.2f \n', percent_power_band_on)
        fprintf('Porcentaje de banda beta en post: %.2f \n\n', percent_power_band_post)
    end

    disp(' ')
    fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', mean(percent_power_band(1:5,:)))
    fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n',mean(percent_power_band(6:10,:)))    
    
    figure;
    subplot(2,1,1)
    bar(percent_power_band(1:5,:),'grouped');
    xt = get(gca, 'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', areas(1:5))
    legend('Pre', 'Stim', 'Post');
    grid on
    subplot(2,1,2)
    bar(percent_power_band(6:10,:),'grouped');
    xt = get(gca, 'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', areas(6:10))
    legend('Pre', 'Stim', 'Post');
    grid on
    
end

