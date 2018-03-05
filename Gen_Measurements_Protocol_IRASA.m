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
        save_protocol = input('Deseas guardar las imagenes del protocolo?[Type si or no]:  ','s');
    catch
        save_protocol = 'no';
    end

    if strcmp(save_protocol, 'si') 
        fprintf('\nSe almacenaran las imagenes del protocolo\n\n');
        save_protocol = 1;
        break
    elseif strcmp(save_protocol, 'no') 
        fprintf('\nNO se almacenaran las imagenes del protocolo\n\n');
        save_protocol = 0;
        break
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
area_lesionada = input('Cual es el area lesionada en este registro?[L o R]:  ','s'); %'R' o 'L'
ind_slash = find(foldername=='\' | foldername=='/');
protocolo_name = foldername(ind_slash(1)+1:ind_slash(2)-1);

if strcmp(area_lesionada,'R')
    area_nolesionada = 'L';
elseif strcmp(area_lesionada,'L')
    area_nolesionada = 'R';
else
    error('Definir bien el area lesionada')
end

close all

% Analisis global
if ~exist('measurementsProtocol','var')
    measurementsProtocol = mergeStructureLFP(measurementsLFP,[], area_lesionada);
else
    measurementsProtocol = mergeStructureLFP(measurementsProtocol, measurementsLFP, area_lesionada);
end

if save_protocol

    %show_measurements_protocol(measurementsProtocol, path);

    % Eliminacion de variables que no se utilizaran
    clearvars -except path name_registro foldername inicio_foldername measurementsProtocol path_name_registro

    path_name_registro = [inicio_foldername,'Images',foldername,'Protocol\','protocol_',foldername(2:end-1)];

    % Descomentar para guardar
    save(path_name_registro,'-v7.3')
    
    disp(['It was saved in: ',path_name_registro])
else    
    % Eliminacion de variables que no se utilizaran
    clearvars -except path name_registro foldername inicio_foldername measurementsProtocol path_name_registro

end

