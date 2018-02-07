% Calcular metrica del protocolo
% Modificar porque hay areas solas en espectro y par de areas en cohernecia !!!!!!!!!! 
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

% Almacenamiento de las medidas
if ~exist('protocoloLFP','var')

    disp('Inicializando la estructura del protocolo')
    % Estructura
    protocoloLFP.name = protocolo_name;
    protocoloLFP.register_checked.name = [];
    protocoloLFP.injured.area = [];
    protocoloLFP.uninjured.area = [];

    for m = 1:length(C)
        
        % Area
        area = C{m};

        % Almacenar los datos
        if strcmp(area(end),area_lesionada)
            if isempty([protocoloLFP.injured.area])
                idx_injured = 0;
            else
                idx_injured = length(protocoloLFP.injured);
            end
            
            protocoloLFP.injured(idx_injured+1).area = area(1:end-1);
            
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.theta.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.theta.on = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.theta.post = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.alpha.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.alpha.on = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.alpha.post = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_low.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_low.on = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_low.post = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_high.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_high.on = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_high.post = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta.on = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta.post = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_parkinson.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_parkinson.on = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_parkinson.post = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_low.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_low.on = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_low.post = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_high.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_high.on = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_high.post = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma.on = [];
            protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma.post = [];
            
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.theta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.theta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.theta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.alpha.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.alpha.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.alpha.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_parkinson.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_parkinson.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_parkinson.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma.post = [];
            
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.theta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.theta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.theta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.alpha.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.alpha.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.alpha.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_parkinson.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_parkinson.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_parkinson.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma.post = [];
            
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.theta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.theta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.theta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.alpha.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.alpha.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.alpha.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_parkinson.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_parkinson.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_parkinson.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma.on = [];
            protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma.post = [];
            
            % Resumen protocolo
            
            protocoloLFP.injured(idx_injured+1).area = area(1:end-1);
            
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.theta.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.theta.on = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.theta.post = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.alpha.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.alpha.on = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.alpha.post = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta_low.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta_low.on = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta_low.post = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta_high.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta_high.on = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta_high.post = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta.on = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta.post = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta_parkinson.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta_parkinson.on = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.beta_parkinson.post = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.gamma_low.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.gamma_low.on = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.gamma_low.post = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.gamma_high.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.gamma_high.on = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.gamma_high.post = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.gamma.pre = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.gamma.on = [];
            protocoloLFP.injured(idx_injured+1).spectral.change_band_power.gamma.post = [];
            
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.theta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.theta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.theta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.alpha.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.alpha.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.alpha.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta_parkinson.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta_parkinson.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.beta_parkinson.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.gamma_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.gamma_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.gamma_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.gamma_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.gamma_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.gamma_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.gamma.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.gamma.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.sum_MSC.gamma.post = [];
            
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.theta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.theta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.theta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.alpha.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.alpha.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.alpha.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta_parkinson.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta_parkinson.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.beta_parkinson.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.gamma_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.gamma_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.gamma_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.gamma_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.gamma_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.gamma_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.gamma.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.gamma.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.coupling_strength.gamma.post = [];
            
            protocoloLFP.injured(idx_injured+1).coherence.delay.theta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.theta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.theta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.alpha.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.alpha.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.alpha.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta_parkinson.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta_parkinson.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.beta_parkinson.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.gamma_low.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.gamma_low.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.gamma_low.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.gamma_high.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.gamma_high.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.gamma_high.post = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.gamma.pre = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.gamma.on = [];
            protocoloLFP.injured(idx_injured+1).coherence.delay.gamma.post = [];


        elseif strcmp(area(end),area_nolesionada)
            if isempty([protocoloLFP.uninjured.area])
                idx_uninjured = 0;
            else
                idx_uninjured = length(protocoloLFP.uninjured);
            end
            
            protocoloLFP.uninjured(idx_uninjured+1).area = area(1:end-1);
            
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.theta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.theta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.theta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.alpha.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.alpha.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.alpha.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_parkinson.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_parkinson.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_parkinson.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma.post = [];
            
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.theta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.theta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.theta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.alpha.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.alpha.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.alpha.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_parkinson.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_parkinson.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_parkinson.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma.post = [];
            
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.theta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.theta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.theta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.alpha.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.alpha.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.alpha.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_parkinson.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_parkinson.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_parkinson.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma.post = [];
            
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.theta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.theta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.theta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.alpha.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.alpha.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.alpha.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_parkinson.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_parkinson.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_parkinson.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma.post = [];
            
            % Resumen protocolo
            
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.theta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.theta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.theta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.alpha.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.alpha.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.alpha.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta_parkinson.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta_parkinson.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.beta_parkinson.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.gamma_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.gamma_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.gamma_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.gamma_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.gamma_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.gamma_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.gamma.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.gamma.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectral.change_band_power.gamma.post = [];
            
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.theta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.theta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.theta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.alpha.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.alpha.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.alpha.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta_parkinson.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta_parkinson.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.beta_parkinson.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.gamma_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.gamma_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.gamma_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.gamma_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.gamma_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.gamma_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.gamma.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.gamma.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.sum_MSC.gamma.post = [];
            
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.theta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.theta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.theta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.alpha.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.alpha.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.alpha.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta_parkinson.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta_parkinson.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.beta_parkinson.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.gamma_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.gamma_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.gamma_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.gamma_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.gamma_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.gamma_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.gamma.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.gamma.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.coupling_strength.gamma.post = [];
            
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.theta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.theta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.theta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.alpha.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.alpha.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.alpha.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta_parkinson.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta_parkinson.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.beta_parkinson.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.gamma_low.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.gamma_low.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.gamma_low.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.gamma_high.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.gamma_high.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.gamma_high.post = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.gamma.pre = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.gamma.on = [];
            protocoloLFP.uninjured(idx_uninjured+1).coherence.delay.gamma.post = [];
            
        else
            disp('Esta area no es lesionada ni no lesionada')

        end

    end
    
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
change_band_power_theta = power_measurements(registroLFP, [4, 8], false);
change_band_power_alpha = power_measurements(registroLFP, [8, 12], false);
change_band_power_beta_low = power_measurements(registroLFP, [12, 20], false);
change_band_power_beta_high = power_measurements(registroLFP, [20, 30], false);
change_band_power_beta = power_measurements(registroLFP, [12, 30], false);
change_band_power_beta_parkinson = power_measurements(registroLFP, [8, 30], false);
change_band_power_gamma_low = power_measurements(registroLFP, [30, 60], false);
change_band_power_gamma_high = power_measurements(registroLFP, [60, 90], false);
change_band_power_gamma = power_measurements(registroLFP, [30, 90], false);

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
        
