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
        %disp(canales_eval(j))
        % Referenciacion
        data_ref = registroLFP.channel(canales_eval(j)).data_noartifacted - average;
        registroLFP.channel(canales_eval(j)).data = data_ref; 
              
    end
    


% Se puede referenciar no solo por la misma area sino por la zona M1!
elseif strcmp(registroLFP.reference_type, 'area') %% Referencia al promedio de cada area (ex M1L)
    % indices de las mismas areas
    [C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');
    
    for m = 1:length(ia) 
        i = ia(m);

        areas_actuales = find(ic == ic(i));

        largo_area_actual = length(areas_actuales);
        data_noartifacted_area = [registroLFP.channel(canales_eval(areas_actuales)).data_noartifacted];
        avarage_area = mean(data_noartifacted_area,2);
          
        for j = 1:largo_area_actual
            data_ref_noartifacted = data_noartifacted_area(:,j) - avarage_area;
            registroLFP.channel(canales_eval(areas_actuales(j))).data = data_ref_noartifacted;
        end

    end


elseif strcmp(registroLFP.reference_type, 'sector') %% Referencia al promedio de los "sectores" (ex M1)
    
    disp('No Disponible')

end  

registroLFP.stage.referencing = 1;

% Eliminacion de variables no utilizadas
clear data_ref zdata largo_area_actual areas_actuales C ia ic data_ref_artifacted data_ref_noartifacted
clear umbral canales_eval average data_referenciado j largo_canales_eval ind_fueraUmbral

