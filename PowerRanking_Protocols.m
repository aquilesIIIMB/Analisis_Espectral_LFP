%%% Ranking de potencia en beta de protocolos

%% Medicion de la potencia en bruto y normalizada en la banda beta parkinson
% Ver si es posible hacer un ranking de potencia fractal

%%

% Calcular metrica del protocolo
%% Calcular datos del protoclo
% Eliminacion de variables que no se utilizaran
clearvars -except measurementsLFP path name_registro foldername inicio_foldername power_ranking slash_system areas
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main 
% Guardarla tabla del protocolo? 
disp(' ')
while 1
    try
        save_power_ranking = input('Would you like to save the protocol table?[Type yes or no]:  ','s');
    catch
        save_power_ranking = 'no';
    end

    if strcmp(save_power_ranking, 'yes') 
        fprintf('\nThe protocol table will be save\n\n');
        save_power_ranking = 1;
        break
    elseif strcmp(save_power_ranking, 'no') 
        fprintf('\nThe protocol table will NOT be save\n\n');
        save_power_ranking = 0;
        break
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
injured_area = input('Which area is the injured in this record?[L o R]:  ','s'); %'R' o 'L'
ind_slash = find(foldername=='\' | foldername=='/');
protocolo_name = foldername(ind_slash(1)+1:ind_slash(2)-1);
slash_system = foldername(1);

if strcmp(injured_area,'R')
    no_injured_area = 'L';
elseif strcmp(injured_area,'L')
    no_injured_area = 'R';
else
    error('Choose the injured area')
end

LastName = {'Name','Protocol','NoLesion_Pre','Lesion_Pre','Lesion_Diff_PreOn','Lesion_Diff_PrePost','Mean_Lesion_Diff_PreOn','Mean_Lesion_Diff_PrePost'};


% Analisis global
if ~exist('power_ranking','var')
    power_ranking_osci = table([],[],[],[],[],[],[],[],'VariableNames',LastName);
    power_ranking_osci_norm = table([],[],[],[],[],[],[],[],'VariableNames',LastName);
    power_ranking_frac = table([],[],[],[],[],[],[],[],'VariableNames',LastName);
    power_ranking_frac_norm = table([],[],[],[],[],[],[],[],'VariableNames',LastName);
    power_ranking_frac_total = table([],[],[],[],[],[],[],[],'VariableNames',LastName);
    
    power_ranking.power_ranking_osci = power_ranking_osci;
    power_ranking.power_ranking_osci_norm = power_ranking_osci_norm;
    power_ranking.power_ranking_frac = power_ranking_frac;
    power_ranking.power_ranking_frac_norm = power_ranking_frac_norm;
    power_ranking.power_ranking_frac_total = power_ranking_frac_total;

end

areas = {measurementsLFP.left.power_band.area};
power_ranking = power_ranking_gen(power_ranking, measurementsLFP, protocolo_name, injured_area);

if save_power_ranking
    
    % Eliminacion de variables que no se utilizaran
    clearvars -except path name_registro foldername inicio_foldername power_ranking path_name_registro slash_system areas

    % Guardar la matriz del ranking
    path_name_registro = [inicio_foldername,'Images',slash_system,'power_ranking_protocols'];

    % Descomentar para guardar
    save(path_name_registro,'-v7.3')

    disp(['It was saved in: ',path_name_registro])

end    

% Eliminacion de variables que no se utilizaran
clearvars -except path name_registro foldername inicio_foldername power_ranking path_name_registro slash_system areas
