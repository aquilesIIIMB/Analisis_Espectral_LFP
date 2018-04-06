% Calcular metrica del protocolo
%% Calcular datos del protoclo
% Eliminacion de variables que no se utilizaran
clearvars -except registroLFP path name_registro foldername inicio_foldername protocoloLFP

% Main 
% Definir que area es la lesionada segun potencia en beta del PSD
power_measurements(registroLFP, [8, 30], true);

area_lesionada = input('Cual es el area lesionada en este registro?[L o R]:  ','s'); %'R' o 'L'
ind_slash = find(foldername=='\' | foldername=='/');
protocolo_name = foldername(ind_slash(1)+1:ind_slash(2)-1);

if strcmp(area_lesionada,'R')
    area_nolesionada = 'L';
elseif strcmp(area_lesionada,'L')
    area_nolesionada = 'R';
else
    error('Definir bien el area lesionada')
end

close all

[C,ia,ic] = unique({registroLFP.area.name},'stable');

idx_areas_injured = [];
idx_areas_uninjured = [];

for k = 1:length(C)
    area_actual = C{k};
    hemisferio = area_actual(end);
    if strcmp(hemisferio,area_lesionada)
        idx_areas_injured = [idx_areas_injured, k];
    elseif strcmp(hemisferio,area_nolesionada)
        idx_areas_uninjured = [idx_areas_uninjured, k];
    end
end

% Estructura de las medidas espectrales
if ~exist('protocoloLFP','var')

    disp('Inicializando la estructura del protocolo')
    % Estructura
    protocoloLFP.name = protocolo_name;
    protocoloLFP.register_checked.name = [];
    protocoloLFP.injured.spectral_record.area = [];
    protocoloLFP.uninjured.spectral_record.area = [];

    for m = 1:length(C)
        
        % Area
        area = C{m};

        % Almacenar los datos
        if strcmp(area(end),area_lesionada)
            if isempty([protocoloLFP.injured.spectral_record.area])
                idx_injured = 0;
            else
                idx_injured = length(protocoloLFP.injured.spectral_record);
            end
            
            protocoloLFP.injured.spectral_record(idx_injured+1).area = area(1:end-1);
            
            protocoloLFP.injured(persona).spectral_record(idx_injured+1).change_band_power(tipo_de_banda).band = [];
            
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.theta.pre = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.theta.on = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.theta.post = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.alpha.pre = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.alpha.on = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.alpha.post = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_low.pre = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_low.on = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_low.post = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_high.pre = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_high.on = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_high.post = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta.pre = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta.on = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta.post = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_parkinson.pre = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_parkinson.on = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_parkinson.post = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_low.pre = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_low.on = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_low.post = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_high.pre = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_high.on = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_high.post = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma.pre = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma.on = [];
            protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma.post = [];
            
            % Resumen protocolo
            
            protocoloLFP.injured.spectral(idx_injured+1).area = area(1:end-1);
            
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.theta.pre = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.theta.on = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.theta.post = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.alpha.pre = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.alpha.on = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.alpha.post = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta_low.pre = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta_low.on = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta_low.post = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta_high.pre = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta_high.on = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta_high.post = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta.pre = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta.on = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta.post = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta_parkinson.pre = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta_parkinson.on = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.beta_parkinson.post = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.gamma_low.pre = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.gamma_low.on = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.gamma_low.post = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.gamma_high.pre = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.gamma_high.on = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.gamma_high.post = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.gamma.pre = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.gamma.on = [];
            protocoloLFP.injured.spectral(idx_injured+1).change_band_power.gamma.post = [];

        elseif strcmp(area(end),area_nolesionada)
            if isempty([protocoloLFP.uninjured.spectral_record.area])
                idx_uninjured = 0;
            else
                idx_uninjured = length(protocoloLFP.uninjured.spectral_record);
            end
            
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).area = area(1:end-1);
            
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.theta.pre = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.theta.on = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.theta.post = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.alpha.pre = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.alpha.on = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.alpha.post = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_low.pre = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_low.on = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_low.post = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_high.pre = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_high.on = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_high.post = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta.pre = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta.on = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta.post = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_parkinson.pre = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_parkinson.on = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_parkinson.post = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_low.pre = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_low.on = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_low.post = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_high.pre = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_high.on = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_high.post = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma.pre = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma.on = [];
            protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma.post = [];
            
            % Resumen protocolo
            
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.theta.pre = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.theta.on = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.theta.post = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.alpha.pre = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.alpha.on = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.alpha.post = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta_low.pre = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta_low.on = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta_low.post = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta_high.pre = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta_high.on = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta_high.post = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta.pre = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta.on = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta.post = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta_parkinson.pre = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta_parkinson.on = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.beta_parkinson.post = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.gamma_low.pre = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.gamma_low.on = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.gamma_low.post = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.gamma_high.pre = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.gamma_high.on = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.gamma_high.post = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.gamma.pre = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.gamma.on = [];
            protocoloLFP.uninjured.spectral(idx_uninjured+1).change_band_power.gamma.post = [];
            
        else
            disp('Esta area no es lesionada ni no lesionada')

        end

    end
    
end

idx_coherence_injured = combntns(idx_areas_injured,2);
idx_coherence_uninjured = combntns(idx_areas_uninjured,2);

