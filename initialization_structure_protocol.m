% Inicializacion de la estructura
function protocoloLFP = initialization_structure_protocol(registroLFP, protocoloLFP, protocolo_name, idx_update_reg, area_lesionada, area_nolesionada, ini_registro, ini_global)

% Estructura de las medidas espectrales
if isempty(protocoloLFP)
    ini_registro = true;
    ini_global = true;
    protocoloLFP.name = protocolo_name;
    protocoloLFP.register_checked.name = [];
end

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

idx_sameregister = [];

% Guardar el nombre del regsitro a cargar
if isempty(idx_update_reg)
    if isempty([protocoloLFP.register_checked.name])
        idx_registerName = 0;
    else
        idx_registerName = length(protocoloLFP.register_checked);
        
        % Si el registro esta en blanco, pero esta guardada su estructura
        if isempty(protocoloLFP.register_checked(idx_registerName).name)
            idx_registerName = idx_registerName - 1;

        else
            idx_sameregister = find(strcmp(string({protocoloLFP.register_checked.name}), registroLFP.name));
            % Se actualiza el registro si ya esta el nombre
            if ~isempty(idx_sameregister)    
                idx_registerName = idx_sameregister(end) - 1;
            end

        end  
    end
    
else
    idx_registerName = idx_update_reg - 1;
end

