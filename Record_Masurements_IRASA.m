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

names_areas = {registroLFP.area.name};
names_areas = cellfun(@(S) S(1:end-1), names_areas, 'Uniform', 0);
names_areas = unique(names_areas,'stable');

% Calculo de las medidas
change_band_power_delta = power_measurements_IRASA(registroLFP, [1, 4], false, true, path);
[sum_MSC_delta, coupling_strength_delta, delay_delta] = coherence_measurements(registroLFP, [1, 4], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in delta band [1, 4] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in delta band [1, 4] Hz'}]);
graph_motorcircuit(coupling_strength_delta, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

change_band_power_theta = power_measurements_IRASA(registroLFP, [4, 8], false, true, path);
[sum_MSC_theta, coupling_strength_theta, delay_theta] = coherence_measurements(registroLFP, [4, 8], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in theta band [4, 8] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in theta band [4, 8] Hz'}]);
graph_motorcircuit(coupling_strength_theta, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

change_band_power_alpha = power_measurements_IRASA(registroLFP, [8, 12], false, true, path);
[sum_MSC_alpha, coupling_strength_alpha, delay_alpha] = coherence_measurements(registroLFP, [8, 12], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in alpha band [8, 12] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in alpha band [8, 12] Hz'}]);
graph_motorcircuit(coupling_strength_alpha, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

change_band_power_beta_low = power_measurements_IRASA(registroLFP, [12, 20], false, true, path);
[sum_MSC_beta_low, coupling_strength_beta_low, delay_beta_low] = coherence_measurements(registroLFP, [12, 20], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta low band [12, 20] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta low band [12, 20] Hz'}]);
graph_motorcircuit(coupling_strength_beta_low, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

change_band_power_beta_high = power_measurements_IRASA(registroLFP, [20, 30], false, true, path);
[sum_MSC_beta_high, coupling_strength_beta_high, delay_beta_high] = coherence_measurements(registroLFP, [20, 30], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta high band [20, 30] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta high band [20, 30] Hz'}]);
graph_motorcircuit(coupling_strength_beta_high, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

change_band_power_beta = power_measurements_IRASA(registroLFP, [12, 30], false, true, path);
[sum_MSC_beta, coupling_strength_beta, delay_beta] = coherence_measurements(registroLFP, [12, 30], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta band [12, 30] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta band [12, 30] Hz'}]);
graph_motorcircuit(coupling_strength_beta, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

change_band_power_beta_parkinson = power_measurements_IRASA(registroLFP, [8, 30], false, true, path);
[sum_MSC_beta_parkinson, coupling_strength_beta_parkinson, delay_beta_parkinson] = coherence_measurements(registroLFP, [8, 30], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta parkinson band [8, 30] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta parkinson band [8, 30] Hz'}]);
graph_motorcircuit(coupling_strength_beta_parkinson, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

change_band_power_gamma_low = power_measurements_IRASA(registroLFP, [30, 60], false, true, path);
[sum_MSC_gamma_low, coupling_strength_gamma_low, delay_gamma_low] = coherence_measurements(registroLFP, [30, 60], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in gamma low band [30, 60] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in gamma low band [30, 60] Hz'}]);
graph_motorcircuit(coupling_strength_gamma_low, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

change_band_power_gamma_high = power_measurements_IRASA(registroLFP, [60, 90], false, true, path);
[sum_MSC_gamma_high, coupling_strength_gamma_high, delay_gamma_high] = coherence_measurements(registroLFP, [60, 90], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in gamma high band [60, 90] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in gamma high band [60, 90] Hz'}]);
graph_motorcircuit(coupling_strength_gamma_high, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

change_band_power_gamma = power_measurements_IRASA(registroLFP, [30, 90], false, true, path);
[sum_MSC_gamma, coupling_strength_gamma, delay_gamma] = coherence_measurements(registroLFP, [30, 90], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in gamma band [30, 90] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in gamma band [30, 90] Hz'}]);
graph_motorcircuit(coupling_strength_gamma, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[power_band_total, power_band_total_norm, power_fractal_band,power_fractal_band_norm] = power_total_measurements_IRASA(registroLFP, false, true, path);

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP path name_registro foldername inicio_foldername