for m = 1:length(C)
    
    % Area
    area = C{m};
    
    % Almacenar los datos
    if strcmp(area(end),area_lesionada)
        
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.theta(idx_registerName+1).pre = change_band_power_theta(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.theta(idx_registerName+1).on = change_band_power_theta(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.theta(idx_registerName+1).post = change_band_power_theta(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.alpha(idx_registerName+1).pre = change_band_power_alpha(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.alpha(idx_registerName+1).on = change_band_power_alpha(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.alpha(idx_registerName+1).post = change_band_power_alpha(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_low(idx_registerName+1).pre = change_band_power_beta_low(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_low(idx_registerName+1).on = change_band_power_beta_low(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_low(idx_registerName+1).post = change_band_power_beta_low(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_high(idx_registerName+1).pre = change_band_power_beta_high(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_high(idx_registerName+1).on = change_band_power_beta_high(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_high(idx_registerName+1).post = change_band_power_beta_high(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta(idx_registerName+1).pre = change_band_power_beta(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta(idx_registerName+1).on = change_band_power_beta(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta(idx_registerName+1).post = change_band_power_beta(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_parkinson(idx_registerName+1).pre = change_band_power_beta_parkinson(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_parkinson(idx_registerName+1).on = change_band_power_beta_parkinson(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.beta_parkinson(idx_registerName+1).post = change_band_power_beta_parkinson(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_low(idx_registerName+1).pre = change_band_power_gamma_low(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_low(idx_registerName+1).on = change_band_power_gamma_low(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_low(idx_registerName+1).post = change_band_power_gamma_low(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_high(idx_registerName+1).pre = change_band_power_gamma_high(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_high(idx_registerName+1).on = change_band_power_gamma_high(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma_high(idx_registerName+1).post = change_band_power_gamma_high(idx_areas_injured(idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma(idx_registerName+1).pre = change_band_power_gamma(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma(idx_registerName+1).on = change_band_power_gamma(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).spectral_record.change_band_power.gamma(idx_registerName+1).post = change_band_power_gamma(idx_areas_injured(idx_injured+1), 3);
        
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.theta(idx_registerName+1).pre = sum_MSC_theta((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.theta(idx_registerName+1).on = sum_MSC_theta((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.theta(idx_registerName+1).post = sum_MSC_theta((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.alpha(idx_registerName+1).pre = sum_MSC_alpha((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.alpha(idx_registerName+1).on = sum_MSC_alpha((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.alpha(idx_registerName+1).post = sum_MSC_alpha((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_low(idx_registerName+1).pre = sum_MSC_beta_low((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_low(idx_registerName+1).on = sum_MSC_beta_low((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_low(idx_registerName+1).post = sum_MSC_beta_low((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_high(idx_registerName+1).pre = sum_MSC_beta_high((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_high(idx_registerName+1).on = sum_MSC_beta_high((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_high(idx_registerName+1).post = sum_MSC_beta_high((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta(idx_registerName+1).pre = sum_MSC_beta((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta(idx_registerName+1).on = sum_MSC_beta((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta(idx_registerName+1).post = sum_MSC_beta((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_parkinson(idx_registerName+1).pre = sum_MSC_beta_parkinson((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_parkinson(idx_registerName+1).on = sum_MSC_beta_parkinson((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.beta_parkinson(idx_registerName+1).post = sum_MSC_beta_parkinsona((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_low(idx_registerName+1).pre = sum_MSC_gamma_low((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_low(idx_registerName+1).on = sum_MSC_gamma_low((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_low(idx_registerName+1).post = sum_MSC_gamma_low((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_high(idx_registerName+1).pre = sum_MSC_gamma_high((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_high(idx_registerName+1).on = sum_MSC_gamma_high((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma_high(idx_registerName+1).post = sum_MSC_gamma_high((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma(idx_registerName+1).pre = sum_MSC_gamma((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma(idx_registerName+1).on = sum_MSC_gamma((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.sum_MSC.gamma(idx_registerName+1).post = sum_MSC_gamma((idx_injured+1), 3);

        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.theta(idx_registerName+1).pre = coupling_strength_theta((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.theta(idx_registerName+1).on = coupling_strength_theta((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.theta(idx_registerName+1).post = coupling_strength_theta((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.alpha(idx_registerName+1).pre = coupling_strength_alpha((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.alpha(idx_registerName+1).on = coupling_strength_alpha((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.alpha(idx_registerName+1).post = coupling_strength_alpha((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_low(idx_registerName+1).pre = coupling_strength_beta_low((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_low(idx_registerName+1).on = coupling_strength_beta_low((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_low(idx_registerName+1).post = coupling_strength_beta_low((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_high(idx_registerName+1).pre = coupling_strength_beta_high((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_high(idx_registerName+1).on = coupling_strength_beta_high((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_high(idx_registerName+1).post = coupling_strength_beta_high((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta(idx_registerName+1).pre = coupling_strength_beta((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta(idx_registerName+1).on = coupling_strength_beta((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta(idx_registerName+1).post = coupling_strength_beta((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_parkinson(idx_registerName+1).pre = coupling_strength_beta_parkinson((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_parkinson(idx_registerName+1).on = coupling_strength_beta_parkinson((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.beta_parkinson(idx_registerName+1).post = coupling_strength_beta_parkinson((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_low(idx_registerName+1).pre = coupling_strength_gamma_low((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_low(idx_registerName+1).on = coupling_strength_gamma_low((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_low(idx_registerName+1).post = coupling_strength_gamma_low((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_high(idx_registerName+1).pre = coupling_strength_gamma_high((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_high(idx_registerName+1).on = coupling_strength_gamma_high((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma_high(idx_registerName+1).post = coupling_strength_gamma_high((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma(idx_registerName+1).pre = coupling_strength_gamma((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma(idx_registerName+1).on = coupling_strength_gamma((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.coupling_strength.gamma(idx_registerName+1).post = coupling_strength_gamma((idx_injured+1), 3);

        protocoloLFP.injured(idx_injured+1).coherence_record.delay.theta(idx_registerName+1).pre = delay_theta((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.theta(idx_registerName+1).on = delay_theta((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.theta(idx_registerName+1).post = delay_theta((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.alpha(idx_registerName+1).pre = delay_alpha((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.alpha(idx_registerName+1).on = delay_alpha((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.alpha(idx_registerName+1).post = delay_alpha((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_low(idx_registerName+1).pre = delay_beta_low((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_low(idx_registerName+1).on = delay_beta_low((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_low(idx_registerName+1).post = delay_beta_low((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_high(idx_registerName+1).pre = delay_beta_high((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_high(idx_registerName+1).on = delay_beta_high((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_high(idx_registerName+1).post = delay_beta_high((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta(idx_registerName+1).pre = delay_beta((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta(idx_registerName+1).on = delay_beta((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta(idx_registerName+1).post = delay_beta((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_parkinson(idx_registerName+1).pre = delay_beta_parkinson((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_parkinson(idx_registerName+1).on = delay_beta_parkinson((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.beta_parkinson(idx_registerName+1).post = delay_beta_parkinson((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_low(idx_registerName+1).pre = delay_gamma_low((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_low(idx_registerName+1).on = delay_gamma_low((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_low(idx_registerName+1).post = delay_gamma_low((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_high(idx_registerName+1).pre = delay_gamma_high((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_high(idx_registerName+1).on = delay_gamma_high((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma_high(idx_registerName+1).post = delay_gamma_high((idx_injured+1), 3);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma(idx_registerName+1).pre = delay_gamma((idx_injured+1), 1);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma(idx_registerName+1).on = delay_gamma((idx_injured+1), 2);
        protocoloLFP.injured(idx_injured+1).coherence_record.delay.gamma(idx_registerName+1).post = delay_gamma((idx_injured+1), 3);
        
        idx_injured = idx_injured + 1;
        
    elseif strcmp(area(end),area_nolesionada)
        
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.theta(idx_registerName+1).pre = change_band_power_theta(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.theta(idx_registerName+1).on = change_band_power_theta(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.theta(idx_registerName+1).post = change_band_power_theta(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.alpha(idx_registerName+1).pre = change_band_power_alpha(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.alpha(idx_registerName+1).on = change_band_power_alpha(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.alpha(idx_registerName+1).post = change_band_power_alpha(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_low(idx_registerName+1).pre = change_band_power_beta_low(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_low(idx_registerName+1).on = change_band_power_beta_low(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_low(idx_registerName+1).post = change_band_power_beta_low(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_high(idx_registerName+1).pre = change_band_power_beta_high(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_high(idx_registerName+1).on = change_band_power_beta_high(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_high(idx_registerName+1).post = change_band_power_beta_high(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta(idx_registerName+1).pre = change_band_power_beta(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta(idx_registerName+1).on = change_band_power_beta(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta(idx_registerName+1).post = change_band_power_beta(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_parkinson(idx_registerName+1).pre = change_band_power_beta_parkinson(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_parkinson(idx_registerName+1).on = change_band_power_beta_parkinson(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.beta_parkinson(idx_registerName+1).post = change_band_power_beta_parkinson(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_low(idx_registerName+1).pre = change_band_power_gamma_low(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_low(idx_registerName+1).on = change_band_power_gamma_low(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_low(idx_registerName+1).post = change_band_power_gamma_low(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_high(idx_registerName+1).pre = change_band_power_gamma_high(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_high(idx_registerName+1).on = change_band_power_gamma_high(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma_high(idx_registerName+1).post = change_band_power_gamma_high(idx_areas_uninjured(idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma(idx_registerName+1).pre = change_band_power_gamma(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma(idx_registerName+1).on = change_band_power_gamma(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).spectral_record.change_band_power.gamma(idx_registerName+1).post = change_band_power_gamma(idx_areas_uninjured(idx_uninjured+1), 3);
        
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.theta(idx_registerName+1).pre = sum_MSC_theta((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.theta(idx_registerName+1).on = sum_MSC_theta((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.theta(idx_registerName+1).post = sum_MSC_theta((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.alpha(idx_registerName+1).pre = sum_MSC_alpha((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.alpha(idx_registerName+1).on = sum_MSC_alpha((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.alpha(idx_registerName+1).post = sum_MSC_alpha((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_low(idx_registerName+1).pre = sum_MSC_beta_low((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_low(idx_registerName+1).on = sum_MSC_beta_low((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_low(idx_registerName+1).post = sum_MSC_beta_low((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_high(idx_registerName+1).pre = sum_MSC_beta_high((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_high(idx_registerName+1).on = sum_MSC_beta_high((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_high(idx_registerName+1).post = sum_MSC_beta_high((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta(idx_registerName+1).pre = sum_MSC_beta((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta(idx_registerName+1).on = sum_MSC_beta((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta(idx_registerName+1).post = sum_MSC_beta((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_parkinson(idx_registerName+1).pre = sum_MSC_beta_parkinson((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_parkinson(idx_registerName+1).on = sum_MSC_beta_parkinson((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.beta_parkinson(idx_registerName+1).post = sum_MSC_beta_parkinson((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_low(idx_registerName+1).pre = sum_MSC_gamma_low((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_low(idx_registerName+1).on = sum_MSC_gamma_low((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_low(idx_registerName+1).post = sum_MSC_gamma_low((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_high(idx_registerName+1).pre = sum_MSC_gamma_high((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_high(idx_registerName+1).on = sum_MSC_gamma_high((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma_high(idx_registerName+1).post = sum_MSC_gamma_high((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma(idx_registerName+1).pre = sum_MSC_gamma((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma(idx_registerName+1).on = sum_MSC_gamma((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.sum_MSC.gamma(idx_registerName+1).post = sum_MSC_gamma((idx_uninjured+1), 3);

        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.theta(idx_registerName+1).pre = coupling_strength_theta((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.theta(idx_registerName+1).on = coupling_strength_theta((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.theta(idx_registerName+1).post = coupling_strength_theta((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.alpha(idx_registerName+1).pre = coupling_strength_alpha((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.alpha(idx_registerName+1).on = coupling_strength_alpha((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.alpha(idx_registerName+1).post = coupling_strength_alpha((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_low(idx_registerName+1).pre = coupling_strength_beta_low((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_low(idx_registerName+1).on = coupling_strength_beta_low((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_low(idx_registerName+1).post = coupling_strength_beta_low((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_high(idx_registerName+1).pre = coupling_strength_beta_high((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_high(idx_registerName+1).on = coupling_strength_beta_high((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_high(idx_registerName+1).post = coupling_strength_beta_high((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta(idx_registerName+1).pre = coupling_strength_beta((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta(idx_registerName+1).on = coupling_strength_beta((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta(idx_registerName+1).post = coupling_strength_beta((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_parkinson(idx_registerName+1).pre = coupling_strength_beta_parkinson((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_parkinson(idx_registerName+1).on = coupling_strength_beta_parkinson((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.beta_parkinson(idx_registerName+1).post = coupling_strength_beta_parkinson((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_low(idx_registerName+1).pre = coupling_strength_gamma_low((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_low(idx_registerName+1).on = coupling_strength_gamma_low((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_low(idx_registerName+1).post = coupling_strength_gamma_low((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_high(idx_registerName+1).pre = coupling_strength_gamma_high((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_high(idx_registerName+1).on = coupling_strength_gamma_high((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma_high(idx_registerName+1).post = coupling_strength_gamma_high((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma(idx_registerName+1).pre = coupling_strength_gamma((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma(idx_registerName+1).on = coupling_strength_gamma((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.coupling_strength.gamma(idx_registerName+1).post = coupling_strength_gamma((idx_uninjured+1), 3);

        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.theta(idx_registerName+1).pre = delay_theta((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.theta(idx_registerName+1).on = delay_theta((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.theta(idx_registerName+1).post = delay_theta((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.alpha(idx_registerName+1).pre = delay_alpha((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.alpha(idx_registerName+1).on = delay_alpha((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.alpha(idx_registerName+1).post = delay_alpha((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_low(idx_registerName+1).pre = delay_beta_low((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_low(idx_registerName+1).on = delay_beta_low((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_low(idx_registerName+1).post = delay_beta_low((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_high(idx_registerName+1).pre = delay_beta_high((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_high(idx_registerName+1).on = delay_beta_high((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_high(idx_registerName+1).post = delay_beta_high((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta(idx_registerName+1).pre = delay_beta((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta(idx_registerName+1).on = delay_beta((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta(idx_registerName+1).post = delay_beta((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_parkinson(idx_registerName+1).pre = delay_beta_parkinson((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_parkinson(idx_registerName+1).on = delay_beta_parkinson((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.beta_parkinson(idx_registerName+1).post = delay_beta_parkinson((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_low(idx_registerName+1).pre = delay_gamma_low((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_low(idx_registerName+1).on = delay_gamma_low((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_low(idx_registerName+1).post = delay_gamma_low((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_high(idx_registerName+1).pre = delay_gamma_high((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_high(idx_registerName+1).on = delay_gamma_high((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma_high(idx_registerName+1).post = delay_gamma_high((idx_uninjured+1), 3);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma(idx_registerName+1).pre = delay_gamma((idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma(idx_registerName+1).on = delay_gamma((idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_uninjured+1).coherence_record.delay.gamma(idx_registerName+1).post = delay_gamma((idx_uninjured+1), 3);
        
        idx_uninjured = idx_uninjured + 1;
        
    else
        disp('Esta area no es lesionada ni no lesionada')
        
    end
    
end

