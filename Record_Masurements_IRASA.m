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
[band_power(:,:,1), band_power_norm(:,:,1)] = power_measurements_IRASA(registroLFP, [1, 4], false, true, path);
[band_power_fractal(:,:,1), band_power_fractal_norm(:,:,1)] = power_fractal_measurements_IRASA(registroLFP, [1, 4], false, true, path);
[sum_MSC(:,:,1), coupling_strength(:,:,1), delay(:,:,1)] = coherence_measurements(registroLFP, [1, 4], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in delta band [1, 4] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in delta band [1, 4] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,1), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power(:,:,2), band_power_norm(:,:,2)] = power_measurements_IRASA(registroLFP, [4, 8], false, true, path);
[band_power_fractal(:,:,2), band_power_fractal_norm(:,:,2)] = power_fractal_measurements_IRASA(registroLFP, [4, 8], false, true, path);
[sum_MSC(:,:,2), coupling_strength(:,:,2), delay(:,:,2)] = coherence_measurements(registroLFP, [4, 8], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in theta band [4, 8] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in theta band [4, 8] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,2), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power(:,:,3), band_power_norm(:,:,3)] = power_measurements_IRASA(registroLFP, [8, 12], false, true, path);
[band_power_fractal(:,:,3), band_power_fractal_norm(:,:,3)] = power_fractal_measurements_IRASA(registroLFP, [8, 12], false, true, path);
[sum_MSC(:,:,3), coupling_strength(:,:,3), delay(:,:,3)] = coherence_measurements(registroLFP, [8, 12], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in alpha band [8, 12] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in alpha band [8, 12] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,3), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power(:,:,4), band_power_norm(:,:,4)] = power_measurements_IRASA(registroLFP, [12, 20], false, true, path);
[band_power_fractal(:,:,4), band_power_fractal_norm(:,:,4)] = power_fractal_measurements_IRASA(registroLFP, [12, 20], false, true, path);
[sum_MSC(:,:,4), coupling_strength(:,:,4), delay(:,:,4)] = coherence_measurements(registroLFP, [12, 20], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta low band [12, 20] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta low band [12, 20] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,4), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power(:,:,5), band_power_norm(:,:,5)] = power_measurements_IRASA(registroLFP, [20, 30], false, true, path);
[band_power_fractal(:,:,5), band_power_fractal_norm(:,:,5)] = power_fractal_measurements_IRASA(registroLFP, [20, 30], false, true, path);
[sum_MSC(:,:,5), coupling_strength(:,:,5), delay(:,:,5)] = coherence_measurements(registroLFP, [20, 30], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta high band [20, 30] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta high band [20, 30] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,5), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power(:,:,6), band_power_norm(:,:,6)] = power_measurements_IRASA(registroLFP, [12, 30], false, true, path);
[band_power_fractal(:,:,6), band_power_fractal_norm(:,:,6)] = power_fractal_measurements_IRASA(registroLFP, [12, 30], false, true, path);
[sum_MSC(:,:,6), coupling_strength(:,:,6), delay(:,:,6)] = coherence_measurements(registroLFP, [12, 30], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta band [12, 30] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta band [12, 30] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,6), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power(:,:,7), band_power_norm(:,:,7)] = power_measurements_IRASA(registroLFP, [8, 30], false, true, path);
[band_power_fractal(:,:,7), band_power_fractal_norm(:,:,7)] = power_fractal_measurements_IRASA(registroLFP, [8, 30], false, true, path);
[sum_MSC(:,:,7), coupling_strength(:,:,7), delay(:,:,7)] = coherence_measurements(registroLFP, [8, 30], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in beta parkinson band [8, 30] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in beta parkinson band [8, 30] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,7), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power(:,:,8), band_power_norm(:,:,8)] = power_measurements_IRASA(registroLFP, [30, 60], false, true, path);
[band_power_fractal(:,:,8), band_power_fractal_norm(:,:,8)] = power_fractal_measurements_IRASA(registroLFP, [30, 60], false, true, path);
[sum_MSC(:,:,8), coupling_strength(:,:,8), delay(:,:,8)] = coherence_measurements(registroLFP, [30, 60], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in gamma low band [30, 60] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in gamma low band [30, 60] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,8), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power(:,:,9), band_power_norm(:,:,9)] = power_measurements_IRASA(registroLFP, [60, 90], false, true, path);
[band_power_fractal(:,:,9), band_power_fractal_norm(:,:,9)] = power_fractal_measurements_IRASA(registroLFP, [60, 90], false, true, path);
[sum_MSC(:,:,9), coupling_strength(:,:,9), delay(:,:,9)] = coherence_measurements(registroLFP, [60, 90], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in gamma high band [60, 90] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in gamma high band [60, 90] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,9), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[band_power(:,:,10), band_power_norm(:,:,10)] = power_measurements_IRASA(registroLFP, [30, 90], false, true, path);
[band_power_fractal(:,:,10), band_power_fractal_norm(:,:,10)] = power_fractal_measurements_IRASA(registroLFP, [30, 90], false, true, path);
[sum_MSC(:,:,10), coupling_strength(:,:,10), delay(:,:,10)] = coherence_measurements(registroLFP, [30, 90], [false, false, false], true, path);
titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in gamma band [30, 90] Hz'}]);
titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in gamma band [30, 90] Hz'}]);
graph_motorcircuit(coupling_strength(:,:,10), names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

[power_band_total, power_band_total_norm, power_fractal_band,power_fractal_band_norm] = power_total_measurements_IRASA(registroLFP, false, true, path);
beta_exponent = exponent_fractal_measurements_IRASA(registroLFP, false, true, path);

    
% Almacenamiento de medidas 
bandas_eval = [{'delta', 'theta','alpha','beta_low','beta_high','beta','beta_parkinson','gamma_low','gamma_high','gamma'}; ...
    {[1, 4], [4, 8], [8, 12], [12, 20], [20, 30], [12, 30], [8, 30], [30, 60], [60, 90], [30, 90]}]';

areas_power = {registroLFP.average_spectrum.area}';

idx_areas_izq = [];
idx_areas_der = [];

for k = 1:length(areas_power)
    area_actual = areas_power{k};
    hemisferio = area_actual(end);
    if strcmp(hemisferio,'L')
        idx_areas_izq = [idx_areas_izq, k];
    elseif strcmp(hemisferio,'R')
        idx_areas_der = [idx_areas_der, k];
    end
end

areas_power_izq = areas_power(idx_areas_izq);
areas_power_der = areas_power(idx_areas_der);

areas_sync_izq = combnk(areas_power(idx_areas_izq),2);
areas_sync_izq = areas_sync_izq(end:-1:1,:);
areas_sync_der = combnk(areas_power(idx_areas_der),2);
areas_sync_der = areas_sync_der(end:-1:1,:);

areas_sync = [areas_sync_izq; areas_sync_der];

idx_areas_sync_izq = [];
idx_areas_sync_der = [];

for k = 1:size(areas_sync,1)
    area_actual = areas_sync{k,1};
    hemisferio = area_actual(end);
    if strcmp(hemisferio,'L')
        idx_areas_sync_izq = [idx_areas_sync_izq, k];
    elseif strcmp(hemisferio,'R')
        idx_areas_sync_der = [idx_areas_sync_der, k];
    end
end

% Eliminacion de variables que no se van a guardar
%clearvars -except registroLFP path name_registro foldername inicio_foldername
clearvars registroLFP

measurementsLFP.register_checked = name_registro;

for i = 1:size(bandas_eval,1)
    for j = 1:length(idx_areas_izq)
        % Izquierda

        measurementsLFP.left.power_band(j).area = areas_power_izq{j}(1:end-1);
        measurementsLFP.left.power_band(j).oscillations(i).band = bandas_eval{i,1};
        measurementsLFP.left.power_band(j).oscillations(i).freq = bandas_eval{i,2};
        measurementsLFP.left.power_band(j).oscillations(i).pre = band_power(idx_areas_izq(j),1,i);
        measurementsLFP.left.power_band(j).oscillations(i).on = band_power(idx_areas_izq(j),2,i);
        measurementsLFP.left.power_band(j).oscillations(i).post = band_power(idx_areas_izq(j),3,i);
        
        measurementsLFP.left.power_band(j).oscillations(i).pre_norm = band_power_norm(idx_areas_izq(j),1,i);
        measurementsLFP.left.power_band(j).oscillations(i).on_norm = band_power_norm(idx_areas_izq(j),2,i);
        measurementsLFP.left.power_band(j).oscillations(i).post_norm = band_power_norm(idx_areas_izq(j),3,i);

        measurementsLFP.left.power_band(j).fractals(i).band = bandas_eval{i,1};
        measurementsLFP.left.power_band(j).fractals(i).freq = bandas_eval{i,2};
        measurementsLFP.left.power_band(j).fractals(i).pre = band_power_fractal(idx_areas_izq(j),1,i);
        measurementsLFP.left.power_band(j).fractals(i).on = band_power_fractal(idx_areas_izq(j),2,i);
        measurementsLFP.left.power_band(j).fractals(i).post = band_power_fractal(idx_areas_izq(j),3,i);
        
        measurementsLFP.left.power_band(j).fractals(i).pre_norm = band_power_fractal_norm(idx_areas_izq(j),1,i);
        measurementsLFP.left.power_band(j).fractals(i).on_norm = band_power_fractal_norm(idx_areas_izq(j),2,i);
        measurementsLFP.left.power_band(j).fractals(i).post_norm = band_power_fractal_norm(idx_areas_izq(j),3,i);

        % Derecha

        measurementsLFP.right.power_band(j).area = areas_power_der{j}(1:end-1);
        measurementsLFP.right.power_band(j).oscillations(i).band = bandas_eval{i,1};
        measurementsLFP.right.power_band(j).oscillations(i).freq = bandas_eval{i,2};
        measurementsLFP.right.power_band(j).oscillations(i).pre = band_power(idx_areas_der(j),1,i);
        measurementsLFP.right.power_band(j).oscillations(i).on = band_power(idx_areas_der(j),2,i);
        measurementsLFP.right.power_band(j).oscillations(i).post = band_power(idx_areas_der(j),3,i);
        
        measurementsLFP.right.power_band(j).oscillations(i).pre_norm = band_power_norm(idx_areas_der(j),1,i);
        measurementsLFP.right.power_band(j).oscillations(i).on_norm = band_power_norm(idx_areas_der(j),2,i);
        measurementsLFP.right.power_band(j).oscillations(i).post_norm = band_power_norm(idx_areas_der(j),3,i);

        measurementsLFP.right.power_band(j).fractals(i).band = bandas_eval{i,1};
        measurementsLFP.right.power_band(j).fractals(i).freq = bandas_eval{i,2};
        measurementsLFP.right.power_band(j).fractals(i).pre = band_power_fractal(idx_areas_der(j),1,i);
        measurementsLFP.right.power_band(j).fractals(i).on = band_power_fractal(idx_areas_der(j),2,i);
        measurementsLFP.right.power_band(j).fractals(i).post = band_power_fractal(idx_areas_der(j),3,i);
        
        measurementsLFP.right.power_band(j).fractals(i).pre_norm = band_power_fractal_norm(idx_areas_der(j),1,i);
        measurementsLFP.right.power_band(j).fractals(i).on_norm = band_power_fractal_norm(idx_areas_der(j),2,i);
        measurementsLFP.right.power_band(j).fractals(i).post_norm = band_power_fractal_norm(idx_areas_der(j),3,i);

    end

    for j = 1:length(idx_areas_sync_izq)

        % Izquierda
        
        measurementsLFP.left.coherence(j).area1 = areas_sync_izq{j,1}(1:end-1);
        measurementsLFP.left.coherence(j).area2 = areas_sync_izq{j,2}(1:end-1);
        measurementsLFP.left.coherence(j).sum_MSC(i).band = bandas_eval{i,1};
        measurementsLFP.left.coherence(j).sum_MSC(i).freq = bandas_eval{i,2};
        measurementsLFP.left.coherence(j).sum_MSC(i).pre = [sum_MSC(idx_areas_sync_izq(j),1,i)];
        measurementsLFP.left.coherence(j).sum_MSC(i).on = [sum_MSC(idx_areas_sync_izq(j),2,i)];
        measurementsLFP.left.coherence(j).sum_MSC(i).post = [sum_MSC(idx_areas_sync_izq(j),3,i)];

        measurementsLFP.left.coherence(j).coupling_strength(i).band = bandas_eval{i,1};
        measurementsLFP.left.coherence(j).coupling_strength(i).freq = bandas_eval{i,2};
        measurementsLFP.left.coherence(j).coupling_strength(i).pre = [coupling_strength(idx_areas_sync_izq(j),1,i)];
        measurementsLFP.left.coherence(j).coupling_strength(i).on = [coupling_strength(idx_areas_sync_izq(j),2,i)];
        measurementsLFP.left.coherence(j).coupling_strength(i).post = [coupling_strength(idx_areas_sync_izq(j),3,i)];

        measurementsLFP.left.coherence(j).delay(i).band = bandas_eval{i,1};
        measurementsLFP.left.coherence(j).delay(i).freq = bandas_eval{i,2};
        measurementsLFP.left.coherence(j).delay(i).pre = [delay(idx_areas_sync_izq(j),1,i)];
        measurementsLFP.left.coherence(j).delay(i).on = [delay(idx_areas_sync_izq(j),2,i)];
        measurementsLFP.left.coherence(j).delay(i).post = [delay(idx_areas_sync_izq(j),3,i)];

        % Derecha

        measurementsLFP.right.coherence(j).area1 = areas_sync_der{j,1}(1:end-1);
        measurementsLFP.right.coherence(j).area2 = areas_sync_der{j,2}(1:end-1);
        measurementsLFP.right.coherence(j).sum_MSC(i).band = bandas_eval{i,1};
        measurementsLFP.right.coherence(j).sum_MSC(i).freq = bandas_eval{i,2};
        measurementsLFP.right.coherence(j).sum_MSC(i).pre = [sum_MSC(idx_areas_sync_der(j),1,i)];
        measurementsLFP.right.coherence(j).sum_MSC(i).on = [sum_MSC(idx_areas_sync_der(j),2,i)];
        measurementsLFP.right.coherence(j).sum_MSC(i).post = [sum_MSC(idx_areas_sync_der(j),3,i)];

        measurementsLFP.right.coherence(j).coupling_strength(i).band = bandas_eval{i,1};
        measurementsLFP.right.coherence(j).coupling_strength(i).freq = bandas_eval{i,2};
        measurementsLFP.right.coherence(j).coupling_strength(i).pre = [coupling_strength(idx_areas_sync_der(j),1,i)];
        measurementsLFP.right.coherence(j).coupling_strength(i).on = [coupling_strength(idx_areas_sync_der(j),2,i)];
        measurementsLFP.right.coherence(j).coupling_strength(i).post = [coupling_strength(idx_areas_sync_der(j),3,i)];

        measurementsLFP.right.coherence(j).delay(i).band = bandas_eval{i,1};
        measurementsLFP.right.coherence(j).delay(i).freq = bandas_eval{i,2};
        measurementsLFP.right.coherence(j).delay(i).pre = [delay(idx_areas_sync_der(j),1,i)];
        measurementsLFP.right.coherence(j).delay(i).on = [delay(idx_areas_sync_der(j),2,i)];
        measurementsLFP.right.coherence(j).delay(i).post = [delay(idx_areas_sync_der(j),3,i)];
    end

end

for j = 1:length(idx_areas_izq)
    
    % Izquierda

    measurementsLFP.left.power_total(j).area = areas_power_izq{j}(1:end-1);
    measurementsLFP.left.power_total(j).oscillations.pre = power_band_total(idx_areas_izq(j),1);
    measurementsLFP.left.power_total(j).oscillations.on = power_band_total(idx_areas_izq(j),2);
    measurementsLFP.left.power_total(j).oscillations.post = power_band_total(idx_areas_izq(j),3);
    
    measurementsLFP.left.power_total(j).oscillations.pre_norm = power_band_total_norm(idx_areas_izq(j),1);
    measurementsLFP.left.power_total(j).oscillations.on_norm = power_band_total_norm(idx_areas_izq(j),2);
    measurementsLFP.left.power_total(j).oscillations.post_norm = power_band_total_norm(idx_areas_izq(j),3);
    
    measurementsLFP.left.power_total(j).fractals.pre = power_fractal_band(idx_areas_izq(j),1);
    measurementsLFP.left.power_total(j).fractals.on = power_fractal_band(idx_areas_izq(j),2);
    measurementsLFP.left.power_total(j).fractals.post = power_fractal_band(idx_areas_izq(j),3);
    
    measurementsLFP.left.power_total(j).fractals.pre_norm = power_fractal_band_norm(idx_areas_izq(j),1);
    measurementsLFP.left.power_total(j).fractals.on_norm = power_fractal_band_norm(idx_areas_izq(j),2);
    measurementsLFP.left.power_total(j).fractals.post_norm = power_fractal_band_norm(idx_areas_izq(j),3);
    
    measurementsLFP.left.power_total(j).beta_exponent.pre = beta_exponent(idx_areas_izq(j),1);
    measurementsLFP.left.power_total(j).beta_exponent.on = beta_exponent(idx_areas_izq(j),2);
    measurementsLFP.left.power_total(j).beta_exponent.post = beta_exponent(idx_areas_izq(j),3);

    % Derecha
    
    measurementsLFP.right.power_total(j).area = areas_power_der{j}(1:end-1);
    measurementsLFP.right.power_total(j).oscillations.pre = power_band_total(idx_areas_der(j),1);
    measurementsLFP.right.power_total(j).oscillations.on = power_band_total(idx_areas_der(j),2);
    measurementsLFP.right.power_total(j).oscillations.post = power_band_total(idx_areas_der(j),3);
    
    measurementsLFP.right.power_total(j).oscillations.pre_norm = power_band_total_norm(idx_areas_der(j),1);
    measurementsLFP.right.power_total(j).oscillations.on_norm = power_band_total_norm(idx_areas_der(j),2);
    measurementsLFP.right.power_total(j).oscillations.post_norm = power_band_total_norm(idx_areas_der(j),3);
    
    measurementsLFP.right.power_total(j).fractals.pre = power_fractal_band(idx_areas_der(j),1);
    measurementsLFP.right.power_total(j).fractals.on = power_fractal_band(idx_areas_der(j),2);
    measurementsLFP.right.power_total(j).fractals.post = power_fractal_band(idx_areas_der(j),3);
    
    measurementsLFP.right.power_total(j).fractals.pre_norm = power_fractal_band_norm(idx_areas_der(j),1);
    measurementsLFP.right.power_total(j).fractals.on_norm = power_fractal_band_norm(idx_areas_der(j),2);
    measurementsLFP.right.power_total(j).fractals.post_norm = power_fractal_band_norm(idx_areas_der(j),3);
    
    measurementsLFP.right.power_total(j).beta_exponent.pre = beta_exponent(idx_areas_der(j),1);
    measurementsLFP.right.power_total(j).beta_exponent.on = beta_exponent(idx_areas_der(j),2);
    measurementsLFP.right.power_total(j).beta_exponent.post = beta_exponent(idx_areas_der(j),3);
       
end



% Eliminacion de variables que no se van a guardar
clearvars -except measurementsLFP path name_registro foldername inicio_foldername

% Guardar matrices en .mat
path_name_registro = [inicio_foldername,'Images',foldername,'measurements_',name_registro];

disp(['It was saved in: ',path_name_registro])

% Descomentar para guardar
save(path_name_registro,'-v7.3')
