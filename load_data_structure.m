function protocoloLFP = load_data_structure(registroLFP, protocoloLFP, change_band_power, sum_MSC, coupling_strength, delay, band, idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada)

[C,~,~] = unique({registroLFP.area.name},'stable');

% Guardar el nombre del regsitro a cargar
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

% Actualizacion si el registro tiene el mismo nombre
%%%% Ver que si el nombre es vacio, rellenar esos datos y buscar si esta en
%%%% en el protocolo para actualzarlo
%if ~isempty(protocoloLFP.register_checked)
%    idx_sameregister = find(strcmp(string({protocoloLFP.register_checked.name}), registroLFP.name));

%    if ~isempty(idx_sameregister)    
%        idx_registerName = idx_sameregister(end) - 1;
%    end
    
%end
    
protocoloLFP.register_checked(idx_registerName+1).name = registroLFP.name;            

idx_injured = 0;
idx_uninjured = 0;

range_bands = reshape([protocoloLFP.injured(1).spectral_record(1).change_band_power.range],2,[])';
idx_band = find(range_bands(:,1) == band(1) & range_bands(:,2) == band(2));
        
% Almacenamiento de las medidas espectrales
for m = 1:length(C)
    
    % Area
    area = C{m};
    
    if strcmp(area(end),area_lesionada)
        
        
        protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(idx_band).pre = change_band_power(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(idx_band).on = change_band_power(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).change_band_power(idx_band).post = change_band_power(idx_areas_injured(idx_injured+1), 3);
            
        idx_injured = idx_injured + 1;
        
    elseif strcmp(area(end),area_nolesionada)
        
        protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(idx_band).pre = change_band_power(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(idx_band).on = change_band_power(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).change_band_power(idx_band).post = change_band_power(idx_areas_uninjured(idx_uninjured+1), 3);
        
        idx_uninjured = idx_uninjured + 1;
        
    else
        disp('Esta area no es lesionada ni no lesionada')
        
    end
    
end

idx_coherence_injured = combntns(idx_areas_injured,2);
idx_coherence_uninjured = combntns(idx_areas_uninjured,2);

if find([idx_areas_injured;idx_areas_uninjured]==1) == 1
    inicio_medida_inj = 1;
    inicio_medida_uninj = round(length([idx_coherence_injured;idx_coherence_uninjured])/2)+1;
else
    inicio_medida_uninj = 1;
    inicio_medida_inj = round(length([idx_coherence_injured;idx_coherence_uninjured])/2)+1;
end

% Almacenamiento de las medidas de coherencia
for p = 1:size(idx_coherence_injured,1)
    
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(idx_band).pre = sum_MSC(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(idx_band).on = sum_MSC(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).sum_MSC(idx_band).post = sum_MSC(inicio_medida_inj+p-1, 3);
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(idx_band).pre = coupling_strength(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(idx_band).on = coupling_strength(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).coupling_strength(idx_band).post = coupling_strength(inicio_medida_inj+p-1, 3);
        
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(idx_band).pre = delay(inicio_medida_inj+p-1, 1);
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(idx_band).on = delay(inicio_medida_inj+p-1, 2);
        protocoloLFP.injured(idx_registerName+1).coherence_record(p).delay(idx_band).post = delay(inicio_medida_inj+p-1, 3);
            
end

% Almacenamiento de las medidas de coherencia
for p = 1:size(idx_coherence_uninjured,1)     
    
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(idx_band).pre = sum_MSC(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(idx_band).on = sum_MSC(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).sum_MSC(idx_band).post = sum_MSC(inicio_medida_uninj+p-1, 3);
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(idx_band).pre = coupling_strength(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(idx_band).on = coupling_strength(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).coupling_strength(idx_band).post = coupling_strength(inicio_medida_uninj+p-1, 3);
        
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(idx_band).pre = delay(inicio_medida_uninj+p-1, 1);
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(idx_band).on = delay(inicio_medida_uninj+p-1, 2);
        protocoloLFP.uninjured(idx_registerName+1).coherence_record(p).delay(idx_band).post = delay(inicio_medida_uninj+p-1, 3);

end




end