% Inicio estructura del registro
if ini_registro
    disp('Inicializando la estructura del protocolo para un registro')
    
    % Estructura 
    if isempty(idx_sameregister)    
        protocoloLFP.register_checked(idx_registerName+1).name = [];
    end
    
    [protocoloLFP.injured(idx_registerName+1).spectral_record.area] = deal([]);
    [protocoloLFP.uninjured(idx_registerName+1).spectral_record.area] = deal([]);

    for m = 1:length(C)

        % Area
        area = C{m};

        % Almacenar los datos
        if strcmp(area(end),area_lesionada)
            if isempty([protocoloLFP.injured(idx_registerName+1).spectral_record.area])
                idx_injured = 0;
            %else
            %    idx_injured = length(protocoloLFP.injured(idx_registerName+1).spectral_record);
            end

            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).area = area(1:end-1);

            %protocoloLFP.injured(persona).spectral_record(idx_injured+1).change_band_power(tipo_de_banda).band = [];

            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(1).band = 'delta';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(1).range = [1, 4];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(1).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(1).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(1).post = [];
            
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(2).band = 'theta';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(2).range = [4, 8];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(2).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(2).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(2).post = [];
            
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(3).band = 'alpha';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(3).range = [8, 12];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(3).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(3).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(3).post = [];
            
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(4).band = 'beta_low';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(4).range = [12, 20];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(4).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(4).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(4).post = [];
            
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(5).band = 'beta_high';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(5).range = [20, 30];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(5).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(5).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(5).post = [];
            
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(6).band = 'beta';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(6).range = [12, 30];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(6).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(6).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(6).post = [];
           
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(7).band = 'beta_parkinson';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(7).range = [8, 30];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(7).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(7).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(7).post = [];
            
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(8).band = 'gamma_low';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(8).range = [30, 60];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(8).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(8).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(8).post = [];
            
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(9).band = 'gamma_high';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(9).range = [60, 90];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(9).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(9).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(9).post = [];
           
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(10).band = 'gamma';
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(10).range = [30, 90];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(10).pre = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(10).on = [];
            protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(10).post = [];
            
            idx_injured = idx_injured + 1;
            

        elseif strcmp(area(end),area_nolesionada)
            if isempty([protocoloLFP.uninjured(idx_registerName+1).spectral_record.area])
                idx_uninjured = 0;
            %else
            %    idx_uninjured = length(protocoloLFP.uninjured(idx_registerName+1).spectral_record);
            end

            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).area = area(1:end-1);
            
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(1).band = 'delta';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(1).range = [1, 4];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(1).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(1).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(1).post = [];
            
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(2).band = 'theta';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(2).range = [4, 8];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(2).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(2).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(2).post = [];
            
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(3).band = 'alpha';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(3).range = [8, 12];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(3).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(3).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(3).post = [];
            
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(4).band = 'beta_low';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(4).range = [12, 20];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(4).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(4).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(4).post = [];
            
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(5).band = 'beta_high';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(5).range = [20, 30];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(5).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(5).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(5).post = [];
            
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(6).band = 'beta';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(6).range = [12, 30];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(6).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(6).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(6).post = [];
          
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(7).band = 'beta_parkinson';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(7).range = [8, 30];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(7).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(7).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(7).post = [];
            
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(8).band = 'gamma_low';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(8).range = [30, 60];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(8).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(8).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(8).post = [];
            
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(9).band = 'gamma_high';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(9).range = [60, 90];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(9).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(9).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(9).post = [];
            
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(10).band = 'gamma';
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(10).range = [30, 90];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(10).pre = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(10).on = [];
            protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(10).post = [];
            
            idx_uninjured = idx_uninjured + 1;

        else
            disp('Esta area no es lesionada ni no lesionada')

        end

    end


    idx_coherence_injured = combntns(idx_areas_injured,2);
    idx_coherence_uninjured = combntns(idx_areas_uninjured,2);

    % Estructura de las medidas de coherencia
    for p = 1:size(idx_coherence_injured,1)

        area_actual_1 = char(registroLFP.average_sync{idx_coherence_injured(p,1),idx_coherence_injured(p,2)}.names(1));
        area_actual_2 = char(registroLFP.average_sync{idx_coherence_injured(p,1),idx_coherence_injured(p,2)}.names(2));
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).area1 = area_actual_1(1:end-1);
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).area2 = area_actual_2(1:end-1);
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(1).band = 'delta';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(1).range = [1, 4];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(1).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(1).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(1).post = [];
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(2).band = 'theta';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(2).range = [4, 8];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(2).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(2).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(2).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(3).band = 'alpha';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(3).range = [8, 12];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(3).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(3).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(3).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(4).band = 'beta_low';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(4).range = [12, 20];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(4).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(4).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(4).post = [];
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(5).band = 'beta_high';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(5).range = [20, 30];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(5).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(5).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(5).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(6).band = 'beta';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(6).range = [12, 30];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(6).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(6).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(6).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(7).band = 'beta_parkinson';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(7).range = [8, 30];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(7).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(7).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(7).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(8).band = 'gamma_low';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(8).range = [30, 60];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(8).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(8).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(8).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(9).band = 'gamma_high';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(9).range = [60, 90];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(9).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(9).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(9).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(10).band = 'gamma';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(10).range = [30, 90];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(10).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(10).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(10).post = [];
        
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(1).band = 'delta';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(1).range = [1, 4];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(1).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(1).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(1).post = [];
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(2).band = 'theta';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(2).range = [4, 8];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(2).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(2).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(2).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(3).band = 'alpha';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(3).range = [8, 12];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(3).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(3).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(3).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(4).band = 'beta_low';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(4).range = [12, 20];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(4).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(4).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(4).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(5).band = 'beta_high';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(5).range = [20, 30];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(5).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(5).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(5).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(6).band = 'beta';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(6).range = [12, 30];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(6).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(6).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(6).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(7).band = 'beta_parkinson';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(7).range = [8, 30];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(7).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(7).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(7).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(8).band = 'gamma_low';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(8).range = [30, 60];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(8).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(8).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(8).post = [];
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(9).band = 'gamma_high';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(9).range = [60, 90];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(9).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(9).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(9).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(10).band = 'gamma';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(10).range = [30, 90];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(10).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(10).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(10).post = [];
        
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(1).band = 'delta';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(1).range = [1, 4];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(1).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(1).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(1).post = [];
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(2).band = 'theta';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(2).range = [4, 8];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(2).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(2).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(2).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(3).band = 'alpha';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(3).range = [8, 12];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(3).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(3).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(3).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(4).band = 'beta_low';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(4).range = [12, 20];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(4).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(4).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(4).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(5).band = 'beta_high';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(5).range = [20, 30];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(5).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(5).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(5).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(6).band = 'beta';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(6).range = [12, 30];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(6).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(6).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(6).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(7).band = 'beta_parkinson';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(7).range = [8, 30];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(7).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(7).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(7).post = [];
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(8).band = 'gamma_low';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(8).range = [30, 60];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(8).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(8).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(8).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(9).band = 'gamma_high';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(9).range = [60, 90];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(9).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(9).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(9).post = [];

        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(10).band = 'gamma';
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(10).range = [30, 90];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(10).pre = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(10).on = [];
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(10).post = [];       

    end

    % Estructura de las medidas de coherencia
    for p = 1:size(idx_coherence_uninjured,1)            

        area_actual_1 = char(registroLFP.average_sync{idx_coherence_uninjured(p,1),idx_coherence_uninjured(p,2)}.names(1));
        area_actual_2 = char(registroLFP.average_sync{idx_coherence_uninjured(p,1),idx_coherence_uninjured(p,2)}.names(2));
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).area1 = area_actual_1(1:end-1);
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).area2 = area_actual_2(1:end-1);
             
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(1).band = 'delta';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(1).range = [1, 4];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(1).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(1).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(1).post = [];
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(2).band = 'theta';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(2).range = [4, 8];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(2).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(2).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(2).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(3).band = 'alpha';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(3).range = [8, 12];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(3).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(3).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(3).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(4).band = 'beta_low';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(4).range = [12, 20];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(4).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(4).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(4).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(5).band = 'beta_high';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(5).range = [20, 30];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(5).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(5).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(5).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(6).band = 'beta';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(6).range = [12, 30];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(6).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(6).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(6).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(7).band = 'beta_parkinson';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(7).range = [8, 30];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(7).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(7).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(7).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(8).band = 'gamma_low';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(8).range = [30, 60];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(8).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(8).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(8).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(9).band = 'gamma_high';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(9).range = [60, 90];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(9).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(9).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(9).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(10).band = 'gamma';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(10).range = [30, 90];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(10).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(10).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(10).post = [];
        
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(1).band = 'delta';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(1).range = [1, 4];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(1).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(1).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(1).post = [];
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(2).band = 'theta';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(2).range = [4, 8];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(2).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(2).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(2).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(3).band = 'alpha';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(3).range = [8, 12];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(3).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(3).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(3).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(4).band = 'beta_low';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(4).range = [12, 20];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(4).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(4).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(4).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(5).band = 'beta_high';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(5).range = [20, 30];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(5).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(5).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(5).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(6).band = 'beta';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(6).range = [12, 30];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(6).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(6).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(6).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(7).band = 'beta_parkinson';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(7).range = [8, 30];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(7).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(7).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(7).post = [];
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(8).band = 'gamma_low';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(8).range = [30, 60];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(8).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(8).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(8).post = [];
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(9).band = 'gamma_high';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(9).range = [60, 90];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(9).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(9).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(9).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(10).band = 'gamma';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(10).range = [30, 90];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(10).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(10).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(10).post = [];
        
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(1).band = 'delta';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(1).range = [1, 4];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(1).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(1).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(1).post = [];
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(2).band = 'theta';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(2).range = [4, 8];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(2).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(2).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(2).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(3).band = 'alpha';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(3).range = [8, 12];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(3).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(3).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(3).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(4).band = 'beta_low';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(4).range = [12, 20];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(4).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(4).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(4).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(5).band = 'beta_high';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(5).range = [20, 30];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(5).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(5).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(5).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(6).band = 'beta';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(6).range = [12, 30];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(6).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(6).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(6).post = [];
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(7).band = 'beta_parkinson';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(7).range = [8, 30];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(7).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(7).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(7).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(8).band = 'gamma_low';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(8).range = [30, 60];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(8).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(8).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(8).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(9).band = 'gamma_high';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(9).range = [60, 90];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(9).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(9).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(9).post = [];

        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(10).band = 'gamma';
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(10).range = [30, 90];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(10).pre = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(10).on = [];
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(10).post = [];     
        
    end
    
