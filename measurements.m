%%% Metricas

%protocoloLFP.register_checked.name = [];
protocoloLFP.coherency.injured.pre.data = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.pre.mean_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.pre.std_mean_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.pre.sum_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.pre.std_sum_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));

protocoloLFP.coherency.injured.on.data = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.on.mean_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.on.std_mean_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.on.sum_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.on.std_sum_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));

protocoloLFP.coherency.injured.post.data = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.post.mean_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.post.std_mean_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.post.sum_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));
protocoloLFP.coherency.injured.post.std_sum_beta = cell(length(protocoloLFP.injured),length(protocoloLFP.injured));


protocoloLFP.coherency.uninjured.pre.data = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.pre.mean_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.pre.std_mean_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.pre.sum_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.pre.std_sum_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));

protocoloLFP.coherency.uninjured.on.data = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.on.mean_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.on.std_mean_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.on.sum_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.on.std_sum_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));

protocoloLFP.coherency.uninjured.post.data = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.post.mean_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.post.std_mean_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.post.sum_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));
protocoloLFP.coherency.uninjured.post.std_sum_beta = cell(length(protocoloLFP.uninjured),length(protocoloLFP.uninjured));

% Beta Band Power
banda_beta = [8, 20];

% Injured
p = 2;

for i = 1:length(protocoloLFP.injured)
    percent_power_band_pre = [];
    percent_power_band_on = [];
    percent_power_band_post = [];
    
    for k = 1:length(protocoloLFP.injured(i).psd.pre)
        % Power Band
        % frecuencia
        freq = protocoloLFP.injured(i).psd.frequency;
        freq_beta = freq(freq>=banda_beta(1) & freq<=banda_beta(2));

        % PSD pre
        psd_pre = db(protocoloLFP.injured(i).psd.pre(k).data,'power');
        psd_pre_beta = psd_pre(freq>=banda_beta(1) & freq<=banda_beta(2));
        
        % Potencia base
        potencia_min_base = psd_pre_beta(1);
        potencia_max_base = psd_pre_beta(end);
        base=interp1([min(freq_beta), max(freq_beta)],[potencia_min_base, potencia_max_base],freq_beta,'linear');
        psd_base = psd_pre;
        psd_base(freq>=banda_beta(1) & freq<=banda_beta(2)) = base;

        % PSD on
        psd_on = db(protocoloLFP.injured(i).psd.on(k).data,'power');
        
        % PSD post
        psd_post = db(protocoloLFP.injured(i).psd.post(k).data,'power');

        min_valor_psd = min([min(psd_pre), min(psd_on), min(psd_post)]);
        power_band_base = bandpower(psd_base-min_valor_psd,freq,banda_beta,'psd');
        power_band_pre = bandpower(psd_pre-min_valor_psd,freq,banda_beta,'psd');
        power_band_on = bandpower(psd_on-min_valor_psd,freq,banda_beta,'psd');
        power_band_post = bandpower(psd_post-min_valor_psd,freq,banda_beta,'psd');

        percent_power_band_pre = [percent_power_band_pre, (100*power_band_pre/power_band_base)-100];
        percent_power_band_on = [percent_power_band_on, (100*power_band_on/power_band_base)-100];
        percent_power_band_post = [percent_power_band_post, (100*power_band_post/power_band_base)-100];
        
    end
    
    % Almacenar los datos
    protocoloLFP.injured(i).power_band.pre.mean = mean(percent_power_band_pre);
    protocoloLFP.injured(i).power_band.pre.std = std(percent_power_band_pre);
    protocoloLFP.injured(i).power_band.on.mean = mean(percent_power_band_on);
    protocoloLFP.injured(i).power_band.on.std = std(percent_power_band_on);
    protocoloLFP.injured(i).power_band.post.mean = mean(percent_power_band_post);
    protocoloLFP.injured(i).power_band.post.std = std(percent_power_band_post);
    
end



