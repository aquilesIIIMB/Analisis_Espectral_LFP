%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Referencing.m
fprintf('\nReferencing\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Referenciacion de cada canal
%registroLFP.stage.referencing = 0; % temporal test

if ~registroLFP.stage.extract_lfp 
    error('Falta el bloque de extraccion de LFP');
    
else
    if ~registroLFP.stage.delete_channel && registroLFP.stage.referencing
        error('Falta el bloque de eliminacion de canal');
    end
end

canales_eval = find(~[registroLFP.channel.removed]);

if strcmp(registroLFP.reference_type, 'none') %% Sin referencia

elseif strcmp(registroLFP.reference_type, 'general') %% Referencia al promedio general
    largo_canales_eval = size(canales_eval,2);
    average = mean([registroLFP.channel.data_raw],2);
    
    for j = 1:largo_canales_eval 
        % Referenciacion
        %data_ref_artifacted = flipud(registroLFP.channel(canales_eval(j)).data_raw - average);
        data_ref_artifacted = registroLFP.channel(canales_eval(j)).data_raw - average;
        registroLFP.channel(canales_eval(j)).data_ref = data_ref_artifacted; 
        
        % Calcular el umbral
        % Tal vez hacer umbral por fase
        umbral = 5*mean(abs(data_ref_artifacted))/0.675; % 3,4,5 amplitud
        registroLFP.channel(canales_eval(j)).threshold = umbral; 
        
        % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
        [data_ref_noartifacted, ind_fueraUmbral] = rmArtifacts_threshold(data_ref_artifacted, umbral,...
            registroLFP.times.steps_m, registroLFP.times.pre_m, ...
            registroLFP.times.start_on_m, registroLFP.times.end_on_m, registroLFP.times.post_m, registroLFP.times.end_m);

        registroLFP.channel(canales_eval(j)).data_noartifacted = data_ref_noartifacted; %%% Aumenta el numero de datos
        
        % Datos estandarizados con zscore de los datos bajo el umbral 
        registroLFP.channel(canales_eval(j)).data = zscore_noartifacted(data_ref_noartifacted,ind_fueraUmbral);
        %registroLFP.channel(canales_eval(j)).data = zscore(data_referenciado);
    
        % Almacenar los indices de los valores sobre el umbral
        registroLFP.channel(canales_eval(j)).ind_over_threshold = ind_fueraUmbral;
    end
    


% Se puede referenciar no solo por la misma area sino por la zona M1!
elseif strcmp(registroLFP.reference_type, 'area') %% Referencia al promedio de cada area (ex M1L)
    % indices de las mismas areas
    [C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');
    
    for m = 1:length(ia) 
        i = ia(m);

        areas_actuales = find(ic == ic(i));

        largo_area_actual = length(areas_actuales);
        zdata = zscore([registroLFP.channel(canales_eval(areas_actuales)).data]);
        avarage_area = mean(zdata,2);
          
        for j = 1:largo_area_actual
            data_ref_noartifacted = zdata(:,j) - avarage_area;
            registroLFP.channel(canales_eval(areas_actuales(j))).data_ref = data_ref_noartifacted;
        end

    end


elseif strcmp(registroLFP.reference_type, 'sector') %% Referencia al promedio de los "sectores" (ex M1)

end  

registroLFP.stage.referencing = 1;

% Eliminacion de variables no utilizadas
clear data_ref zdata largo_area_actual areas_actuales C ia ic data_ref_artifacted data_ref_noartifacted
clear umbral canales_eval average data_referenciado j largo_canales_eval ind_fueraUmbral

