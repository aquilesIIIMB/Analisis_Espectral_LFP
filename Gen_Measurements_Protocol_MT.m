% Calcular metrica del protocolo
%% Calcular datos del protoclo
% Eliminacion de variables que no se utilizaran
clearvars -except registroLFP path name_registro foldername inicio_foldername protocoloLFP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main 
% Guardar las imgenges del protocolo? 
disp(' ')
while 1
    try
        save_protocol = input('Deseas guardar las imagenes del protocolo?[Type si or no]:  ','s');
    catch
        save_protocol = 'no';
    end

    if strcmp(save_protocol, 'si') 
        fprintf('\nSe almacenaran las imagenes del protocolo\n\n');
        save_protocol = 1;
        break
    elseif strcmp(save_protocol, 'no') 
        fprintf('\nNO se almacenaran las imagenes del protocolo\n\n');
        save_protocol = 0;
        break
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definir que area es la lesionada segun potencia en beta del PSD
power_measurements_MT(registroLFP, [8, 30], true, false, path);

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

[C,~,~] = unique({registroLFP.area.name},'stable');

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
    protocoloLFP = initialization_structure_protocol(registroLFP, [], protocolo_name, [], area_lesionada, area_nolesionada, true, true);
else
    protocoloLFP = initialization_structure_protocol(registroLFP, protocoloLFP, protocolo_name, [], area_lesionada, area_nolesionada, true, true);
end
  
    
if ~strcmp(protocoloLFP.name, protocolo_name)
    error('Annadiendo registro a protoclo de otro nombre')
end

disp('Annadiendo informacion al protocolo')

% Guardar el nombre del regsitro a cargar       

% Calculo de las medidas
change_band_power_delta = power_measurements_MT(registroLFP, [1, 4], false, false, path);
[sum_MSC_delta, coupling_strength_delta, delay_delta] = coherence_measurements(registroLFP, [1, 4], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_delta, sum_MSC_delta, coupling_strength_delta, delay_delta, [1, 4], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

change_band_power_theta = power_measurements_MT(registroLFP, [4, 8], false, false, path);
[sum_MSC_theta, coupling_strength_theta, delay_theta] = coherence_measurements(registroLFP, [4, 8], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_theta, sum_MSC_theta, coupling_strength_theta, delay_theta, [4, 8], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

change_band_power_alpha = power_measurements_MT(registroLFP, [8, 12], false, false, path);
[sum_MSC_alpha, coupling_strength_alpha, delay_alpha] = coherence_measurements(registroLFP, [8, 12], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_alpha, sum_MSC_alpha, coupling_strength_alpha, delay_alpha, [8, 12], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

change_band_power_beta_low = power_measurements_MT(registroLFP, [12, 20], false, false, path);
[sum_MSC_beta_low, coupling_strength_beta_low, delay_beta_low] = coherence_measurements(registroLFP, [12, 20], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_beta_low, sum_MSC_beta_low, coupling_strength_beta_low, delay_beta_low, [12, 20], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

change_band_power_beta_high = power_measurements_MT(registroLFP, [20, 30], false, false, path);
[sum_MSC_beta_high, coupling_strength_beta_high, delay_beta_high] = coherence_measurements(registroLFP, [20, 30], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_beta_high, sum_MSC_beta_high, coupling_strength_beta_high, delay_beta_high, [20, 30], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

change_band_power_beta = power_measurements_MT(registroLFP, [12, 30], false, false, path);
[sum_MSC_beta, coupling_strength_beta, delay_beta] = coherence_measurements(registroLFP, [12, 30], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_beta, sum_MSC_beta, coupling_strength_beta, delay_beta, [12, 30], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

change_band_power_beta_parkinson = power_measurements_MT(registroLFP, [8, 30], false, false, path);
[sum_MSC_beta_parkinson, coupling_strength_beta_parkinson, delay_beta_parkinson] = coherence_measurements(registroLFP, [8, 30], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_beta_parkinson, sum_MSC_beta_parkinson, coupling_strength_beta_parkinson, delay_beta_parkinson, [8, 30], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

change_band_power_gamma_low = power_measurements_MT(registroLFP, [30, 60], false, false, path);
[sum_MSC_gamma_low, coupling_strength_gamma_low, delay_gamma_low] = coherence_measurements(registroLFP, [30, 60], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_gamma_low, sum_MSC_gamma_low, coupling_strength_gamma_low, delay_gamma_low, [30, 60], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

change_band_power_gamma_high = power_measurements_MT(registroLFP, [60, 90], false, false, path);
[sum_MSC_gamma_high, coupling_strength_gamma_high, delay_gamma_high] = coherence_measurements(registroLFP, [60, 90], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_gamma_high, sum_MSC_gamma_high, coupling_strength_gamma_high, delay_gamma_high, [60, 90], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

change_band_power_gamma = power_measurements_MT(registroLFP, [30, 90], false, false, path);
[sum_MSC_gamma, coupling_strength_gamma, delay_gamma] = coherence_measurements(registroLFP, [30, 90], [false, false, false], false, path);
protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power_gamma, sum_MSC_gamma, coupling_strength_gamma, delay_gamma, [30, 90], idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada);

% Analisis global
protocoloLFP = protocol_statistics(protocoloLFP, path, save_protocol);

if save_protocol

    % Guardar matrices en .mat
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
    path_name_registro = [inicio_foldername,'Images',foldername,'Protocol',slash_system,'protocol_',foldername(2:end-1)];

    % Eliminacion de variables que no se utilizaran
    clearvars -except path name_registro foldername inicio_foldername protocoloLFP path_name_registro

    % Descomentar para guardar
    save(path_name_registro,'-v7.3')
else    
    % Eliminacion de variables que no se utilizaran
    clearvars -except path name_registro foldername inicio_foldername protocoloLFP path_name_registro

end

