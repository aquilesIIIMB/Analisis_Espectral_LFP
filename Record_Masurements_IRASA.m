%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Record_Masurements.m
fprintf('\nVisualizacion de cambios de potencia y coherencia\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.analysis_stages.spectral_area || ~registroLFP.analysis_stages.coherence_area
    error('Falta el bloque de eliminacion de canales y referenciacion');
    
end

% Calculo de las medidas
change_band_power_delta = power_measurements_IRASA(registroLFP, [1, 4], false, true, path);
%[sum_MSC_delta, coupling_strength_delta, delay_delta] = coherence_measurements(registroLFP, [1, 4], [false, false, false], true, path);

change_band_power_theta = power_measurements_IRASA(registroLFP, [4, 8], false, true, path);
%[sum_MSC_theta, coupling_strength_theta, delay_theta] = coherence_measurements(registroLFP, [4, 8], [false, false, false], true, path);

change_band_power_alpha = power_measurements_IRASA(registroLFP, [8, 12], false, true, path);
%[sum_MSC_alpha, coupling_strength_alpha, delay_alpha] = coherence_measurements(registroLFP, [8, 12], [false, false, false], true, path);

change_band_power_beta_low = power_measurements_IRASA(registroLFP, [12, 20], false, true, path);
%[sum_MSC_beta_low, coupling_strength_beta_low, delay_beta_low] = coherence_measurements(registroLFP, [12, 20], [false, false, false], true, path);

change_band_power_beta_high = power_measurements_IRASA(registroLFP, [20, 30], false, true, path);
%[sum_MSC_beta_high, coupling_strength_beta_high, delay_beta_high] = coherence_measurements(registroLFP, [20, 30], [false, false, false], true, path);

change_band_power_beta = power_measurements_IRASA(registroLFP, [12, 30], false, true, path);
%[sum_MSC_beta, coupling_strength_beta, delay_beta] = coherence_measurements(registroLFP, [12, 30], [false, false, false], true, path);

change_band_power_beta_parkinson = power_measurements_IRASA(registroLFP, [8, 30], false, true, path);
%[sum_MSC_beta_parkinson, coupling_strength_beta_parkinson, delay_beta_parkinson] = coherence_measurements(registroLFP, [8, 30], [false, false, false], true, path);

change_band_power_gamma_low = power_measurements_IRASA(registroLFP, [30, 60], false, true, path);
%[sum_MSC_gamma_low, coupling_strength_gamma_low, delay_gamma_low] = coherence_measurements(registroLFP, [30, 60], [false, false, false], true, path);

change_band_power_gamma_high = power_measurements_IRASA(registroLFP, [60, 90], false, true, path);
%[sum_MSC_gamma_high, coupling_strength_gamma_high, delay_gamma_high] = coherence_measurements(registroLFP, [60, 90], [false, false, false], true, path);

change_band_power_gamma = power_measurements_IRASA(registroLFP, [30, 90], false, true, path);
%[sum_MSC_gamma, coupling_strength_gamma, delay_gamma] = coherence_measurements(registroLFP, [30, 90], [false, false, false], true, path);


% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP path name_registro foldername inicio_foldername
