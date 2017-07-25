%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Referencing_4_8.m
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
    %zdata = zscore([registroLFP.channel.data]);    
    average = mean([registroLFP.channel.data],2);
    
    for j = 1:largo_canales_eval        
        data_ref_artifacted = registroLFP.channel(canales_eval(j)).data - average;
        registroLFP.channel(canales_eval(j)).data_artifacted = data_ref_artifacted; 
        
        umbral = 4*mean(abs(data_ref_artifacted))/0.675; % 3,4,5 amplitud
        registroLFP.channel(canales_eval(j)).threshold = umbral; 
        
        [data_referenciado, ind_fueraUmbral] = rmArtifacts_mean(data_ref_artifacted, umbral,...
            registroLFP.times.steps_m, registroLFP.times.pre_m, ...
            registroLFP.times.start_on_m, registroLFP.times.end_on_m, registroLFP.times.post_m);

        registroLFP.channel(canales_eval(j)).data_ref = data_referenciado;
        registroLFP.channel(canales_eval(j)).ind_over_threshold = ind_fueraUmbral;
    end
    
    %plot(registroLFP.channel(14).data_artifacted(umbral),'.')
    %plot(registroLFP.channel(14).data_artifacted-registroLFP.channel(14).data_ref,'.')


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
            data_referenciado = zdata(:,j) - avarage_area;
            registroLFP.channel(canales_eval(areas_actuales(j))).data_ref = data_referenciado;
        end

    end


elseif strcmp(registroLFP.reference_type, 'sector') %% Referencia al promedio de los "sectores" (ex M1)

end  

registroLFP.stage.referencing = 1;

% Eliminacion de variables no utilizadas
clear data_ref zdata largo_area_actual areas_actuales C ia ic data_ref_artifacted
clear umbral canales_eval average data_referenciado j largo_canales_eval ind_fueraUmbral

