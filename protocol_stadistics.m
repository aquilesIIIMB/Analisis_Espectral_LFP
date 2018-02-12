function protocoloLFP = protocol_stadistics(protocoloLFP,path,save_protocol)

num_record = length(protocoloLFP.register_checked);
% Colocar las areas de coherencia, que son mas, ver si se estan
% guardando!!!
num_areas = length(protocoloLFP.injured_global(1).spectral);
num_bands = length(protocoloLFP.injured_global(1).spectral(1).change_band_power);

azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];


% Agregar coherencia

for area_actual = 1:num_areas
    datos_actual_inj_change_power = [];
    datos_actual_uninj_change_power = [];
    
    datos_actual_inj_sum_MSC= [];
    datos_actual_uninj_sum_MSC = [];
    
    datos_actual_inj_coupling_strength= [];
    datos_actual_uninj_coupling_strength = [];
    
    datos_actual_inj_delay = [];
    datos_actual_uninj_delay = [];
    
    for reg_actual = 1:num_record
        % Change power in injured area
        change_power_actual_inj = struct2cell(protocoloLFP.injured(reg_actual).spectral_record(area_actual).change_band_power);
        change_power_reg_inj = [change_power_actual_inj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_inj_change_power = [datos_actual_inj_change_power; change_power_reg_inj];
        
        % Change power in uninjured area
        change_power_actual_uninj = struct2cell(protocoloLFP.uninjured(reg_actual).spectral_record(area_actual).change_band_power);
        change_power_reg_uninj = [change_power_actual_uninj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_uninj_change_power = [datos_actual_uninj_change_power; change_power_reg_uninj];
        
        % Change power in injured area
        sum_MSC_actual_inj = struct2cell(protocoloLFP.injured(reg_actual).coherence_record(area_actual).sum_MSC);
        sum_MSC_reg_inj = [sum_MSC_actual_inj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_inj_sum_MSC = [datos_actual_inj_sum_MSC; sum_MSC_reg_inj];
        
        % Change power in uninjured area
        sum_MSC_actual_uninj = struct2cell(protocoloLFP.uninjured(reg_actual).coherence_record(area_actual).sum_MSC);
        sum_MSC_reg_uninj = [sum_MSC_actual_uninj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_uninj_sum_MSC = [datos_actual_uninj_sum_MSC; sum_MSC_reg_uninj];
        
        % Change power in injured area
        coupling_strength_actual_inj = struct2cell(protocoloLFP.injured(reg_actual).coherence_record(area_actual).coupling_strength);
        coupling_strength_reg_inj = [coupling_strength_actual_inj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_inj_coupling_strength = [datos_actual_inj_coupling_strength; coupling_strength_reg_inj];
        
        % Change power in uninjured area
        coupling_strength_actual_uninj = struct2cell(protocoloLFP.uninjured(reg_actual).coherence_record(area_actual).coupling_strength);
        coupling_strength_reg_uninj = [coupling_strength_actual_uninj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_uninj_coupling_strength = [datos_actual_uninj_coupling_strength; coupling_strength_reg_uninj];
        
        % Change power in injured area
        delay_actual_inj = struct2cell(protocoloLFP.injured(reg_actual).coherence_record(area_actual).delay);
        delay_reg_inj = [delay_actual_inj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_inj_delay = [datos_actual_inj_delay; delay_reg_inj];
        
        % Change power in uninjured area
        delay_actual_uninj = struct2cell(protocoloLFP.uninjured(reg_actual).coherence_record(area_actual).delay);
        delay_reg_uninj = [delay_actual_uninj{3:end,:,:}]; % Todos los valores de pre, on ,post, en cada banda evaluada
        datos_actual_uninj_delay = [datos_actual_uninj_delay; delay_reg_uninj];
    end
    
    if size(datos_actual_inj_change_power,1) == 1
        % Stadistics for Change power in injured area
        datos_actual_inj_change_power_mean = datos_actual_inj_change_power;
        datos_actual_inj_change_power_std = datos_actual_inj_change_power.*0;
        datos_actual_inj_change_power_quantil = [datos_actual_inj_change_power; datos_actual_inj_change_power; datos_actual_inj_change_power];
        datos_actual_inj_change_power_quantil = reshape(datos_actual_inj_change_power_quantil,9,[])';
                
        datos_actual_inj_sum_MSC_mean = datos_actual_inj_sum_MSC;
        datos_actual_inj_sum_MSC_std = datos_actual_inj_sum_MSC.*0;
        datos_actual_inj_sum_MSC_quantil = [datos_actual_inj_sum_MSC; datos_actual_inj_sum_MSC; datos_actual_inj_sum_MSC];
        datos_actual_inj_sum_MSC_quantil = reshape(datos_actual_inj_sum_MSC_quantil,9,[])';
               
        datos_actual_inj_coupling_strength_mean = datos_actual_inj_coupling_strength;
        datos_actual_inj_coupling_strength_std = datos_actual_inj_coupling_strength.*0;
        datos_actual_inj_coupling_strength_quantil = [datos_actual_inj_coupling_strength; datos_actual_inj_coupling_strength; datos_actual_inj_coupling_strength];
        datos_actual_inj_coupling_strength_quantil = reshape(datos_actual_inj_coupling_strength_quantil,9,[])';
               
        datos_actual_inj_delay_mean = datos_actual_inj_delay;
        datos_actual_inj_delay_std = datos_actual_inj_delay.*0;
        datos_actual_inj_delay_quantil = [datos_actual_inj_delay; datos_actual_inj_delay; datos_actual_inj_delay];
        datos_actual_inj_delay_quantil = reshape(datos_actual_inj_delay_quantil,9,[])';
        
        % Stadistics for Change power in uninjured area
        datos_actual_uninj_change_power_mean = datos_actual_uninj_change_power;
        datos_actual_uninj_change_power_std = datos_actual_uninj_change_power.*0;
        datos_actual_uninj_change_power_quantil = [datos_actual_uninj_change_power; datos_actual_uninj_change_power; datos_actual_uninj_change_power];
        datos_actual_uninj_change_power_quantil = reshape(datos_actual_uninj_change_power_quantil,9,[])';
        
        datos_actual_uninj_sum_MSC_mean = datos_actual_uninj_sum_MSC;
        datos_actual_uninj_sum_MSC_std = datos_actual_uninj_sum_MSC.*0;
        datos_actual_uninj_sum_MSC_quantil = [datos_actual_uninj_sum_MSC; datos_actual_uninj_sum_MSC; datos_actual_uninj_sum_MSC];
        datos_actual_uninj_sum_MSC_quantil = reshape(datos_actual_uninj_sum_MSC_quantil,9,[])';
               
        datos_actual_uninj_coupling_strength_mean = datos_actual_uninj_coupling_strength;
        datos_actual_uninj_coupling_strength_std = datos_actual_uninj_coupling_strength.*0;
        datos_actual_uninj_coupling_strength_quantil = [datos_actual_uninj_coupling_strength; datos_actual_uninj_coupling_strength; datos_actual_uninj_coupling_strength];
        datos_actual_uninj_coupling_strength_quantil = reshape(datos_actual_uninj_coupling_strength_quantil,9,[])';
               
        datos_actual_uninj_delay_mean = datos_actual_uninj_delay;
        datos_actual_uninj_delay_std = datos_actual_uninj_delay.*0;
        datos_actual_uninj_delay_quantil = [datos_actual_uninj_delay; datos_actual_uninj_delay; datos_actual_uninj_delay];
        datos_actual_uninj_delay_quantil = reshape(datos_actual_uninj_delay_quantil,9,[])';
        
    else        
        % Stadistics for Change power in injured area
        datos_actual_inj_change_power_mean = mean(datos_actual_inj_change_power);
        datos_actual_inj_change_power_std = std(datos_actual_inj_change_power);
        datos_actual_inj_change_power_quantil = quantile(datos_actual_inj_change_power, [.25 .50 .75]);
        datos_actual_inj_change_power_quantil = reshape(datos_actual_inj_change_power_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        datos_actual_inj_sum_MSC_mean = mean(datos_actual_inj_sum_MSC);
        datos_actual_inj_sum_MSC_std = std(datos_actual_inj_sum_MSC);
        datos_actual_inj_sum_MSC_quantil = quantile(datos_actual_inj_sum_MSC, [.25 .50 .75]);
        datos_actual_inj_sum_MSC_quantil = reshape(datos_actual_inj_sum_MSC_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        datos_actual_inj_coupling_strength_mean = mean(datos_actual_inj_coupling_strength);
        datos_actual_inj_coupling_strength_std = std(datos_actual_inj_coupling_strength);
        datos_actual_inj_coupling_strength_quantil = quantile(datos_actual_inj_coupling_strength, [.25 .50 .75]);
        datos_actual_inj_coupling_strength_quantil = reshape(datos_actual_inj_coupling_strength_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        datos_actual_inj_delay_mean = mean(datos_actual_inj_delay);
        datos_actual_inj_delay_std = std(datos_actual_inj_delay);
        datos_actual_inj_delay_quantil = quantile(datos_actual_inj_delay, [.25 .50 .75]);
        datos_actual_inj_delay_quantil = reshape(datos_actual_inj_delay_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        % Stadistics for Change power in uninjured area
        datos_actual_uninj_change_power_mean = mean(datos_actual_uninj_change_power);
        datos_actual_uninj_change_power_std = std(datos_actual_uninj_change_power);   
        datos_actual_uninj_change_power_quantil = quantile(datos_actual_uninj_change_power, [.25 .50 .75]);
        datos_actual_uninj_change_power_quantil = reshape(datos_actual_uninj_change_power_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        
        datos_actual_uninj_sum_MSC_mean = mean(datos_actual_uninj_sum_MSC);
        datos_actual_uninj_sum_MSC_std = std(datos_actual_uninj_sum_MSC);
        datos_actual_uninj_sum_MSC_quantil = quantile(datos_actual_uninj_sum_MSC, [.25 .50 .75]);
        datos_actual_uninj_sum_MSC_quantil = reshape(datos_actual_uninj_sum_MSC_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        datos_actual_uninj_coupling_strength_mean = mean(datos_actual_uninj_coupling_strength);
        datos_actual_uninj_coupling_strength_std = std(datos_actual_uninj_coupling_strength);
        datos_actual_uninj_coupling_strength_quantil = quantile(datos_actual_uninj_coupling_strength, [.25 .50 .75]);
        datos_actual_uninj_coupling_strength_quantil = reshape(datos_actual_uninj_coupling_strength_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
        
        datos_actual_uninj_delay_mean = mean(datos_actual_uninj_delay);
        datos_actual_uninj_delay_std = std(datos_actual_uninj_delay);
        datos_actual_uninj_delay_quantil = quantile(datos_actual_uninj_delay, [.25 .50 .75]);
        datos_actual_uninj_delay_quantil = reshape(datos_actual_uninj_delay_quantil,9,[])'; % 9 porque son 3 de los 3 cuantiles
    end
    
    % Stadistics for Change power in injured area
    datos_actual_inj_change_power_mean = reshape(datos_actual_inj_change_power_mean,3,[])';    
    datos_actual_inj_change_power_std = reshape(datos_actual_inj_change_power_std,3,[])';
    
    datos_actual_inj_sum_MSC_mean = reshape(datos_actual_inj_sum_MSC_mean,3,[])';    
    datos_actual_inj_sum_MSC_std = reshape(datos_actual_inj_sum_MSC_std,3,[])';
    
    datos_actual_inj_coupling_strength_mean = reshape(datos_actual_inj_coupling_strength_mean,3,[])';    
    datos_actual_inj_coupling_strength_std = reshape(datos_actual_inj_coupling_strength_std,3,[])';
    
    datos_actual_inj_delay_mean = reshape(datos_actual_inj_delay_mean,3,[])';    
    datos_actual_inj_delay_std = reshape(datos_actual_inj_delay_std,3,[])';    
    
    % Stadistics for Change power in uninjured area
    datos_actual_uninj_change_power_mean = reshape(datos_actual_uninj_change_power_mean,3,[])';    
    datos_actual_uninj_change_power_std = reshape(datos_actual_uninj_change_power_std,3,[])';
    
    datos_actual_uninj_sum_MSC_mean = reshape(datos_actual_uninj_sum_MSC_mean,3,[])';    
    datos_actual_uninj_sum_MSC_std = reshape(datos_actual_uninj_sum_MSC_std,3,[])';
    
    datos_actual_uninj_coupling_strength_mean = reshape(datos_actual_uninj_coupling_strength_mean,3,[])';    
    datos_actual_uninj_coupling_strength_std = reshape(datos_actual_uninj_coupling_strength_std,3,[])';
    
    datos_actual_uninj_delay_mean = reshape(datos_actual_uninj_delay_mean,3,[])';    
    datos_actual_uninj_delay_std = reshape(datos_actual_uninj_delay_std,3,[])';
    
    for band_actual = 1:num_bands
        
        % Save data in global structure injured change power
        protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre = datos_actual_inj_change_power_quantil(band_actual,1:3); % porque son 3 cuantiles
        protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre_mean = datos_actual_inj_change_power_mean(band_actual,1);
        protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre_std = datos_actual_inj_change_power_std(band_actual,1);
        protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on = datos_actual_inj_change_power_quantil(band_actual,4:6);
        protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on_mean = datos_actual_inj_change_power_mean(band_actual,2);
        protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on_std = datos_actual_inj_change_power_std(band_actual,2);
        protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post = datos_actual_inj_change_power_quantil(band_actual,7:9);
        protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post_mean = datos_actual_inj_change_power_mean(band_actual,3);
        protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post_std = datos_actual_inj_change_power_std(band_actual,3);
        
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre = datos_actual_inj_sum_MSC_quantil(band_actual,1:3); % porque son 3 cuantiles
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre_mean = datos_actual_inj_sum_MSC_mean(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre_std = datos_actual_inj_sum_MSC_std(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on = datos_actual_inj_sum_MSC_quantil(band_actual,4:6);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on_mean = datos_actual_inj_sum_MSC_mean(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on_std = datos_actual_inj_sum_MSC_std(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post = datos_actual_inj_sum_MSC_quantil(band_actual,7:9);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post_mean = datos_actual_inj_sum_MSC_mean(band_actual,3);
        protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post_std = datos_actual_inj_sum_MSC_std(band_actual,3);
        
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre = datos_actual_inj_coupling_strength_quantil(band_actual,1:3); % porque son 3 cuantiles
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre_mean = datos_actual_inj_coupling_strength_mean(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre_std = datos_actual_inj_coupling_strength_std(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on = datos_actual_inj_coupling_strength_quantil(band_actual,4:6);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on_mean = datos_actual_inj_coupling_strength_mean(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on_std = datos_actual_inj_coupling_strength_std(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post = datos_actual_inj_coupling_strength_quantil(band_actual,7:9);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post_mean = datos_actual_inj_coupling_strength_mean(band_actual,3);
        protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post_std = datos_actual_inj_coupling_strength_std(band_actual,3);
        
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre = datos_actual_inj_delay_quantil(band_actual,1:3); % porque son 3 cuantiles
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre_mean = datos_actual_inj_delay_mean(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre_std = datos_actual_inj_delay_std(band_actual,1);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on = datos_actual_inj_delay_quantil(band_actual,4:6);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on_mean = datos_actual_inj_delay_mean(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on_std = datos_actual_inj_delay_std(band_actual,2);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post = datos_actual_inj_delay_quantil(band_actual,7:9);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post_mean = datos_actual_inj_delay_mean(band_actual,3);
        protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post_std = datos_actual_inj_delay_std(band_actual,3);
        
        % Save data in global structure uninjured change power
        protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre = datos_actual_uninj_change_power_quantil(band_actual,1:3); % porque son 3 cuantiles
        protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre_mean = datos_actual_uninj_change_power_mean(band_actual,1);
        protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre_std = datos_actual_uninj_change_power_std(band_actual,1);
        protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on = datos_actual_uninj_change_power_quantil(band_actual,4:6);
        protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on_mean = datos_actual_uninj_change_power_mean(band_actual,2);
        protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on_std = datos_actual_uninj_change_power_std(band_actual,2);
        protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post = datos_actual_uninj_change_power_quantil(band_actual,7:9);
        protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post_mean = datos_actual_uninj_change_power_mean(band_actual,3);
        protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post_std = datos_actual_uninj_change_power_std(band_actual,3);
        
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre = datos_actual_uninj_sum_MSC_quantil(band_actual,1:3); % porque son 3 cuantiles
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre_mean = datos_actual_uninj_sum_MSC_mean(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre_std = datos_actual_uninj_sum_MSC_std(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on = datos_actual_uninj_sum_MSC_quantil(band_actual,4:6);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on_mean = datos_actual_uninj_sum_MSC_mean(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on_std = datos_actual_uninj_sum_MSC_std(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post = datos_actual_uninj_sum_MSC_quantil(band_actual,7:9);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post_mean = datos_actual_uninj_sum_MSC_mean(band_actual,3);
        protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post_std = datos_actual_uninj_sum_MSC_std(band_actual,3);
        
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre = datos_actual_uninj_coupling_strength_quantil(band_actual,1:3); % porque son 3 cuantiles
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre_mean = datos_actual_uninj_coupling_strength_mean(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre_std = datos_actual_uninj_coupling_strength_std(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on = datos_actual_uninj_coupling_strength_quantil(band_actual,4:6);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on_mean = datos_actual_uninj_coupling_strength_mean(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on_std = datos_actual_uninj_coupling_strength_std(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post = datos_actual_uninj_coupling_strength_quantil(band_actual,7:9);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post_mean = datos_actual_uninj_coupling_strength_mean(band_actual,3);
        protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post_std = datos_actual_uninj_coupling_strength_std(band_actual,3);
        
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre = datos_actual_uninj_delay_quantil(band_actual,1:3); % porque son 3 cuantiles
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre_mean = datos_actual_uninj_delay_mean(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre_std = datos_actual_uninj_delay_std(band_actual,1);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on = datos_actual_uninj_delay_quantil(band_actual,4:6);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on_mean = datos_actual_uninj_delay_mean(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on_std = datos_actual_uninj_delay_std(band_actual,2);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post = datos_actual_uninj_delay_quantil(band_actual,7:9);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post_mean = datos_actual_uninj_delay_mean(band_actual,3);
        protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post_std = datos_actual_uninj_delay_std(band_actual,3);
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
        inj_change_band_power_mean = [];
        inj_change_band_power_std = [];
        uninj_change_band_power_mean = [];
        uninj_change_band_power_std = [];

        inj_sum_MSC_mean = [];
        inj_sum_MSC_std = [];
        uninj_sum_MSC_mean = [];
        uninj_sum_MSC_std = [];

        inj_coupling_strength_mean = [];
        inj_coupling_strength_std = [];
        uninj_coupling_strength_mean = [];
        uninj_coupling_strength_std = [];

        inj_delay_mean = [];
        inj_delay_std = [];
        uninj_delay_mean = [];
        uninj_delay_std = [];

        for area_actual = 1:num_areas

            inj_change_band_power_mean = [inj_change_band_power_mean; protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre_mean, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on_mean, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post_mean];
            inj_change_band_power_std = [inj_change_band_power_std; protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).pre_std, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).on_std, protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).post_std];

            uninj_change_band_power_mean = [uninj_change_band_power_mean; protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre_mean, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on_mean, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post_mean];
            uninj_change_band_power_std = [uninj_change_band_power_std; protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).pre_std, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).on_std, protocoloLFP.uninjured_global.spectral(area_actual).change_band_power(band_actual).post_std];

            inj_sum_MSC_mean = [inj_sum_MSC_mean; protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre_mean, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on_mean, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post_mean];
            inj_sum_MSC_std = [inj_sum_MSC_std; protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).pre_std, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).on_std, protocoloLFP.injured_global.coherence(area_actual).sum_MSC(band_actual).post_std];

            uninj_sum_MSC_mean = [uninj_sum_MSC_mean; protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre_mean, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on_mean, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post_mean];
            uninj_sum_MSC_std = [uninj_sum_MSC_std; protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).pre_std, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).on_std, protocoloLFP.uninjured_global.coherence(area_actual).sum_MSC(band_actual).post_std];

            inj_coupling_strength_mean = [inj_coupling_strength_mean; protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre_mean, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on_mean, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post_mean];
            inj_coupling_strength_std = [inj_coupling_strength_std; protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).pre_std, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).on_std, protocoloLFP.injured_global.coherence(area_actual).coupling_strength(band_actual).post_std];

            uninj_coupling_strength_mean = [uninj_coupling_strength_mean; protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre_mean, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on_mean, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post_mean];
            uninj_coupling_strength_std = [uninj_coupling_strength_std; protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).pre_std, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).on_std, protocoloLFP.uninjured_global.coherence(area_actual).coupling_strength(band_actual).post_std];

            inj_delay_mean = [inj_delay_mean; protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre_mean, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on_mean, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post_mean];
            inj_delay_std = [inj_delay_std; protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).pre_std, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).on_std, protocoloLFP.injured_global.coherence(area_actual).delay(band_actual).post_std];

            uninj_delay_mean = [uninj_delay_mean; protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre_mean, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on_mean, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post_mean];
            uninj_delay_std = [uninj_delay_std; protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).pre_std, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).on_std, protocoloLFP.uninjured_global.coherence(area_actual).delay(band_actual).post_std];

        end

        banda_eval = protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).range;
        banda_name = protocoloLFP.injured_global.spectral(area_actual).change_band_power(band_actual).band;
        areas = {protocoloLFP.injured_global.spectral.area};

        % Graficar cambio en la potencia    
        y_max = max([max([(inj_change_band_power_mean+inj_change_band_power_std);(uninj_change_band_power_mean+uninj_change_band_power_std)])]);
        y_min = min([min([(inj_change_band_power_mean-inj_change_band_power_std);(uninj_change_band_power_mean-uninj_change_band_power_std)])]);
        y_max = y_max + abs(y_max)*0.1;
        y_min = y_min - abs(y_min)*0.1;
        fig_11 = figure('units','normalized','outerposition',[0 0 1 1]);
        %subplot(2,1,1)
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        bar_inj = bar(inj_change_band_power_mean,'grouped');
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        hold on
        errorbar(x,inj_change_band_power_mean,inj_change_band_power_std,'k*','LineWidth',1.0,'MarkerSize',2,'CapSize',20)
        lgd = legend([bar_inj(1) bar_inj(2) bar_inj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        bar_inj(1).FaceColor = azul; bar_inj(2).FaceColor = rojo; bar_inj(3).FaceColor = verde;
        grid on
        ylim([-50 200])
        ylabel('Signal/Pink noise Power Rate', 'FontSize', 24)
        set(gca,'fontsize',20)
        title(['Signal/Pink noise Power Rate of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1)Change in Power in ',banda_name,' of injured area'];
        saveas(fig_11,name_figure_save,'png');
        saveas(fig_11,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_11)   

        fig_12 = figure('units','normalized','outerposition',[0 0 1 1]);
        %subplot(2,1,2)
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        bar_uninj = bar(uninj_change_band_power_mean,'grouped');
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        hold on
        errorbar(x,uninj_change_band_power_mean,uninj_change_band_power_std,'k*','LineWidth',1.0,'MarkerSize',2,'CapSize',20)
        lgd = legend([bar_uninj(1) bar_uninj(2) bar_uninj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        bar_uninj(1).FaceColor = azul; bar_uninj(2).FaceColor = rojo; bar_uninj(3).FaceColor = verde;
        grid on
        ylim([-50 200])
        ylabel('Signal/Pink noise Power Rate', 'FontSize', 24)
        set(gca,'fontsize',20)
        title(['Signal/Pink noise Power Rate of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(1)Change in Power in ',banda_name,' of uninjured area'];
        saveas(fig_12,name_figure_save,'png');
        saveas(fig_12,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_12)   
        
        [vs{1:length(string(areas1))}] = deal('-');
        areas = join([string(areas1)',vs',string(areas2)'],'');

        y_max = max([max([(inj_sum_MSC_mean+inj_sum_MSC_std);(uninj_sum_MSC_mean+inj_sum_MSC_std)])]);
        %y_min = min([min(inj_sum_MSC_mean) min(uninj_sum_MSC_mean)]);
        y_max = y_max + abs(y_max)*0.1;
        %y_min = y_min - abs(y_min)*0.1;
        fig_21 = figure('units','normalized','outerposition',[0 0 1 1]);
        %subplot(2,1,1)
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        bar_inj = bar(inj_sum_MSC_mean,'grouped');
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        hold on
        errorbar(x,inj_sum_MSC_mean,inj_sum_MSC_std.*0,inj_sum_MSC_std,'k*','LineWidth',1.0,'MarkerSize',2,'CapSize',20)
        lgd = legend([bar_inj(1) bar_inj(2) bar_inj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        bar_inj(1).FaceColor = azul; bar_inj(2).FaceColor = rojo; bar_inj(3).FaceColor = verde;
        grid on
        ylim([0 y_max])
        ylabel('Sum MSC', 'FontSize', 24)
        set(gca,'fontsize',20)
        title(['Sum Magnitude-Squared Coherence (MSC) of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2)Sum MSC in ',banda_name,' of injured area'];
        saveas(fig_21,name_figure_save,'png');
        saveas(fig_21,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_21)  

        fig_22 = figure('units','normalized','outerposition',[0 0 1 1]);
        %subplot(2,1,2)
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        bar_uninj = bar(uninj_sum_MSC_mean,'grouped');
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        hold on
        errorbar(x,uninj_sum_MSC_mean,uninj_sum_MSC_std.*0,uninj_sum_MSC_std,'k*','LineWidth',1.0,'MarkerSize',2,'CapSize',20)
        lgd = legend([bar_uninj(1) bar_uninj(2) bar_uninj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        bar_uninj(1).FaceColor = azul; bar_uninj(2).FaceColor = rojo; bar_uninj(3).FaceColor = verde;
        grid on
        ylim([0 y_max])
        ylabel('Sum MSC', 'FontSize', 24)
        set(gca,'fontsize',20)
        title(['Sum Magnitude-Squared Coherence (MSC) of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(2)Sum MSC in ',banda_name,' of uninjured area'];
        saveas(fig_22,name_figure_save,'png');
        saveas(fig_22,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_22)

        %y_max = max([max(inj_coupling_strength_mean) max(uninj_coupling_strength_mean)]);
        %y_min = min([min(inj_coupling_strength_mean) min(uninj_coupling_strength_mean)]);
        %y_max = y_max + abs(y_max)*0.1;
        %y_min = y_min - abs(y_min)*0.1;
        fig_31 = figure('units','normalized','outerposition',[0 0 1 1]);
        %subplot(2,1,1)
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        bar_inj = bar(inj_coupling_strength_mean,'grouped');
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        hold on
        errorbar(x,inj_coupling_strength_mean,inj_coupling_strength_std.*0,inj_coupling_strength_std,'k*','LineWidth',1.0,'MarkerSize',2,'CapSize',20)
        lgd = legend([bar_inj(1) bar_inj(2) bar_inj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        bar_inj(1).FaceColor = azul; bar_inj(2).FaceColor = rojo; bar_inj(3).FaceColor = verde;
        grid on
        ylim([0 0.6])
        ylabel('Coupling Strength', 'FontSize', 24)
        set(gca,'fontsize',20)
        title(['Coupling Strength of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3)Coupling Strength in ',banda_name,' of injured area'];
        saveas(fig_31,name_figure_save,'png');
        saveas(fig_31,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_31)

        fig_32 = figure('units','normalized','outerposition',[0 0 1 1]);
        %subplot(2,1,2)
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        bar_uninj = bar(uninj_coupling_strength_mean,'grouped');
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        hold on
        errorbar(x,uninj_coupling_strength_mean,uninj_coupling_strength_std.*0,uninj_coupling_strength_std,'k*','LineWidth',1.0,'MarkerSize',2,'CapSize',20)
        lgd = legend([bar_uninj(1) bar_uninj(2) bar_uninj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        bar_uninj(1).FaceColor = azul; bar_uninj(2).FaceColor = rojo; bar_uninj(3).FaceColor = verde;
        grid on
        ylim([0 0.6])
        ylabel('Coupling Strength', 'FontSize', 24)
        set(gca,'fontsize',20)
        title(['Coupling Strength of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(3)Coupling Strength in ',banda_name,' of uninjured area'];
        saveas(fig_32,name_figure_save,'png');
        saveas(fig_32,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_32)

        fig_41 = figure('units','normalized','outerposition',[0 0 1 1]);
        %subplot(2,1,1)
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        bar_inj = bar(inj_delay_mean.*1000,'grouped');
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        hold on
        errorbar(x,inj_delay_mean.*1000,inj_delay_std.*0,inj_delay_std.*1000,'k*','LineWidth',1.0,'MarkerSize',2,'CapSize',20)
        lgd = legend([bar_inj(1) bar_inj(2) bar_inj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        bar_inj(1).FaceColor = azul; bar_inj(2).FaceColor = rojo; bar_inj(3).FaceColor = verde;
        grid on
        ylim([0 120])
        ylabel('Delay [ms]', 'FontSize', 24)
        set(gca,'fontsize',20)
        title(['Delay of injured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        %subplot(2,1,2)
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(4)Delay in ',banda_name,' of injured area'];
        saveas(fig_41,name_figure_save,'png');
        saveas(fig_41,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_41)

        fig_42 = figure('units','normalized','outerposition',[0 0 1 1]);
        xt = 1:length(areas);
        x = [xt-0.225;xt;xt+0.225]';
        bar_uninj = bar(uninj_delay_mean.*1000,'grouped');
        %xt = get(gca, 'XTick');
        set(gca, 'XTick', xt, 'XTickLabel', areas)
        hold on
        errorbar(x,uninj_delay_mean.*1000,uninj_delay_std.*0,uninj_delay_std.*1000,'k*','LineWidth',1.0,'MarkerSize',2,'CapSize',20)
        lgd = legend([bar_uninj(1) bar_uninj(2) bar_uninj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
        lgd.FontSize = 20;
        bar_uninj(1).FaceColor = azul; bar_uninj(2).FaceColor = rojo; bar_uninj(3).FaceColor = verde;
        grid on
        ylim([0 120])
        ylabel('Delay [ms]', 'FontSize', 24)
        set(gca,'fontsize',20)
        title(['Delay of uninjured area in ',banda_name,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
        % Guardar imagen de la figura
        name_figure_save = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'(4)Delay in ',banda_name,' of uninjured area'];
        saveas(fig_42,name_figure_save,'png');
        saveas(fig_42,name_figure_save,'fig');
        %waitforbuttonpress;
        close(fig_42)

    end
    
end

end

    