for i=1:length(protocoloLFP.injured)-1
    % Coherencia    
    for j = length(protocoloLFP.injured):-1:p
        
        Coherency_pre = [];
        Coherency_on = [];
        Coherency_post = [];
            
        mean_cohe_beta_pre = [];
        sum_cohe_beta_pre = [];
        mean_cohe_beta_on = [];
        sum_cohe_beta_on = [];
        mean_cohe_beta_post = [];
        sum_cohe_beta_post = [];

        for k = 1:length(protocoloLFP.injured(i).area_signals)
            
            signal1 = protocoloLFP.injured(i).area_signals(k).data; %
            signal2 = protocoloLFP.injured(j).area_signals(k).data;
            params = protocoloLFP.multitaper.params;
            movingwin = [protocoloLFP.multitaper.movingwin.window protocoloLFP.multitaper.movingwin.winstep];
            [C,phi,S12,S1,S2,t,f]=cohgramc(signal1,signal2,movingwin,params);

            % Coherencia promedio por etapa
            time_range = protocoloLFP.times.phase_range_m(1);
            Coherency_pre_mean = mean(C((t<time_range*60),:),1);
            Coherency_on_mean = mean(C((t>time_range*60.0+30 & t<time_range*2*60.0+30),:),1);
            Coherency_post_mean = mean(C((t>time_range*2*60.0+60),:),1);
            
            Coherency_pre = [Coherency_pre; Coherency_pre_mean];
            Coherency_on = [Coherency_on; Coherency_on_mean];
            Coherency_post = [Coherency_post; Coherency_post_mean];

            % Metricas en la banda beta
            mean_cohe_beta_pre = [mean_cohe_beta_pre, mean(Coherency_pre_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            sum_cohe_beta_pre = [sum_cohe_beta_pre, sum(Coherency_pre_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            mean_cohe_beta_on = [mean_cohe_beta_on, mean(Coherency_on_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            sum_cohe_beta_on = [sum_cohe_beta_on, sum(Coherency_on_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            mean_cohe_beta_post = [mean_cohe_beta_post, mean(Coherency_post_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            sum_cohe_beta_post = [sum_cohe_beta_post, sum(Coherency_post_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            
        end

        % Almacenar los datos
        protocoloLFP.coherency.injured.pre.data{i,j} = mean(Coherency_pre,1); %sacar el promedio
        protocoloLFP.coherency.injured.pre.mean_beta{i,j} = mean(mean_cohe_beta_pre);
        protocoloLFP.coherency.injured.pre.std_mean_beta{i,j} = std(mean_cohe_beta_pre);
        protocoloLFP.coherency.injured.pre.sum_beta{i,j} = mean(sum_cohe_beta_pre);
        protocoloLFP.coherency.injured.pre.std_sum_beta{i,j} = std(sum_cohe_beta_pre);

        protocoloLFP.coherency.injured.on.data{i,j} = mean(Coherency_on,1);
        protocoloLFP.coherency.injured.on.mean_beta{i,j} = mean(mean_cohe_beta_on);
        protocoloLFP.coherency.injured.on.std_mean_beta{i,j} = std(mean_cohe_beta_on);
        protocoloLFP.coherency.injured.on.sum_beta{i,j} = mean(sum_cohe_beta_on);
        protocoloLFP.coherency.injured.on.std_sum_beta{i,j} = std(sum_cohe_beta_on);

        protocoloLFP.coherency.injured.post.data{i,j} = mean(Coherency_post,1);
        protocoloLFP.coherency.injured.post.mean_beta{i,j} = mean(mean_cohe_beta_post);
        protocoloLFP.coherency.injured.post.std_mean_beta{i,j} = std(mean_cohe_beta_post);
        protocoloLFP.coherency.injured.post.sum_beta{i,j} = mean(sum_cohe_beta_post);
        protocoloLFP.coherency.injured.post.std_sum_beta{i,j} = std(sum_cohe_beta_post);

        protocoloLFP.coherency.injured.frequency = f;

    end

    p=p+1;


end
    

% Uninjured
p = 2;

for i = 1:length(protocoloLFP.uninjured)
    percent_power_band_pre = [];
    percent_power_band_on = [];
    percent_power_band_post = [];
    
    for k = 1:length(protocoloLFP.uninjured(i).psd.pre)
        % Power Band
        freq = protocoloLFP.uninjured(i).psd.frequency;
        freq_beta = freq(freq>=banda_beta(1) & freq<=banda_beta(2));

        psd_pre = db(protocoloLFP.uninjured(i).psd.pre(k).data,'power');
        psd_pre_beta = psd_pre(freq>=banda_beta(1) & freq<=banda_beta(2));
        potencia_min_base = psd_pre_beta(1);
        potencia_max_base = psd_pre_beta(end);

        base=interp1([min(freq_beta), max(freq_beta)],[potencia_min_base, potencia_max_base],freq_beta,'linear');
        psd_base = psd_pre;
        psd_base(freq>=banda_beta(1) & freq<=banda_beta(2)) = base;

        psd_on = db(protocoloLFP.uninjured(i).psd.on(k).data,'power');
        psd_post = db(protocoloLFP.uninjured(i).psd.post(k).data,'power');

        min_valor_psd = min([min(psd_pre), min(psd_on), min(psd_post)]);
        power_band_base = bandpower(psd_base-min_valor_psd,freq,banda_beta,'psd');
        power_band_pre = bandpower(psd_pre-min_valor_psd,freq,banda_beta,'psd');
        power_band_on = bandpower(psd_on-min_valor_psd,freq,banda_beta,'psd');
        power_band_post = bandpower(psd_post-min_valor_psd,freq,banda_beta,'psd');
        
        percent_power_band_pre = [percent_power_band_pre, (100*power_band_pre/power_band_base)-100];
        percent_power_band_on = [percent_power_band_on, (100*power_band_on/power_band_base)-100];
        percent_power_band_post = [percent_power_band_post, (100*power_band_post/power_band_base)-100];
        
    end

    % Almacenar los datos
    protocoloLFP.uninjured(i).power_band.pre.mean = mean(percent_power_band_pre);
    protocoloLFP.uninjured(i).power_band.pre.std = std(percent_power_band_pre);
    protocoloLFP.uninjured(i).power_band.on.mean = mean(percent_power_band_on);
    protocoloLFP.uninjured(i).power_band.on.std = std(percent_power_band_on);
    protocoloLFP.uninjured(i).power_band.post.mean = mean(percent_power_band_post);
    protocoloLFP.uninjured(i).power_band.post.std = std(percent_power_band_post);
    
end

for i=1:length(protocoloLFP.uninjured)-1

    % Coherencia    
    for j = length(protocoloLFP.uninjured):-1:p
        
        Coherency_pre = [];
        Coherency_on = [];
        Coherency_post = [];
            
        mean_cohe_beta_pre = [];
        sum_cohe_beta_pre = [];
        mean_cohe_beta_on = [];
        sum_cohe_beta_on = [];
        mean_cohe_beta_post = [];
        sum_cohe_beta_post = [];

        for k = 1:length(protocoloLFP.uninjured(i).area_signals)

            signal1 = protocoloLFP.uninjured(i).area_signals(k).data;
            signal2 = protocoloLFP.uninjured(j).area_signals(k).data;
            params = protocoloLFP.multitaper.params;
            movingwin = [protocoloLFP.multitaper.movingwin.window protocoloLFP.multitaper.movingwin.winstep];
            [C,phi,S12,S1,S2,t,f]=cohgramc(signal1,signal2,movingwin,params);

            % Coherencia promedio por etapa
            time_range = protocoloLFP.times.phase_range_m(1);
            Coherency_pre_mean = mean(C((t<time_range*60),:),1);
            Coherency_on_mean = mean(C((t>time_range*60.0+30 & t<time_range*2*60.0+30),:),1);
            Coherency_post_mean = mean(C((t>time_range*2*60.0+60),:),1);
            
            Coherency_pre = [Coherency_pre; Coherency_pre_mean];
            Coherency_on = [Coherency_on; Coherency_on_mean];
            Coherency_post = [Coherency_post; Coherency_post_mean];

            % Metricas en la banda beta
            mean_cohe_beta_pre = [mean_cohe_beta_pre, mean(Coherency_pre_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            sum_cohe_beta_pre = [sum_cohe_beta_pre, sum(Coherency_pre_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            mean_cohe_beta_on = [mean_cohe_beta_on, mean(Coherency_on_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            sum_cohe_beta_on = [sum_cohe_beta_on, sum(Coherency_on_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            mean_cohe_beta_post = [mean_cohe_beta_post, mean(Coherency_post_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            sum_cohe_beta_post = [sum_cohe_beta_post, sum(Coherency_post_mean(f>=banda_beta(1) & f<=banda_beta(2)))];
            
        end

        % Almacenar los datos
        protocoloLFP.coherency.uninjured.pre.data{i,j} = mean(Coherency_pre,1); 
        protocoloLFP.coherency.uninjured.pre.mean_beta{i,j} = mean(mean_cohe_beta_pre);
        protocoloLFP.coherency.uninjured.pre.std_mean_beta{i,j} = std(mean_cohe_beta_pre);
        protocoloLFP.coherency.uninjured.pre.sum_beta{i,j} = mean(sum_cohe_beta_pre);
        protocoloLFP.coherency.uninjured.pre.std_sum_beta{i,j} = std(sum_cohe_beta_pre);
        
        protocoloLFP.coherency.uninjured.on.data{i,j} = mean(Coherency_on,1);
        protocoloLFP.coherency.uninjured.on.mean_beta{i,j} = mean(mean_cohe_beta_on);
        protocoloLFP.coherency.uninjured.on.std_mean_beta{i,j} = std(mean_cohe_beta_on);
        protocoloLFP.coherency.uninjured.on.sum_beta{i,j} = mean(sum_cohe_beta_on);
        protocoloLFP.coherency.uninjured.on.std_sum_beta{i,j} = std(sum_cohe_beta_on);
        
        protocoloLFP.coherency.uninjured.post.data{i,j} = mean(Coherency_post,1);
        protocoloLFP.coherency.uninjured.post.mean_beta{i,j} = mean(mean_cohe_beta_post);
        protocoloLFP.coherency.uninjured.post.std_mean_beta{i,j} = std(mean_cohe_beta_post);
        protocoloLFP.coherency.uninjured.post.sum_beta{i,j} = mean(sum_cohe_beta_post);
        protocoloLFP.coherency.uninjured.post.std_sum_beta{i,j} = std(sum_cohe_beta_post);
        
        protocoloLFP.coherency.uninjured.frequency = f;
        
    end
    
    p=p+1;
    
    
end


clear banda_beta base C Coherency_on_mean Coherency_post_mean Coherency_pre_mean
clear f freq freq_beta i j mean_cohe_beta_on mean_cohe_beta_post mean_cohe_beta_pre
clear min_valor_psd movingwin p params percent_power_band percent_power_band_on
clear percent_power_band_post percent_power_band_pre phi potencia_max_base
clear potencia_min_base power_band_base power_band_on power_band_post power_band_pre
clear psd_base psd_on psd_post psd_pre psd_pre_beta S1 S12 S2 signal1
clear signal2 sum_cohe_beta_on sum_cohe_beta_post sum_cohe_beta_pre
clear t time_range k Coherency_on Coherency_pre Coherency_post