% Estructura de las medidas de coherencia
for p = 1:size(idx_coherence_injured,1)

    area_actual_1 = char(registroLFP.average_sync{idx_coherence_injured(p,1),idx_coherence_injured(p,2)}.names(1));
    area_actual_2 = char(registroLFP.average_sync{idx_coherence_injured(p,1),idx_coherence_injured(p,2)}.names(2));
    protocoloLFP.injured.coherence_record(p).area1 = area_actual_1(1:end-1);
    protocoloLFP.injured.coherence_record(p).area2 = area_actual_2(1:end-1);

    protocoloLFP.injured.coherence_record(p).sum_MSC.theta.pre = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.theta.on = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.theta.post = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.alpha.pre = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.alpha.on = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.alpha.post = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta_low.pre = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta_low.on = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta_low.post = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta_high.pre = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta_high.on = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta_high.post = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta.pre = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta.on = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta.post = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta_parkinson.pre = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta_parkinson.on = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.beta_parkinson.post = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_low.pre = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_low.on = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_low.post = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_high.pre = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_high.on = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_high.post = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.gamma.pre = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.gamma.on = [];
    protocoloLFP.injured.coherence_record(p).sum_MSC.gamma.post = [];

    protocoloLFP.injured.coherence_record(p).coupling_strength.theta.pre = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.theta.on = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.theta.post = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.alpha.pre = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.alpha.on = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.alpha.post = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta_low.pre = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta_low.on = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta_low.post = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta_high.pre = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta_high.on = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta_high.post = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta.pre = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta.on = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta.post = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta_parkinson.pre = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta_parkinson.on = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.beta_parkinson.post = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_low.pre = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_low.on = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_low.post = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_high.pre = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_high.on = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_high.post = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.gamma.pre = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.gamma.on = [];
    protocoloLFP.injured.coherence_record(p).coupling_strength.gamma.post = [];

    protocoloLFP.injured.coherence_record(p).delay.theta.pre = [];
    protocoloLFP.injured.coherence_record(p).delay.theta.on = [];
    protocoloLFP.injured.coherence_record(p).delay.theta.post = [];
    protocoloLFP.injured.coherence_record(p).delay.alpha.pre = [];
    protocoloLFP.injured.coherence_record(p).delay.alpha.on = [];
    protocoloLFP.injured.coherence_record(p).delay.alpha.post = [];
    protocoloLFP.injured.coherence_record(p).delay.beta_low.pre = [];
    protocoloLFP.injured.coherence_record(p).delay.beta_low.on = [];
    protocoloLFP.injured.coherence_record(p).delay.beta_low.post = [];
    protocoloLFP.injured.coherence_record(p).delay.beta_high.pre = [];
    protocoloLFP.injured.coherence_record(p).delay.beta_high.on = [];
    protocoloLFP.injured.coherence_record(p).delay.beta_high.post = [];
    protocoloLFP.injured.coherence_record(p).delay.beta.pre = [];
    protocoloLFP.injured.coherence_record(p).delay.beta.on = [];
    protocoloLFP.injured.coherence_record(p).delay.beta.post = [];
    protocoloLFP.injured.coherence_record(p).delay.beta_parkinson.pre = [];
    protocoloLFP.injured.coherence_record(p).delay.beta_parkinson.on = [];
    protocoloLFP.injured.coherence_record(p).delay.beta_parkinson.post = [];
    protocoloLFP.injured.coherence_record(p).delay.gamma_low.pre = [];
    protocoloLFP.injured.coherence_record(p).delay.gamma_low.on = [];
    protocoloLFP.injured.coherence_record(p).delay.gamma_low.post = [];
    protocoloLFP.injured.coherence_record(p).delay.gamma_high.pre = [];
    protocoloLFP.injured.coherence_record(p).delay.gamma_high.on = [];
    protocoloLFP.injured.coherence_record(p).delay.gamma_high.post = [];
    protocoloLFP.injured.coherence_record(p).delay.gamma.pre = [];
    protocoloLFP.injured.coherence_record(p).delay.gamma.on = [];
    protocoloLFP.injured.coherence_record(p).delay.gamma.post = [];

    % Resumen protocolo

    protocoloLFP.injured.coherence(p).area1 = area_actual_1(1:end-1);
    protocoloLFP.injured.coherence(p).area2 = area_actual_2(1:end-1);

    protocoloLFP.injured.coherence(p).sum_MSC.theta.pre = [];
    protocoloLFP.injured.coherence(p).sum_MSC.theta.on = [];
    protocoloLFP.injured.coherence(p).sum_MSC.theta.post = [];
    protocoloLFP.injured.coherence(p).sum_MSC.alpha.pre = [];
    protocoloLFP.injured.coherence(p).sum_MSC.alpha.on = [];
    protocoloLFP.injured.coherence(p).sum_MSC.alpha.post = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta_low.pre = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta_low.on = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta_low.post = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta_high.pre = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta_high.on = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta_high.post = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta.pre = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta.on = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta.post = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta_parkinson.pre = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta_parkinson.on = [];
    protocoloLFP.injured.coherence(p).sum_MSC.beta_parkinson.post = [];
    protocoloLFP.injured.coherence(p).sum_MSC.gamma_low.pre = [];
    protocoloLFP.injured.coherence(p).sum_MSC.gamma_low.on = [];
    protocoloLFP.injured.coherence(p).sum_MSC.gamma_low.post = [];
    protocoloLFP.injured.coherence(p).sum_MSC.gamma_high.pre = [];
    protocoloLFP.injured.coherence(p).sum_MSC.gamma_high.on = [];
    protocoloLFP.injured.coherence(p).sum_MSC.gamma_high.post = [];
    protocoloLFP.injured.coherence(p).sum_MSC.gamma.pre = [];
    protocoloLFP.injured.coherence(p).sum_MSC.gamma.on = [];
    protocoloLFP.injured.coherence(p).sum_MSC.gamma.post = [];

    protocoloLFP.injured.coherence(p).coupling_strength.theta.pre = [];
    protocoloLFP.injured.coherence(p).coupling_strength.theta.on = [];
    protocoloLFP.injured.coherence(p).coupling_strength.theta.post = [];
    protocoloLFP.injured.coherence(p).coupling_strength.alpha.pre = [];
    protocoloLFP.injured.coherence(p).coupling_strength.alpha.on = [];
    protocoloLFP.injured.coherence(p).coupling_strength.alpha.post = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta_low.pre = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta_low.on = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta_low.post = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta_high.pre = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta_high.on = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta_high.post = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta.pre = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta.on = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta.post = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta_parkinson.pre = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta_parkinson.on = [];
    protocoloLFP.injured.coherence(p).coupling_strength.beta_parkinson.post = [];
    protocoloLFP.injured.coherence(p).coupling_strength.gamma_low.pre = [];
    protocoloLFP.injured.coherence(p).coupling_strength.gamma_low.on = [];
    protocoloLFP.injured.coherence(p).coupling_strength.gamma_low.post = [];
    protocoloLFP.injured.coherence(p).coupling_strength.gamma_high.pre = [];
    protocoloLFP.injured.coherence(p).coupling_strength.gamma_high.on = [];
    protocoloLFP.injured.coherence(p).coupling_strength.gamma_high.post = [];
    protocoloLFP.injured.coherence(p).coupling_strength.gamma.pre = [];
    protocoloLFP.injured.coherence(p).coupling_strength.gamma.on = [];
    protocoloLFP.injured.coherence(p).coupling_strength.gamma.post = [];

    protocoloLFP.injured.coherence(p).delay.theta.pre = [];
    protocoloLFP.injured.coherence(p).delay.theta.on = [];
    protocoloLFP.injured.coherence(p).delay.theta.post = [];
    protocoloLFP.injured.coherence(p).delay.alpha.pre = [];
    protocoloLFP.injured.coherence(p).delay.alpha.on = [];
    protocoloLFP.injured.coherence(p).delay.alpha.post = [];
    protocoloLFP.injured.coherence(p).delay.beta_low.pre = [];
    protocoloLFP.injured.coherence(p).delay.beta_low.on = [];
    protocoloLFP.injured.coherence(p).delay.beta_low.post = [];
    protocoloLFP.injured.coherence(p).delay.beta_high.pre = [];
    protocoloLFP.injured.coherence(p).delay.beta_high.on = [];
    protocoloLFP.injured.coherence(p).delay.beta_high.post = [];
    protocoloLFP.injured.coherence(p).delay.beta.pre = [];
    protocoloLFP.injured.coherence(p).delay.beta.on = [];
    protocoloLFP.injured.coherence(p).delay.beta.post = [];
    protocoloLFP.injured.coherence(p).delay.beta_parkinson.pre = [];
    protocoloLFP.injured.coherence(p).delay.beta_parkinson.on = [];
    protocoloLFP.injured.coherence(p).delay.beta_parkinson.post = [];
    protocoloLFP.injured.coherence(p).delay.gamma_low.pre = [];
    protocoloLFP.injured.coherence(p).delay.gamma_low.on = [];
    protocoloLFP.injured.coherence(p).delay.gamma_low.post = [];
    protocoloLFP.injured.coherence(p).delay.gamma_high.pre = [];
    protocoloLFP.injured.coherence(p).delay.gamma_high.on = [];
    protocoloLFP.injured.coherence(p).delay.gamma_high.post = [];
    protocoloLFP.injured.coherence(p).delay.gamma.pre = [];
    protocoloLFP.injured.coherence(p).delay.gamma.on = [];
    protocoloLFP.injured.coherence(p).delay.gamma.post = [];
            
