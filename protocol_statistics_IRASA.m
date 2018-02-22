function protocoloLFP = protocol_statistics_IRASA(protocoloLFP,path,save_protocol)

num_record = length(protocoloLFP.register_checked);
num_areas_spectral = length(protocoloLFP.injured_global(1).spectral);
num_areas_coherence = length(protocoloLFP.injured_global(1).coherence);
num_bands = length(protocoloLFP.injured_global(1).spectral(1).change_band_power);

azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];


% Agregar coherencia

for area_actual = 1:max([num_areas_spectral, num_areas_coherence])
    if area_actual <= num_areas_spectral
        % Spectral
        datos_actual_inj_change_power = [];
        datos_actual_uninj_change_power = [];
        
        datos_actual_inj_fractal_power = [];
        datos_actual_uninj_fractal_power = [];
    end
    
    % Coherence
    datos_actual_inj_sum_MSC= [];
    datos_actual_uninj_sum_MSC = [];
    
    datos_actual_inj_coupling_strength= [];
    datos_actual_uninj_coupling_strength = [];
    
    datos_actual_inj_delay = [];
    datos_actual_uninj_delay = [];
    
    for reg_actual = 1:num_record
        if area_actual <= num_areas_spectral
            % Change power in injured area
            change_power_actual_inj = struct2cell(protocoloLFP.injured(reg_actual).spectral_record(area_actual).change_band_power);
            change_power_reg_inj = [change_power_actual_inj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
            datos_actual_inj_change_power = [datos_actual_inj_change_power; change_power_reg_inj];
        
            % Change power in uninjured area
            change_power_actual_uninj = struct2cell(protocoloLFP.uninjured(reg_actual).spectral_record(area_actual).change_band_power);
            change_power_reg_uninj = [change_power_actual_uninj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
            datos_actual_uninj_change_power = [datos_actual_uninj_change_power; change_power_reg_uninj];
            
            
            % Fractal power in injured area
            fractal_power_actual_inj_pre = protocoloLFP.injured(reg_actual).spectral_record(area_actual).fractal_power.pre;
            fractal_power_actual_inj_on = protocoloLFP.injured(reg_actual).spectral_record(area_actual).fractal_power.on;
            fractal_power_actual_inj_post = protocoloLFP.injured(reg_actual).spectral_record(area_actual).fractal_power.post;
            datos_actual_inj_fractal_power = [datos_actual_inj_fractal_power; [fractal_power_actual_inj_pre, fractal_power_actual_inj_on, fractal_power_actual_inj_post]];
        
            % Fractal power in uninjured area            
            fractal_power_actual_uninj_pre = protocoloLFP.injured(reg_actual).spectral_record(area_actual).fractal_power.pre;
            fractal_power_actual_uninj_on = protocoloLFP.injured(reg_actual).spectral_record(area_actual).fractal_power.on;
            fractal_power_actual_uninj_post = protocoloLFP.injured(reg_actual).spectral_record(area_actual).fractal_power.post;
            datos_actual_uninj_fractal_power = [datos_actual_uninj_fractal_power; [fractal_power_actual_uninj_pre, fractal_power_actual_uninj_on, fractal_power_actual_uninj_post]];
        end
        
        % Sum MSC in injured area
        sum_MSC_actual_inj = struct2cell(protocoloLFP.injured(reg_actual).coherence_record(area_actual).sum_MSC);
        sum_MSC_reg_inj = [sum_MSC_actual_inj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_inj_sum_MSC = [datos_actual_inj_sum_MSC; sum_MSC_reg_inj];
        
        % Sum MSC in uninjured area
        sum_MSC_actual_uninj = struct2cell(protocoloLFP.uninjured(reg_actual).coherence_record(area_actual).sum_MSC);
        sum_MSC_reg_uninj = [sum_MSC_actual_uninj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_uninj_sum_MSC = [datos_actual_uninj_sum_MSC; sum_MSC_reg_uninj];
        
        % Coupling Strength in injured area
        coupling_strength_actual_inj = struct2cell(protocoloLFP.injured(reg_actual).coherence_record(area_actual).coupling_strength);
        coupling_strength_reg_inj = [coupling_strength_actual_inj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_inj_coupling_strength = [datos_actual_inj_coupling_strength; coupling_strength_reg_inj];
        
        % Coupling Strength in uninjured area
        coupling_strength_actual_uninj = struct2cell(protocoloLFP.uninjured(reg_actual).coherence_record(area_actual).coupling_strength);
        coupling_strength_reg_uninj = [coupling_strength_actual_uninj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_uninj_coupling_strength = [datos_actual_uninj_coupling_strength; coupling_strength_reg_uninj];
        
        % Delay in injured area
        delay_actual_inj = struct2cell(protocoloLFP.injured(reg_actual).coherence_record(area_actual).delay);
        delay_reg_inj = [delay_actual_inj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_inj_delay = [datos_actual_inj_delay; delay_reg_inj];
        
        % Delay in uninjured area
        delay_actual_uninj = struct2cell(protocoloLFP.uninjured(reg_actual).coherence_record(area_actual).delay);
        delay_reg_uninj = [delay_actual_uninj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_uninj_delay = [datos_actual_uninj_delay; delay_reg_uninj];
    end
    
    if size(datos_actual_inj_change_power,1) == 1
        if area_actual <= num_areas_spectral
            % Stadistics for Change power in injured area
            datos_actual_inj_change_power_mean = datos_actual_inj_change_power;
            datos_actual_inj_change_power_std = datos_actual_inj_change_power.*0;
            datos_actual_inj_change_power_total = reshape(datos_actual_inj_change_power,[],3,num_bands);
            %datos_actual_inj_change_power_quantil = [datos_actual_inj_change_power; datos_actual_inj_change_power; datos_actual_inj_change_power];
            %datos_actual_inj_change_power_quantil = reshape(datos_actual_inj_change_power_quantil,9,[])';
                        
            datos_actual_inj_fractal_power_mean = datos_actual_inj_fractal_power;
            datos_actual_inj_fractal_power_std = datos_actual_inj_fractal_power.*0;
            datos_actual_inj_fractal_power_total = reshape(datos_actual_inj_fractal_power,[],3);
        end
            
        % Coherence
        datos_actual_inj_sum_MSC_mean = datos_actual_inj_sum_MSC;
        datos_actual_inj_sum_MSC_std = datos_actual_inj_sum_MSC.*0;
        datos_actual_inj_sum_MSC_total = reshape(datos_actual_inj_sum_MSC,[],3,num_bands);
        %datos_actual_inj_sum_MSC_quantil = [datos_actual_inj_sum_MSC; datos_actual_inj_sum_MSC; datos_actual_inj_sum_MSC];
        %datos_actual_inj_sum_MSC_quantil = reshape(datos_actual_inj_sum_MSC_quantil,9,[])';
               
        datos_actual_inj_coupling_strength_mean = datos_actual_inj_coupling_strength;
        datos_actual_inj_coupling_strength_std = datos_actual_inj_coupling_strength.*0;
        datos_actual_inj_coupling_strength_total = reshape(datos_actual_inj_coupling_strength,[],3,num_bands);
        %datos_actual_inj_coupling_strength_quantil = [datos_actual_inj_coupling_strength; datos_actual_inj_coupling_strength; datos_actual_inj_coupling_strength];
        %datos_actual_inj_coupling_strength_quantil = reshape(datos_actual_inj_coupling_strength_quantil,9,[])';
               
        datos_actual_inj_delay_mean = datos_actual_inj_delay;
        datos_actual_inj_delay_std = datos_actual_inj_delay.*0;
        datos_actual_inj_delay_total = reshape(datos_actual_inj_delay,[],3,num_bands);
        %datos_actual_inj_delay_quantil = [datos_actual_inj_delay; datos_actual_inj_delay; datos_actual_inj_delay];
        %datos_actual_inj_delay_quantil = reshape(datos_actual_inj_delay_quantil,9,[])';
        
        if area_actual <= num_areas_spectral
            % Stadistics for Change power in uninjured area
            datos_actual_uninj_change_power_mean = datos_actual_uninj_change_power;
            datos_actual_uninj_change_power_std = datos_actual_uninj_change_power.*0;
            datos_actual_uninj_change_power_total = reshape(datos_actual_uninj_change_power,[],3,num_bands);
            %datos_actual_uninj_change_power_quantil = [datos_actual_uninj_change_power; datos_actual_uninj_change_power; datos_actual_uninj_change_power];
            %datos_actual_uninj_change_power_quantil = reshape(datos_actual_uninj_change_power_quantil,9,[])';
                        
            datos_actual_uninj_fractal_power_mean = datos_actual_uninj_fractal_power;
            datos_actual_uninj_fractal_power_std = datos_actual_uninj_fractal_power.*0;
            datos_actual_uninj_fractal_power_total = reshape(datos_actual_uninj_fractal_power,[],3);
        end
        
        % Coherence
        datos_actual_uninj_sum_MSC_mean = datos_actual_uninj_sum_MSC;
        datos_actual_uninj_sum_MSC_std = datos_actual_uninj_sum_MSC.*0;
        datos_actual_uninj_sum_MSC_total = reshape(datos_actual_uninj_sum_MSC,[],3,num_bands);
        %datos_actual_uninj_sum_MSC_quantil = [datos_actual_uninj_sum_MSC; datos_actual_uninj_sum_MSC; datos_actual_uninj_sum_MSC];
        %datos_actual_uninj_sum_MSC_quantil = reshape(datos_actual_uninj_sum_MSC_quantil,9,[])';
               
        datos_actual_uninj_coupling_strength_mean = datos_actual_uninj_coupling_strength;
        datos_actual_uninj_coupling_strength_std = datos_actual_uninj_coupling_strength.*0;
        datos_actual_uninj_coupling_strength_total = reshape(datos_actual_uninj_coupling_strength,[],3,num_bands);
        %datos_actual_uninj_coupling_strength_quantil = [datos_actual_uninj_coupling_strength; datos_actual_uninj_coupling_strength; datos_actual_uninj_coupling_strength];
        %datos_actual_uninj_coupling_strength_quantil = reshape(datos_actual_uninj_coupling_strength_quantil,9,[])';
               
        datos_actual_uninj_delay_mean = datos_actual_uninj_delay;
        datos_actual_uninj_delay_std = datos_actual_uninj_delay.*0;
        datos_actual_uninj_delay_total = reshape(datos_actual_uninj_delay,[],3,num_bands);
        %datos_actual_uninj_delay_quantil = [datos_actual_uninj_delay; datos_actual_uninj_delay; datos_actual_uninj_delay];
        %datos_actual_uninj_delay_quantil = reshape(datos_actual_uninj_delay_quantil,9,[])';
        
    else     
        if area_actual <= num_areas_spectral
            % Stadistics for Change power in injured area
            datos_actual_inj_change_power_mean = mean(datos_actual_inj_change_power);
            datos_actual_inj_change_power_std = std(datos_actual_inj_change_power);
            datos_actual_inj_change_power_total = reshape(datos_actual_inj_change_power,[],3,num_bands);
            %datos_actual_inj_change_power_quantil = quantile(datos_actual_inj_change_power, [.25 .50 .75]);
            %datos_actual_inj_change_power_quantil = reshape(datos_actual_inj_change_power_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
            
            datos_actual_inj_fractal_power_mean = mean(datos_actual_inj_fractal_power);
            datos_actual_inj_fractal_power_std = std(datos_actual_inj_fractal_power);
            datos_actual_inj_fractal_power_total = reshape(datos_actual_inj_fractal_power,[],3);
        end
        
        % Coherence
        datos_actual_inj_sum_MSC_mean = mean(datos_actual_inj_sum_MSC);
        datos_actual_inj_sum_MSC_std = std(datos_actual_inj_sum_MSC);
        datos_actual_inj_sum_MSC_total = reshape(datos_actual_inj_sum_MSC,[],3,num_bands);
        %datos_actual_inj_sum_MSC_quantil = quantile(datos_actual_inj_sum_MSC, [.25 .50 .75]);
        %datos_actual_inj_sum_MSC_quantil = reshape(datos_actual_inj_sum_MSC_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        datos_actual_inj_coupling_strength_mean = mean(datos_actual_inj_coupling_strength);
        datos_actual_inj_coupling_strength_std = std(datos_actual_inj_coupling_strength);
        datos_actual_inj_coupling_strength_total = reshape(datos_actual_inj_coupling_strength,[],3,num_bands);
        %datos_actual_inj_coupling_strength_quantil = quantile(datos_actual_inj_coupling_strength, [.25 .50 .75]);
        %datos_actual_inj_coupling_strength_quantil = reshape(datos_actual_inj_coupling_strength_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        datos_actual_inj_delay_mean = mean(datos_actual_inj_delay);
        datos_actual_inj_delay_std = std(datos_actual_inj_delay);
        datos_actual_inj_delay_total = reshape(datos_actual_inj_delay,[],3,num_bands);
        %datos_actual_inj_delay_quantil = quantile(datos_actual_inj_delay, [.25 .50 .75]);
        %datos_actual_inj_delay_quantil = reshape(datos_actual_inj_delay_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        if area_actual <= num_areas_spectral
            % Stadistics for Change power in uninjured area
            datos_actual_uninj_change_power_mean = mean(datos_actual_uninj_change_power);
            datos_actual_uninj_change_power_std = std(datos_actual_uninj_change_power);
            datos_actual_uninj_change_power_total = reshape(datos_actual_uninj_change_power,[],3,num_bands);
            %datos_actual_uninj_change_power_quantil = quantile(datos_actual_uninj_change_power, [.25 .50 .75]);
            %datos_actual_uninj_change_power_quantil = reshape(datos_actual_uninj_change_power_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
            
            datos_actual_uninj_fractal_power_mean = mean(datos_actual_uninj_fractal_power);
            datos_actual_uninj_fractal_power_std = std(datos_actual_uninj_fractal_power);
            datos_actual_uninj_fractal_power_total = reshape(datos_actual_uninj_fractal_power,[],3);
        end
        
        % Coherence
        datos_actual_uninj_sum_MSC_mean = mean(datos_actual_uninj_sum_MSC);
        datos_actual_uninj_sum_MSC_std = std(datos_actual_uninj_sum_MSC);
        datos_actual_uninj_sum_MSC_total = reshape(datos_actual_uninj_sum_MSC,[],3,num_bands);
        %datos_actual_uninj_sum_MSC_quantil = quantile(datos_actual_uninj_sum_MSC, [.25 .50 .75]);
        %datos_actual_uninj_sum_MSC_quantil = reshape(datos_actual_uninj_sum_MSC_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        datos_actual_uninj_coupling_strength_mean = mean(datos_actual_uninj_coupling_strength);
        datos_actual_uninj_coupling_strength_std = std(datos_actual_uninj_coupling_strength);
        datos_actual_uninj_coupling_strength_total = reshape(datos_actual_uninj_coupling_strength,[],3,num_bands);
        %datos_actual_uninj_coupling_strength_quantil = quantile(datos_actual_uninj_coupling_strength, [.25 .50 .75]);
        %datos_actual_uninj_coupling_strength_quantil = reshape(datos_actual_uninj_coupling_strength_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        datos_actual_uninj_delay_mean = mean(datos_actual_uninj_delay);
        datos_actual_uninj_delay_std = std(datos_actual_uninj_delay);
        datos_actual_uninj_delay_total = reshape(datos_actual_uninj_delay,[],3,num_bands);
        %datos_actual_uninj_delay_quantil = quantile(datos_actual_uninj_delay, [.25 .50 .75]);
        %datos_actual_uninj_delay_quantil = reshape(datos_actual_uninj_delay_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
    end
    
    if area_actual <= num_areas_spectral
        % Stadistics for Change power in injured area
        datos_actual_inj_change_power_mean = reshape(datos_actual_inj_change_power_mean,3,[])';    
        datos_actual_inj_change_power_std = reshape(datos_actual_inj_change_power_std,3,[])';
                
        datos_actual_inj_fractal_power_mean = reshape(datos_actual_inj_fractal_power_mean,3,[])';    
        datos_actual_inj_fractal_power_std = reshape(datos_actual_inj_fractal_power_std,3,[])';
    end
    
    % Coherence
    datos_actual_inj_sum_MSC_mean = reshape(datos_actual_inj_sum_MSC_mean,3,[])';    
    datos_actual_inj_sum_MSC_std = reshape(datos_actual_inj_sum_MSC_std,3,[])';
    
    datos_actual_inj_coupling_strength_mean = reshape(datos_actual_inj_coupling_strength_mean,3,[])';    
    datos_actual_inj_coupling_strength_std = reshape(datos_actual_inj_coupling_strength_std,3,[])';
    
    datos_actual_inj_delay_mean = reshape(datos_actual_inj_delay_mean,3,[])';    
    datos_actual_inj_delay_std = reshape(datos_actual_inj_delay_std,3,[])';    
    
    if area_actual <= num_areas_spectral
        % Stadistics for Change power in uninjured area
        datos_actual_uninj_change_power_mean = reshape(datos_actual_uninj_change_power_mean,3,[])';    
        datos_actual_uninj_change_power_std = reshape(datos_actual_uninj_change_power_std,3,[])';
                
        datos_actual_uninj_fractal_power_mean = reshape(datos_actual_uninj_fractal_power_mean,3,[])';    
        datos_actual_uninj_fractal_power_std = reshape(datos_actual_uninj_fractal_power_std,3,[])';
    end
    
    % Coherence
    datos_actual_uninj_sum_MSC_mean = reshape(datos_actual_uninj_sum_MSC_mean,3,[])';    
    datos_actual_uninj_sum_MSC_std = reshape(datos_actual_uninj_sum_MSC_std,3,[])';
    
    datos_actual_uninj_coupling_strength_mean = reshape(datos_actual_uninj_coupling_strength_mean,3,[])';    
    datos_actual_uninj_coupling_strength_std = reshape(datos_actual_uninj_coupling_strength_std,3,[])';
    
    datos_actual_uninj_delay_mean = reshape(datos_actual_uninj_delay_mean,3,[])';    
    datos_actual_uninj_delay_std = reshape(datos_actual_uninj_delay_std,3,[])';
    
    for band_actual = 1:num_bands
        if area_actual <= num_areas_spectral
            % Save data in global structure injured change power
            protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre = datos_actual_inj_change_power_total(:,1,band_actual); 
            protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre_mean = datos_actual_inj_change_power_mean(band_actual,1);
            protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre_std = datos_actual_inj_change_power_std(band_actual,1);
            protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on = datos_actual_inj_change_power_total(:,2,band_actual); 
            protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on_mean = datos_actual_inj_change_power_mean(band_actual,2);
            protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on_std = datos_actual_inj_change_power_std(band_actual,2);
            protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post = datos_actual_inj_change_power_total(:,3,band_actual); 
            protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post_mean = datos_actual_inj_change_power_mean(band_actual,3);
            protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post_std = datos_actual_inj_change_power_std(band_actual,3);
            
        end
        
        % Coherence
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre = datos_actual_inj_sum_MSC_total(:,1,band_actual);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre_mean = datos_actual_inj_sum_MSC_mean(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre_std = datos_actual_inj_sum_MSC_std(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on = datos_actual_inj_sum_MSC_total(:,2,band_actual); 
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on_mean = datos_actual_inj_sum_MSC_mean(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on_std = datos_actual_inj_sum_MSC_std(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post = datos_actual_inj_sum_MSC_total(:,3,band_actual); 
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post_mean = datos_actual_inj_sum_MSC_mean(band_actual,3);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post_std = datos_actual_inj_sum_MSC_std(band_actual,3);
        
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre = datos_actual_inj_coupling_strength_total(:,1,band_actual);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre_mean = datos_actual_inj_coupling_strength_mean(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre_std = datos_actual_inj_coupling_strength_std(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on = datos_actual_inj_coupling_strength_total(:,2,band_actual); 
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on_mean = datos_actual_inj_coupling_strength_mean(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on_std = datos_actual_inj_coupling_strength_std(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post = datos_actual_inj_coupling_strength_total(:,3,band_actual); 
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post_mean = datos_actual_inj_coupling_strength_mean(band_actual,3);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post_std = datos_actual_inj_coupling_strength_std(band_actual,3);
        
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre = datos_actual_inj_delay_total(:,1,band_actual);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre_mean = datos_actual_inj_delay_mean(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre_std = datos_actual_inj_delay_std(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on = datos_actual_inj_delay_total(:,2,band_actual); 
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on_mean = datos_actual_inj_delay_mean(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on_std = datos_actual_inj_delay_std(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post = datos_actual_inj_delay_total(:,3,band_actual); 
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post_mean = datos_actual_inj_delay_mean(band_actual,3);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post_std = datos_actual_inj_delay_std(band_actual,3);
        
        if area_actual <= num_areas_spectral
            % Save data in global structure uninjured change power
            protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre = datos_actual_uninj_change_power_total(:,1,band_actual);
            protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre_mean = datos_actual_uninj_change_power_mean(band_actual,1);
            protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre_std = datos_actual_uninj_change_power_std(band_actual,1);
            protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on = datos_actual_uninj_change_power_total(:,2,band_actual); 
            protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on_mean = datos_actual_uninj_change_power_mean(band_actual,2);
            protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on_std = datos_actual_uninj_change_power_std(band_actual,2);
            protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post = datos_actual_uninj_change_power_total(:,3,band_actual); 
            protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post_mean = datos_actual_uninj_change_power_mean(band_actual,3);
            protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post_std = datos_actual_uninj_change_power_std(band_actual,3);
        end
        
        % Coherence
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre = datos_actual_uninj_sum_MSC_total(:,1,band_actual);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre_mean = datos_actual_uninj_sum_MSC_mean(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre_std = datos_actual_uninj_sum_MSC_std(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on = datos_actual_uninj_sum_MSC_total(:,2,band_actual); 
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on_mean = datos_actual_uninj_sum_MSC_mean(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on_std = datos_actual_uninj_sum_MSC_std(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post = datos_actual_uninj_sum_MSC_total(:,3,band_actual); 
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post_mean = datos_actual_uninj_sum_MSC_mean(band_actual,3);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post_std = datos_actual_uninj_sum_MSC_std(band_actual,3);
        
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre = datos_actual_uninj_coupling_strength_total(:,1,band_actual);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre_mean = datos_actual_uninj_coupling_strength_mean(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre_std = datos_actual_uninj_coupling_strength_std(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on = datos_actual_uninj_coupling_strength_total(:,2,band_actual); 
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on_mean = datos_actual_uninj_coupling_strength_mean(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on_std = datos_actual_uninj_coupling_strength_std(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post = datos_actual_uninj_coupling_strength_total(:,3,band_actual); 
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post_mean = datos_actual_uninj_coupling_strength_mean(band_actual,3);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post_std = datos_actual_uninj_coupling_strength_std(band_actual,3);
        
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre = datos_actual_uninj_delay_total(:,1,band_actual);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre_mean = datos_actual_uninj_delay_mean(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre_std = datos_actual_uninj_delay_std(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on = datos_actual_uninj_delay_total(:,2,band_actual); 
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on_mean = datos_actual_uninj_delay_mean(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on_std = datos_actual_uninj_delay_std(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post = datos_actual_uninj_delay_total(:,3,band_actual); 
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post_mean = datos_actual_uninj_delay_mean(band_actual,3);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post_std = datos_actual_uninj_delay_std(band_actual,3);
    end
     
    if area_actual <= num_areas_spectral
        protocoloLFP.injured_global.spectral(area_actual).fractal_power.pre = datos_actual_inj_fractal_power_total(:,1); 
        protocoloLFP.injured_global.spectral(area_actual).fractal_power.pre_mean = datos_actual_inj_fractal_power_mean(1);
        protocoloLFP.injured_global.spectral(area_actual).fractal_power.pre_std = datos_actual_inj_fractal_power_std(1);
        protocoloLFP.injured_global.spectral(area_actual).fractal_power.on = datos_actual_inj_fractal_power_total(:,2); 
        protocoloLFP.injured_global.spectral(area_actual).fractal_power.on_mean = datos_actual_inj_fractal_power_mean(2);
        protocoloLFP.injured_global.spectral(area_actual).fractal_power.on_std = datos_actual_inj_fractal_power_std(2);
        protocoloLFP.injured_global.spectral(area_actual).fractal_power.post = datos_actual_inj_fractal_power_total(:,3); 
        protocoloLFP.injured_global.spectral(area_actual).fractal_power.post_mean = datos_actual_inj_fractal_power_mean(3);
        protocoloLFP.injured_global.spectral(area_actual).fractal_power.post_std = datos_actual_inj_fractal_power_std(3);

        protocoloLFP.uninjured_global.spectral(area_actual).fractal_power.pre = datos_actual_uninj_fractal_power_total(:,1);
        protocoloLFP.uninjured_global.spectral(area_actual).fractal_power.pre_mean = datos_actual_uninj_fractal_power_mean(1);
        protocoloLFP.uninjured_global.spectral(area_actual).fractal_power.pre_std = datos_actual_uninj_fractal_power_std(1);
        protocoloLFP.uninjured_global.spectral(area_actual).fractal_power.on = datos_actual_uninj_fractal_power_total(:,2); 
        protocoloLFP.uninjured_global.spectral(area_actual).fractal_power.on_mean = datos_actual_uninj_fractal_power_mean(2);
        protocoloLFP.uninjured_global.spectral(area_actual).fractal_power.on_std = datos_actual_uninj_fractal_power_std(2);
        protocoloLFP.uninjured_global.spectral(area_actual).fractal_power.post = datos_actual_uninj_fractal_power_total(:,3); 
        protocoloLFP.uninjured_global.spectral(area_actual).fractal_power.post_mean = datos_actual_uninj_fractal_power_mean(3);
        protocoloLFP.uninjured_global.spectral(area_actual).fractal_power.post_std = datos_actual_uninj_fractal_power_std(3); 
    end
    
end

% Grafica

if save_protocol
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

    for band_actual = 1:num_bands

        %Cargar datos
        % Spectral
        inj_change_band_power_total = [];
        inj_change_band_power_mean = [];
        inj_change_band_power_std = [];
        uninj_change_band_power_total = [];
        uninj_change_band_power_mean = [];
        uninj_change_band_power_std = [];
               
        inj_fractal_power_total = [];
        inj_fractal_power_mean = [];
        inj_fractal_power_std = [];
        uninj_fractal_power_total = [];
        uninj_fractal_power_mean = [];
        uninj_fractal_power_std = [];
        
        % Coherence
        inj_sum_MSC_total = [];
        inj_sum_MSC_mean = [];
        inj_sum_MSC_std = [];
        uninj_sum_MSC_total = [];
        uninj_sum_MSC_mean = [];
        uninj_sum_MSC_std = [];

        inj_coupling_strength_total = [];
        inj_coupling_strength_mean = [];
        inj_coupling_strength_std = [];
        uninj_coupling_strength_total = [];
        uninj_coupling_strength_mean = [];
        uninj_coupling_strength_std = [];

        inj_delay_total = [];
        inj_delay_mean = [];
        inj_delay_std = [];
        uninj_delay_total = [];
        uninj_delay_mean = [];
        uninj_delay_std = [];

        for area_actual = 1:max([num_areas_spectral, num_areas_coherence])

            if area_actual <= num_areas_spectral
                % Spectral
                inj_change_band_power_total = [inj_change_band_power_total, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post];
                inj_change_band_power_mean = [inj_change_band_power_mean; protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre_mean, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on_mean, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post_mean];
                inj_change_band_power_std = [inj_change_band_power_std; protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre_std, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on_std, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post_std];

                uninj_change_band_power_total = [uninj_change_band_power_total, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post];
                uninj_change_band_power_mean = [uninj_change_band_power_mean; protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre_mean, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on_mean, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post_mean];
                uninj_change_band_power_std = [uninj_change_band_power_std; protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre_std, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on_std, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post_std];
                               
                %inj_fractal_power_total = [inj_fractal_power_total, protocoloLFP.injured_global.spectral(area_actual).fractal_power(band_actual).pre, protocoloLFP.injured_global.spectral(area_actual).fractal_power(band_actual).on, protocoloLFP.injured_global.spectral(area_actual).fractal_power(band_actual).post];
                %inj_fractal_power_mean = [inj_fractal_power_mean; protocoloLFP.injured_global.spectral(area_actual).fractal_power(band_actual).pre_mean, protocoloLFP.injured_global.spectral(area_actual).fractal_power(band_actual).on_mean, protocoloLFP.injured_global.spectral(area_actual).fractal_power(band_actual).post_mean];
                %inj_fractal_power_std = [inj_fractal_power_std; protocoloLFP.injured_global.spectral(area_actual).fractal_power(band_actual).pre_std, protocoloLFP.injured_global.spectral(area_actual).fractal_power(band_actual).on_std, protocoloLFP.injured_global.spectral(area_actual).fractal_power(band_actual).post_std];

                %uninj_fractal_power_total = [uninj_fractal_power_total, protocoloLFP.uninjured_global.spectral(area_actual).fractal_power(band_actual).pre, protocoloLFP.uninjured_global.spectral(area_actual).fractal_power(band_actual).on, protocoloLFP.uninjured_global.spectral(area_actual).fractal_power(band_actual).post];
                %uninj_fractal_power_mean = [uninj_fractal_power_mean; protocoloLFP.uninjured_global.spectral(area_actual).fractal_power(band_actual).pre_mean, protocoloLFP.uninjured_global.spectral(area_actual).fractal_power(band_actual).on_mean, protocoloLFP.uninjured_global.spectral(area_actual).fractal_power(band_actual).post_mean];
                %uninj_fractal_power_std = [uninj_fractal_power_std; protocoloLFP.uninjured_global.spectral(area_actual).fractal_power(band_actual).pre_std, protocoloLFP.uninjured_global.spectral(area_actual).fractal_power(band_actual).on_std, protocoloLFP.uninjured_global.spectral(area_actual).fractal_power(band_actual).post_std];
            
            end
            
            % Coherence
            inj_sum_MSC_total = [inj_sum_MSC_total, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post];
            inj_sum_MSC_mean = [inj_sum_MSC_mean; protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre_mean, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on_mean, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post_mean];
            inj_sum_MSC_std = [inj_sum_MSC_std; protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre_std, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on_std, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post_std];

            uninj_sum_MSC_total = [uninj_sum_MSC_total, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post];
            uninj_sum_MSC_mean = [uninj_sum_MSC_mean; protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre_mean, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on_mean, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post_mean];
            uninj_sum_MSC_std = [uninj_sum_MSC_std; protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre_std, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on_std, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post_std];

            inj_coupling_strength_total = [inj_coupling_strength_total, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post];
            inj_coupling_strength_mean = [inj_coupling_strength_mean; protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre_mean, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on_mean, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post_mean];
            inj_coupling_strength_std = [inj_coupling_strength_std; protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre_std, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on_std, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post_std];

            uninj_coupling_strength_total = [uninj_coupling_strength_total, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post];
            uninj_coupling_strength_mean = [uninj_coupling_strength_mean; protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre_mean, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on_mean, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post_mean];
            uninj_coupling_strength_std = [uninj_coupling_strength_std; protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre_std, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on_std, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post_std];

            inj_delay_total = [inj_delay_total, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post];
            inj_delay_mean = [inj_delay_mean; protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre_mean, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on_mean, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post_mean];
            inj_delay_std = [inj_delay_std; protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre_std, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on_std, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post_std];

            uninj_delay_total = [uninj_delay_total, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post];
            uninj_delay_mean = [uninj_delay_mean; protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre_mean, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on_mean, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post_mean];
            uninj_delay_std = [uninj_delay_std; protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre_std, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on_std, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post_std];

        end

        
        banda_eval = protocoloLFP.injured_global.spectral(1).change_band_power(band_actual).range;
        banda_name = protocoloLFP.injured_global.spectral(1).change_band_power(band_actual).band;
        areas = {protocoloLFP.injured_global.spectral.area};

        % Graficar cambio en la potencia  % Graficar cambio en la potencia   
        y_etiqueta = 'Normalized oscillatory Signal Power';
        titulo = ['Oscillatory Signal Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-1)Power in (',int2str(band_actual),')',banda_name,' of injured area'];
        boxplot_custom(inj_change_band_power_total, areas, num_record, [0 1], y_etiqueta, titulo, name_figure_save); 

        y_etiqueta = 'Normalized oscillatory Signal Power';
        titulo = ['Oscillatory Signal Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-1)Power in (',int2str(band_actual),')',banda_name,' of uninjured area'];
        boxplot_custom(uninj_change_band_power_total, areas, num_record, [0 1], y_etiqueta, titulo, name_figure_save); 
        
        % Graficar cambio en la potencia   
        fig_13 = figure('units','normalized','outerposition',[0 0 1 1]);
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        pre = plot(x(:,1),inj_change_band_power_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
        hold on
        on = plot(x(:,2),inj_change_band_power_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
        hold on
        post = plot(x(:,3),inj_change_band_power_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        grid on
        ylim([0 1])
        xlim([xt(1)-0.5, xt(end)+0.5])
        ylabel('Normalized oscillatory Signal Power', 'FontSize', 24)
        set(gca,'fontsize',17)
        title(['Oscillatory Signal Power of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-2)Power in (',int2str(band_actual),')',banda_name,' of injured area'];
        saveas(fig_13,name_figure_save,'png');
        saveas(fig_13,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_13)   

        fig_14 = figure('units','normalized','outerposition',[0 0 1 1]);
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        pre = plot(x(:,1),uninj_change_band_power_total(:,1:3:end)','+','Color',azul,'MarkerSize',15,'LineWidth',3);
        hold on
        on = plot(x(:,2),uninj_change_band_power_total(:,2:3:end)','o','Color',rojo,'MarkerSize',10,'MarkerFaceColor',rojo,'LineWidth',1);
        hold on
        post = plot(x(:,3),uninj_change_band_power_total(:,3:3:end)','x','Color',verde,'MarkerSize',15,'LineWidth',3);
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        lgd = legend([pre(1) on(1) post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        grid on
        ylim([0 1])
        xlim([xt(1)-0.5, xt(end)+0.5])
        ylabel('Normalized oscillatory Signal Power', 'FontSize', 24)
        set(gca,'fontsize',17)
        title(['Oscillatory Signal Power of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-2)Power in (',int2str(band_actual),')',banda_name,' of uninjured area'];
        saveas(fig_14,name_figure_save,'png');
        saveas(fig_14,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_14)   
        
        banda_eval = protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).range;
        banda_name = protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).band;
        areas1 = {protocoloLFP.injured_global.coherence.area1};
        areas2 = {protocoloLFP.injured_global.coherence.area2};
        [vs{1:length(string(areas1))}] = deal('&');
        areas = join([string(areas1)',vs',string(areas2)'],'');

        y_max = max([max([(inj_sum_MSC_mean+inj_sum_MSC_std);(uninj_sum_MSC_mean+uninj_sum_MSC_std)])]);
        %y_min = min([min(inj_sum_MSC_mean) min(uninj_sum_MSC_mean)]);
        y_max = y_max + abs(y_max)*0.1;
        %y_min = y_min - abs(y_min)*0.1;
        y_etiqueta = 'Sum MSC';
        titulo = ['Sum Magnitude-Squared Coherence (MSC) of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2)Sum MSC in (',int2str(band_actual),')',banda_name,' of injured area'];
        boxplot_custom(inj_sum_MSC_total, areas', num_record, [0 y_max], y_etiqueta, titulo, name_figure_save); 
        
        y_etiqueta = 'Sum MSC';
        titulo = ['Sum Magnitude-Squared Coherence (MSC) of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2)Sum MSC in (',int2str(band_actual),')',banda_name,' of uninjured area'];
        boxplot_custom(uninj_sum_MSC_total, areas', num_record, [0 y_max], y_etiqueta, titulo, name_figure_save); 
        
        
        %y_max = max([max(inj_coupling_strength_mean) max(uninj_coupling_strength_mean)]);
        %y_min = min([min(inj_coupling_strength_mean) min(uninj_coupling_strength_mean)]);
        %y_max = y_max + abs(y_max)*0.1;
        %y_min = y_min - abs(y_min)*0.1;        
        y_etiqueta = 'Coupling Strength';
        titulo = ['Coupling Strength of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3-1)Coupling Strength in (',int2str(band_actual),')',banda_name,' of injured area'];
        boxplot_custom(inj_coupling_strength_total, areas', num_record, [0 0.6], y_etiqueta, titulo, name_figure_save); 
        
        y_etiqueta = 'Coupling Strength';
        titulo = ['Coupling Strength of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3-1)Coupling Strength in (',int2str(band_actual),')',banda_name,' of uninjured area'];
        boxplot_custom(uninj_coupling_strength_total, areas', num_record, [0 0.6], y_etiqueta, titulo, name_figure_save); 
        
        fig_33 = figure('units','normalized','outerposition',[0 0 1 1]);
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
        ylim([0 0.6])
        xlim([xt(1)-0.5, xt(end)+0.5])
        ylabel('Coupling Strength', 'FontSize', 24)
        set(gca,'fontsize',17)
        title(['Coupling Strength of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3-2)Coupling Strength in (',int2str(band_actual),')',banda_name,' of injured area'];
        saveas(fig_33,name_figure_save,'png');
        saveas(fig_33,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_33)

        fig_34 = figure('units','normalized','outerposition',[0 0 1 1]);
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
        ylim([0 0.6])
        xlim([xt(1)-0.5, xt(end)+0.5])
        ylabel('Coupling Strength', 'FontSize', 24)
        set(gca,'fontsize',17)
        title(['Coupling Strength of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3-2)Coupling Strength in (',int2str(band_actual),')',banda_name,' of uninjured area'];
        saveas(fig_34,name_figure_save,'png');
        saveas(fig_34,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_34)
        

        y_etiqueta = 'Delay [ms]';
        titulo = ['Delay of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(4)Delay in (',int2str(band_actual),')',banda_name,' of injured area'];
        boxplot_custom(inj_delay_total.*1000, areas', num_record, [0 200], y_etiqueta, titulo, name_figure_save); 

        y_etiqueta = 'Delay [ms]';
        titulo = ['Delay of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'];
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(4)Delay in (',int2str(band_actual),')',banda_name,' of uninjured area'];
        boxplot_custom(uninj_delay_total.*1000, areas', num_record, [0 200], y_etiqueta, titulo, name_figure_save); 
        
    end
    
    % Fractal
    % Graficar cambio en la potencia  % Graficar cambio en la potencia   
    y_etiqueta = 'Normalized fractal Signal Power';
    titulo = ['Fractal Signal Power of injured area'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-1)Fractal Power of injured area'];
    boxplot_custom(inj_fractal_power_total, areas, num_record, [0 1], y_etiqueta, titulo, name_figure_save); 

    y_etiqueta = 'Normalized fractal Signal Power';
    titulo = ['Fractal Signal Power of uninjured area'];
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-1)Fractal Power of uninjured area'];
    boxplot_custom(uninj_fractal_power_total, areas, num_record, [0 1], y_etiqueta, titulo, name_figure_save); 

    % Graficar cambio en la potencia   
    fig_43 = figure('units','normalized','outerposition',[0 0 1 1]);
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
    ylim([0 1])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Normalized fractal Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Fractal Signal Power of injured area'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-2)Fractal Power of injured area'];
    saveas(fig_43,name_figure_save,'png');
    saveas(fig_43,name_figure_save,'fig');
    %%waitforbuttonpress;
    close(fig_43)   

    fig_44 = figure('units','normalized','outerposition',[0 0 1 1]);
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
    ylim([0 1])
    xlim([xt(1)-0.5, xt(end)+0.5])
    ylabel('Normalized fractal Signal Power', 'FontSize', 24)
    set(gca,'fontsize',17)
    title(['Fractal Signal Power of uninjured area'], 'FontSize', 20, 'Interpreter', 'none')
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1-2)Fractal Power of uninjured area'];
    saveas(fig_44,name_figure_save,'png');
    saveas(fig_44,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_44)
            
end

end

    
