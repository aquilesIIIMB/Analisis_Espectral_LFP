%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Detect_Aritfacts_Normalization.m
fprintf('\nRemoving artifacts and normalization\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detecta los indices de los artefactos y sus proyecciones y normaliza cada canal

canales_eval = find(~[registroLFP.channel.removed]);

largo_canales_eval = size(canales_eval,2);
average = mean([registroLFP.channel.data_raw],2);

for j = 1:largo_canales_eval 
    
    data_artifacted = registroLFP.channel(canales_eval(j)).data_raw;
    %registroLFP.channel(canales_eval(j)).data_ref = data_ref_artifacted; 

    % Calcular el umbral
    % Tal vez hacer umbral por fase
    umbral = registroLFP.amp_threshold * median(sort(abs(data_artifacted)))/0.675; % 3,4,5 amplitud
    registroLFP.channel(canales_eval(j)).threshold = umbral; 

    % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
    Fc = registroLFP.frec_sin_artifacts;      % hertz Freq: 120Hz
    [data_noartifacted, ind_fueraUmbral] = rmArtifacts_threshold(data_artifacted, umbral, Fc);
    
    % Almacenar los indices de los valores sobre el umbral
    registroLFP.channel(canales_eval(j)).ind_over_threshold = ind_fueraUmbral;

    % Datos estandarizados con zscore de los datos bajo el umbral 
    registroLFP.channel(canales_eval(j)).data_noartifacted = zscore_noartifacted(data_noartifacted, ind_fueraUmbral);
    
   
end

















