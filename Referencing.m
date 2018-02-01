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
        %data_ref = registroLFP.channel(canales_eval(j)).data_noartifacted - average;
        %registroLFP.channel(canales_eval(j)).data = data_ref; 

        % Referenciacion
        %data_ref_artifacted = flipud(registroLFP.channel(canales_eval(j)).data_raw - average);
        data_ref_artifacted = registroLFP.channel(canales_eval(j)).data_raw - average;
        registroLFP.channel(canales_eval(j)).data_ref = data_ref_artifacted; 
        
        % Calcular el umbral
        % Tal vez hacer umbral por fase
        umbral = registroLFP.amp_threshold * median(sort(abs(data_ref_artifacted)))/0.675; % 3,4,5 amplitud
        registroLFP.channel(canales_eval(j)).threshold = umbral; 
        
        % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
        Fc = registroLFP.frec_sin_artifacts;      % hertz Freq: 110Hz
        [data_ref_noartifacted, ind_fueraUmbral] = rmArtifacts_threshold(data_ref_artifacted, umbral, Fc);

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
        data_artifacted_area = [registroLFP.channel(canales_eval(areas_actuales)).data_raw];
        average_area = mean(zscore(data_artifacted_area),2);
          
        %for j = 1:largo_area_actual 
        %    ind_over_threshold = registroLFP.channel(canales_eval(areas_actuales(j))).ind_over_threshold;
        %    data_ref_noartifacted = data_noartifacted_area(:,j);
        %    data_ref_noartifacted(~ind_over_threshold) = data_noartifacted_area((~ind_over_threshold),j) - avarage_area(~ind_over_threshold);
        %    registroLFP.channel(canales_eval(areas_actuales(j))).data = data_ref_noartifacted;
        %end
        
        for j = 1:largo_area_actual 
            data_ref_artifacted = zscore(registroLFP.channel(canales_eval(areas_actuales(j))).data_raw) - average_area;
            registroLFP.channel(canales_eval(areas_actuales(j))).data_ref = sign(mean(data_ref_artifacted)).*data_ref_artifacted; 
            
            % Calcular el umbral
            % Tal vez hacer umbral por fase
            %umbral = registroLFP.amp_threshold * median(sort(abs(data_ref_artifacted)))/0.675; % 3,4,5 amplitud
            %registroLFP.channel(canales_eval(areas_actuales(j))).threshold = umbral; 

            % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
            %Fc = registroLFP.frec_sin_artifacts;      % hertz Freq: 110Hz
            %[data_ref_noartifacted, ind_fueraUmbral] = rmArtifacts_threshold(data_ref_artifacted, umbral, Fc);

            %registroLFP.channel(canales_eval(areas_actuales(j))).data_noartifacted = data_ref_noartifacted; %%% Aumenta el numero de datos

            % Datos estandarizados con zscore de los datos bajo el umbral 
            %registroLFP.channel(canales_eval(areas_actuales(j))).data = zscore_noartifacted(data_ref_noartifacted,ind_fueraUmbral);
            %registroLFP.channel(canales_eval(j)).data = zscore(data_referenciado);

            % Almacenar los indices de los valores sobre el umbral
            %registroLFP.channel(canales_eval(areas_actuales(j))).ind_over_threshold = ind_fueraUmbral;    
            
        end
        
        Data_area = zscore(mean([registroLFP.channel(canales_eval(areas_actuales)).data_ref],2));
        
        Data_area_pre = Data_area(registroLFP.times.steps_m<(registroLFP.times.phase_range_m(1)));
        Data_area_on = Data_area(registroLFP.times.steps_m>(registroLFP.times.phase_range_m(1)) & registroLFP.times.steps_m<(registroLFP.times.phase_range_m(1)*2+1));
        Data_area_post = Data_area(registroLFP.times.steps_m>(registroLFP.times.phase_range_m(1)*2+1));
        % Realizar el sacado de artefactos aca y por etapa;
        umbral_pre = registroLFP.amp_threshold(1) * median(sort(abs(Data_area_pre)))/0.675; % 3,4,5 amplitud 30
        umbral_on = registroLFP.amp_threshold(2) * median(sort(abs(Data_area_on)))/0.675;
        umbral_post = registroLFP.amp_threshold(3) * median(sort(abs(Data_area_post)))/0.675;
        % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
        Fc = registroLFP.frec_sin_artifacts;      % hertz Freq: 110Hz
        [Data_area_pre_noartifacted, ind_fueraUmbral_pre] = rmArtifacts_threshold(Data_area_pre, umbral_pre, Fc);
        [Data_area_on_noartifacted, ind_fueraUmbral_on] = rmArtifacts_threshold(Data_area_on, umbral_on, Fc);
        [Data_area_post_noartifacted, ind_fueraUmbral_post] = rmArtifacts_threshold(Data_area_post, umbral_post, Fc);
        
        Data_area_noartifacted = [Data_area_pre_noartifacted; Data_area_on_noartifacted; Data_area_post_noartifacted];
        ind_fueraUmbral = [ind_fueraUmbral_pre; ind_fueraUmbral_on; ind_fueraUmbral_post];
        
        %Nombre del area
        registroLFP.area(m).name = C(m);
        
        % Datos estandarizados con zscore de los datos bajo el umbral 
        registroLFP.area(m).data = Data_area_noartifacted; %zscore_noartifacted(Data_area_noartifacted, ind_fueraUmbral);
        
        % Almacenar los indices de los valores sobre el umbral
        registroLFP.area(m).ind_over_threshold = ind_fueraUmbral;   
        

    end


elseif strcmp(registroLFP.reference_type, 'sector') %% Referencia al promedio de los "sectores" (ex M1)
    
    disp('No Disponible')

end  

registroLFP.stage.referencing = 1;

% Eliminacion de variables no utilizadas
clear data_ref zdata largo_area_actual areas_actuales C ia ic data_ref_artifacted data_ref_noartifacted
clear umbral canales_eval average data_referenciado j largo_canales_eval ind_fueraUmbral
clear avarage_area data_artifacted_area Fc i m


plot(Data_area)
hold on
linea_ref = refline([0 umbral_pre]); linea_ref.Color = 'r'; linea_ref.LineStyle = '--';
hold on;
linea_ref = refline([0 umbral_on]); linea_ref.Color = 'g'; linea_ref.LineStyle = '--';
hold on;
linea_ref = refline([0 umbral_post]); linea_ref.Color = 'b'; linea_ref.LineStyle = '--';
hold on;
linea_ref = refline([0 -umbral_pre]); linea_ref.Color = 'r'; linea_ref.LineStyle = '--';
hold on;
linea_ref = refline([0 -umbral_on]); linea_ref.Color = 'g'; linea_ref.LineStyle = '--';
hold on;
linea_ref = refline([0 -umbral_post]); linea_ref.Color = 'b'; linea_ref.LineStyle = '--';
hold on;
plot(Data_area_noartifacted)