end

% Estructura de las medidas de coherencia
for p = 1:size(idx_coherence_uninjured,1)            

    area_actual_1 = char(registroLFP.average_sync{idx_coherence_uninjured(p,1),idx_coherence_uninjured(p,2)}.names(1));
    area_actual_2 = char(registroLFP.average_sync{idx_coherence_uninjured(p,1),idx_coherence_uninjured(p,2)}.names(2));
    protocoloLFP.uninjured.coherence_record(p).area1 = area_actual_1(1:end-1);
    protocoloLFP.uninjured.coherence_record(p).area2 = area_actual_2(1:end-1);

    protocoloLFP.uninjured.coherence_record(p).sum_MSC.theta.pre = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.theta.on = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.theta.post = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.alpha.pre = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.alpha.on = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.alpha.post = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_low.pre = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_low.on = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_low.post = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_high.pre = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_high.on = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_high.post = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta.pre = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta.on = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta.post = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_parkinson.pre = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_parkinson.on = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_parkinson.post = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_low.pre = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_low.on = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_low.post = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_high.pre = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_high.on = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_high.post = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma.pre = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma.on = [];
    protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma.post = [];

    protocoloLFP.uninjured.coherence_record(p).coupling_strength.theta.pre = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.theta.on = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.theta.post = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.alpha.pre = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.alpha.on = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.alpha.post = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_low.pre = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_low.on = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_low.post = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_high.pre = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_high.on = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_high.post = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta.pre = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta.on = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta.post = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_parkinson.pre = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_parkinson.on = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_parkinson.post = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_low.pre = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_low.on = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_low.post = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_high.pre = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_high.on = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_high.post = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma.pre = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma.on = [];
    protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma.post = [];

    protocoloLFP.uninjured.coherence_record(p).delay.theta.pre = [];
    protocoloLFP.uninjured.coherence_record(p).delay.theta.on = [];
    protocoloLFP.uninjured.coherence_record(p).delay.theta.post = [];
    protocoloLFP.uninjured.coherence_record(p).delay.alpha.pre = [];
    protocoloLFP.uninjured.coherence_record(p).delay.alpha.on = [];
    protocoloLFP.uninjured.coherence_record(p).delay.alpha.post = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta_low.pre = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta_low.on = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta_low.post = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta_high.pre = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta_high.on = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta_high.post = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta.pre = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta.on = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta.post = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta_parkinson.pre = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta_parkinson.on = [];
    protocoloLFP.uninjured.coherence_record(p).delay.beta_parkinson.post = [];
    protocoloLFP.uninjured.coherence_record(p).delay.gamma_low.pre = [];
    protocoloLFP.uninjured.coherence_record(p).delay.gamma_low.on = [];
    protocoloLFP.uninjured.coherence_record(p).delay.gamma_low.post = [];
    protocoloLFP.uninjured.coherence_record(p).delay.gamma_high.pre = [];
    protocoloLFP.uninjured.coherence_record(p).delay.gamma_high.on = [];
    protocoloLFP.uninjured.coherence_record(p).delay.gamma_high.post = [];
    protocoloLFP.uninjured.coherence_record(p).delay.gamma.pre = [];
    protocoloLFP.uninjured.coherence_record(p).delay.gamma.on = [];
    protocoloLFP.uninjured.coherence_record(p).delay.gamma.post = [];

    % Resumen protocolo

    protocoloLFP.uninjured.coherence(p).area1 = area_actual_1(1:end-1);
    protocoloLFP.uninjured.coherence(p).area2 = area_actual_2(1:end-1);

    protocoloLFP.uninjured.coherence(p).sum_MSC.theta.pre = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.theta.on = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.theta.post = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.alpha.pre = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.alpha.on = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.alpha.post = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta_low.pre = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta_low.on = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta_low.post = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta_high.pre = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta_high.on = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta_high.post = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta.pre = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta.on = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta.post = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta_parkinson.pre = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta_parkinson.on = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.beta_parkinson.post = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.gamma_low.pre = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.gamma_low.on = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.gamma_low.post = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.gamma_high.pre = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.gamma_high.on = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.gamma_high.post = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.gamma.pre = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.gamma.on = [];
    protocoloLFP.uninjured.coherence(p).sum_MSC.gamma.post = [];

    protocoloLFP.uninjured.coherence(p).coupling_strength.theta.pre = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.theta.on = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.theta.post = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.alpha.pre = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.alpha.on = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.alpha.post = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta_low.pre = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta_low.on = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta_low.post = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta_high.pre = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta_high.on = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta_high.post = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta.pre = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta.on = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta.post = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta_parkinson.pre = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta_parkinson.on = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.beta_parkinson.post = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.gamma_low.pre = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.gamma_low.on = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.gamma_low.post = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.gamma_high.pre = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.gamma_high.on = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.gamma_high.post = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.gamma.pre = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.gamma.on = [];
    protocoloLFP.uninjured.coherence(p).coupling_strength.gamma.post = [];

    protocoloLFP.uninjured.coherence(p).delay.theta.pre = [];
    protocoloLFP.uninjured.coherence(p).delay.theta.on = [];
    protocoloLFP.uninjured.coherence(p).delay.theta.post = [];
    protocoloLFP.uninjured.coherence(p).delay.alpha.pre = [];
    protocoloLFP.uninjured.coherence(p).delay.alpha.on = [];
    protocoloLFP.uninjured.coherence(p).delay.alpha.post = [];
    protocoloLFP.uninjured.coherence(p).delay.beta_low.pre = [];
    protocoloLFP.uninjured.coherence(p).delay.beta_low.on = [];
    protocoloLFP.uninjured.coherence(p).delay.beta_low.post = [];
    protocoloLFP.uninjured.coherence(p).delay.beta_high.pre = [];
    protocoloLFP.uninjured.coherence(p).delay.beta_high.on = [];
    protocoloLFP.uninjured.coherence(p).delay.beta_high.post = [];
    protocoloLFP.uninjured.coherence(p).delay.beta.pre = [];
    protocoloLFP.uninjured.coherence(p).delay.beta.on = [];
    protocoloLFP.uninjured.coherence(p).delay.beta.post = [];
    protocoloLFP.uninjured.coherence(p).delay.beta_parkinson.pre = [];
    protocoloLFP.uninjured.coherence(p).delay.beta_parkinson.on = [];
    protocoloLFP.uninjured.coherence(p).delay.beta_parkinson.post = [];
    protocoloLFP.uninjured.coherence(p).delay.gamma_low.pre = [];
    protocoloLFP.uninjured.coherence(p).delay.gamma_low.on = [];
    protocoloLFP.uninjured.coherence(p).delay.gamma_low.post = [];
    protocoloLFP.uninjured.coherence(p).delay.gamma_high.pre = [];
    protocoloLFP.uninjured.coherence(p).delay.gamma_high.on = [];
    protocoloLFP.uninjured.coherence(p).delay.gamma_high.post = [];
    protocoloLFP.uninjured.coherence(p).delay.gamma.pre = [];
    protocoloLFP.uninjured.coherence(p).delay.gamma.on = [];
    protocoloLFP.uninjured.coherence(p).delay.gamma.post = [];   

