function protocoloLFP = load_fractal_data_structure(registroLFP, protocoloLFP, fractal_power, idx_areas_injured, idx_areas_uninjured, area_lesionada, area_nolesionada)

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
  
protocoloLFP.register_checked(idx_registerName+1).name = registroLFP.name;            

idx_injured = 0;
idx_uninjured = 0;
        
% Almacenamiento de las medidas espectrales
for m = 1:length(C)
    
    % Area
    area = C{m};
    
    if strcmp(area(end),area_lesionada)
        
        
        protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).fractal_power.pre = fractal_power(idx_areas_injured(idx_injured+1), 1);
        protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).fractal_power.on = fractal_power(idx_areas_injured(idx_injured+1), 2);
        protocoloLFP.injured(idx_registerName+1).spectral_record(idx_injured+1).fractal_power.post = fractal_power(idx_areas_injured(idx_injured+1), 3);
            
        idx_injured = idx_injured + 1;
        
    elseif strcmp(area(end),area_nolesionada)
        
        protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).fractal_power.pre = fractal_power(idx_areas_uninjured(idx_uninjured+1), 1);
        protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).fractal_power.on = fractal_power(idx_areas_uninjured(idx_uninjured+1), 2);
        protocoloLFP.uninjured(idx_registerName+1).spectral_record(idx_uninjured+1).fractal_power.post = fractal_power(idx_areas_uninjured(idx_uninjured+1), 3);
        
        idx_uninjured = idx_uninjured + 1;
        
    else
        disp('Esta area no es lesionada ni no lesionada')
        
    end
    
end


end