end


% Inicio estructura global
if ini_global
    
    try
        protocoloLFP.injured_global = rmfield(protocoloLFP.injured_global, 'spectral');
        protocoloLFP.injured_global = rmfield(protocoloLFP.injured_global, 'coherence');
        protocoloLFP.uninjured_global = rmfield(protocoloLFP.injured_global, 'spectral');
        protocoloLFP.uninjured_global = rmfield(protocoloLFP.injured_global, 'coherence');
    end

    disp('Inicializando la estructura del protocolo para un registro')
    
    % Estructura    
    [protocoloLFP.injured_global.spectral.area] = deal([]);
    [protocoloLFP.uninjured_global.spectral.area] = deal([]);
    
    for m = 1:length(C)

        % Area
        area = C{m};

        % Almacenar los datos
        if strcmp(area(end),area_lesionada)
            if isempty([protocoloLFP.injured_global.spectral.area])
                idx_injured_global = 0;
            else
                idx_injured_global = length(protocoloLFP.injured_global.spectral);
            end

            protocoloLFP.injured_global.spectral(idx_injured_global+1).area = area(1:end-1);

            %protocoloLFP.injured_global(persona).spectral(idx_injured_global+1).change_band_power(tipo_de_banda).band = [];

            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).band = 'delta';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).range = [1, 4];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(1).post_std = [];
            
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).band = 'theta';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).range = [4, 8];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(2).post_std = [];
            
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).band = 'alpha';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).range = [8, 12];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(3).post_std = [];
            
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).band = 'beta_low';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).range = [12, 20];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(4).post_std = [];
            
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).band = 'beta_high';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).range = [20, 30];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(5).post_std = [];
           
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).band = 'beta';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).range = [12, 30];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(6).post_std = [];
          
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).band = 'beta_parkinson';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).range = [8, 30];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(7).post_std = [];
            
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).band = 'gamma_low';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).range = [30, 60];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(8).post_std = [];
            
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).band = 'gamma_high';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).range = [60, 90];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(9).post_std = [];
            
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).band = 'gamma';
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).range = [30, 90];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).pre = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).pre_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).pre_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).on = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).on_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).on_std = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).post = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).post_mean = [];
            protocoloLFP.injured_global.spectral(idx_injured_global+1).change_band_power(10).post_std = [];
            

        elseif strcmp(area(end),area_nolesionada)
            if isempty([protocoloLFP.uninjured_global.spectral.area])
                idx_uninjured_global = 0;
            else
                idx_uninjured_global = length(protocoloLFP.uninjured_global.spectral);
            end

            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).area = area(1:end-1);
            
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).band = 'delta';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).range = [1, 4];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(1).post_std = [];
            
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).band = 'theta';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).range = [4, 8];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(2).post_std = [];
            
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).band = 'alpha';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).range = [8, 12];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(3).post_std = [];
            
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).band = 'beta_low';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).range = [12, 20];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(4).post_std = [];
            
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).band = 'beta_high';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).range = [20, 30];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(5).post_std = [];
            
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).band = 'beta';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).range = [12, 30];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(6).post_std = [];
           
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).band = 'beta_parkinson';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).range = [8, 30];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(7).post_std = [];
            
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).band = 'gamma_low';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).range = [30, 60];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(8).post_std = [];
            
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).band = 'gamma_high';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).range = [60, 90];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(9).post_std = [];
            
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).band = 'gamma';
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).range = [30, 90];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).pre = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).pre_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).pre_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).on = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).on_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).on_std = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).post = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).post_mean = [];
            protocoloLFP.uninjured_global.spectral(idx_uninjured_global+1).change_band_power(10).post_std = [];

        else
            disp('Esta area no es lesionada ni no lesionada')

        end

    end


    idx_coherence_injured_global = combntns(idx_areas_injured,2);
    idx_coherence_uninjured_global = combntns(idx_areas_uninjured,2);

    % Estructura de las medidas de coherencia
    for p = 1:size(idx_coherence_injured_global,1)

        area_actual_1 = char(registroLFP.average_sync{idx_coherence_injured_global(p,1),idx_coherence_injured_global(p,2)}.names(1));
        area_actual_2 = char(registroLFP.average_sync{idx_coherence_injured_global(p,1),idx_coherence_injured_global(p,2)}.names(2));
        protocoloLFP.injured_global.coherence(p).area1 = area_actual_1(1:end-1);
        protocoloLFP.injured_global.coherence(p).area2 = area_actual_2(1:end-1);
        
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).band = 'delta';
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).range = [1, 4];
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(1).post_std = [];
        
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).band = 'theta';
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).range = [4, 8];
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(2).post_std = [];

        protocoloLFP.injured_global.coherence(p).sum_MSC(3).band = 'alpha';
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).range = [8, 12];
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(3).post_std = [];

        protocoloLFP.injured_global.coherence(p).sum_MSC(4).band = 'beta_low';
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).range = [12, 20];
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(4).post_std = [];

        protocoloLFP.injured_global.coherence(p).sum_MSC(5).band = 'beta_high';
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).range = [20, 30];
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(5).post_std = [];

        protocoloLFP.injured_global.coherence(p).sum_MSC(6).band = 'beta';
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).range = [12, 30];
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(6).post_std = [];

        protocoloLFP.injured_global.coherence(p).sum_MSC(7).band = 'beta_parkinson';
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).range = [8, 30];
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(7).post_std = [];

        protocoloLFP.injured_global.coherence(p).sum_MSC(8).band = 'gamma_low';
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).range = [30, 60];
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(8).post_std = [];
        
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).band = 'gamma_high';
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).range = [60, 90];
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(9).post_std = [];

        protocoloLFP.injured_global.coherence(p).sum_MSC(10).band = 'gamma';
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).range = [30, 90];
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).pre = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).pre_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).on = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).on_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).on_std = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).post = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).post_mean = [];
        protocoloLFP.injured_global.coherence(p).sum_MSC(10).post_std = [];
        
        
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).band = 'delta';
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).range = [1, 4];
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(1).post_std = [];
        
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).band = 'theta';
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).range = [4, 8];
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(2).post_std = [];

        protocoloLFP.injured_global.coherence(p).coupling_strength(3).band = 'alpha';
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).range = [8, 12];
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(3).post_std = [];

        protocoloLFP.injured_global.coherence(p).coupling_strength(4).band = 'beta_low';
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).range = [12, 20];
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(4).post_std = [];

        protocoloLFP.injured_global.coherence(p).coupling_strength(5).band = 'beta_high';
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).range = [20, 30];
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(5).post_std = [];

        protocoloLFP.injured_global.coherence(p).coupling_strength(6).band = 'beta';
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).range = [12, 30];
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(6).post_std = [];

        protocoloLFP.injured_global.coherence(p).coupling_strength(7).band = 'beta_parkinson';
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).range = [8, 30];
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(7).post_std = [];

        protocoloLFP.injured_global.coherence(p).coupling_strength(8).band = 'gamma_low';
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).range = [30, 60];
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(8).post_std = [];

        protocoloLFP.injured_global.coherence(p).coupling_strength(9).band = 'gamma_high';
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).range = [60, 90];
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(9).post_std = [];

        protocoloLFP.injured_global.coherence(p).coupling_strength(10).band = 'gamma';
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).range = [30, 90];
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).pre = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).pre_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).on = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).on_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).on_std = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).post = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).post_mean = [];
        protocoloLFP.injured_global.coherence(p).coupling_strength(10).post_std = [];
              
        
        protocoloLFP.injured_global.coherence(p).delay(1).band = 'delta';
        protocoloLFP.injured_global.coherence(p).delay(1).range = [1, 4];
        protocoloLFP.injured_global.coherence(p).delay(1).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(1).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(1).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(1).on = [];
        protocoloLFP.injured_global.coherence(p).delay(1).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(1).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(1).post = [];
        protocoloLFP.injured_global.coherence(p).delay(1).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(1).post_std = [];
        
        protocoloLFP.injured_global.coherence(p).delay(2).band = 'theta';
        protocoloLFP.injured_global.coherence(p).delay(2).range = [4, 8];
        protocoloLFP.injured_global.coherence(p).delay(2).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(2).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(2).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(2).on = [];
        protocoloLFP.injured_global.coherence(p).delay(2).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(2).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(2).post = [];
        protocoloLFP.injured_global.coherence(p).delay(2).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(2).post_std = [];

        protocoloLFP.injured_global.coherence(p).delay(3).band = 'alpha';
        protocoloLFP.injured_global.coherence(p).delay(3).range = [8, 12];
        protocoloLFP.injured_global.coherence(p).delay(3).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(3).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(3).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(3).on = [];
        protocoloLFP.injured_global.coherence(p).delay(3).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(3).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(3).post = [];
        protocoloLFP.injured_global.coherence(p).delay(3).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(3).post_std = [];

        protocoloLFP.injured_global.coherence(p).delay(4).band = 'beta_low';
        protocoloLFP.injured_global.coherence(p).delay(4).range = [12, 20];
        protocoloLFP.injured_global.coherence(p).delay(4).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(4).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(4).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(4).on = [];
        protocoloLFP.injured_global.coherence(p).delay(4).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(4).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(4).post = [];
        protocoloLFP.injured_global.coherence(p).delay(4).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(4).post_std = [];

        protocoloLFP.injured_global.coherence(p).delay(5).band = 'beta_high';
        protocoloLFP.injured_global.coherence(p).delay(5).range = [20, 30];
        protocoloLFP.injured_global.coherence(p).delay(5).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(5).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(5).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(5).on = [];
        protocoloLFP.injured_global.coherence(p).delay(5).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(5).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(5).post = [];
        protocoloLFP.injured_global.coherence(p).delay(5).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(5).post_std = [];

        protocoloLFP.injured_global.coherence(p).delay(6).band = 'beta';
        protocoloLFP.injured_global.coherence(p).delay(6).range = [12, 30];
        protocoloLFP.injured_global.coherence(p).delay(6).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(6).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(6).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(6).on = [];
        protocoloLFP.injured_global.coherence(p).delay(6).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(6).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(6).post = [];
        protocoloLFP.injured_global.coherence(p).delay(6).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(6).post_std = [];

        protocoloLFP.injured_global.coherence(p).delay(7).band = 'beta_parkinson';
        protocoloLFP.injured_global.coherence(p).delay(7).range = [8, 30];
        protocoloLFP.injured_global.coherence(p).delay(7).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(7).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(7).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(7).on = [];
        protocoloLFP.injured_global.coherence(p).delay(7).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(7).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(7).post = [];
        protocoloLFP.injured_global.coherence(p).delay(7).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(7).post_std = [];

        protocoloLFP.injured_global.coherence(p).delay(8).band = 'gamma_low';
        protocoloLFP.injured_global.coherence(p).delay(8).range = [30, 60];
        protocoloLFP.injured_global.coherence(p).delay(8).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(8).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(8).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(8).on = [];
        protocoloLFP.injured_global.coherence(p).delay(8).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(8).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(8).post = [];
        protocoloLFP.injured_global.coherence(p).delay(8).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(8).post_std = [];

        protocoloLFP.injured_global.coherence(p).delay(9).band = 'gamma_high';
        protocoloLFP.injured_global.coherence(p).delay(9).range = [60, 90];
        protocoloLFP.injured_global.coherence(p).delay(9).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(9).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(9).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(9).on = [];
        protocoloLFP.injured_global.coherence(p).delay(9).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(9).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(9).post = [];
        protocoloLFP.injured_global.coherence(p).delay(9).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(9).post_std = [];

        protocoloLFP.injured_global.coherence(p).delay(10).band = 'gamma';
        protocoloLFP.injured_global.coherence(p).delay(10).range = [30, 90];
        protocoloLFP.injured_global.coherence(p).delay(10).pre = [];
        protocoloLFP.injured_global.coherence(p).delay(10).pre_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(10).pre_std = [];
        protocoloLFP.injured_global.coherence(p).delay(10).on = [];
        protocoloLFP.injured_global.coherence(p).delay(10).on_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(10).on_std = [];
        protocoloLFP.injured_global.coherence(p).delay(10).post = [];
        protocoloLFP.injured_global.coherence(p).delay(10).post_mean = [];
        protocoloLFP.injured_global.coherence(p).delay(10).post_std = [];
              

    end

    % Estructura de las medidas de coherencia
    for p = 1:size(idx_coherence_uninjured_global,1)            

        area_actual_1 = char(registroLFP.average_sync{idx_coherence_uninjured_global(p,1),idx_coherence_uninjured_global(p,2)}.names(1));
        area_actual_2 = char(registroLFP.average_sync{idx_coherence_uninjured_global(p,1),idx_coherence_uninjured_global(p,2)}.names(2));
        protocoloLFP.uninjured_global.coherence(p).area1 = area_actual_1(1:end-1);
        protocoloLFP.uninjured_global.coherence(p).area2 = area_actual_2(1:end-1);        
        
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).band = 'delta';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).range = [1, 4];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(1).post_std = [];
        
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).band = 'theta';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).range = [4, 8];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(2).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).band = 'alpha';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).range = [8, 12];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(3).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).band = 'beta_low';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).range = [12, 20];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(4).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).band = 'beta_high';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).range = [20, 30];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(5).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).band = 'beta';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).range = [12, 30];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(6).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).band = 'beta_parkinson';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).range = [8, 30];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(7).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).band = 'gamma_low';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).range = [30, 60];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(8).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).band = 'gamma_high';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).range = [60, 90];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(9).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).band = 'gamma';
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).range = [30, 90];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).pre = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).on = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).post = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).sum_MSC(10).post_std = [];
        
        
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).band = 'delta';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).range = [1, 4];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(1).post_std = [];
        
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).band = 'theta';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).range = [4, 8];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(2).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).band = 'alpha';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).range = [8, 12];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(3).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).band = 'beta_low';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).range = [12, 20];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(4).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).band = 'beta_high';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).range = [20, 30];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(5).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).band = 'beta';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).range = [12, 30];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(6).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).band = 'beta_parkinson';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).range = [8, 30];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(7).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).band = 'gamma_low';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).range = [30, 60];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(8).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).band = 'gamma_high';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).range = [60, 90];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(9).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).band = 'gamma';
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).range = [30, 90];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).pre = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).on = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).post = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).coupling_strength(10).post_std = [];
              
        
        protocoloLFP.uninjured_global.coherence(p).delay(1).band = 'delta';
        protocoloLFP.uninjured_global.coherence(p).delay(1).range = [1, 4];
        protocoloLFP.uninjured_global.coherence(p).delay(1).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(1).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(1).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(1).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(1).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(1).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(1).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(1).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(1).post_std = [];
        
        protocoloLFP.uninjured_global.coherence(p).delay(2).band = 'theta';
        protocoloLFP.uninjured_global.coherence(p).delay(2).range = [4, 8];
        protocoloLFP.uninjured_global.coherence(p).delay(2).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(2).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(2).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(2).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(2).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(2).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(2).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(2).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(2).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).delay(3).band = 'alpha';
        protocoloLFP.uninjured_global.coherence(p).delay(3).range = [8, 12];
        protocoloLFP.uninjured_global.coherence(p).delay(3).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(3).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(3).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(3).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(3).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(3).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(3).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(3).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(3).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).delay(4).band = 'beta_low';
        protocoloLFP.uninjured_global.coherence(p).delay(4).range = [12, 20];
        protocoloLFP.uninjured_global.coherence(p).delay(4).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(4).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(4).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(4).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(4).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(4).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(4).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(4).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(4).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).delay(5).band = 'beta_high';
        protocoloLFP.uninjured_global.coherence(p).delay(5).range = [20, 30];
        protocoloLFP.uninjured_global.coherence(p).delay(5).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(5).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(5).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(5).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(5).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(5).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(5).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(5).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(5).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).delay(6).band = 'beta';
        protocoloLFP.uninjured_global.coherence(p).delay(6).range = [12, 30];
        protocoloLFP.uninjured_global.coherence(p).delay(6).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(6).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(6).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(6).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(6).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(6).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(6).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(6).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(6).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).delay(7).band = 'beta_parkinson';
        protocoloLFP.uninjured_global.coherence(p).delay(7).range = [8, 30];
        protocoloLFP.uninjured_global.coherence(p).delay(7).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(7).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(7).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(7).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(7).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(7).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(7).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(7).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(7).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).delay(8).band = 'gamma_low';
        protocoloLFP.uninjured_global.coherence(p).delay(8).range = [30, 60];
        protocoloLFP.uninjured_global.coherence(p).delay(8).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(8).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(8).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(8).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(8).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(8).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(8).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(8).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(8).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).delay(9).band = 'gamma_high';
        protocoloLFP.uninjured_global.coherence(p).delay(9).range = [60, 90];
        protocoloLFP.uninjured_global.coherence(p).delay(9).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(9).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(9).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(9).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(9).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(9).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(9).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(9).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(9).post_std = [];

        protocoloLFP.uninjured_global.coherence(p).delay(10).band = 'gamma';
        protocoloLFP.uninjured_global.coherence(p).delay(10).range = [30, 90];
        protocoloLFP.uninjured_global.coherence(p).delay(10).pre = [];
        protocoloLFP.uninjured_global.coherence(p).delay(10).pre_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(10).pre_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(10).on = [];
        protocoloLFP.uninjured_global.coherence(p).delay(10).on_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(10).on_std = [];
        protocoloLFP.uninjured_global.coherence(p).delay(10).post = [];
        protocoloLFP.uninjured_global.coherence(p).delay(10).post_mean = [];
        protocoloLFP.uninjured_global.coherence(p).delay(10).post_std = [];
        

    end
    
end