end


    
if ~strcmp(protocoloLFP.name, protocolo_name)
    error('Annadiendo registro a protoclo de otro nombre')
end

disp('Annadiendo informacion al protocolo')

% Guardar el nombre del regsitro a cargar
if isempty([protocoloLFP.register_checked.name])
    idx_registerName = 0;
else
    idx_registerName = length(protocoloLFP.register_checked);
end

% Actualizacion si el registro tiene el mismo nombre
if ~isempty(protocoloLFP.register_checked.name)
    idx_sameregister = find(strcmp(string({protocoloLFP.register_checked.name}), registroLFP.name));

    if ~isempty(idx_sameregister)    
        idx_registerName = idx_sameregister(end) - 1;
    end
    
end
    
protocoloLFP.register_checked(idx_registerName+1).name = registroLFP.name;            

% Calculo de las medidas
change_band_power_theta = power_measurements(registroLFP, [4, 8], true);
change_band_power_alpha = power_measurements(registroLFP, [8, 12], true);
change_band_power_beta_low = power_measurements(registroLFP, [12, 20], true);
change_band_power_beta_high = power_measurements(registroLFP, [20, 30], true);
change_band_power_beta = power_measurements(registroLFP, [12, 30], true);
change_band_power_beta_parkinson = power_measurements(registroLFP, [8, 30], true);
change_band_power_gamma_low = power_measurements(registroLFP, [30, 60], true);
change_band_power_gamma_high = power_measurements(registroLFP, [60, 90], true);
change_band_power_gamma = power_measurements(registroLFP, [30, 90], true);

