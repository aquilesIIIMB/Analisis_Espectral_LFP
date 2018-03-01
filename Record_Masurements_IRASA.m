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

names_areas = {registroLFP.areas.name};
% Eliminar la ultima letra de las areas (el hemisferio)
names_areas = cellfun(@(S) S(1:end-1), names_areas, 'Uniform', 0);
names_areas = unique(names_areas,'stable');

% Calculo de las medidas
[band_power_delta, band_power_delta_norm] = power_measurements_IRASA(registroLFP, [1, 4], false, true, path);
[band_power_fractal_delta, band_power_fractal_delta_norm] = power_fractal_measurements_IRASA(registroLFP, [1, 4], false, true, path);
[sum_MSC_delta, coupling_strength_delta, delay_delta] = coherence_measurements(registroLFP, [1, 4], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in delta band [1, 4] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in delta band [1, 4] Hz'}]);
graph_motorcircuit(coupling_strength_delta, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power_theta, band_power_theta_norm] = power_measurements_IRASA(registroLFP, [4, 8], false, true, path);
[band_power_fractal_theta, band_power_fractal_theta_norm] = power_fractal_measurements_IRASA(registroLFP, [4, 8], false, true, path);
[sum_MSC_theta, coupling_strength_theta, delay_theta] = coherence_measurements(registroLFP, [4, 8], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in theta band [4, 8] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in theta band [4, 8] Hz'}]);
graph_motorcircuit(coupling_strength_theta, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power_alpha, band_power_alpha_norm] = power_measurements_IRASA(registroLFP, [8, 12], false, true, path);
[band_power_fractal_alpha, band_power_fractal_alpha_norm] = power_fractal_measurements_IRASA(registroLFP, [8, 12], false, true, path);
[sum_MSC_alpha, coupling_strength_alpha, delay_alpha] = coherence_measurements(registroLFP, [8, 12], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in alpha band [8, 12] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in alpha band [8, 12] Hz'}]);
graph_motorcircuit(coupling_strength_alpha, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power_beta_low, band_power_beta_low_norm] = power_measurements_IRASA(registroLFP, [12, 20], false, true, path);
[band_power_fractal_beta_low, band_power_fractal_beta_low_norm] = power_fractal_measurements_IRASA(registroLFP, [12, 20], false, true, path);
[sum_MSC_beta_low, coupling_strength_beta_low, delay_beta_low] = coherence_measurements(registroLFP, [12, 20], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta low band [12, 20] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta low band [12, 20] Hz'}]);
graph_motorcircuit(coupling_strength_beta_low, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power_beta_high, band_power_beta_high_norm] = power_measurements_IRASA(registroLFP, [20, 30], false, true, path);
[band_power_fractal_beta_high, band_power_fractal_beta_high_norm] = power_fractal_measurements_IRASA(registroLFP, [20, 30], false, true, path);
[sum_MSC_beta_high, coupling_strength_beta_high, delay_beta_high] = coherence_measurements(registroLFP, [20, 30], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta high band [20, 30] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta high band [20, 30] Hz'}]);
graph_motorcircuit(coupling_strength_beta_high, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power_beta, band_power_beta_norm] = power_measurements_IRASA(registroLFP, [12, 30], false, true, path);
[band_power_fractal_beta, band_power_fractal_beta_norm] = power_fractal_measurements_IRASA(registroLFP, [12, 30], false, true, path);
[sum_MSC_beta, coupling_strength_beta, delay_beta] = coherence_measurements(registroLFP, [12, 30], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta band [12, 30] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta band [12, 30] Hz'}]);
graph_motorcircuit(coupling_strength_beta, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power_beta_parkinson, band_power_beta_parkinson_norm] = power_measurements_IRASA(registroLFP, [8, 30], false, true, path);
[band_power_fractal_beta_parkinson, band_power_fractal_beta_parkinson_norm] = power_fractal_measurements_IRASA(registroLFP, [8, 30], false, true, path);
[sum_MSC_beta_parkinson, coupling_strength_beta_parkinson, delay_beta_parkinson] = coherence_measurements(registroLFP, [8, 30], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta parkinson band [8, 30] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta parkinson band [8, 30] Hz'}]);
graph_motorcircuit(coupling_strength_beta_parkinson, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power_gamma_low, band_power_gamma_low_norm] = power_measurements_IRASA(registroLFP, [30, 60], false, true, path);
[band_power_fractal_gamma_low, band_power_fractal_gamma_low_norm] = power_fractal_measurements_IRASA(registroLFP, [30, 60], false, true, path);
[sum_MSC_gamma_low, coupling_strength_gamma_low, delay_gamma_low] = coherence_measurements(registroLFP, [30, 60], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in gamma low band [30, 60] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in gamma low band [30, 60] Hz'}]);
graph_motorcircuit(coupling_strength_gamma_low, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power_gamma_high, band_power_gamma_high_norm] = power_measurements_IRASA(registroLFP, [60, 90], false, true, path);
[band_power_fractal_gamma_high, band_power_fractal_gamma_high_norm] = power_fractal_measurements_IRASA(registroLFP, [60, 90], false, true, path);
[sum_MSC_gamma_high, coupling_strength_gamma_high, delay_gamma_high] = coherence_measurements(registroLFP, [60, 90], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in gamma high band [60, 90] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in gamma high band [60, 90] Hz'}]);
graph_motorcircuit(coupling_strength_gamma_high, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power_gamma, band_power_gamma_norm] = power_measurements_IRASA(registroLFP, [30, 90], false, true, path);
[band_power_fractal_gamma, band_power_fractal_gamma_norm] = power_fractal_measurements_IRASA(registroLFP, [30, 90], false, true, path);
[sum_MSC_gamma, coupling_strength_gamma, delay_gamma] = coherence_measurements(registroLFP, [30, 90], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in gamma band [30, 90] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in gamma band [30, 90] Hz'}]);
graph_motorcircuit(coupling_strength_gamma, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[power_band_total, power_band_total_norm, power_fractal_band,power_fractal_band_norm] = power_total_measurements_IRASA(registroLFP, false, true, path);
beta_exponent = exponent_fractal_measurements_IRASA(registroLFP, false, true, path);

% Eliminacion de variables que no se van a guardar
%clearvars -except registroLFP path name_registro foldername inicio_foldername
clearvars registroLFP

measurements_LFP.power_band.oscillations.delta = [band_power_delta, band_power_delta_norm];
measurements_LFP.power_band.oscillations.theta = [band_power_theta, band_power_theta_norm];
measurements_LFP.power_band.oscillations.alpha = [band_power_alpha, band_power_alpha_norm];
measurements_LFP.power_band.oscillations.beta_low = [band_power_beta_low, band_power_beta_low_norm];
measurements_LFP.power_band.oscillations.beta_high = [band_power_beta_high, band_power_beta_high_norm];
measurements_LFP.power_band.oscillations.beta = [band_power_beta, band_power_beta_norm];
measurements_LFP.power_band.oscillations.beta_parkinson = [band_power_beta_parkinson, band_power_beta_parkinson_norm];
measurements_LFP.power_band.oscillations.gamma_low = [band_power_gamma_low, band_power_gamma_low_norm];
measurements_LFP.power_band.oscillations.gamma_high = [band_power_gamma_high, band_power_gamma_high_norm];
measurements_LFP.power_band.oscillations.gamma = [band_power_gamma, band_power_gamma_norm];

measurements_LFP.power_band.fractals.delta = [band_power_fractal_delta, band_power_fractal_delta_norm];
measurements_LFP.power_band.fractals.theta = [band_power_fractal_theta, band_power_fractal_theta_norm];
measurements_LFP.power_band.fractals.alpha = [band_power_fractal_alpha, band_power_fractal_alpha_norm];
measurements_LFP.power_band.fractals.beta_low = [band_power_fractal_beta_low, band_power_fractal_beta_low_norm];
measurements_LFP.power_band.fractals.beta_high = [band_power_fractal_beta_high, band_power_fractal_beta_high_norm];
measurements_LFP.power_band.fractals.beta = [band_power_fractal_beta, band_power_fractal_beta_norm];
measurements_LFP.power_band.fractals.beta_parkinson = [band_power_fractal_beta_parkinson, band_power_fractal_beta_parkinson_norm];
measurements_LFP.power_band.fractals.gamma_low = [band_power_fractal_gamma_low, band_power_fractal_gamma_low_norm];
measurements_LFP.power_band.fractals.gamma_high = [band_power_fractal_gamma_high, band_power_fractal_gamma_high_norm];
measurements_LFP.power_band.fractals.gamma = [band_power_fractal_gamma, band_power_fractal_gamma_norm];
                                    
measurements_LFP.power_total.oscillations = [power_band_total, power_band_total_norm];
measurements_LFP.power_total.fractals = [power_fractal_band,power_fractal_band_norm];
measurements_LFP.beta_exponent = beta_exponent;

measurements_LFP.coherence.sum_MSC.delta = [sum_MSC_delta];
measurements_LFP.coherence.sum_MSC.theta = [sum_MSC_theta];
measurements_LFP.coherence.sum_MSC.alpha = [sum_MSC_alpha];
measurements_LFP.coherence.sum_MSC.beta_low = [sum_MSC_beta_low];
measurements_LFP.coherence.sum_MSC.beta_high = [sum_MSC_beta_high];
measurements_LFP.coherence.sum_MSC.beta = [sum_MSC_beta];
measurements_LFP.coherence.sum_MSC.beta_parkinson = [sum_MSC_beta_parkinson];
measurements_LFP.coherence.sum_MSC.gamma_low = [sum_MSC_gamma_low];
measurements_LFP.coherence.sum_MSC.gamma_high = [sum_MSC_gamma_high];
measurements_LFP.coherence.sum_MSC.gamma = [sum_MSC_gamma];

measurements_LFP.coherence.coupling_strength.delta = [coupling_strength_delta];
measurements_LFP.coherence.coupling_strength.theta = [coupling_strength_theta];
measurements_LFP.coherence.coupling_strength.alpha = [coupling_strength_alpha];
measurements_LFP.coherence.coupling_strength.beta_low = [coupling_strength_beta_low];
measurements_LFP.coherence.coupling_strength.beta_high = [coupling_strength_beta_high];
measurements_LFP.coherence.coupling_strength.beta = [coupling_strength_beta];
measurements_LFP.coherence.coupling_strength.beta_parkinson = [coupling_strength_beta_parkinson];
measurements_LFP.coherence.coupling_strength.gamma_low = [coupling_strength_gamma_low];
measurements_LFP.coherence.coupling_strength.gamma_high = [coupling_strength_gamma_high];
measurements_LFP.coherence.coupling_strength.gamma = [coupling_strength_gamma];

measurements_LFP.coherence.delay.delta = [delay_delta];
measurements_LFP.coherence.delay.theta = [delay_theta];
measurements_LFP.coherence.delay.alpha = [delay_alpha];
measurements_LFP.coherence.delay.beta_low = [delay_beta_low];
measurements_LFP.coherence.delay.beta_high = [delay_beta_high];
measurements_LFP.coherence.delay.beta = [delay_beta];
measurements_LFP.coherence.delay.beta_parkinson = [delay_beta_parkinson];
measurements_LFP.coherence.delay.gamma_low = [delay_gamma_low];
measurements_LFP.coherence.delay.gamma_high = [delay_gamma_high];
measurements_LFP.coherence.delay.gamma = [delay_gamma];


% Eliminacion de variables que no se van a guardar
clearvars -except measurements_LFP path name_registro foldername inicio_foldername

% Guardar matrices en .mat
path_name_registro = [inicio_foldername,'Images',foldername,'measurements_',name_registro];

% Descomentar para guardar
save(path_name_registro,'-v7.3')
