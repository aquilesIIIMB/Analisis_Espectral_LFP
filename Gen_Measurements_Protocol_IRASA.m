% Calcular metrica del protocolo
%% Calcular datos del protoclo
% Eliminacion de variables que no se utilizaran
clearvars -except measurementsLFP path name_registro foldername inicio_foldername measurementsProtocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main 
% Guardar las imgenges del protocolo? 
disp(' ')
while 1
    try
        save_protocol = input('Would you like to save the protocol images?[Type yes or no]:  ','s');
    catch
        save_protocol = 'no';
    end

    if strcmp(save_protocol, 'yes') 
        fprintf('\nThe protocol images will be save\n\n');
        save_protocol = 1;
        break
    elseif strcmp(save_protocol, 'no') 
        fprintf('\nThe protocol images will NOT be save\n\n');
        save_protocol = 0;
        break
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
area_lesionada = input('Which area is the injured in this record?[L o R]:  ','s'); %'R' o 'L'
ind_slash = find(foldername=='\' | foldername=='/');
protocolo_name = foldername(ind_slash(1)+1:ind_slash(2)-1);

if strcmp(area_lesionada,'R')
    area_nolesionada = 'L';
elseif strcmp(area_lesionada,'L')
    area_nolesionada = 'R';
else
    error('Choose the injured area')
end

close all

% Analisis global
if ~exist('measurementsProtocol','var')
    measurementsProtocol = mergeStructureLFP(measurementsLFP,[], area_lesionada);
else
    measurementsProtocol = mergeStructureLFP(measurementsProtocol, measurementsLFP, area_lesionada);
end

if save_protocol

    show_measurements_protocol(measurementsProtocol, path);

else    
    % Eliminacion de variables que no se utilizaran
    clearvars -except path name_registro foldername inicio_foldername measurementsProtocol path_name_registro

end