[sum_MSC_theta, coupling_strength_theta, delay_theta] = coherence_measurements(registroLFP, [4, 8], [false, false, false]);
[sum_MSC_alpha, coupling_strength_alpha, delay_alpha] = coherence_measurements(registroLFP, [8, 12], [false, false, false]);
[sum_MSC_beta_low, coupling_strength_beta_low, delay_beta_low] = coherence_measurements(registroLFP, [12, 20], [false, false, false]);
[sum_MSC_beta_high, coupling_strength_beta_high, delay_beta_high] = coherence_measurements(registroLFP, [20, 30], [false, false, false]);
[sum_MSC_beta, coupling_strength_beta, delay_beta] = coherence_measurements(registroLFP, [12, 30], [false, false, false]);
[sum_MSC_beta_parkinson, coupling_strength_beta_parkinson, delay_beta_parkinson] = coherence_measurements(registroLFP, [8, 30], [false, false, false]);
[sum_MSC_gamma_low, coupling_strength_gamma_low, delay_gamma_low] = coherence_measurements(registroLFP, [30, 60], [false, false, false]);
[sum_MSC_gamma_high, coupling_strength_gamma_high, delay_gamma_high] = coherence_measurements(registroLFP, [60, 90], [false, false, false]);
[sum_MSC_gamma, coupling_strength_gamma, delay_gamma] = coherence_measurements(registroLFP, [30, 90], [false, false, false]);

idx_injured = 0;
idx_uninjured = 0;
        
