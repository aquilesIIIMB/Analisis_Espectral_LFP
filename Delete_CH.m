%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Delete_CH.m
fprintf('\nEliminacionCH\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eliminar los canales no validos y volver a calcular
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.analysis_stages.view_spectrum 
    error('Falta el bloque de visualizacion de LFP');

end

% Sonido de alerta que se necesita al usuario
sonido_alarma;    

% Ingresar los canales que se eliminaran, se sale del loop apretando "Enter"
Ch_del = [];

% Confirma que ya se seleccionaron los canales
while 1
    try
        confirmation = input('Ya seleccionaste los canales a eliminar?[Type si]:  ','s');
    catch
        continue;
    end

    if strcmp(confirmation,'si')  
        fprintf('\nEliminemos Canales \n\n');
        break
    end
end

while 1
    try
        Ch_del_actual = input('Ingrese numero del canal que desea eliminar: ');
        if isempty(Ch_del_actual)
            break;        
        end
        Ch_del = [Ch_del, Ch_del_actual];
    catch
        break;
    end
end

if ~isempty(Ch_del)
    % Se notifica como removido
    [registroLFP.channels(Ch_del).removed] = deal(1);
    
end

% Canales que seran evaluados despues de eliminar los que no son adecuados
canales_eval_selected = find(~[registroLFP.channels.removed]);

fprintf('\nTodos los canales seleccionados que se usaran:\n\n');
fprintf('\tCanal\t\tArea\n');
for k = 1:length(canales_eval_selected)
    fprintf('\t %s\t\t %s\n',registroLFP.channels(canales_eval_selected(k)).name , registroLFP.channels(canales_eval_selected(k)).area);
end
fprintf('\n');

registroLFP.analysis_stages.delete_channel = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP path name_registro foldername inicio_foldername

    