% Almacenamiento de las medidas espectrales
for m = 1:length(C)
    
    % Area
    area = C{m};
    
    if strcmp(area(end),area_lesionada)
        
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.theta(idx_registerName+1).pre = change_band_power_theta(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.theta(idx_registerName+1).on = change_band_power_theta(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.theta(idx_registerName+1).post = change_band_power_theta(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.alpha(idx_registerName+1).pre = change_band_power_alpha(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.alpha(idx_registerName+1).on = change_band_power_alpha(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.alpha(idx_registerName+1).post = change_band_power_alpha(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_low(idx_registerName+1).pre = change_band_power_beta_low(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_low(idx_registerName+1).on = change_band_power_beta_low(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_low(idx_registerName+1).post = change_band_power_beta_low(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_high(idx_registerName+1).pre = change_band_power_beta_high(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_high(idx_registerName+1).on = change_band_power_beta_high(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_high(idx_registerName+1).post = change_band_power_beta_high(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta(idx_registerName+1).pre = change_band_power_beta(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta(idx_registerName+1).on = change_band_power_beta(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta(idx_registerName+1).post = change_band_power_beta(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_parkinson(idx_registerName+1).pre = change_band_power_beta_parkinson(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_parkinson(idx_registerName+1).on = change_band_power_beta_parkinson(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.beta_parkinson(idx_registerName+1).post = change_band_power_beta_parkinson(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_low(idx_registerName+1).pre = change_band_power_gamma_low(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_low(idx_registerName+1).on = change_band_power_gamma_low(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_low(idx_registerName+1).post = change_band_power_gamma_low(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_high(idx_registerName+1).pre = change_band_power_gamma_high(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_high(idx_registerName+1).on = change_band_power_gamma_high(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma_high(idx_registerName+1).post = change_band_power_gamma_high(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma(idx_registerName+1).pre = change_band_power_gamma(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma(idx_registerName+1).on = change_band_power_gamma(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured.spectral_record(idx_injured+1).change_band_power.gamma(idx_registerName+1).post = change_band_power_gamma(idx_areas_injured(idx_injured+1), 3);
        
        idx_injured = idx_injured + 1;
        
    elseif strcmp(area(end),area_nolesionada)
        
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.theta(idx_registerName+1).pre = change_band_power_theta(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.theta(idx_registerName+1).on = change_band_power_theta(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.theta(idx_registerName+1).post = change_band_power_theta(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.alpha(idx_registerName+1).pre = change_band_power_alpha(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.alpha(idx_registerName+1).on = change_band_power_alpha(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.alpha(idx_registerName+1).post = change_band_power_alpha(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_low(idx_registerName+1).pre = change_band_power_beta_low(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_low(idx_registerName+1).on = change_band_power_beta_low(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_low(idx_registerName+1).post = change_band_power_beta_low(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_high(idx_registerName+1).pre = change_band_power_beta_high(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_high(idx_registerName+1).on = change_band_power_beta_high(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_high(idx_registerName+1).post = change_band_power_beta_high(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta(idx_registerName+1).pre = change_band_power_beta(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta(idx_registerName+1).on = change_band_power_beta(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta(idx_registerName+1).post = change_band_power_beta(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_parkinson(idx_registerName+1).pre = change_band_power_beta_parkinson(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_parkinson(idx_registerName+1).on = change_band_power_beta_parkinson(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.beta_parkinson(idx_registerName+1).post = change_band_power_beta_parkinson(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_low(idx_registerName+1).pre = change_band_power_gamma_low(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_low(idx_registerName+1).on = change_band_power_gamma_low(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_low(idx_registerName+1).post = change_band_power_gamma_low(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_high(idx_registerName+1).pre = change_band_power_gamma_high(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_high(idx_registerName+1).on = change_band_power_gamma_high(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma_high(idx_registerName+1).post = change_band_power_gamma_high(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma(idx_registerName+1).pre = change_band_power_gamma(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma(idx_registerName+1).on = change_band_power_gamma(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured.spectral_record(idx_uninjured+1).change_band_power.gamma(idx_registerName+1).post = change_band_power_gamma(idx_areas_uninjured(idx_uninjured+1), 3);
        
        idx_uninjured = idx_uninjured + 1;
        
    else
        disp('Esta area no es lesionada ni no lesionada')
        
    end
    
end

if find([idx_areas_injured;idx_areas_uninjured]==1) == 1
    inicio_medida_inj = 1;
    inicio_medida_uninj = round(length([idx_coherence_injured;idx_coherence_uninjured])/2)+1;
else
    inicio_medida_uninj = 1;
    inicio_medida_inj = round(length([idx_coherence_injured;idx_coherence_uninjured])/2)+1;
end

% Almacenamiento de las medidas de coherencia
for p = 1:size(idx_coherence_injured,1)
        
        protocoloLFP.injured.coherence_record(p).sum_MSC.theta(idx_registerName+1).pre = sum_MSC_theta(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).sum_MSC.theta(idx_registerName+1).on = sum_MSC_theta(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).sum_MSC.theta(idx_registerName+1).post = sum_MSC_theta(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).sum_MSC.alpha(idx_registerName+1).pre = sum_MSC_alpha(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).sum_MSC.alpha(idx_registerName+1).on = sum_MSC_alpha(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).sum_MSC.alpha(idx_registerName+1).post = sum_MSC_alpha(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta_low(idx_registerName+1).pre = sum_MSC_beta_low(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta_low(idx_registerName+1).on = sum_MSC_beta_low(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta_low(idx_registerName+1).post = sum_MSC_beta_low(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta_high(idx_registerName+1).pre = sum_MSC_beta_high(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta_high(idx_registerName+1).on = sum_MSC_beta_high(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta_high(idx_registerName+1).post = sum_MSC_beta_high(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta(idx_registerName+1).pre = sum_MSC_beta(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta(idx_registerName+1).on = sum_MSC_beta(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta(idx_registerName+1).post = sum_MSC_beta(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta_parkinson(idx_registerName+1).pre = sum_MSC_beta_parkinson(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta_parkinson(idx_registerName+1).on = sum_MSC_beta_parkinson(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).sum_MSC.beta_parkinson(idx_registerName+1).post = sum_MSC_beta_parkinson(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_low(idx_registerName+1).pre = sum_MSC_gamma_low(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_low(idx_registerName+1).on = sum_MSC_gamma_low(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_low(idx_registerName+1).post = sum_MSC_gamma_low(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_high(idx_registerName+1).pre = sum_MSC_gamma_high(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_high(idx_registerName+1).on = sum_MSC_gamma_high(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).sum_MSC.gamma_high(idx_registerName+1).post = sum_MSC_gamma_high(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).sum_MSC.gamma(idx_registerName+1).pre = sum_MSC_gamma(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).sum_MSC.gamma(idx_registerName+1).on = sum_MSC_gamma(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).sum_MSC.gamma(idx_registerName+1).post = sum_MSC_gamma(inicio_medida_inj+p-1, 3);

        protocoloLFP.injured.coherence_record(p).coupling_strength.theta(idx_registerName+1).pre = coupling_strength_theta(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).coupling_strength.theta(idx_registerName+1).on = coupling_strength_theta(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).coupling_strength.theta(idx_registerName+1).post = coupling_strength_theta(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).coupling_strength.alpha(idx_registerName+1).pre = coupling_strength_alpha(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).coupling_strength.alpha(idx_registerName+1).on = coupling_strength_alpha(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).coupling_strength.alpha(idx_registerName+1).post = coupling_strength_alpha(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta_low(idx_registerName+1).pre = coupling_strength_beta_low(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta_low(idx_registerName+1).on = coupling_strength_beta_low(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta_low(idx_registerName+1).post = coupling_strength_beta_low(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta_high(idx_registerName+1).pre = coupling_strength_beta_high(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta_high(idx_registerName+1).on = coupling_strength_beta_high(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta_high(idx_registerName+1).post = coupling_strength_beta_high(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta(idx_registerName+1).pre = coupling_strength_beta(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta(idx_registerName+1).on = coupling_strength_beta(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta(idx_registerName+1).post = coupling_strength_beta(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta_parkinson(idx_registerName+1).pre = coupling_strength_beta_parkinson(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta_parkinson(idx_registerName+1).on = coupling_strength_beta_parkinson(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).coupling_strength.beta_parkinson(idx_registerName+1).post = coupling_strength_beta_parkinson(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_low(idx_registerName+1).pre = coupling_strength_gamma_low(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_low(idx_registerName+1).on = coupling_strength_gamma_low(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_low(idx_registerName+1).post = coupling_strength_gamma_low(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_high(idx_registerName+1).pre = coupling_strength_gamma_high(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_high(idx_registerName+1).on = coupling_strength_gamma_high(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).coupling_strength.gamma_high(idx_registerName+1).post = coupling_strength_gamma_high(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).coupling_strength.gamma(idx_registerName+1).pre = coupling_strength_gamma(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).coupling_strength.gamma(idx_registerName+1).on = coupling_strength_gamma(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).coupling_strength.gamma(idx_registerName+1).post = coupling_strength_gamma(inicio_medida_inj+p-1, 3);

        protocoloLFP.injured.coherence_record(p).delay.theta(idx_registerName+1).pre = delay_theta(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).delay.theta(idx_registerName+1).on = delay_theta(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).delay.theta(idx_registerName+1).post = delay_theta(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).delay.alpha(idx_registerName+1).pre = delay_alpha(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).delay.alpha(idx_registerName+1).on = delay_alpha(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).delay.alpha(idx_registerName+1).post = delay_alpha(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).delay.beta_low(idx_registerName+1).pre = delay_beta_low(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).delay.beta_low(idx_registerName+1).on = delay_beta_low(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).delay.beta_low(idx_registerName+1).post = delay_beta_low(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).delay.beta_high(idx_registerName+1).pre = delay_beta_high(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).delay.beta_high(idx_registerName+1).on = delay_beta_high(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).delay.beta_high(idx_registerName+1).post = delay_beta_high(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).delay.beta(idx_registerName+1).pre = delay_beta(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).delay.beta(idx_registerName+1).on = delay_beta(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).delay.beta(idx_registerName+1).post = delay_beta(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).delay.beta_parkinson(idx_registerName+1).pre = delay_beta_parkinson(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).delay.beta_parkinson(idx_registerName+1).on = delay_beta_parkinson(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).delay.beta_parkinson(idx_registerName+1).post = delay_beta_parkinson(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).delay.gamma_low(idx_registerName+1).pre = delay_gamma_low(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).delay.gamma_low(idx_registerName+1).on = delay_gamma_low(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).delay.gamma_low(idx_registerName+1).post = delay_gamma_low(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).delay.gamma_high(idx_registerName+1).pre = delay_gamma_high(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).delay.gamma_high(idx_registerName+1).on = delay_gamma_high(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).delay.gamma_high(idx_registerName+1).post = delay_gamma_high(inicio_medida_inj+p-1, 3);
        protocoloLFP.injured.coherence_record(p).delay.gamma(idx_registerName+1).pre = delay_gamma(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured.coherence_record(p).delay.gamma(idx_registerName+1).on = delay_gamma(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured.coherence_record(p).delay.gamma(idx_registerName+1).post = delay_gamma(inicio_medida_inj+p-1, 3);

            
end

% Almacenamiento de las medidas de coherencia
for p = 1:size(idx_coherence_uninjured,1)     

        protocoloLFP.uninjured.coherence_record(p).sum_MSC.theta(idx_registerName+1).pre = sum_MSC_theta(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.theta(idx_registerName+1).on = sum_MSC_theta(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.theta(idx_registerName+1).post = sum_MSC_theta(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.alpha(idx_registerName+1).pre = sum_MSC_alpha(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.alpha(idx_registerName+1).on = sum_MSC_alpha(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.alpha(idx_registerName+1).post = sum_MSC_alpha(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_low(idx_registerName+1).pre = sum_MSC_beta_low(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_low(idx_registerName+1).on = sum_MSC_beta_low(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_low(idx_registerName+1).post = sum_MSC_beta_low(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_high(idx_registerName+1).pre = sum_MSC_beta_high(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_high(idx_registerName+1).on = sum_MSC_beta_high(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_high(idx_registerName+1).post = sum_MSC_beta_high(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta(idx_registerName+1).pre = sum_MSC_beta(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta(idx_registerName+1).on = sum_MSC_beta(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta(idx_registerName+1).post = sum_MSC_beta(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_parkinson(idx_registerName+1).pre = sum_MSC_beta_parkinson(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_parkinson(idx_registerName+1).on = sum_MSC_beta_parkinson(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.beta_parkinson(idx_registerName+1).post = sum_MSC_beta_parkinson(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_low(idx_registerName+1).pre = sum_MSC_gamma_low(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_low(idx_registerName+1).on = sum_MSC_gamma_low(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_low(idx_registerName+1).post = sum_MSC_gamma_low(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_high(idx_registerName+1).pre = sum_MSC_gamma_high(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_high(idx_registerName+1).on = sum_MSC_gamma_high(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma_high(idx_registerName+1).post = sum_MSC_gamma_high(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma(idx_registerName+1).pre = sum_MSC_gamma(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma(idx_registerName+1).on = sum_MSC_gamma(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).sum_MSC.gamma(idx_registerName+1).post = sum_MSC_gamma(inicio_medida_uninj+p-1, 3);

        protocoloLFP.uninjured.coherence_record(p).coupling_strength.theta(idx_registerName+1).pre = coupling_strength_theta(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.theta(idx_registerName+1).on = coupling_strength_theta(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.theta(idx_registerName+1).post = coupling_strength_theta(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.alpha(idx_registerName+1).pre = coupling_strength_alpha(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.alpha(idx_registerName+1).on = coupling_strength_alpha(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.alpha(idx_registerName+1).post = coupling_strength_alpha(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_low(idx_registerName+1).pre = coupling_strength_beta_low(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_low(idx_registerName+1).on = coupling_strength_beta_low(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_low(idx_registerName+1).post = coupling_strength_beta_low(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_high(idx_registerName+1).pre = coupling_strength_beta_high(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_high(idx_registerName+1).on = coupling_strength_beta_high(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_high(idx_registerName+1).post = coupling_strength_beta_high(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta(idx_registerName+1).pre = coupling_strength_beta(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta(idx_registerName+1).on = coupling_strength_beta(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta(idx_registerName+1).post = coupling_strength_beta(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_parkinson(idx_registerName+1).pre = coupling_strength_beta_parkinson(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_parkinson(idx_registerName+1).on = coupling_strength_beta_parkinson(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.beta_parkinson(idx_registerName+1).post = coupling_strength_beta_parkinson(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_low(idx_registerName+1).pre = coupling_strength_gamma_low(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_low(idx_registerName+1).on = coupling_strength_gamma_low(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_low(idx_registerName+1).post = coupling_strength_gamma_low(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_high(idx_registerName+1).pre = coupling_strength_gamma_high(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_high(idx_registerName+1).on = coupling_strength_gamma_high(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma_high(idx_registerName+1).post = coupling_strength_gamma_high(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma(idx_registerName+1).pre = coupling_strength_gamma(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma(idx_registerName+1).on = coupling_strength_gamma(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).coupling_strength.gamma(idx_registerName+1).post = coupling_strength_gamma(inicio_medida_uninj+p-1, 3);

        protocoloLFP.uninjured.coherence_record(p).delay.theta(idx_registerName+1).pre = delay_theta(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).delay.theta(idx_registerName+1).on = delay_theta(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).delay.theta(idx_registerName+1).post = delay_theta(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).delay.alpha(idx_registerName+1).pre = delay_alpha(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).delay.alpha(idx_registerName+1).on = delay_alpha(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).delay.alpha(idx_registerName+1).post = delay_alpha(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).delay.beta_low(idx_registerName+1).pre = delay_beta_low(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).delay.beta_low(idx_registerName+1).on = delay_beta_low(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).delay.beta_low(idx_registerName+1).post = delay_beta_low(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).delay.beta_high(idx_registerName+1).pre = delay_beta_high(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).delay.beta_high(idx_registerName+1).on = delay_beta_high(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).delay.beta_high(idx_registerName+1).post = delay_beta_high(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).delay.beta(idx_registerName+1).pre = delay_beta(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).delay.beta(idx_registerName+1).on = delay_beta(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).delay.beta(idx_registerName+1).post = delay_beta(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).delay.beta_parkinson(idx_registerName+1).pre = delay_beta_parkinson(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).delay.beta_parkinson(idx_registerName+1).on = delay_beta_parkinson(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).delay.beta_parkinson(idx_registerName+1).post = delay_beta_parkinson(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).delay.gamma_low(idx_registerName+1).pre = delay_gamma_low(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).delay.gamma_low(idx_registerName+1).on = delay_gamma_low(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).delay.gamma_low(idx_registerName+1).post = delay_gamma_low(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).delay.gamma_high(idx_registerName+1).pre = delay_gamma_high(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).delay.gamma_high(idx_registerName+1).on = delay_gamma_high(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).delay.gamma_high(idx_registerName+1).post = delay_gamma_high(inicio_medida_uninj+p-1, 3);
        protocoloLFP.uninjured.coherence_record(p).delay.gamma(idx_registerName+1).pre = delay_gamma(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured.coherence_record(p).delay.gamma(idx_registerName+1).on = delay_gamma(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured.coherence_record(p).delay.gamma(idx_registerName+1).post = delay_gamma(inicio_medida_uninj+p-1, 3);

end

% Hacer la funcion para las medidas globales con los graficos,
% Basarse en el coherence measuemrents 
